# Example 5
#
# Separate Web and database servers serving up static/dynamic sites via Puppet.
#
# NOTE: Make sure you have the xenial64 base box installed...
# vagrant box add xenial64 http://files.vagrantup.com/xenial64.box

nodes = [
  { :hostname => 'ex5web', :ip => '192.168.33.10', :box => 'xenial64', :ram => 4096 },
  { :hostname => 'ex5db',  :ip => '192.168.33.11', :box => 'xenial64', :ram => 4096 }
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = "ubuntu/xenial64"
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "90",
          "--memory", memory.to_s,
        ]
      end
    end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
  end
end
