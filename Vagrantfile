# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.provider "virtualbox" do |vb|
      vb.cpus = 8
      vb.memory = "4096"
    end
    jenkins.vm.network "private_network", ip: "10.0.0.10"
    #jenkins.vm.network "public_network"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
    jenkins.vm.provision "shell", path: "jenkins/01-docker.sh"
    jenkins.vm.provision "shell", path: "jenkins/02-jenkins.sh"
    jenkins.vm.provision "shell", path: "jenkins/03-packages.sh"
    jenkins.vm.provision "shell", path: "jenkins/04-jenkins-user.sh"
    jenkins.vm.provision "shell", path: "jenkins/05-jenkins-plugins.sh"
    jenkins.vm.provision "shell", path: "jenkins/06-jenkins-jobs.sh"
  end

  config.vm.define "nginx" do |nginx|
    nginx.vm.provider "virtualbox" do |vb|
      vb.cpus = 8
      vb.memory = "4096"
    end
    nginx.vm.network "private_network", ip: "10.0.0.11"
    #nginx.vm.network "public_network"
    nginx.vm.network "forwarded_port", guest: 80, host: 8000, host_ip: "127.0.0.1"
    nginx.vm.provision "shell", path: "nginx/01-nginx.sh"
    nginx.vm.provision "shell", path: "nginx/02-nginx-http.sh"
  end

  config.vm.define "manager1" do |manager1|
    manager1.vm.provider "virtualbox" do |vb|
      vb.cpus = 8
      vb.memory = "4096"
    end
    manager1.vm.network "private_network", ip: "10.0.0.12"
    manager1.vm.provision "shell", path: "manager/01-docker.sh"
    manager1.vm.provision "shell", path: "manager/02-docker-swarm-manager.sh"
    manager1.vm.provision "shell", path: "manager/03-jenkins-credentials.sh"
  end

  config.vm.define "worker1" do |worker1|
    worker1.vm.provider "virtualbox" do |vb|
      vb.cpus = 8
      vb.memory = "4096"
    end
    worker1.vm.network "private_network", ip: "10.0.0.13"
    worker1.vm.provision "shell", path: "worker/01-docker.sh"
    worker1.vm.provision "shell", path: "worker/02-docker-swarm-worker.sh"
  end

  config.vm.define "worker2" do |worker2|
    worker2.vm.provider "virtualbox" do |vb|
      vb.cpus = 8
      vb.memory = "4096"
    end
    worker2.vm.network "private_network", ip: "10.0.0.14"
    worker2.vm.provision "shell", path: "worker/01-docker.sh"
    worker2.vm.provision "shell", path: "worker/02-docker-swarm-worker.sh"
  end
  
end
