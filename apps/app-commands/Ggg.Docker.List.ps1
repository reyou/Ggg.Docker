cls 
Write-Host "Interpreting $PSScriptRoot on $(Get-Date)."

function ggg-docker-ps() {
    docker ps
}

function Ggg-Get-Running-Processes() {
    Get-Process *docker*
}

<#https://docs.docker.com/engine/reference/commandline/ps/#> 
function Ggg-Docker-ListAllContainers($filter) {
    
    if ($filter) {
        Write-Host "Filter: $filter"
        docker ps -a -f $filter --format --no-trunc
    }
    else {
        Write-Host "Filter: no filter is used."
        docker ps -a --format --no-trunc
    }
}

function Ggg-Docker-ListLatestContainer() {
    docker ps --latest --no-trunc
}

function Ggg-Docker-ListLastContainers($count) {
    if ($count.Length -eq 0) {
        $count = 5
    }
    docker ps -a --last $count --no-trunc    
}

function Ggg-Docker-ListContainerFileSizes() {
    docker ps --size
} 
 
function Ggg-Docker-ListImages() {
    docker images
}






