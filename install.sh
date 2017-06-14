#       chmod 777 install.sh
#       ./install.sh


# And now for something special:
mkdir /usr/local/citnetconf

curl -s www.considerit.co.uk/mac/citnetconf/com.citnetconf.plist -o /Library/LaunchDaemons/com.citnetconf.plist

chmod +x /Library/LaunchDaemons/com.citnetconf.plist
chown root:wheel /Library/LaunchDaemons/com.citnetconf.plist

echo "Making directories..."
curl -s www.considerit.co.uk/mac/citnetconf/network.sh -o /usr/local/citnetconf/network.sh
curl -s www.considerit.co.uk/mac/citnetconf/commit.sh -o /usr/local/citnetconf/commit.sh
sleep 1
echo "Setting permissions..."
chmod +x /usr/local/citnetconf/network.sh
sleep 1
chmod +x /usr/local/citnetconf/commit.sh
echo "Completed install. Running network script..."


/usr/local/citnetconf/network.sh

echo "All done!"
