# Activar el reenvío de paquetes IPv4
echo "1" > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf

# Configurar NAT para la red interna
iptables -t nat -C POSTROUTING -s 192.168.57.0/24 -o eth1 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING -s 192.168.57.0/24 -o eth1 -j MASQUERADE

# Configurar la salida del servidor por la red pública
ip route replace default via 192.168.1.1 dev eth1