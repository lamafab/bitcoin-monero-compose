echo '
          :--====--:          
       -+************+-       
     -******************-     
    +*+-+************+-+*+    
   =**+  -+********+-  +**+   
  .***+    -+****+-    +***:  
  :***+  .   -++-   .  +***-  
  .***+  :*=      =*-  +***:  
   ::::  :***=  =***-  ::::   
     ....-**********=.....    
     -******************=     
       -+************+-       
          :-==++==-:          '

# TODO: setup DNS over VPN
if "${INSTALL_VPN}" == "true"; then
	echo -e "\n## VPN enabled, setting up routes..."
	ip route del default
	ip route add default via ${GATEWAY}

	echo -e "\n## IP ROUTE:"
	ip route show

	echo -e "\n## IP ADDRESS:"
	ip addr

	echo -e "\n## EXTERNAL IP"
	echo "You will connect to the network via IP $(curl -s ifconfig.me)"
fi

echo -e "\n## About to start service ..."
sleep 5

/app/monero/monerod ${CLI_ARGS}
