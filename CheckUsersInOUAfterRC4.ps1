
<#
System requirements
PSVersion                      5.1.19041.2364                                                                                                       
PSEdition                      Desktop                                                                                                              
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}                                                                                              
BuildVersion                   10.0.19041.2364                                                                                                      
CLRVersion                     4.0.30319.42000                                                                                                      
WSManStackVersion              3.0                                                                                                                  
PSRemotingProtocolVersion      2.3                                                                                                                  
SerializationVersion           1.1.0.1      
About Script 
Author : Fardin Barashi
Title : RC4 Checker
Description : This Script checks if user in the OU got a RC4 encryption
Version : 1.0
Release day : 
Github Link  : https://github.com/fardinbarashi
News : 
#>

#----------------------------------- Settings ------------------------------------------
# Transcript
$ScriptName = $MyInvocation.MyCommand.Name
$LogFileDate = (Get-Date -Format yyyy/MM/dd/HH.mm.ss)
$TranScriptLogFile = "$PSScriptRoot\Logs\$ScriptName - $LogFileDate.Txt" 
$StartTranscript = Start-Transcript -Path $TranScriptLogFile -Force
Get-Date -Format "yyyy/MM/dd HH:mm:ss"
Write-Host ".. Starting TranScript"

# Error-Settings
$ErrorActionPreference = 'Continue'
#----------------------------------- Start Script ------------------------------------------
# Section 1 : Connect to $OU and process user that have RS4 enabled
$Section = "Section 1 : Connect to $OU and process user that have RS4 enabled"

Try
{ # Start Try, $Section
    Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Host $Section... "0%" -ForegroundColor Yellow

    # Connect to OU and get all enabled users
    $OU = ""
    $Users = Get-ADUser -Filter {Enabled -eq $true} -SearchBase $OU -Properties *

    # Process users in $CheckAdGroup, Check if user got RC4 Enabled or not
    $PasswordLastSet = $Users | Sort-Object PasswordLastSet

    # Generate a HTML report columns
    $Report = "<html><head><style>table {border-collapse: collapse;} td {border: 1px dotted; padding: 5px;} tr:nth-child(even) {background-color: #f2f2f2;}</style></head><body><table>"
    $Report += "<tr>"
    $Report += "<td><b>Username</b></td>"
    $Report += "<td><b>Password Last Set</b></td>"
    $Report += "<td><b>Description</b></td>"
    $Report += "<td><b>Department</b></td>"
    $Report += "<td><b>Only RC4 Enabled</b></td>"
    $Report += "<td><b>Password changed since 2023</b></td>"
    $Report += "</tr>"

    # Add users to HTML-report
    $RowCount = 0
    Foreach ($User in $PasswordLastSet) 
    {  # Start foreach ($User in $PasswordLastSet)  
        $RC4Enabled = ""
        
        If ($User.'msDS-SupportedEncryptionTypes' -band 0x4) 
         { # Start if ($User.'msDS-SupportedEncryptionTypes' -band 0x4) 
          $RC4Enabled = "Yes"
         } # End if ($User.'msDS-SupportedEncryptionTypes' -band 0x4) 
       
        Else 
        { # Start Else, if ($User.'msDS-SupportedEncryptionTypes' -band 0x4) 
            $RC4Enabled = "No"
        } # End Else, if ($User.'msDS-SupportedEncryptionTypes' -band 0x4) 

        # Variabls for date
        $PasswordLastSet = Get-Date $User.PasswordLastSet
        $PasswordLastSetYear = $PasswordLastSet.Year

        # Create color text for password
        $LastSetIn2023 = ""
        If ($PasswordLastSetYear -eq 2023) 
        { # Start if ($PasswordLastSetYear -eq 2023) 
          $LastSetIn2023 = "<font color='green'>Yes</font>"
        } # End if ($PasswordLastSetYear -eq 2023) 
        Else 
        { # Start Else, if ($PasswordLastSetYear -eq 2023) 
             $LastSetIn2023 = "<font color='Red'>No</font>"
        } # End Else, if ($PasswordLastSetYear -eq 2023) 

         If ($RC4Enabled -eq "No") 
        { # Start if ($RC4Enabled -eq 2023) 
          $RC4Enabled = "<font color='green'>No</font>"
        } # End if ($RC4Enabled -eq 2023) 
        Else 
        { # Start Else, if ($RC4Enabled -eq 2023) 
             $RC4Enabled = "<font color='Red'>Yes</font>"
        } # End Else, if ($RC4Enabled -eq 2023) 

        $Report += "<tr>"
        $Report += "<td>$($User.Name)</td>"
        $Report += "<td>$($User.PasswordLastSet)</td>"
        $Report += "<td>$($User.Description)</td>"
        $Report += "<td>$($User.Department)</td>"
        $Report += "<td>$($RC4Enabled)</td>"
        $Report += "<td>$($LastSetIn2023)</td>"
        $Report += "</tr>"

        $RowCount += 1
    } # End # Start foreach ($User in $PasswordLastSet)  

    # Save Html file
    $Report += "</table></body></html>"
    $Report | Out-File "$PSScriptRoot\HtmlReport\$ScriptName - UserAccountReport - $LogFileDate.html" 

} # End Try

Catch
{ # Start Catch
    Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Host "ERROR on $Section" -ForegroundColor Red
    Write-Warning $Error[0]
    Write-Host "Stopping Transcript and Script!" -ForegroundColor Red
    Stop-Transcript
    Exit
} # End Catch

#----------------------------------- End Script ------------------------------------------
Stop-Transcript

