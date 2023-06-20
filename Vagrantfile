Vagrant.configure("2") do |config|
  # Debian 11
  config.vm.box = "debian/bookworm64"
  # Sync colletions folder
  config.vm.provider "virtualbox" do |provider|
    # Display the GUI when booting the machine
    provider.gui = true # this option does not exist on libvirt provider

    # Install pip
    #config.vm.provision "shell", inline: "sudo apt update && sudo apt upgrade -y && apt install -y python3-pip"
    # Customize the amount of memory on the VM:
    provider.memory = "6000"

    # Run playbook
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "main.yml"
      ansible.verbose = "vv"
    end
  end
end
