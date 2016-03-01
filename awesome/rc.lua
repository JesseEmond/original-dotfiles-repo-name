-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local vicious = require("vicious")
local blingbling = require("blingbling")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Variables
-- wallpaper
local wp_timeout  = 900
local wp_timer = timer { timeout = wp_timeout }

-- }}}
-- {{{ Function definitions
-- scan directory, and optionally filter outputs
function scandir(directory, filter)
    local i, t, popen = 0, {}, io.popen
    if not filter then
        filter = function(s) return true end
    end
    print(filter)
    for filename in popen('ls -a "'..directory..'"'):lines() do
        if filter(filename) then
            i = i + 1
            t[i] = filename
        end
    end
    return t
end
-- pick random wallpapers for each screen
function pick_random_wallpapers()
    for s = 1, screen.count() do
        pick_random_wallpaper(s)
    end
end
-- pick a random wallpaper for the given screen
function pick_random_wallpaper(screen)
    local wp_filter = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") end
    local wp_path = beautiful.wallpapers_dir
    local wp_files = scandir(wp_path, wp_filter)
    -- pick random index
    local wp_index = math.random(1, #wp_files)

    gears.wallpaper.maximized(wp_path .. wp_files[wp_index], screen, true)

    -- stop the timer (we don't need multiple instances running at the same time)
    wp_timer:stop()

    --restart the timer
    wp_timer.timeout = wp_timeout
    wp_timer:start()
end
function focused_screen() return client and client.focus and client.focus.screen or 1 end
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e \"" .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = { "zsh", "wrk", "www", "im ", " ♫ ", 6, 7, 8, 9, "" }
    , layout = { layouts[2], layouts[2], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile .. "\"" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox

-- separation
separation_layout_date_img = wibox.widget.imagebox()
separation_layout_date_img:set_image(beautiful.widget_ar_layout_date)
separation_layout_date_margin = wibox.layout.margin(separation_layout_date_img,0,5,0,0)
separation_layout_date = wibox.widget.background()
separation_layout_date:set_widget(separation_layout_date_margin)
separation_layout_date:set_bg("#00796B")

--{{---| Date widget |-------------------------------------------------------------------------------
datewidget = wibox.widget.background()
datewidget_clock = awful.widget.textclock(beautiful.widget_date_format)
datewidget:set_bg(beautiful.widget_date_bg_color)
datewidget:set_fg(beautiful.widget_date_fg_color)
datewidget:set_widget(datewidget_clock)
dateicon = wibox.widget.imagebox()
dateicon:set_image(beautiful.widget_date)

-- separation
separation_date_time = wibox.widget.imagebox()
separation_date_time:set_image(beautiful.widget_ar_date_time)

--{{---| Time widget |-------------------------------------------------------------------------------
timewidget = wibox.widget.background()
timewidget_clock = awful.widget.textclock(beautiful.widget_time_format)
timewidget:set_bg(beautiful.widget_time_bg_color)
timewidget:set_fg(beautiful.widget_time_fg_color)
timewidget:set_widget(timewidget_clock)
timeicon = wibox.widget.imagebox()
timeicon:set_image(beautiful.widget_time)

-- separation
separation_time_net = wibox.widget.imagebox()
separation_time_net:set_image(beautiful.widget_ar_time_net)

--{{---| Net widget |-------------------------------------------------------------------------------
netwidgetdbg= wibox.widget.textbox()

netwidgetdown = wibox.widget.textbox()
vicious.register(netwidgetdown, vicious.widgets.net,'<span font="Terminus 9">${wlp3s0 down_kb}</span>', 3)
netwidgetdown:set_align("right")

netwidgeticon = wibox.widget.textbox()
netwidgeticon:set_markup('<span font="Terminus 9"> ↓↑ </span>')
netwidgeticon:set_align("center")

netwidgetup = wibox.widget.textbox()
vicious.register(netwidgetup, vicious.widgets.net,'<span font="Terminus 9">${wlp3s0 up_kb}</span>', 3)
netwidgetup:set_align("left")

netwidgetlay = wibox.layout.flex.horizontal()
netwidgetlay:add(netwidgetdown)
netwidgetlay:add(netwidgeticon)
netwidgetlay:add(netwidgetup)

netwidgetfixed = wibox.layout.constraint(netwidgetlay, "exact", 145, nil)

netwidget = wibox.widget.background()
netwidget:set_bg("#C2C2A4")
netwidget:set_fg("#FFFFFF")
netwidget:set_widget(netwidgetfixed)

neticon = wibox.widget.imagebox()
neticon:set_image(beautiful.widget_net)

-- separation
separation_network_battery = wibox.widget.imagebox()
separation_network_battery:set_image(beautiful.widget_ar_net_bat)

--{{---| Battery widget |---------------------------------------------------------------------------  
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_battery)
batwidget = wibox.widget.textbox()
vicious.register( batwidget, vicious.widgets.bat, '<span background="#92B0A0" font="Terminus 12"> <span font="Terminus 9" color="#FFFFFF" background="#92B0A0">$1$2% </span></span>', 1, "BAT0" )

-- separation
separation_battery_fs = wibox.widget.imagebox()
separation_battery_fs:set_image(beautiful.widget_ar_bat_hdd)

--{{---| FS widget |---------------------------------------------------------------------------  
fsicon = wibox.widget.imagebox()
fsicon:set_image(beautiful.widget_hdd)
fswidget = wibox.widget.textbox()
vicious.register( fswidget, vicious.widgets.fs, '<span background="#D0785D" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE">${/ avail_gb} GB </span></span>', 8)

-- separation
separation_fs_cputemp = wibox.widget.imagebox()
separation_fs_cputemp:set_image(beautiful.widget_ar_hdd_cputemp)

--{{---| CPU temp widget |---------------------------------------------------------------------------  
cputempicon = wibox.widget.imagebox()
cputempicon:set_image(beautiful.widget_cputemp)
cputemp1 = wibox.widget.textbox()
vicious.register( cputemp1, vicious.widgets.thermal, '<span background="#4B3B51" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE">$1° <span color="#888888">·</span></span></span>',2,'thermal_zone1')
cputemp2 = wibox.widget.textbox()
vicious.register( cputemp2, vicious.widgets.thermal, '<span background="#4B3B51" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE">$1° </span></span>',2,'thermal_zone2')

-- separation
separation_cputemp_cpu = wibox.widget.imagebox()
separation_cputemp_cpu:set_image(beautiful.widget_ar_cputemp_cpu)

--{{---| CPU widget |---------------------------------------------------------------------------
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, function(widget, args)
          return ('<span background="#4B696D" font="Terminus 12"> <span font="Terminus 9" color="#DDDDDD">%02d%% <span color="#888888">·</span> %02d%% </span></span>'):format(args[2],args[3])
        end, 2)

-- separation
separation_cpu_ram = wibox.widget.imagebox()
separation_cpu_ram:set_image(beautiful.widget_ar_cpu_ram)

--{{---| RAM widget |---------------------------------------------------------------------------
ramicon = wibox.widget.imagebox()
ramicon:set_image(beautiful.widget_ram)
ramwidget = wibox.widget.textbox()
vicious.register(ramwidget, vicious.widgets.mem,
  '<span background="#777E76" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE" background="#777E76">$1% </span></span>', 2)

-- separation
separation_ram_tray = wibox.widget.imagebox()
separation_ram_tray:set_image(beautiful.widget_ar_ram_tray)

-- tray
systray = wibox.widget.systray()

-- separation
separation_tray_end = wibox.widget.imagebox()
separation_tray_end:set_image(beautiful.widget_ar_tray_end)


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 16 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(separation_tray_end)
    if s == 1 then right_layout:add(systray) end
    right_layout:add(separation_ram_tray)
    right_layout:add(ramicon)
    right_layout:add(ramwidget)
    right_layout:add(separation_cpu_ram)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(separation_cputemp_cpu)
    right_layout:add(cputempicon)
    right_layout:add(cputemp1)
    right_layout:add(cputemp2)
    right_layout:add(separation_fs_cputemp)
    right_layout:add(fsicon)
    right_layout:add(fswidget)
    right_layout:add(separation_battery_fs)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(separation_network_battery)
    right_layout:add(neticon)
    right_layout:add(netwidget)
    right_layout:add(separation_time_net)
    right_layout:add(timeicon)
    right_layout:add(timewidget)
    right_layout:add(separation_date_time)
    right_layout:add(dateicon)
    right_layout:add(datewidget)
    right_layout:add(separation_layout_date)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    --awful.button({ }, 4, awful.tag.viewnext),
    --awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () pick_random_wallpaper(focused_screen()) end),

    -- Generic bindings
    awful.key({ modkey,           }, "F12", function () awful.util.spawn("slimlock")    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end),
        -- Multimedia keys
        awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 1%+") end),
        awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 1%-") end),
        awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     --raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "chrome" }, callback = function(c) awful.client.movetotag(tags[focused_screen()][3], c) end },
    { rule = { class = "Firefox" }, callback = function(c) awful.client.movetotag(tags[focused_screen()][3], c) end },
    { rule = { class = "Subl3" }, callback = function(c) awful.client.movetotag(tags[focused_screen()][2], c) end },
    { rule = { class = "Skype" }, callback = function(c) awful.client.movetotag(tags[focused_screen()][4], c) end },
    { rule = { class = "Audacious" }, callback = function(c) awful.client.movetotag(tags[focused_screen()][5], c) end },
    { rule = { class = "Eclipse" }, callback = function(c) awful.client.movetotag(tags[focused_screen()][2], c) end },
    { rule = { class = "Spotify" }, callback = function(c) awful.client.movetotag(tags[focused_screen()][5], c) end },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

 
-- {{{ Random wallpapers
-- initial start when rc.lua is first run
wp_timer:connect_signal("timeout", pick_random_wallpapers)
wp_timer:start()
pick_random_wallpapers() -- start with random wallpapers
--- }}}
