# Windows 10

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.define "host02" do |host02|
    # Every Vagrant virtual environment requires a box to build off of.
    host02.vm.box = "sbrumley/palo-win10"
    host02.vm.box_version = "1.1"
    host02.vm.hostname = "host02"
    host02.vm.network "private_network", ip: "10.0.2.4", auto_config: false
    host02.vm.guest = :windows
    host02.vm.communicator = "winrm"
    host02.vm.boot_timeout = 600
    host02.vm.graceful_halt_timeout = 600
    #host02.winrm.port = 5986
    host02.vm.network :forwarded_port, guest: 3389, host: 3390, id: "rdp", auto_correct: true
    host02.vm.network :forwarded_port, guest: 5985, host: 5986, id: "winrm", auto_correct: true


    ## Deep six Defender
    #host02.vm.provision "shell", privileged: true, powershell_elevated_interactive: true, path: "scripts/defender.ps1"
    #host02.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", inline: <<-SHELL
    #    Set-MpPreference -DisableRealtimeMonitoring $true
    #    SHELL

    host02.vm.provider "virtualbox" do |vm|
        vm.name = "host02"
        vm.gui = false 
        vm.cpus = 1
        vm.memory = 2048
    end

    ## Bootstrap OS
    host02.vm.provision "shell", path: "scripts/bootstrap.bat", privileged: true

    ## SSH Keys
    #host02.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys" 
    #host02.ssh.private_key_path = "~/.ssh/id_rsa"
    #host02.ssh.forward_agent = true
  
  end

  config.vm.define "host01" do |host01|
    # Every Vagrant virtual environment requires a box to build off of.
    host01.vm.box = "sbrumley/palo-win10"
    host01.vm.box_version = "1.1"
    host01.vm.hostname = "host01"
    host01.vm.network "private_network", ip: "10.0.2.3",auto_config: false
    host01.vm.guest = :windows
    host01.vm.communicator = "winrm"
    host01.vm.boot_timeout = 600
    host01.vm.graceful_halt_timeout = 600
    #host01.winrm.port = 5985
    ## Deep six Defender
    host01.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    host01.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    host01.vm.provision "shell", privileged: true, path: "scripts/defender.ps1"
  
  
    host01.vm.provider "virtualbox" do |vm|
        vm.name = "host01"
        vm.gui = false 
        vm.cpus = 1
        vm.memory = 2048
    end
  
    ## SSH Keys
    #host01.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys" 
    #host01.ssh.private_key_path = "~/.ssh/id_rsa"
    #host01.ssh.forward_agent = true

    host01.vm.provision "shell", path: "scripts/bootstrap.bat", privileged: true
  end

  ## Start Up Linux Host03
  config.vm.define "host03" do |host03|
    host03.vm.box = "hashicorp/bionic64"
    host03.vm.network "private_network", ip: "10.0.2.5", auto_config: false
    host03.vm.provider "virtualbox" do |vm|
            vm.name = "host03"
            vm.gui = false
            vm.cpus = 1
            vm.memory = 2048
    end
    host03.vm.provision "shell", path: "scripts/bootstrap.sh", privileged: true
  end
end
