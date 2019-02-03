#! /bin/bash

### Add user input for username and password ###

    # Set username and password to file .client.conf #
touch /etc/openvpn/.test.conf
echo "p0920742" > /etc/openvpn/.test.conf
echo "56FGVXcMRr" >> /etc/openvpn/.test.conf
cat /etc/openvpn/.test.conf
