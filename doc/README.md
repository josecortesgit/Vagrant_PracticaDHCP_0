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

## Checkpoint 3 - Comprobación del cliente DHCP c1

Se creó y configuró la máquina virtual `c1` como cliente DHCP dentro de la red interna `intnet`.

Para comprobar la dirección IP obtenida se utilizó:

ip -br a

El cliente recibió la dirección:

192.168.57.20/24

Esta dirección se encuentra dentro del rango configurado en el servidor DHCP:

192.168.57.20 - 192.168.57.50

Después se revisaron los mensajes intercambiados entre el cliente y el servidor DHCP mediante:

sudo cat /var/log/syslog | grep dhcpd

Se comprobaron los siguientes mensajes:

DHCPDISCOVER
DHCPOFFER
DHCPREQUEST
DHCPACK

Finalmente se revisó el archivo de concesiones del servidor:

sudo cat /var/lib/dhcp/dhcpd.leases

En dicho archivo aparece registrada la concesión de la dirección 192.168.57.20 al cliente c1.


## Checkpoint 4 - Reserva DHCP para printer

Se configuró una máquina virtual llamada `printer` dentro de la red interna `intnet`.

A su interfaz de red se le asignó una MAC conocida:

08:00:27:A1:B2:C3

En el servidor DHCP se creó una reserva para que esta MAC reciba siempre la dirección:

192.168.57.111

La configuración se comprobó dentro de `printer` mediante:

ip -br a

La interfaz de la red interna recibió correctamente:

192.168.57.111/24

Esto confirma que la reserva DHCP basada en la dirección MAC funciona correctamente.

## Checkpoint 5 - Routing y NAT

Se configuró el servidor para actuar como router entre la red interna `192.168.57.0/24` y la red pública.

El servidor utiliza las siguientes interfaces:

- `eth1`: interfaz conectada a la red pública.
- `eth2`: interfaz interna con la dirección `192.168.57.10/24`.

Se activó el reenvío de paquetes IPv4 y se configuró NAT mediante `iptables`.

La puerta de enlace de la red pública utilizada por el servidor es:

192.168.1.1

Los clientes `c1` y `printer` fueron configurados para utilizar como puerta de enlace:

192.168.57.10

La configuración de routing y NAT se automatizó mediante dos scripts:

- `scripts/server.sh`: configuración de routing y NAT del servidor.
- `scripts/client.sh`: configuración de la puerta de enlace de los clientes.

Para comprobar la conectividad desde los clientes se utilizó:

ping -c 4 8.8.8.8

La prueba fue correcta, por lo que los clientes pueden acceder a la red pública a través del servidor.
