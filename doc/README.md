\# Práctica DHCP A



\## Checkpoint 1 - Configuración inicial del servidor Linux



\### Configuración de red



Primero se comprobó la configuración de las interfaces de red del servidor con el siguiente comando:



ip -br a



La interfaz interna es `eth2` y tiene configurada la siguiente dirección IP:



192.168.57.10/24



Esta interfaz pertenece a la red interna `intnet`, que será la red utilizada para comunicar el servidor con los clientes de la práctica.



\### Instalación del servicio DHCP



Se actualizó la lista de paquetes con:



sudo apt update



Después se instaló el servicio DHCP con:



sudo apt install isc-dhcp-server -y



Tras la instalación, el servicio DHCP todavía no puede iniciarse correctamente porque aún no se ha configurado la subred que deberá gestionar.



\### Configuración de la interfaz DHCP



Se configuró el servicio DHCP para que escuche las peticiones por la interfaz interna `eth2`.



Para ello se modificó el archivo:



/etc/default/isc-dhcp-server



Y se configuró:



INTERFACESv4="eth2"



\### Copia de seguridad de la configuración DHCP



Antes de modificar el archivo principal de configuración de DHCP, se realizó una copia de seguridad con:



sudo cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak



De esta forma se conserva una copia del archivo original antes de realizar cambios.

