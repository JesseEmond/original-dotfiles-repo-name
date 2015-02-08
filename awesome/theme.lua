---------------------------
-- Default awesome theme --
---------------------------

green = "#7fb219"
cyan  = "#7f4de6"
red   = "#e04613"
lblue = "#6c9eab"
dblue = "#00ccff"
black = "#3f3f3f"
lgrey = "#d2d2d2"
dgrey = "#333333"
white = "#ffffff"

theme = {}

theme.font                                 = "Terminus 8"
theme.fg_normal                             = "#aaaaaa"
theme.fg_focus                              = "#f0dfaf"
theme.fg_urgent                             = "#cc9393"
theme.bg_normal                             = "#222222"
theme.bg_focus                              = "#1e2320"
theme.bg_urgent                             = "#3f3f3f"
theme.bg_systray                            = "#313131"
theme.border_width                          = 0
theme.border_normal                         = "#3f3f3f"
theme.border_focus                          = "#6f6f6f"
theme.border_marked                         = "#cc9393"
theme.titlebar_bg_focus                     = "#3f3f3f"
theme.titlebar_bg_normal                    = "#3f3f3f"
theme.taglist_bg_focus                      = black 
theme.taglist_fg_focus                      = dblue
theme.tasklist_bg_focus                     = "#222222" 
theme.tasklist_fg_focus                     = dblue
theme.textbox_widget_as_label_font_color    = white 
theme.textbox_widget_margin_top             = 1
theme.text_font_color_1                     = green
theme.text_font_color_2                     = dblue
theme.text_font_color_3                     = white
theme.notify_font_color_1                   = green
theme.notify_font_color_2                   = dblue
theme.notify_font_color_3                   = black
theme.notify_font_color_4                   = white
theme.notify_font                           = "Monaco 7"
theme.notify_fg                             = theme.fg_normal
theme.notify_bg                             = theme.bg_normal
theme.notify_border                         = theme.border_focus
theme.awful_widget_bckgrd_color             = dgrey
theme.awful_widget_border_color             = dgrey
theme.awful_widget_color                    = dblue
theme.awful_widget_gradien_color_1          = orange
theme.awful_widget_gradien_color_2          = orange
theme.awful_widget_gradien_color_3          = orange
theme.awful_widget_height                   = 14
theme.awful_widget_margin_top               = 2

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 16
theme.menu_width  = 140

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Widget icons
local icons = "~/.config/awesome/icons/"
theme.widget_net = icons .. "net.png"
theme.widget_ar_net_bat = icons .. "arr3.png"
theme.widget_battery = icons .. "battery.png"
theme.widget_ar_time_net = icons .. "arr2.png"
theme.widget_time = icons .. "clock.png"
theme.widget_ar_date_time = icons .. "arr1.png"
theme.widget_date = icons .. "calendar-o.png"
theme.widget_ar_layout_date = icons .. "arr0.png"
theme.widget_ar_bat_hdd = icons .. "arr4.png"
theme.widget_hdd = icons .. "hdd.png"
theme.widget_cputemp = icons .. "temp.png"
theme.widget_ar_hdd_cputemp = icons .. "arr5.png"
theme.widget_cpu = icons .. "cpu.png"
theme.widget_ar_cputemp_cpu = icons .. "arr6.png"
theme.widget_ram = icons .. "mem.png"
theme.widget_ar_cpu_ram = icons .. "arr7.png"
theme.widget_ar_ram_tray = icons .. "arr8.png"
theme.widget_ar_tray_end = icons .. "arr9.png"

-- Widget colors
theme.widget_time_fg_color = "#ffffff"
theme.widget_time_bg_color = "#777e76"
theme.widget_date_fg_color = "#ffffff"
theme.widget_date_bg_color = "#566855"

-- Widget params
theme.widget_time_format = " %H:%M "
theme.widget_date_format = " %a  %b %d "

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- change for your wallpaper dir and images
wallpapers_dir = os.getenv("HOME") .. "/media/images/wallpapers/"
theme.wallpapers = {
    wallpapers_dir .. "spiky.jpg",
    wallpapers_dir .. "motivational.png",
    wallpapers_dir .. "powerarrow-bg.jpg",
    wallpapers_dir .. "lines.jpg",
    wallpapers_dir .. "wave.jpg",
    wallpapers_dir .. "pi.jpg",
    wallpapers_dir .. "cuby.jpg",
    wallpapers_dir .. "cuby.jpg",
    wallpapers_dir .. "cuby.jpg"

}

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
