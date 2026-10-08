Vagrant.configure("2") do |config|
config.vm.box = "debian/bookworm64" #Esto te dice que se creará en Debian

  # SERVER

  config.vm.define "server" do |srv|
  srv.vm.hostname = "server" #El primero te dice que la vm se va a llamar server y la segunda que el usuario será server
  srv.vm.provision "shell",path: "scripts/server.sh"#Esto enlaza con el script que he creado de los comandos de NAT y forwarding

  srv.vm.network "public_network",#Conecta el servidor a el wifi de mi casa
  bridge: "Intel(R) Wi-Fi 6E AX211 160MHz"

  srv.vm.network "private_network",
  ip: "192.168.57.10",
  virtualbox__intnet: "intnet"#Crea el segundo adaptador de red interna, intnet para poder comunicarse con el cliente y la impresora
  end

  # CLIENTE C1
  # Recibirá su dirección IP automáticamente por que la solicita mediante DHCP y el server se la dará por el puerto por que esta abierto
  config.vm.define "c1" do |c1|
  c1.vm.hostname = "c1"
  c1.vm.provision "shell", path: "scripts/client.sh" #Esto enlaza con el script que he creado de los comandos

  # Conectamos c1 a la misma red interna que el servidor
  c1.vm.network "private_network",
  type: "dhcp",
  virtualbox__intnet: "intnet"
  end

  # PRINTER
  # Cliente DHCP con una MAC conocida
  config.vm.define "printer" do |printer|
  printer.vm.hostname = "printer"
  printer.vm.provision "shell", path: "scripts/client.sh" #Esto enlaza con el script que he creado de los comandos

  printer.vm.network "private_network",
  mac: "080027A1B2C3",
  type: "dhcp",
  virtualbox__intnet: "intnet"
  end
end