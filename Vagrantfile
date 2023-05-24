# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANT_EXPERIMENTAL="disks"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "geerlingguy/centos7"
  config.ssh.insert_key = false
  config.vm.provider :virtualbox do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end
  config.vm.disk :disk, size: "90GB", primary: true
  config.vm.synced_folder "sync-folder", "/home/vagrant/sync-folder"



  # Set the name of the VM.
  config.vm.define :master1 do |master1|
    master1.vm.hostname = "master1"
    master1.vm.network :private_network, ip: "192.168.10.11"
  end
  config.vm.define :worker1 do |worker1|
    worker1.vm.hostname = "worker1"
    worker1.vm.network :private_network, ip: "192.168.10.12"
    worker1.vm.provider :virtualbox do |v|
      v.memory = 3072
      v.cpus = 4
    end
  end
  config.vm.define :worker2 do |worker2|
    worker2.vm.hostname = "worker2"
    worker2.vm.network :private_network, ip: "192.168.10.90"
    worker2.vm.disk :disk, size: "30GB", name: "disk-01"
    worker2.vm.provider :virtualbox do |v|
      v.memory = 3072
      v.cpus = 4
    end
  end
  config.vm.define :kubespray do |kubespray|
    kubespray.vm.hostname = "kubespray"
    kubespray.vm.network :private_network, ip: "192.168.10.8"
  end

  config.vm.provision "shell",
    path: "init-vm.sh"  
  # # # Ansible provisioner.
  # config.vm.provision "ansible" do |ansible|
  #   ansible.playbook = "provisioning/playbook.yml"
  #   ansible.inventory_path = "provisioning/inventory"
  #   ansible.become = true
  # end
end 
