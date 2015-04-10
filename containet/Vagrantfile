# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Copy the scripts to your favorite folder and modify the source
# of the synced_folder in the below config to your chosen folder
#  e.g., If you choose "~/myfolder" then modify "~/docker/meetup/" to "~/myfolder"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "host1" do |host1|
     host1.vm.box = "ubuntu/trusty64"
     host1.vm.network "private_network", ip: "10.0.0.3"
     host1.vm.synced_folder File.dirname(__FILE__), "/home/vagrant/meetup/"
  end

  config.vm.define "host2" do |host2|
     host2.vm.box = "ubuntu/trusty64"
     host2.vm.network "private_network", ip: "10.0.0.4"
     host2.vm.synced_folder File.dirname(__FILE__), "/home/vagrant/meetup/"
  end

end
