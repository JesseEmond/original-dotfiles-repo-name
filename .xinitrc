xset -b
synapse -s &
nm-applet &
redshift-gtk &

# setup gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)

#exec cinnamon-session

exec awesome
