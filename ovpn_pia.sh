#! /bin/bash

#   openvpn@privateinternetaccess setup omegahammer73

    # test for and if need be install openvpn
if hash openvpn
    then
     echo "openvpn is already installed"
else
     apt-get update
     apt-get install openvpn

fi

    # get and unzip openvpn.zip servers file
wget -P /etc/openvpn/ https://www.privateinternetaccess.com/openvpn/openvpn.zip
wait
unzip /etc/openvpn/openvpn.zip -d /etc/openvpn

    # Make a file / get username and password / put in file
touch /etc/openvpn/.client.conf
echo -e "\n\n\tPIA USERNAME : "
  read username
echo "$username" > /etc/openvpn/.client.conf
echo -e "\n\tPIA PASSWORD : "
  read password
echo -e "$password" >> /etc/openvpn/.client.conf

    # Make a copy of anyname.ovpn file here and name it anyname.conf
cp /etc/openvpn/Sweden.ovpn /etc/openvpn/sweden.conf

    # Add .client.conf after auth-user-pass  [ auth-user-pass .client.conf ]
sed -i 's/auth-user-pass/auth-user-pass .client.conf/' /etc/openvpn/sweden.conf 

  ### configure openvpn to auto start at boot up

    # uncoment [ AUTOSTART="all" ] in /etc/default/openvpn
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/' /etc/default/openvpn
    # enable openvpn service
systemctl enable openvpn@sweden.service
wait
    # get curent ip and save to file
curl ipinfo.io > /tmp/ovpn_test_ip

    # restart openvpn daemon
systemctl daemon-reload
wait
    # start openvpn
service openvpn start

####################################################################
# make wait longer and add echo "restarting ovpn_pia service"      #
# also add a progress bar for wait                                 #
#################################################################### 
#                                                                  #
wait                                                               #
#                                                                  #
####################################################################
#                                                                  #
####################################################################
    # get new ip and append to file /temp/ovpn_test.1
curl ipinfo.io >> /tmp/ovpn_test_ip

    # print old and new ip's to console
cat /tmp/ovpn_test_ip

    # Reboot system######### commented out because may not be needed
#shutdown -r now
