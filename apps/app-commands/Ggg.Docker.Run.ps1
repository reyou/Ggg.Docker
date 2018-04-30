# C:\Github\Ggg\Ggg.Linux\app\docker.js
cls 
Write-Host "Interpreting $PSScriptRoot on $(Get-Date)."

function Ggg-Start-Docker() {
    $dockerPath = "C:\Program Files\Docker\Docker\Docker for Windows.exe"
    $result = Start-Process $dockerPath -Wait
    Write-Host $result
}

<#Run a command in a new container#>
<#https://docs.docker.com/engine/reference/commandline/run/#>
function Ggg-Docker-Run($image) {
    <#simple plain run#>
    docker run $image    
}

function Ggg-Docker-Run-Attached($image) { 
    docker run -it $image sh
    # sleep for 2 seconds
    Ggg-Ps-Sleep 2
    # list last N container
    Ggg-Docker-ListLastContainers(5)
    
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

# docker run alpine sh
function Ggg-Docker-Run-NotInteractive($image) {   
    docker run $image sh
}

function Ggg-Docker-Remove-Container($containerId, $preference) {
    docker stop $containerId
    <#remove container#>
    if ($preference) {
        Write-Host "Preference: $preference"
        docker run --rm $containerId
    }
    else {
        Write-Host "Preference: no preference is used."
        docker rm $containerId
    }   
    $count = 20
    Write-Host "Last $count containers: "
    Ggg-Docker-ListLastContainers $count
}

# https://docs.docker.com/docker-for-windows/#explore-the-application-and-run-examples
# test pulling an image from Docker Hub and starting a container
function ggg-docker-run-hello() {
    docker run hello-world
}

# This will download the ubuntu container image and start it. 
function ggg-docker-run-ubuntu() {
    docker run -it ubuntu bash
}

function ggg-docker-run-alpine() {
    docker run alpine env
    Write-Host
    Ggg-Docker-ListLastContainers 20
}

# Start a Dockerized webserver with this command
# -p <host_port>:<container_port>
# http://localhost:8086
function ggg-start-dockerized-webserver() {
    docker run -d -p 8086:80 --name webserver nginx
}

function ggg-docker-start-container($containerName) {
    Write-Host "Will attempt to start container '$containerName'."
    docker start $containerName
    Ggg-Docker-ListLastContainers
}

# ggg-docker-inspect-container alpine
function ggg-docker-inspect-container($containerName) {
    if ($containerName.Length -eq 0) {
        $containerName = "webserver"
    }
    docker inspect $containerName
}

# Test-NetConnection
# https://docs.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection?view=win10-ps
# ggg-test-net-connection 8086
function ggg-test-net-connection($port) {
    Test-NetConnection -Port $port -InformationLevel "Detailed"
}

# To stop and remove the running container with a single command
# ggg-stop-remove-container 2061da59e0d5bfd3b5adb70a12799f5956a040e66c67588041ada3241dd13e88
function ggg-stop-remove-container($containerName) {
    docker rm -f $containerName
    Ggg-Docker-ListLastContainers 20
}

# To remove an image you no longer need
# ggg-remove-image nginx
function ggg-remove-image($imageName) {
    docker rmi $imageName
}