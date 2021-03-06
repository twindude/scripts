# ===============================================================
#    NAME: PowerVIConfigurator2.ps1
#    AUTHOR: Jeremy and vTwindude - Ron
#
# ===============================================================
Write-Host "                                                          "
Write-Host "                                                          "
Write-Host "**********************************************************"
Write-Host "*  Last Updated: 7.26.2015                               *"
Write-Host "**********************************************************"
Write-Host "*  Welcome to the PowerVIConfigurator 2!!!               *" -ForegroundColor Green
Write-Host "**********************************************************"
Write-Host "*  VI Configurator is a very powerful tool which         *"
Write-Host "*  brings forth a large menu of configuration            *"
Write-Host "*  items to help speed up any D&I Deployments in case    *"
Write-Host "*  of any changes or misconfiguration missed by factory. *"
Write-Host "**********************************************************"
Write-Host ""
Write-Host ""
Write-Host "Terminating any existing connections to vcenter-servers" -foregroundcolor green

add-pssnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

Disconnect-VIServer -Confirm:$False -ErrorAction SilentlyContinue | out-null
Write-Host ""
Write-Host ""

# Login Credentials
$vccred  = $Host.UI.PromptForCredential("The Virtual Environment Computing Company", "vCenter Credentials", "administrator", "")
$vc = Read-Host -Prompt "What is your vCenter IP Address?"
Connect-VIServer $vc -Credential $vccred
Write-Host ""

