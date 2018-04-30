cls 
Write-Host "Interpreting $PSScriptRoot on $(Get-Date)."

function Ggg-DockerListMachines() {
    docker-machine ls
}

function Ggg-DockerMachineMain() {
    docker-machine
}

function Ggg-DockerCreateDefaultMachine() {
    docker-machine create default
}

function Ggg-CreateDefaultMachineWithVirtualBox() {
    <#"This computer is running Hyper-V. VirtualBox won't boot a 64bits VM 
when Hyper-V is activated. Either use Hyper-V as a driver, or disable the Hyper-V hypervisor. 
(To skip this check, use --virtualbox-no-vtx-check)"#>    
    #docker-machine create --driver virtualbox default    
    docker-machine create --d virtualbox --virtualbox-no-vtx-check default
}

function Ggg-DockerStartMachine() {
    docker-machine start default
}

function Ggg-RemoveDefaultMachine() {
    docker-machine rm default
}

# https://stackoverflow.com/questions/42866013/docker-toolbox-localhost-not-working
function ggg-docker-get-machine-ip-default() {
    docker-machine ip default  
}

