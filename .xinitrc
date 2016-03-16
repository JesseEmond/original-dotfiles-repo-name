xset -b
synapse -s &
nm-applet &

# setup gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)

#exec cinnamon-session

exec awesome
