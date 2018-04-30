# https://www.youtube.com/watch?v=EHIoGg9ajBs&list=WL&index=1

# $pshome
# C:\Windows\System32\WindowsPowerShell\v1.0\modules
# https://serverfault.com/questions/757749/powershell-module-servermanager-not-found-on-windows-10
function import-servermanager(){
import-module servermanager
}
function install-containers(){
 Install-WindowsFeature containers
}
<#The DISM PowerShell module is included in Windows 8.1 and Windows Server 2012 R2. 
On other supported operating systems, you can install the Windows Assessment and Deployment Kit 
(Windows ADK) which includes the DISM PowerShell module.#>
function List-available-commands(){
 gcm -module DISM
}

# install-windowsfeature

# tests
import-servermanager
install-containers