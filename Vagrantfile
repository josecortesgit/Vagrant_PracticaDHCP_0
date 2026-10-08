Vagrant.configure("2") do |config|
config.vm.box = "debian/bookworm64" #Esto te dice que se creará en Debian

  config.vm.define "server" do |srv|
  srv.vm.hostname = "server" #El primero te dice que la vm se va a llamar server y la segunda que el usuario será server

  srv.vm.network "public_network",#Conecta el servidor a el wifi de mi casa
  bridge: "Intel(R) Wi-Fi 6E AX211 160MHz"

  srv.vm.network "private_network",
  ip: "192.168.57.10",
  virtualbox__intnet: "intnet"#Crea el segundo adaptador de red interna, intnet para poder comunicarse con el cliente y la impresora
  end

end