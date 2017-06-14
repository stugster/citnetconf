#!/bin/bash
# We can cheat. Dump it all to a file, remove WiFi, add WiFi to end. Then run command based on the file.

# Find out number of services
numberOfServices=$(networksetup -listnetworkserviceorder | cut -d')' -f2 | sed '/^$/d' | sed '1d' | sed -e 's/^[ \t]*//' | wc -l)
#echo $numberOfServices

stopvalue=$numberOfServices
startvalue=1

# Now we can iterate through and dump to (a clean) file).
> /usr/local/citnetconf/output.txt
for((i=$startvalue;i<=$stopvalue;++i)) do
#       echo $i
        service=$(networksetup -listnetworkserviceorder | cut -d')' -f2 | sed '/^$/d' | sed '1d' | sed -e 's/^[ \t]*//' | awk NR==$i)
        echo $service >> /usr/local/citnetconf/output.txt
done

# We now delete "WiFi" from the file and then append to end.
> /usr/local/citnetconf/cleaned.txt
sed '/Wi-Fi/d' /usr/local/citnetconf/output.txt >> /usr/local/citnetconf/cleaned.txt
echo Wi-Fi >> /usr/local/citnetconf/cleaned.txt

# So now pull it into an array to use

#servicesList="networksetup -ordernetworkservices "
while IFS='' read -r line || [[ -n "$line" ]]; do
    servicesList="$servicesList \"$line\""
done < /usr/local/citnetconf/cleaned.txt
#echo $servicesList

ProperList="/usr/sbin/networksetup -ordernetworkservices $servicesList"
#printf $ProperList
#/usr/sbin/networksetup -ordernetworkservices $servicesList

ProperList=${ProperList//$'\n'/}
> /usr/local/citnetconf/commit.sh
echo $ProperList >> /usr/local/citnetconf/commit.sh
chmod 777 /usr/local/citnetconf/commit.sh
/usr/local/citnetconf/commit.sh
