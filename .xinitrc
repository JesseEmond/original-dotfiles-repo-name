xset -b

if [ -s ~/.xmodmap ] ; then
    xmodmap ~/.xmodmap
fi

synapse -s &
nm-applet &
dualscreen
#exec cinnamon-session
exec awesome
