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


## Checkpoint 2 - Configuración del servicio DHCP

Se configuró el archivo principal del servidor DHCP:

/etc/dhcp/dhcpd.conf

La configuración utilizada establece:

- Tiempo de concesión por defecto: 1 día.
- Tiempo máximo de concesión: 8 días.
- Dominio: jose.test.
- Servidores DNS: 10.0.0.2 y 4.4.4.4.
- Red: 192.168.57.0/24.
- Rango de direcciones DHCP: 192.168.57.20 - 192.168.57.50.

Para comprobar que la sintaxis del archivo era correcta se utilizó:

sudo dhcpd -t

Después se reinició el servicio DHCP:

sudo systemctl restart isc-dhcp-server

Se comprobó que el servicio estaba activo con:

systemctl status isc-dhcp-server

El servicio apareció como:

Active: active (running)

Finalmente se comprobaron los puertos UDP abiertos mediante:

sudo ss -lun

En la salida apareció el puerto UDP 67:

0.0.0.0:67

Esto confirma que el servidor DHCP está activo y escuchando peticiones de los clientes.

