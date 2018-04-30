cls 
Write-Host "Interpreting $PSScriptRoot on $(Get-Date)."

function ggg-docker-version() {
    docker version
}

# https://docs.docker.com/docker-for-windows/#check-versions-of-docker-engine-compose-and-machine
function ggg-docker-get-version() {
    docker --version
}

function ggg-docker-compose-get-version() {
    docker-compose --version
}

function ggg-docker-machine-get-version() {
    docker-machine --version
}

# http://www.poweronplatforms.com/enable-disable-hyper-v-windows-10-8/
function Ggg-Enable-Hyper-V() {
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V �All
}

# http://www.poweronplatforms.com/enable-disable-hyper-v-windows-10-8/
function Ggg-Disable-Hyper-V() {
    Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V �All
}

function Ggg-DockerInfo() {
    docker info
}

<#https://docs.docker.com/engine/reference/commandline/stop/#description#>
function Ggg-Docker-Stop-Container($containerName, $time) {       
    if ($time) {
        docker stop $containerName --time   
    }
    else {
        docker stop $containerName
    }   
    Ggg-Docker-ListLastContainers(5)
}

# https://docs.docker.com/docker-for-windows/#explore-the-application-and-run-examples
# Ggg-Docker-Restart-Container webserver
function Ggg-Docker-Restart-Container($containerName, $time) {  
    Write-Host "Stopping container: $containerName."     
    docker stop $containerName    
    Write-Host "Starting container: $containerName."     
    docker start $containerName  
    Ggg-Docker-ListLastContainers  
}

function Ggg-DockerPull ($packageName) {
    <# from hub.docker.com #>
    # https://hub.docker.com/_/alpine/
    # docker pull alpine
    docker pull $packageName
}
 

function Ggg-Docker-Remove($image, $preference) {
    <#remove container#>
    if ($preference -eq "run") {
        docker run --rm $image
    }
    else {
        docker rm $image
    }   
}

function Ggg-Ps-Sleep($seconds) {
    Start-Sleep -s $seconds
}

function Ggg-Docker-Run-Detached($image) {
    <#detached version of container#>
    docker run --d -it $image sh
    # sleep for 2 seconds
    Ggg-Ps-Sleep 2
    # list last N container
    Ggg-Docker-ListLastContainers(5)
    
}

function Ggg-Docker-Run-WithPort($hostPort, $intPort) {
    <#host:internal containers port #>
    # docker run --d -p 4000:4000 
    docker run --d -p "$hostPort" + ":" + "$intPort"
}

function Ggg-Docker-Run-WithName($customName, $image) {
    <#set name for your image#>
    docker run --name=$customName $image 
}