# Setup Menu
do {

    # Select environment MENU
    Write-Host "                                                                     "
    Write-Host "                                                                     "
    Write-Host "*********************************************************************" -ForegroundColor Green
    Write-Host "*   PowerVIConfigurator 2                                           *" -ForegroundColor Green
    Write-Host "*********************************************************************" -ForegroundColor Green
    Write-Host "                                                                     "
    Write-Host "    Please select the number task you want to perform?               " -ForegroundColor Yellow
    Write-Host "                                                                     "
    Write-Host "     Key:                                                            " -ForegroundColor Green
    Write-Host "     Single:   Makes changes only to a single host.                  "
    Write-Host "     Cluster:  Makes changes to all ESXi host in a cluster.          "
    Write-Host "     Datacnet: Makes changes to all ESXi hosts in a Datacenter.      "
    Write-Host "                                                                     "
    Write-Host "*** Modify Firewall Settings ****************************************"  -ForegroundColor Green
    Write-Host " 1.  Single:     Enable Specified Firewall Ports                     "
    Write-Host " 2.  Cluster:    Enable Specified Firewall Ports                     "
    Write-Host " 3.  Datacenter: Enable Specified Firewall Ports                     "
    Write-Host "                                                                     "
    Write-Host "*** Disconnect Media Devices from VMs *******************************"  -ForegroundColor Green
    Write-Host " 10. Cluster:    Disconnect all Media Devices from VMs               "
    Write-Host "                                                                     "
    Write-Host "*** Modify Logging Settings *****************************************"  -ForegroundColor Green
    Write-Host " 11. Single:     Update Syslog Settings                              "
    Write-Host " 12. Cluster:    Update Syslog Settings                              "
    Write-Host " 13. Datacenter: Update Syslog Settings                              "
    Write-Host "                                                                     "
    Write-Host "*** Create Scratch Location *****************************************"  -ForegroundColor Green
    Write-Host " 14. Single:     Create a Persistent Scratch Location                "
    Write-Host "                                                                     "
    Write-Host "*** Modify Domain Name and DNS **************************************"  -ForegroundColor Green
    Write-Host " 15. Single:     Modify DOMAIN NAME and DNS                          "
    Write-Host " 16. Cluster:    Modify DOMAIN NAME and DNS                          "
    Write-Host " 17. Datacenter: Modify DOMAIN NAME and DNS                          "
    Write-Host "                                                                     "
    Write-Host "*** Modify NTP ******************************************************"  -ForegroundColor Green
    Write-Host " 18. Single:     Modify NTP                                          "
    Write-Host " 19. Cluster:    Modify NTP                                          "
    Write-Host " 20. Datacenter: Modify NTP                                          "
    Write-Host "                                                                     "
    Write-Host "*** Modify Storage Settings *****************************************"  -ForegroundColor Green
    Write-Host " 21. Single:     Rescan for New Storage                              "
    Write-Host " 22. Cluster:    Rescan for New Storage                              "
    Write-Host " 23. Datacenter: Rescan for New Storage                              "
    Write-Host " 24. Cluster:    Add new Datastore                                   "
    Write-Host " 25. Cluster:    Rename Datastore                                    "
    Write-Host " 26. Single:     Mount NFS Share                                     "
    Write-Host " 27. Cluster:    Mount NFS Share                                     "
    Write-Host " 28. Datacenter: Mount NFS Share                                     "
    Write-Host "                                                                     "
    Write-Host "*** Maintenance Mode ************************************************"  -ForegroundColor Green
    Write-Host " 29. Single:     Enter Maintenance Mode                              "
    Write-Host " 30. Cluster:    Enter Maintenance Mode                              "
    Write-Host " 31. Datacenter: Enter Maintenance Mode                              "
    Write-Host " 32. Single:     Exit Maintenance Mode                               "
    Write-Host " 33. Cluster:    Exit Maintenance Mode                               "
    Write-Host " 34. Datacenter: Exit Maintenance Mode                               "
    Write-Host "                                                                     "
    Write-Host "*** Adding, Disconnecting, Remove ESXi Hosts from vCenter ***********"  -ForegroundColor Green
    Write-Host " 35. Single:     Add ESXi Host to vCenter                            "
    Write-Host " 36. Single:     Remove ESXi Host from vCenter                       "
    Write-Host "                                                                     "
    Write-Host "*** Change Root Password ********************************************"  -ForegroundColor Green
    Write-Host " 37. Single:     Change ESXi Root Password                           "
    Write-Host " 38. Cluster:    Change ESXi Root Password                           "
    Write-Host " 39. Datacenter: Change ESXi Root Password                           "
    Write-Host "                                                                     "
    Write-Host "*** View ESXi Logs **************************************************"  -ForegroundColor Green
    Write-Host " 40. Single: View the hostd Logs                                     "
    Write-Host " 41. Single: View the vmkernel Logs                                  "
    Write-Host " 42. Single: View the vpxa Logs                                      "
    Write-Host "                                                                     "
    Write-Host "*** Enable\Disable SSH **********************************************"  -ForegroundColor Green
    Write-Host " 43. Single: Enable SSH                                              "
    Write-Host " 44. Cluster: Enable SSH                                             "
    Write-Host " 45. Datacenter: Enable SSH                                          "
    Write-Host "                                                                     "
    Write-Host " 46. Single: Disable SSH                                             "
    Write-Host " 47. Cluster: Disable SSH                                            "
    Write-Host " 48. Datacenter: Disable SSH                                         "
    Write-Host "                                                                     "
    Write-Host "*** Modify Networking Global Settings *******************************"  -ForegroundColor Green
    Write-Host " 49. Single:     Remove default 'VM Network' Portgroup               "
    Write-Host " 50. Cluster:    Remove default 'VM Network' Portgroup               "
    Write-Host " 51. Datacenter: Remove default 'VM Network' Portgroup               "
    Write-Host "                                                                     "
    Write-Host "*** Modify Networking for vSwitch0 **********************************"  -ForegroundColor Green
    Write-Host " 52. Single:     Rename 'Management Network' Portgroup from vSwitch0 "
    Write-Host " 53. Cluster:    Rename 'Management Network' Portgroup from vSwitch0 "
    Write-Host " 54. Datacenter: Rename 'Management Network' Portgroup from vSwitch0 "
    Write-Host " 55. Single:     Add second vNIC to vSwitch0                         "
    Write-Host " 56. Cluster:    Add second vNIC to vSwitch0                         "
    Write-Host " 57. Datacenter: Add second vNIC to vSwitch0                         "
    Write-Host " 58. Single:     Add vmkernel Portgroup for NFS on vSwitch0          "
    Write-Host "                                                                     "
    Write-Host "*** Modify Networking for vSwitch1 **********************************"  -ForegroundColor Green
    Write-Host " 59. Single:     Add vSwitch1                                        "
    Write-Host " 60. Cluster:    Add vSwitch1                                        "
    Write-Host " 61. Datacenter: Add vSwitch1                                        "
    Write-Host " 62. Single:     Add second vNIC to vSwitch1                         "
    Write-Host " 63. Cluster:    Add second vNIC to vSwitch1                         "
    Write-Host " 64. Datacenter: Add second vNIC to vSwitch1                         "
    Write-Host " 65. Single:     Add vmkernel Portgroup for vMotion on vSwitch1      "
    Write-Host "                                                                     "
    Write-Host "*** Modify Networking for vSwitch2 **********************************"  -ForegroundColor Green
    Write-Host " 66. Single:     Add vSwitch2                                        "
    Write-Host " 67. Cluster:    Add vSwitch2                                        "
    Write-Host " 68. Datacenter: Add vSwitch2                                        "
    Write-Host " 69. Single:     Add second vNIC to vSwitch2                         "
    Write-Host " 70. Cluster:    Add second vNIC to vSwitch2                         "
    Write-Host " 71. Datacenter: Add second vNIC to vSwitch2                         "
    Write-Host " 72. Single:     Add vmware Portgroup for Data on vSwitch2           "
    Write-Host " 73. Cluster:    Add vmware Portgroup for Data on vSwitch2           "
    Write-Host " 74. Datacenter: Add vmware Portgroup for Data on vSwitch2           "
    Write-Host "                                                                     "
    Write-Host "                                                                     "
    Write-Host " 0. Quit                                                             "
    Write-Host "                                                                     "
    $response = Read-Host "Select 1-74                                                          "
    Write-Host "                                                                     "

    switch ($response)
    {

        1 {
            "** Enable specified Firewall ports to a single ESXi Host only **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Enable: syslog, NTP Client, SSH Client, VUM to each ESXi Host
            Get-VMhostFirewallException -VMHost $ESX -Name "syslog" | Set-VMHostFirewallException -Enabled:$true
            Get-VMhostFirewallException -VMHost $ESX -Name "SSH Client" | Set-VMHostFirewallException -Enabled:$true
            Get-VMhostFirewallException -VMHost $ESX -Name "NTP Client" | Set-VMHostFirewallException -Enabled:$true
            Get-VMhostFirewallException -VMHost $ESX -Name "vCenter Update Manager" | Set-VMHostFirewallException -Enabled:$true

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions" -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        2 {
            "** Enable specified Firewall ports to all the ESXi hosts in a cluster. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost

            # Enable: syslog, NTP Client, SSH Client, VUM for all ESXi hosts in specified Cluster
            foreach ($ESX in $HOSTS) {
                Get-VMhostFirewallException -VMHost $ESX -Name "syslog" | Set-VMHostFirewallException -Enabled:$true
                Get-VMhostFirewallException -VMHost $ESX -Name "SSH Client" | Set-VMHostFirewallException -Enabled:$true
                Get-VMhostFirewallException -VMHost $ESX -Name "NTP Client" | Set-VMHostFirewallException -Enabled:$true
                Get-VMhostFirewallException -VMHost $ESX -Name "vCenter Update Manager" | Set-VMHostFirewallException -Enabled:$true
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions" -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        3 {
            "** Enable specified Firewall ports to all the ESXi hosts in a Datacenter. **"

            # List available Datacenters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost

            # Enable: syslog, NTP Client, SSH Client, VUM for all ESXi hosts in specified Cluster
            foreach ($ESX in $HOSTS) {
                Get-VMhostFirewallException -VMHost $ESX -Name "syslog" | Set-VMHostFirewallException -Enabled:$true
                Get-VMhostFirewallException -VMHost $ESX -Name "SSH Client" | Set-VMHostFirewallException -Enabled:$true
                Get-VMhostFirewallException -VMHost $ESX -Name "NTP Client" | Set-VMHostFirewallException -Enabled:$true
                Get-VMhostFirewallException -VMHost $ESX -Name "vCenter Update Manager" | Set-VMHostFirewallException -Enabled:$true
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions"  -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        10 {
            "** Disconnect all Media Devices from all the VMs in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"
            $VM = Get-Cluster $CLUSTER | Get-VM

            # Disconnects CDROM and Floppy devices from all ESXi hosts in specified Cluster
            foreach ($VM in $VM) {

                Get-VM $VM | Get-CDDrive | set-cddrive -nomedia -Confirm:$False
                Get-VM $VM | Get-FloppyDrive | Set-FloppyDrive -nomedia -Confirm:$False

            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Disconnect all Hardware Devices from all the AMP VMs in Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        11 {
            "** Updated Syslog Settings to a single ESXi Host only **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for the IP or Name of the Syslog Server
            $LOGHOST = Read-Host "Enter LogHost Server IP or Name"

            # Update IP/Name and Port of the Syslog Server to specified ESXi Host
            Get-VMHost $ESX | Set-VMHostSysLogServer -SysLogServer $LOGHOST -SysLogServerPort 514

            # Updates Syslog Rotate and Size Values to specified ESXi Host
            if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultRotate).Values -ne "20"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultRotate -Value 20 -Confirm:$false
            }
              if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultSize).Values -ne "10240"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultSize -Value 10240 -Confirm:$false
            }
            if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.rotate).Values -ne "80"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.rotate -Value 80 -Confirm:$false
            }
            if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.size).Values -ne "10240"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.size -Value 10240 -Confirm:$false
            }
            if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.rotate).Values -ne "80"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.rotate -Value 80 -Confirm:$false
            }
            if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.size).Values -ne "10240"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.size -Value 10240 -Confirm:$false
            }
            if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.fdm.rotate).Values -ne "80"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.fdm.rotate -Value 80 -Confirm:$false
            }
            if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vpxa.size).Values -ne "20"){
                Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vpxa.size -Value 20 -Confirm:$false
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated Syslog Settings to the ESXi host." -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        12 {
            "** Updated Syslog Settings to all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Request input for the IP or Name of the Syslog Server
            $LOGHOST = Read-Host "Enter LogHost Server IP or Name"

            # Get all ESXi hosts in specified Cluster and insert into Variable
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost

            # Update IP/Name, Rotation, and Size of the Syslog Server to all ESXi hosts to specified Cluster
            foreach ($ESX in $HOSTS) {

                # Update IP/Name and Port of the Syslog Server to all ESXi Hosts in specified Cluster
                Get-VMHost $ESX | Set-VMHostSysLogServer -SysLogServer $LOGHOST -SysLogServerPort 514

                # Updates Syslog Rotate and Size Values to all ESXi Hosts in specified Cluster
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultRotate).Values -ne "20"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultRotate -Value 20 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultSize).Values -ne "10240"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultSize -Value 10240 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.rotate).Values -ne "80"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.rotate -Value 80 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.size).Values -ne "10240"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.size -Value 10240 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.rotate).Values -ne "80"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.rotate -Value 80 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.size).Values -ne "10240"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.size -Value 10240 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.fdm.rotate).Values -ne "80"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.fdm.rotate -Value 80 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vpxa.size).Values -ne "20"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vpxa.size -Value 20 -Confirm:$false
                }
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated Syslog Settings to all hosts in Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        13 {
            "** Updated Syslog Settings to all hosts in Datacenter **"

            # List available Datacenters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Request input for the IP or Name of the Syslog Server
            $LOGHOST = Read-Host "Enter LogHost Server IP or Name"

            # Get all ESXi hosts in specified Datacenter and insert into Variable
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost

            # Update IP/Name, Rotation, and Size of the Syslog Server to all the ESXi hosts to specified Datacenter
            foreach ($ESX in $HOSTS) {

                # Update IP/Name and Port of the Syslog Server to all ESXi Hosts in specified Cluster
                Get-VMHost $ESX | Set-VMHostSysLogServer -SysLogServer $LOGHOST -SysLogServerPort 514

                # Updates Syslog Rotate and Size Values to all ESXi Hosts in specified Cluster
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultRotate).Values -ne "20"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultRotate -Value 20 -Confirm:$false
                }
                  if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultSize).Values -ne "10240"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.global.defaultSize -Value 10240 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.rotate).Values -ne "80"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.rotate -Value 80 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.size).Values -ne "10240"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.hostd.size -Value 10240 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.rotate).Values -ne "80"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.rotate -Value 80 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.size).Values -ne "10240"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vmkernel.size -Value 10240 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.fdm.rotate).Values -ne "80"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.fdm.rotate -Value 80 -Confirm:$false
                }
                if((Get-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vpxa.size).Values -ne "20"){
                    Set-VMHostAdvancedConfiguration -VMHost $ESX -Name Syslog.loggers.vpxa.size -Value 20 -Confirm:$false
                }
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated Syslog Settings to all hosts in Datacenter." -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        14 {
            "** Add Scratch Partition to a single ESXi Host only **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # List Datastores to specified ESXi host
            $DATASTORE = Get-Datastore
            Write-Host ""
            Write-Host "List of Datastore Names for, $ESX, :" -ForegroundColor Green
            Write-Host = $DATASTORE
            Write-Host ""

            # Request input for Datastore Name
            $DS = Read-Host "Enter Datastore Name to Mount"

            # Request input for a uniquely-named directory for this ESXi host
            $NewDir = Read-Host "Enter new directory name (.locker-ESXHostname):"

            # Create a scratch directory
            Get-VMHost $ESX | mkdir /tmp/scratch

            # Mount a datastore read/write as a PSDrive
            New-PSDrive -Name "mounteddatastore" -Root \ -PSProvider VimDatastore -Datastore (Get-Datastore $DS)

            # Access the new PSDrive
            Set-Location mounteddatastore:

            # Create a uniquely-named directory for the ESXi host
            New-Item "$NewDir" -ItemType directory

            # Change the ScratchConfig.ConfiguredScratchLocation configuration option, specifying the full path to the directory
            Set-VMHostAdvancedConfiguration -Name "ScratchConfig.ConfiguredScratchLocation" -Value "/vmfs/volumes/" + $DS + "/" + $NewDir

            # Exit out of the PSDrive
            cd c:

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Created Scratch Partition to specified ESXi Host. " -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            #Clear-Host
            break
        }

        15 {
            "** Update Domain Name and DNS settings to a single ESXi Host only **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for Primary DNS IP
            $PDNS = Read-Host "Enter Primary IP Address (Leave blank if it dont exist)"

            # Request input for Secondary DNS IP
            $SDNS = Read-Host "Enter Secondary IP Address (Leave blank if it dont exist)"

            # Request input for Domain Name
            $DOMAINNAME = Read-Host "Enter the Domain Name (Leave blank if it dont exist)"

            # Updates DNS IP(s), Domain Name, and Search Domain to the specified ESXi Host
            Get-VMHost "$ESX" | Get-VMhostNetwork | Set-VMHostNetwork -DnsAddress $PDNS,$SDNS -DomainName $DOMAINNAME -SearchDomain $DOMAINNAME

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated Domain Name and DNS Server Values to specified ESXi Host." -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        16 {
            "** Update Domain Name and DNS settings to all the ESXi Host in a Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Request input for Primary DNS IP
            $PDNS = Read-Host "Enter Primary IP Address (Leave blank if it dont exist)"

            # Request input for Secondary DNS IP
            $SDNS = Read-Host "Enter Secondary IP Address (Leave blank if it dont exist)"

            # Request input for Domain Name
            $DOMAINNAME = Read-Host "Enter the Domain Name (Leave blank if it dont exist)"

            # Updates DNS IP(s), Domain Name, and Search Domain to all ESXi Hosts specified in Cluster
            Get-Cluster "$CLUSTER" | Get-VMHost | Get-VMhostNetwork | Set-VMHostNetwork -DnsAddress $PDNS,$SDNS -DomainName $DOMAINNAME -SearchDomain $DOMAINNAME

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated Domain Name and DNS Server Values to all ESXi Hosts in specified Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        17 {
            "** Update Domain Name and DNS settings to all the ESXi Host in Datacenter **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Request input for Primary DNS IP
            $PDNS = Read-Host "Enter Primary IP Address (Leave blank if it dont exist)"

            # Request input for Secondary DNS IP
            $SDNS = Read-Host "Enter Secondary IP Address (Leave blank if it dont exist)"

            # Request input for Domain Name
            $DOMAINNAME = Read-Host "Enter the Domain Name (Leave blank if it dont exist)"

            # Updates DNS IP(s), Domain Name, and Search Domain to all ESXi Hosts specified in Datacenter
            Get-Datacenter "$DATACENTER" | Get-VMHost | Get-VMhostNetwork | Set-VMHostNetwork -DnsAddress $PDNS,$SDNS -DomainName $DOMAINNAME -SearchDomain $DOMAINNAME

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated Domain Name and DNS Server Values to all ESXi Hosts in specified Datacenter." -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        18 {
            "** Update NTP Settings to a single ESXi host only **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for Primary DNS IP
            $PNTP = Read-Host "Enter Primary IP or Name"

            # Request input for Secondary DNS IP
            $SNTP = Read-Host "Enter Secondary IP or Name (Leave blank if it dont exist)"

            # Updates NTP Settings to specified ESXi Host
            Get-VMHost "$ESX" | Add-VMHostNtpServer -NtpServer "$PNTP","$SNTP"

            # Enable 'NTP Client' and change startup policy to "Automatic" to specified ESXi Host
            $ftpFirewallExceptions = Get-VMhostFirewallException -VMHost $ESX | where {$_.Name.StartsWith('NTP Client')}
            $ftpFirewallExceptions | Set-VMHostFirewallException -Enabled $true
            Set-VMHostService -HostService (Get-VMHostservice -VMHost (Get-VMHost $ESX) | Where-Object {$_.key -eq "ntpd"}) -Policy "Automatic"

            # Restart NTP Client to specified ESXi Host
            $NTP = Get-VMHostService -VMHost(Get-VMHost $ESX) | Where-Object {$_.key -eq "ntpd"}
            Restart-VMHostService $NTP -Confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated NTP Server Values to specified ESXi Host." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        19 {
            "** Update NTP Settings to all the ESXi hosts in a Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Request input for Primary DNS IP
            $PNTP = Read-Host "Enter Primary IP or Name"

            # Request input for Secondary DNS IP
            $SNTP = Read-Host "Enter Secondary IP or Name (Leave blank if it dont exist)"

            # Updates NTP Settings to all ESXi Hosts in specified Cluster
            Get-Cluster "$CLUSTER" | Get-VMHost | Add-VMHostNtpServer -NtpServer "$PNTP","$SNTP"

            #Enable 'NTP Client' and change startup policy to "Automatic" to all ESXi Hosts in specified Cluster
            $ftpFirewallExceptions = Get-VMhostFirewallException -VMHost (Get-CLuster | Get-VMHost) | where {$_.Name.StartsWith('NTP Client')}
            $ftpFirewallExceptions | Set-VMHostFirewallException -Enabled $true
            Set-VMHostService -HostService (Get-VMHostservice -VMHost (Get-Cluster | Get-VMHost) | Where-Object {$_.key -eq "ntpd"}) -Policy "Automatic"

            # Restart NTP Client to all ESXi Hosts in specified Cluster
            $NTP = Get-VMHostService -VMHost(Get-Cluster | Get-VMHost) | Where-Object {$_.key -eq "ntpd"}
            Restart-VMHostService $NTP -Confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated NTP Server Values to all ESXi Hosts in specified Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        20 {
            "** Update NTP Settings to all the ESXi hosts in a Datacenter **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Request input for Primary DNS IP
            $PNTP = Read-Host "Enter Primary IP or Name"

            # Request input for Secondary DNS IP
            $SNTP = Read-Host "Enter Secondary IP or Name (Leave blank if it dont exist)"

            # Updates NTP Settings to all ESXi Hosts in specified Datacenter
            Get-Datacenter "$DATACENTER" | Get-VMHost | Add-VMHostNtpServer -NtpServer "$PNTP","$SNTP"

            # Enable 'NTP Client' and change startup policy to "Automatic" to all ESXi Hosts in specified Datacenter
            $ftpFirewallExceptions = Get-VMhostFirewallException -VMHost (Get-Datacenter | Get-VMHost) | where {$_.Name.StartsWith('NTP Client')}
            $ftpFirewallExceptions | Set-VMHostFirewallException -Enabled $true
            Set-VMHostService -HostService (Get-VMHostservice -VMHost (Get-Datacenter | Get-VMHost) | Where-Object {$_.key -eq "ntpd"}) -Policy "Automatic"

            #Restart NTP Client to all ESXi Hosts in specified Datacenter
            $NTP = Get-VMHostService -VMHost(Get-Datacenter | Get-VMHost) | Where-Object {$_.key -eq "ntpd"}
            Restart-VMHostService $NTP -Confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Updated NTP Server Values to all ESXi Hosts in specified Datacenter." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        21 {
            "** Rescan for new storage on a single host. **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Rescan all HBAs for VMFS Datastores for the specified ESXi Host.
            Get-VMHost $ESX | Get-VMHostStorage -RescanAllHba -RescanVmfs -Refresh

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All HBAs scanned for VMFS Datastores to specified ESXi Host." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        22 {
            "** Rescan for new storage for all hosts in Cluster. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Rescan all HBAs for VMFS Datastores on all ESXi Hosts in the specified Cluster.
            Get-Cluster $CLUSTER |Get-VMHost | Get-VMHostStorage -RescanAllHba -RescanVmfs -Refresh

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All HBAs scanned for VMFS Datastores to all ESXi Hosts in specified Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        23 {
            "** Rescan for new storage for all hosts in Datacenter. **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Rescan all HBAs for VMFS Datastores on all ESXi Hosts in the specified Datacenter.
            Get-Datacenter $DATACENTER |Get-VMHost | Get-VMHostStorage -RescanAllHba -RescanVmfs -Refresh

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All HBAs scanned for VMFS Datastores to all ESXi Hosts in specified Datacenter." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        24 {
            "** Add new Datastore for all hosts in Cluster. **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for Datacenter Name
            $DATASTORENAME = Read-Host "Enter Datastore Name"

            # Add new Datastores to all ESXi Hosts in the cluster that is sharing with specified ESXi Host.
            $iSCSILuns = Get-VMHost $ESX | Get-ScsiLun -LunType disk | Where {$_.Vendor -match "EMC"}
            New-DataStore -VMHost $ESX -Vmfs -Path $iSCSILuns.CanonicalName -Name $DATASTORENAME

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Rescanned and add Datastores to all ESXi hosts in shared Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        25 {
            "** Rename Datastore for all hosts in Cluster. **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # List Datastores to specified ESXi host
            $DATASTORE = Get-Datastore
            Write-Host ""
            Write-Host "List of Datastore Names for, $ESX, :" -ForegroundColor Green
            Write-Host = $DATASTORE
            Write-Host ""

            # Request input for Old Datastore Name
            $OLDDATASTORENAME = Read-Host "Enter Old Datastore Name"

            # Request input for New Datastore Name
            $NEWDATASTORENAME = Read-Host "Enter New Datastore Name"

            # Update Datastore Name to all ESXi hosts in shared Cluster
            Get-VMHost $ESX | Get-Datastore -Name "$OLDDATASTORENAME" | Set-Datastore -Name $NEWDATASTORENAME

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Datastore has been renamed." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        26 {
            "** Mount NFS Share to a single host. **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for NFS IP
            $IP  = Read-Host "Enter NFS IP Share"

            # Request input for name of the Datastore
            $DSNAME = Read-Host "Enter name of Datastore"

            # Request input for the NFS share path
            $PATH = Read-Host "Enter share path (/mnt/nfs/share)"

            # Mount NFS Datastore to specified ESXi Host
            New-Datastore -Nfs -VMHost $ESX -Name $DSNAME -Path "$PATH" -NfsHost $IP

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "Mounted NFS Share to a single host." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        27 {
            "** Mount NFS Share to all hosts in Cluster. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Request input for name of the Datastore
            $DSNAME = Read-Host "Enter name of Datastore"

            # Request input for the NFS share path
            $PATH = Read-Host "Enter share path (/mnt/nfs/share)"

            # Mount NFS Datastore to specified ESXi Host
            Get-Cluster $CLUSTER | Get-VMHost | New-Datastore -Nfs -Name $DSNAME -Path "$PATH" -NfsHost $IP

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Mounted NFS Share to all ESXi Hosts in specified Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        28 {
            "** Mount NFS Share to all hosts in Datacenter. **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Request input for name of the Datastore
            $DSNAME = Read-Host "Enter name of Datastore"

            # Request input for the NFS share path
            $PATH = Read-Host "Enter share path (/mnt/nfs/share)"

            # Mount NFS Datastore to all ESXi Hosts in specified Datacenter
            Get-Datacenter $DATACENTER | Get-VMHost | New-Datastore -Nfs -Name $DSNAME -Path "$PATH" -NfsHost $IP

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Mounted NFS Share to all ESXi Hosts in specified Datacenter." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        29 {
            "** Enter ESXi Host in Maintenance Mode. **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Puts specified ESXi Host into Maintenance Mode
            Set-VMHost -VMHost $ESX -State "Maintenance"

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: The specified ESXi Host has entered Maintenance Mode." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        30 {
            "** Enter all ESXi Hosts in Cluster into Maintenance Mode. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost

            # Puts all ESXi Hosts specified in Cluster into Maintenance Mode
            foreach ($ESX in $HOSTS) {
                Set-VMHost -VMHost $ESX -State "Maintenance" -RunAsync
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All the specified ESXi Hosts in Cluster has entered Maintenance Mode." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        31 {
            "** Enter all ESXi Hosts in Datacenter into Maintenance Mode. **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost

            # Puts all ESXi Hosts specified in Datacenter into Maintenance Mode
            foreach ($ESX in $HOSTS) {
                Set-VMHost -VMHost $ESX -State "Maintenance" -RunAsync
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All the specified ESXi Hosts in Datacenter has exit Maintenance Mode." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        32 {
            "** Exit ESXi Host from Maintenance Mode. **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Puts specified ESXi Host into Maintenance Mode
            Set-VMHost -VMHost $ESX -State "Connected"

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: The specified ESXi Host has exit Maintenance Mode." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        33 {
            "** Exit all ESXi Hosts in Cluster from Maintenance Mode. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost

            # Puts all ESXi Hosts specified in Cluster into Maintenance Mode
            foreach ($ESX in $HOSTS) {
                Set-VMHost -VMHost $ESX -State "Connected" -RunAsync
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All the specified ESXi Hosts in Cluster has exit Maintenance Mode." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        34 {
            "** Exit all ESXi Hosts in Datacenter from Maintenance Mode. **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost

            # Puts all ESXi Hosts specified in Datacenter into Maintenance Mode
            foreach ($ESX in $HOSTS) {
                Set-VMHost -VMHost $ESX -State "Connected" -RunAsync
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All the specified ESXi Hosts in Datacenter has entered Maintenance Mode." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        35 {
            "** Add specified ESXi Host to vCenter. **"

            # Request input for ESXi Name
            $ESXhost = Read-Host "Enter the ESXi Name or IP"

            # Request input for ESXi Name
            $USER = Read-Host "Enter the root User"

            # Request input for ESXi Name
            $PASSWORD = Read-Host "Enter the root Password"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for ESXi Name
            $ClusterName = Read-Host "Enter Cluster Name where you want to add the ESXi Host"

            # Join ESXi host to vCenter
            Write-Host ""
            "Join the ESX Server to the VCS server"
            Write-Host ""
            $VCSLocation = Get-Cluster -Name $ClusterName -ErrorAction Inquire
            $ESXHost = Add-VMHost -Location $VCSLocation -Name $ESXhost -User $USER -Password $PASSWORD -RunAsync:$False -ErrorAction Inquire -Force

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: The specified ESXi has been added to vCenter." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        36 {
            "** Remove specified ESXi Host  vCenter. **"

            # Request input for ESXi Name
            $ESXhost = Read-Host "Enter the ESXi Name or IP"

            # Request input for ESXi Name
            $USER = Read-Host "Enter the root User"

            # Request input for ESXi Name
            $PASSWORD = Read-Host "Enter the root Password"

            # Remove ESXi host to vCenter
            Write-Host ""
            "Remove $ESXhost from vCenter server"
            $ESXHost = Remove-VMHost $ESXhost

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: $ESXhost has been removed from vCenter." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        37 {
            "** Change root password on specified ESXi Host. **"


            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Request input of Old password
            $oldpw = read-host -prompt "Enter the current root password" -AsSecureString

            # Request input of New password
            $newpw = read-host -prompt "Enter the desired new root password" -AsSecureString

            # Updates New root Password
            Write-Host ""
            write-host "Connecting to $ESX..." -ForegroundColor Green
            Write-Host ""
            connect-viserver -server $ESX -user root -password "$oldpw"
            Write-Host ""
            write-host "Changing root password on $ESX..." -ForegroundColor Green
            Set-VMHostAccount -UserAccount root -password "$newpw"
            Disconnect-VIServer $ESX -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Root password changed on specified ESXi Host." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        38 {
            "** Change root password on all ESXi Hosts in specified Cluster. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost

            # Request input of Old password
            $oldpw = read-host -prompt "Enter the current root password" -AsSecureString

            # Request input of New password
            $newpw = read-host -prompt "Enter the desired new root password" -AsSecureString

            # Updates New root Password
            Write-Host ""
            write-host "Connecting to $HOSTS..." -ForegroundColor Green
            Write-Host ""
            connect-viserver -server $HOSTS -user root -password "$oldpw"
            Write-Host ""
            write-host "Changing root password on $vmhost..." -ForegroundColor Green
            Set-VMHostAccount -UserAccount root -password "$newpw"
            Disconnect-VIServer $HOSTS -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Root password changed on all the specified ESXi Hosts in Cluster." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        39 {
            "** Change root password on all ESXi Hosts in specified Datacenter. **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost

            # Request input of Old password
            $oldpw = read-host -prompt "Enter the current root password" -AsSecureString

            # Request input of New password
            $newpw = read-host -prompt "Enter the desired new root password" -AsSecureString

            # Updates New root Password
            Write-Host ""
            write-host "Connecting to $HOSTS..." -ForegroundColor Green
            Write-Host ""
            connect-viserver -server $HOSTS -user root -password "$oldpw"
            Write-Host ""
            write-host "Changing root password on $vmhost..." -ForegroundColor Green
            Set-VMHostAccount -UserAccount root -password "$newpw"
            Disconnect-VIServer $HOSTS -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Root password changed on all the specified ESXi Hosts in Datacenter." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        40 {

         "*** List all the warning message logs for hostd ***"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # List all the warning message logs for hostd
            (Get-Log -VMHost (Get-VMHost $ESX*) hostd).Entries | Where {$_ -like "*WARNING*" }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All the hostd WARNING messages for $ESX is complete." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        41 {

            "*** List all the warning message logs for vmkernel ***"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # List all the warning message logs for vmkernel
            (Get-Log -VMHost (Get-VMHost $ESX*) vmkernel).Entries | Where {$_ -like "*WARNING*" }

            # Output Completion when script is finished
            #"
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All the hostd WARNING messages for $ESX is complete." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        42 {

            "*** List all the warning message logs for vpxa ***"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            #
            (Get-Log -VMHost (Get-VMHost $ESX*) vpxa).Entries | Where {$_ -like "*WARNING*" }

            # Output Completion when script is finished
            #"
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: All the hostd WARNING messages for $ESX is complete." -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        43 {
            "** Enable SSH to a single ESXi Host only **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Enable SSH on all ESXi hosts in specified Cluster
            Get-VMhost -name $ESX | Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions" -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        44 {
            "** Enable SSH to all the ESXi hosts in a cluster. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost

            # Enable SSH on all ESXi hosts in specified Cluster
            Get-Cluster -name $HOSTS | Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions" -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        45 {
            "** Enable SSH to all the ESXi hosts in a Datacenter. **"

            # List available Datacenters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost

            # Enable SSH on all ESXi hosts in specified Cluster
            Get-Datacenter -name $HOSTS | Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions"  -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        46 {
            "** Disable SSH to a single ESXi Host only **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Enable SSH on all ESXi hosts in specified Cluster
            Get-VMhost -name $ESX | Get-VMHost | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions" -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        47 {
            "** Disable SSH to all the ESXi hosts in a cluster. **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster Name
            $CLUSTER = Read-Host "Enter Cluster Name"
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost

            # Enable SSH on all ESXi hosts in specified Cluster
            Get-Cluster -name $HOSTS | Get-VMHost | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions" -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        48 {
            "** Disable SSH to all the ESXi hosts in a Datacenter. **"

            # List available Datacenters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter Name
            $DATACENTER = Read-Host "Enter Datacenter Name"
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost

            # Enable SSH on all ESXi hosts in specified Cluster
            Get-Datacenter -name $HOSTS | Get-VMHost | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Enabled the necessary Firewall Exceptions"  -ForegroundColor Green
            Write-Host ""
            Read-Host "Press return to continue..."

            Clear-Host
            break
        }

        49 {
            "** Update - Remove default 'VM Network' Portgroup on a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Name
            $ESX = Read-Host "Enter ESXi Name"

            # Remove default 'VM Network' Portgroup on a single host
            $DefaultPG1 = Get-VirtualPortGroup -vmhost $ESX -Name "VM Network"
            Remove-VirtualPortGroup $DefaultPG1 -Confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Removed default 'VM Network' Portgroup from vSwitch0" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        50 {
            "** Update - Remove default 'VM Network' Portgroup on all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Remove default 'VM Network' Portgroup on a single host
            $DefaultPG1 = Get-VirtualPortGroup -vmhost (Get-Cluster $CLUSTER | Get-VMHost) -Name "VM Network"
            Remove-VirtualPortGroup $DefaultPG1 -Confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Removed default 'VM Network' Portgroup from vSwitch0 on all ESXi hosts in specified Cluster" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        51 {
            "** Update - Remove default 'VM Network' Portgroup from any vSwitch on all hosts in Datacenter **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Remove default 'VM Network' Portgroup on a single host
            $DefaultPG1 = Get-VirtualPortGroup -vmhost (Get-Datacenter $DATACENTER | Get-VMHost) -Name "VM Network"
            Remove-VirtualPortGroup $DefaultPG1 -Confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Removed default 'VM Network' Portgroup from vSwitch0 on all ESXi hosts in specified Datacenter" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        52 {
            "** Update - Rename 'Management Network' Portgroup from vSwitch0 on a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for new Portgroup Name
            $RenameMgmtPG  = Read-Host "Enter PortGroup name for the ESXi console"

            # Request input for vSwitch
            $VS = Read-Host "Enter the vSwitch name"

            # Rename 'Management Network' Porgroup to new name
            $vSwitch0 = Get-VirtualSwitch -vmhost $ESX
            $PortGroup = Get-VirtualPortGroup -VirtualSwitch $vSwitch0 -Name "Management Network"
            Set-VirtualPortGroup -VirtualPortGroup $PortGroup -Name "$RenameMgmtPG"

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Renamed 'Management Network' Portgroup from vSwitch0 for specified ESXi Host" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        53 {
            "** Update - Rename 'Management Network' Portgroup from vSwitch0 on all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Request input for new Portgroup Name
            $RenameMgmtPG  = Read-Host "Enter PortGroup name for the ESXi console"

            # Rename 'Management Network' Porgroup to new name for all ESXi Hosts in specified Cluster
            $PortGroup = Get-VirtualPortGroup -VirtualSwitch vSwitch0 -Name "Management Network"
            Set-VirtualPortGroup -VirtualPortGroup $PortGroup -Name "$RenameMgmtPG"

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Renamed 'Management Network' Portgroup from vSwitch0 for all ESXi Hosts in Cluster" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        54 {
            "** Update - Rename 'Management Network' Portgroup from vSwitch0 on all hosts in Datacenter **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Request input for new Portgroup Name
            $RenameMgmtPG  = Read-Host "Enter PortGroup name for the ESXi console"

            # Rename 'Management Network' Porgroup to new name for all ESXi hosts in specified Datacenter
            $PortGroup = Get-VirtualPortGroup -VirtualSwitch vSwitch0 -Name "Management Network"
            Set-VirtualPortGroup -VirtualPortGroup $PortGroup -Name "$RenameMgmtPG"

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Renamed 'Management Network' Portgroup from vSwitch0 for all ESXi Hosts in Datacenter" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        55 {
            "** Add second vNIC to vSwitch0 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Add second vNIC to vSwitch 0 to a specified ESXi Host
            $vSwitch0 = Get-VirtualSwitch -vmhost $ESX
            Set-VirtualSwitch -VirtualSwitch $vSwitch0 -nic vmnic0,vmnic1 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second vNIC has been added to vSwitch0 for specified ESXi Host" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        56 {
            "** Add second vNIC to vSwitch0 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Add second vNIC to vSwitch 0 to all ESXi hosts in Cluster
            $vSwitch0 = Get-VirtualSwitch -vmhost (Get-Cluster $CLUSTER | Get-VMHost)
            Set-VirtualSwitch -VirtualSwitch $vSwitch0 -nic vmnic0,vmnic1 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second vNIC has been added to vSwitch0 for all ESXi Hosts in specified Cluster" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'


            Clear-Host
            break
        }

        57 {
            "** Add second vNIC to vSwitch0 to all hosts in Datacenter **"

            # List available Datacenter in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenter Names in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Add second vNIC to vSwitch 0 to all ESXi hosts in Datacenter
            $vSwitch0 = Get-VirtualSwitch -vmhost (Get-Datacenter $DATACENTER | Get-VMHost)
            Set-VirtualSwitch -VirtualSwitch $vSwitch0 -nic vmnic0,vmnic1 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second vNIC has been added to vSwitch0 for all ESXi Hosts in specified Datacenter" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'


            Clear-Host
            break
        }

        58 {
            "** Add vmkernal Portgroup for NFS on vSwitch0 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for NFS Portgroup Name
            $NFSNAME = Read-Host "Enter the name of the NFS PortGroup"

            # Request input for NFS Portgroup IP
            $NFSIP = Read-Host "Enter the NFS Porgroup IP"

            # Request input for NFS Portgroup SubnetMask
            $NFSMASK = Read-Host "Enter the SubnetMask"

            # Request input for NFS VLAN
            $NFSVLAN = Read-Host "Enter the VLAN"

            # Update TCP/IP for NFS Porgroup on vSwitch0
            $VS0 = Get-VirtualSwitch -vmhost $ESX -Name  vSwitch0
            New-VMHostNetworkAdapter -vmhost $ESX -PortGroup "$NFSNAME" -VirtualSwitch $VS0 -IP $NFSIP -SubnetMask $NFSMASK -Mtu 9000 -VMotionEnabled:$false

            # Update the NFS Porgroup Name and VLAN
            $PG = Get-VirtualPortgroup -vmhost $ESX -Name $NFSNAME
            Set-VirtualPortGroup -VirtualPortGroup $PG -VlanId $NFSVLAN

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Added NFS Portgroup for specified ESXi Host on vSwitch0" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        59 {
            "** Add second vSwitch named vSwitch1 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Add second vSwitch named vSwitch1 to a single host
            $VS1 = New-VirtualSwitch -VMHost $ESX -Name vSwitch1
            Set-VirtualSwitch -VirtualSwitch $VS1 -nic vmnic2,vmnic3 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added for specified ESXi Host on vSwitch0" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        60 {
            "** Add second vSwitch named vSwitch1 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Add second vSwitch named vSwitch1 to all hosts in Cluster
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost
            foreach ($item in $HOSTS) {
                $VH = $item.Name
                $VS1 = New-VirtualSwitch -VMHost $VH -Name vSwitch1
                Set-VirtualSwitch -VirtualSwitch $VS1 -nic vmnic2,vmnic3 -confirm:$false
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added for all ESXi Hosts in specified Cluster on vSwitch0" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        61 {
            "** Add second vSwitch named vSwitch1 to all hosts in Datacenter **"

            # List available Clusters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATCENTER = Read-Host "Enter Datacenter Name"

            $HOSTS = Get-Datacenter $DATCENTER | Get-VMHost
            foreach ($item in $HOSTS) {
                $VH = $item.Name

                $VS1 = New-VirtualSwitch -VMHost $VH -Name vSwitch1
                Set-VirtualSwitch -VirtualSwitch $VS1 -nic vmnic2,vmnic3 -confirm:$false
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added for all ESXi Hosts in specified Datacenter on vSwitch0" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        62 {
            "** Add second vNIC to vSwitch1 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Add second vNIC to vSwitch1 to specified ESXi Host
            $vSwitch1 = Get-VirtualSwitch -vmhost $ESX -Name 'vSwitch1'
            Set-VirtualSwitch -VirtualSwitch $vSwitch1 -nic vmnic2,vmnic3 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added for specified ESXi Host on vSwitch1" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        63 {
            "** Add second vNIC to vSwitch1 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Add second vNIC to vSwitch1 to specified all ESXi Hosts in Cluster
            $vSwitch1 = Get-VirtualSwitch -vmhost (Get-VMHost -Location $CLUSTER) -Name 'vSwitch1'
            Set-VirtualSwitch -VirtualSwitch $vSwitch1 -nic vmnic2,vmnic3 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added for all ESXi Hosts in specified Cluster on vSwitch1" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        64 {
            "** Add second vNIC to vSwitch1 to all hosts in Datacenter **"

            # List available Clusters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Add second vNIC to vSwitch1 to specified all ESXi Hosts in Datacenter
            $vSwitch1 = Get-VirtualSwitch -vmhost (Get-VMHost -Location $DATACENTER) -Name 'vSwitch1'
            Set-VirtualSwitch -VirtualSwitch $vSwitch1 -nic vmnic2,vmnic3 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added for all ESXi Hosts in specified Datacenter on vSwitch1" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        65 {
            "** Add vmkernal Portgroup for vMotion on vSwitch1 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for vMotion Portgroup Name
            $VNAME = Read-Host "Enter the name of the vMotion PortGroup"

            # Request input for vMotion IP
            $VIP = Read-Host "Enter the IP"

            # Request input for vMotion SubnetMask
            $VMASK = Read-Host "Enter the SubnetMask"

            # Request input for vMotion VLAN
            $VVLAN = Read-Host "Enter the VLAN"

            # Add vmkernal Portgroup for vMotion on vSwitch1 to a single host
            $VS1 = Get-VirtualSwitch -vmhost $ESX -Name  vSwitch1
            New-VMHostNetworkAdapter -vmhost $ESX -PortGroup "$VNAME" -VirtualSwitch $VS1 -IP $VIP -SubnetMask $VMASK -VMotionEnabled:$true
            $PG = Get-VirtualPortgroup -vmhost $ESX -Name $VNAME
            Set-VirtualPortGroup -VirtualPortGroup $PG -VlanId $VVLAN

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Added vmotion Portgroup for specified ESXi Host on vSwitch1" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break
        }

        66 {
            "** Add second vSwitch named vSwitch2 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Add second vSwitch named vSwitch2 to specified ESXi Host
            $VS2 = New-VirtualSwitch -VMHost $ESX -Name vSwitch2
            Set-VirtualSwitch -VirtualSwitch $VS2 -nic vmnic4,vmnic5 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second vNIC has been added to vSwitch2 on specified ESXi Host" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        67 {
            "** Add second vSwitch named vSwitch2 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Add second vSwitch named vSwitch2 to all hosts in Cluster
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost
            foreach ($item in $HOSTS) {
                $VH = $item.Name
                $VS2 = New-VirtualSwitch -VMHost $VH -Name vSwitch2
                Set-VirtualSwitch -VirtualSwitch $VS2 -nic vmnic4,vmnic5 -confirm:$false
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second vNIC has been added to vSwitch2 on all ESXi Hosts in specified Cluster" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        68 {
            "** Add second vSwitch named vSwitch2 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATCENTER = Read-Host "Enter Datacenter Name"

            # Add second vSwitch named vSwitch2 to all hosts in Cluster
            $HOSTS = Get-Datacenter $DATCENTER | Get-VMHost
            foreach ($item in $HOSTS) {
                $VH = $item.Name
                $VS2 = New-VirtualSwitch -VMHost $VH -Name vSwitch2
                Set-VirtualSwitch -VirtualSwitch $VS2 -nic vmnic4,vmnic5 -confirm:$false
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second vNIC has been added to vSwitch2 on all ESXi Hosts in specified Datacenter" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        69 {
            "** Add second vNIC to vSwitch2 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Add second vNIC to vSwitch2 to specified ESXi Host
            $vSwitch2 = Get-VirtualSwitch -vmhost $ESX -Name 'vSwitch2'
            Set-VirtualSwitch -VirtualSwitch $vSwitch2 -nic vmnic4,vmnic5 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added to vSwitch2 on specified ESXi Host" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        70 {
            "** Add second vNIC to vSwitch2 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Add second vNIC to vSwitch2 to all hosts in Cluster
            $vSwitch2 = Get-VirtualSwitch -vmhost (Get-VMHost -Location $CLUSTER) -Name 'vSwitch2'
            Set-VirtualSwitch -VirtualSwitch $vSwitch2 -nic vmnic4,vmnic5 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added to vSwitch2 on all ESXi Hosts in specified Cluster" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        71 {
            "** Add second vNIC to vSwitch2 to all hosts in Datacenter **"

            # List available Clusters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Add second vNIC to vSwitch2 to all hosts in Datacenter
            $vSwitch2 = Get-VirtualSwitch -vmhost (Get-VMHost -Location $DATACENTER) -Name 'vSwitch2'
            Set-VirtualSwitch -VirtualSwitch $vSwitch2 -nic vmnic4,vmnic5 -confirm:$false

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Second NIC has been added to vSwitch2 on all ESXi Hosts in specified Datacenter" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        72 {
            "** Add VM Portgroup on vSwitch2 to a single host **"

            # List available ESXi Hosts in vCenter
            $EHOST = Get-VMhost
            Write-Host ""
            Write-Host "List of ESXi hosts in vCenter:" -ForegroundColor Green
            Write-Host "$EHOST"
            Write-Host ""

            # Request input for ESXi Host
            $ESX = Read-Host "Enter ESXi Name"

            # Request input for VM Porgroup Name
            $DNAME = Read-Host "Enter the name of the VM PortGroup"

            # Request input for VM Porgroup VLAN
            $VLAN = Read-Host "Enter the VLAN"

            # Add VM Portgroup on vSwitch2 to a single host
            Get-VMHost "$ESX" | Get-VirtualSwitch -Name 'vSwitch2' | New-VirtualPortGroup -Name $DNAME -VLanId $VLAN

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Added VM Portgroup for on vSwitch2 for specified ESXi Host" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        73 {
            "** Add VM Portgroup on vSwitch2 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $CLUSTER = Get-Cluster
            Write-Host ""
            Write-Host "List of Clusters in vCenter:" -ForegroundColor Green
            Write-Host "$CLUSTER"
            Write-Host ""

            # Request input for Cluster
            $CLUSTER = Read-Host "Enter Cluster Name"

            # Request input for VM Porgroup Name
            $DNAME = Read-Host "Enter the name of the VM PortGroup"

            # Request input for VM Porgroup VLAN
            $VLAN = Read-Host "Enter the VLAN"

            # Add VM Portgroup on vSwitch2 to all ESXi Hosts in specified Cluster
            $HOSTS = Get-Cluster $CLUSTER | Get-VMHost
            foreach ($item in $HOSTS) {
                $VH = $item.Name
                Get-VMHost "$VH" | Get-VirtualSwitch -Name 'vSwitch2' | New-VirtualPortGroup -Name $DNAME -VLanId $VLAN
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Added VM Portgroup for on vSwitch2 for all ESXi Hosts in specified Cluster" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        74 {
            "** Add VM Portgroup on vSwitch2 to all hosts in Cluster **"

            # List available Clusters in vCenter
            $DATACENTER = Get-Datacenter
            Write-Host ""
            Write-Host "List of Datacenters in vCenter:" -ForegroundColor Green
            Write-Host "$DATACENTER"
            Write-Host ""

            # Request input for Datacenter
            $DATACENTER = Read-Host "Enter Datacenter Name"

            # Request input for VM Porgroup Name
            $DNAME = Read-Host "Enter the name of the VM PortGroup"

            # Request input for VM Porgroup VLAN
            $VLAN = Read-Host "Enter the VLAN"

            # Add VM Portgroup on vSwitch2 to all ESXi Hosts in specified Datacenter
            $HOSTS = Get-Datacenter $DATACENTER | Get-VMHost
            foreach ($item in $HOSTS) {
                $VH = $item.Name
                Get-VMHost "$VH" | Get-VirtualSwitch -Name 'vSwitch2' | New-VirtualPortGroup -Name $DNAME -VLanId $VLAN
            }

            # Output Completion when script is finished
            Write-Host ""
            Write-Host ""
            Write-Host "COMPLETED: Added VM Portgroup for on vSwitch2 for all ESXi Hosts in specified Datacenter" -ForegroundColor Green
            Write-Host ""
            Read-Host 'Press return to continue...'

            Clear-Host
            break;
        }

        default {
            return;
        }

    }
} while ($True)
