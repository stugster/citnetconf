# citnetconf
Fed up with users sitting at their desks, plugged into Ethernet, but the Mac decides it wants to prioritise Wi-Fi? This tool solves the problem.

The tool is installed via a simple 'install.sh' file. You can grab the files yourself and self-host after changing the URLs, or you can just run it from our repository:

curl -s www.considerit.co.uk/mac/citnetconf/install.sh | bash -

The tool pulls all the network devices listed under Apple > System Preferences > Network and dumps them to a file.
It then removes Wi-Fi from the list, appending it to the bottom.
Once it has the new list, it pulls this information back in and runs the following on the device:

/usr/sbin/networksetup -ordernetworkservices $servicesList ($servicseList being the list of Devices, ordered with Wi-Fi last).

Lastly, the tool also takes advantage of Mac OS's 'launchd' for launching scripts as root on boot. The tool adds itself to run every time the Mac boots.

Uninstall:

At time of writing, to uninstall simply:
rm /Library/LaunchDaemons/com.citnetconf.plist
rm -r /usr/local/citnetconf

