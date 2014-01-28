# This script enable Hyper-V Role on Windows Server 2012

# On remote machine
# Install-WindowsFeature -Name Hyper-V -ComputerName <computer_name> -IncludeManagementTools -Restart

# On local machine
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools



# RDS
Add-WindowsFeature -Name Remote-Desktop-Services -IncludeAllSubFeature

# Remote Desktop Services Tools
Add-WindowsFeature -Name RSAT-RDS-Tools -IncludeAllSubFeature



Import-Module RemoteDesktopServices


Restart-Computer

