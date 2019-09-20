#########################################################################################
#
#                      Software Suit
#  
# This program is helps you to install few important
# software silently with less input and efficiency from user
# 
#  
# This is scrpt will work both inside and outside office. 
#  
#
#########################################################################################



# The below section would start new PowerShell in elevated mode

param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

'Running with full privileges'

#Setting Execution policy for the current process to run
Set-ExecutionPolicy -ErrorAction SilentlyContinue -Force -Scope Process -ExecutionPolicy Unrestricted
Set-ExecutionPolicy -ErrorAction SilentlyContinue -Force -Scope Process -ExecutionPolicy RemoteSigned


# The command will disable UAC and won't prompt user for "Yes" or "No"
$val = Get-ItemProperty -Path hklm:software\microsoft\windows\currentversion\policies\system -Name "ConsentPromptBehaviorAdmin"
if($val.ConsentPromptBehaviorAdmin -ne 6)
{
 set-itemproperty -Path hklm:software\microsoft\windows\currentversion\policies\system -Name "ConsentPromptBehaviorAdmin" -value 6
}


$nl = [Environment]::NewLine
$restart = new-Object System.Management.Automation.Host.ChoiceDescription "&Restart","Restart";
$exit = new-Object System.Management.Automation.Host.ChoiceDescription "&Exit","Exit";


# The command will Enable UAC
<#---------------------------APP Configration------------------------- #>

<# APPCONFIG
   ---------
  e.g. $ChromeURL is the URL for Chrome
  e.g. $ChromeFileName is the downloaded filename without extension .exe/msu 
#>



<#----------- No.01 for SQL Server--------#>


<#++++++++++++++++++   For SQL Server 2017 (2017) ++++++++++++++++++ #>
# For Mumbai
$SQLServer17MUMFileSharePath="\\192.168.0.0\Site_Software\12_SQL_Server\SQLServer_2017\RTM\SQL_Server_2017_RTM"

# For Hyderbad
$SQLServer17HYDFileSharePath="\\192.168.0.0\Site_Software\4_SQL_Server\SQL Server 2017\SQL_Server_2017_RTM"

$SQLServer17FileName="setup"


$SQLServer2017URL="https://go.microsoft.com/fwlink/?linkid=853017"
$SQLServer2017URLFileName="SQLServer2017-SSEI-Expr"

<#++++++++++++++++++   For SQL Server 2016 (SP1) ++++++++++++++++++ #>

# For Mumbai
$SQLServer16MUMFileSharePath="\\192.168.0.0\Site_Software\12_SQL_Server\SQL_2016_Sp1\SQLServer2016SP1-FullSlipstream-x64-ENU"

# For Hyderbad
$SQLServer16HYDFileSharePath="\\192.168.0.0\Site_Software\4_SQL_Server\SQLExpress2016_SP1\SQLServer2016SP1-FullSlipstream-x64-ENU"

$SQLServer16FileName="setup"


$SQLServer2016URL="https://download.microsoft.com/download/B/F/2/BF2EDBB8-004D-47F3-AA2B-FEA897591599/SQLServer2016-SSEI-Expr.exe"
$SQLServer2016URLFileName="SQLServer2016-SSEI-Expr"




<#----------- No.02 for SSMS--------#>
# For Mumbai
$SQLSMSMUMFileSharePath="\\192.168.0.0\Site_Software\12_SQL_Server\SSMS_17"

# For Hyderbad
$SQLSMSHYDFileSharePath="\\192.168.0.0\Site_Software\4_SQL_Server\SQL Server 2017"

$SQLSMSFileName="SSMS 17.5 -Setup-ENU"

$SSMSURL="https://go.microsoft.com/fwlink/?linkid=867670"
$SSMSFileName="SSMS-Setup-ENU"




<#----------- No.03 for Visual Studio--------#>


<#++++++++++++++++++   For Visual Studio Express for desktop (2017) ++++++++++++++++++ #>

# For Mumbai
$VSExpressDesktop17MUMFileSharePath="\\192.168.0.0\Site_Software\0_Development_Software\VS_2017\Express_2017_for_Desktop"

# For Hyderbad
$VSExpressDesktop17HYDFileSharePath=""

$VSExpressDesktop17FileName="wdexpress_full"

$VSExpressDesktop17URL="http://aka.ms/vs/15/release/vs_WDExpress.exe"



<#++++++++++++++++++   For Visual Studio Express for desktop (2015) ++++++++++++++++++ #>

# For Mumbai
$VSExpressDesktop15MUMFileSharePath="\\192.168.0.0\Site_Software\0_Development_Software\VS_2017\Express_2015_for_Desktop"

# For Hyderbad
$VSExpressDesktop15HYDFileSharePath="\\192.168.0.0\Site_Software\3_Visual_Studio\VisualStudio_Express_2015\Express_2015_for_Desktop"

$VSExpressDesktop15FileName="vs_WDExpress"


$VSExpressDesktop15URL=""

$VSExpressDesktop15FileName=""

<#+++++++++++++++   For Visual Studio Professional ++++++++++++++++++ #>
# For Mumbai
$VSExpressProfMUMFileSharePath="\\192.168.0.0\Site_Software\0_Development_Software\VS_2015\VS_Prof_2015"

# For Hyderabad
$VSExpressProfHYDFileSharePath=""


$VSExpressProfURL=""
$VSExpressProfFileName="vs_professional"


<#+++++++++++++++++   For Visual Studio Express for web (2017) +++++++++++++ #>

# For Mumbai
$VSExpressWebMUMFileSharePath="\\192.168.0.0\Site_Software\0_Development_Software\VS_2015\Express_2015_for_Web"

# For Hyderbad
$VSExpressWebHYDFileSharePath="\\192.168.0.0\Site_Software\3_Visual_Studio\VisualStudio_Express_2015\Express_2015_for_Web"


$VSExpressWebFileName="vns_full"

$VSExpressWebURL="https://www.dropbox.com/s/j6fux8li3obj9eu/vsn_ENU__441099077.1503898815.exe?dl=1"
$VSExpressWebURLFileName="vsn_ENU__441099077.1503898815"

<#+++++++++++++++   For Visual Studio Code ++++++++++++++++++ #>
# For Mumbai
$VSCodeMUMFileSharePath=""

# For Hyderabad
$VSCodeHYDFileSharePath=""


$VSCodeURL="https://go.microsoft.com/fwlink/?Linkid=852157"
$VSCodeFileName="VSCodeSetup-x64-1.19.2"


<#----------- No.04 for Microsoft Office 365--------#>
$Office365URL="https://c2rsetup.officeapps.live.com/c2r/download.aspx?productReleaseID=O365ProPlusRetail&platform=X64&language=en-us&TaxRegion=sg&correlationId=45ff11c8-f6b8-47f2-88b8-97842f2b1143&token=06a0f4e0-f5e8-430b-a27b-0fb6423be779&version=O16GA&source=O15OLSO365&Br=1"
$Office365FileName="Setup.X64.en-us_O365ProPlusRetail_06a0f4e0-f5e8-430b-a27b-0fb6423be779_TX_SG_b_16_"

<#----------- No.05 for Microsoft Power BI Desktop--------#>
$PowerBIURL="https://go.microsoft.com/fwlink/?LinkId=521662&clcid=0x409"
$PowerBIFileName="PBIDesktop_x64"

<#----------- No.06 Annoconda--------#>
$AnnocondaURL="https://repo.continuum.io/archive/Anaconda3-5.0.1-Windows-x86_64.exe"
$AnnocondaFileName="Anaconda3-5.0.1-Windows-x86_64"

<#----------- No.07 for Microsoft Teams--------#>
$MicosoftTeamsURL="https://statics.teams.microsoft.com/production-windows-x64/1.0.00.34151/Teams_windows_x64.exe"
$MicosoftTeamsFileName="Teams_windows_x64"

<#----------- No.08 Skype--------#>
$SkypeURL="https://www.dropbox.com/s/qw6v3j1uqabtg72/SkypeSetupFull_Latest.exe?dl=1"
$SkypeFileName="SkypeSetupFull_Latest"

<#----------- No.09 for X-Lite--------#>
$XLiteURL="http://counterpath.s3.amazonaws.com/downloads/X-Lite_5.1.0_89322.exe"
$XLiteFileName="X-Lite_5.1.0_89322"

<#----------- No.10 for Mozilla Firefox--------#>
$FirefoxURL="https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
$FirefoxFileName="Firefox Installer"

<#----------- No.11 for Zoiper--------#>
$ZoiperURL="https://www.dropbox.com/s/d3bsxwhjv9gf9ie/Zoiper5_Installer_v5.2.12.exe?dl=1"
$ZoiperFileName="Zoiper5_Installer_v5.2.12"
                      


<#----------- No.12 for Google Chrome--------#>
$ChromeURL="http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$ChromeFileName="ChromeInstaller"


<#----------- No.13 for SSDT--------#>


<#++++++++++++++++++   SSDT for Visual Studio 2015 (17.4) ++++++++++++++++++ #>
$SSDTURL="https://go.microsoft.com/fwlink/?linkid=863440"
$SSDTFileName="SSDTSetup"

<#++++++++++++++++++   SSDT for Visual Studio 2017 (15.5.1) ++++++++++++++++++ #>
$SSDTURLNEW="https://go.microsoft.com/fwlink/?linkid=874716"
$SSDTFileNameNEW="SSDT-Setup-ENU"




<#---------------------------Program Execution------------------------- #>
do {cls
  [int] $choice1 = 0
  while ( $choice1 -lt 1 -or $choice1 -gt 14) {
Write-Host "Welcome to Software Suit, '$env:UserName'"$nl
Write-Host "Please enter the software category:$nl
            1 = SQL Server
            2 = SSMS (SQL Server Management Studio)
            3 = Visual Studio 
            4 = Microsoft Office 365 
            5 = Microsoft Power BI Desktop     
            6 = Anaconda Navigator  
            7 = Microsoft Teams 
            8 = Skype 
            9 = X-Lite 
            10 = Mozilla Firefox  
            11 = Zoiper 
            12 = Google Chrome 
            13 = SSDT (SQL Server Data Tools)  
            14 = Exit
            15 = Restart PC$nl


"
$choice1 = read-host -prompt "Select number & press enter"

switch ($choice1) 
    { 
        1 {         #******************* SQL SERVER  *****************************
            
            do{ cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = SQL SERVER 2017 RTM  $nl
            2 = SQL SERVER 2016 SP1 $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 
                             1 {
                                         do{ cls 
                                             [int] $choice3 = 0
                                               while ( $choice3 -eq 1 -or $choice3 -eq 2 -or $choice3 -eq 0 ) {cls
                                                Write-Host "Please enter the software category$nl$nl
                  1 = Install SQL SERVER 2017 RTM (Recommended if you are in office)  $nl
                  2 = Install SQL SERVER 2017 RTM  with Integerated, Analysis service and R Service 
                      (Recommended if you are in office)
                  
                  3 = Install SQL SERVER 2017 RTM (Download online) $nl
                  4 = Uninstall SQL SERVER 2017 RTM $nl
                  5 = Exit/Main Menu $nl
            
            "
                                                $choice3 = read-host -prompt "Select number & press enter"
           
                                               switch ($choice3) 
                                                   {      
                                                   
                                     1 {                                                                        
                                               <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection 

                                                 
                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$SQLServer17MUMFileSharePath
                                                                 $strFolderName2=$SQLServer17HYDFileSharePath
                                                                 $strFileName=$SQLServerFileName
                                                                 $strRootFolderName="c:\installer"

                                                                 $currentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name;
                                                                 $UserName=$env:UserName
                                                                 $PCName=$env:ComputerName
                                                                 $password = Read-Host -Prompt "Enter password for $UserName" -AsSecureString
                                                                 #$password=Read-Host -Prompt "Enter password for $UserName";
                                                                 #$password=$password -replace '\s',''
                                                                  $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
                                                                  $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)


                                                                 # Display Existing SQL Instance
                                                                       write-host -ForegroundColor Red  " Note: Existing SQL Server Instance in current machine:-" 
                                                                        
                                                                        (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances

                                                                 $INSTANCEName= Read-Host -Prompt "Enter Instance Name for your new SQL Server" 

                                                                 #New-Item -Path $strRootFolderName  -ItemType directory

                                                                                                     
                                                                    # Check if work directory exists if not create it

                                                                     If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName"
                                                                          
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName\SQL_Server_2017_RTM" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName\SQL_Server_2017_RTM" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        
                                                                        $cmd = "$strRootFolderName\SQL_Server_2017_RTM\setup.exe /qs /ACTION=Install /FEATURES=SQLEngine,FullText,LocalDB /INSTANCENAME='$INSTANCEName' /SECURITYMODE='SQL' /SAPWD='Pass@123' /SQLSYSADMINACCOUNTS='$currentUserName' /SQLSVCStartUpType='automatic' /AGTSVCACCOUNT='NT AUTHORITY\Network Service' /AGTSVCStartUpType='automatic' /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS=1"
                                                                       Invoke-Expression -command $cmd | out-null;
 
                                                                     # Wait XX Seconds for the installation to finish
                                                                      write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 280
                                                                                                                                               
 
                                                                      # Remove the installer

                                                                        rm -Force  -Recurse "$strRootFolderName\SQL_Server_2017_RTM"
                                      #>  
                                   } 

                                   2{
                                   
                                                                                                         
                                               <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection 

                                                 
                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$SQLServer17MUMFileSharePath
                                                                 $strFolderName2=$SQLServer17HYDFileSharePath
                                                                 $strFileName=$SQLServerFileName
                                                                 $strRootFolderName="c:\installer"

                                                                 $currentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name;
                                                                 $UserName=$env:UserName
                                                                 $PCName=$env:ComputerName
                                                                 $password = Read-Host -Prompt "Enter password for $UserName" -AsSecureString
                                                                 #$password=Read-Host -Prompt "Enter password for $UserName";
                                                                 #$password=$password -replace '\s',''
                                                                  $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
                                                                  $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

                                                                 # Display Existing SQL Instance
                                                                       write-host -ForegroundColor Red  " Note: Existing SQL Server Instance in current machine:-" 
                                                                        
                                                                        (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances

                                                                 $INSTANCEName= Read-Host -Prompt "Enter Instance Name for your new SQL Server" 

                                                                 New-Item -Path $strRootFolderName  -ItemType directory

                                                                                                     
                                                                    # Check if work directory exists if not create it

                                                                     If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName"
                                                                          
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName\SQL_Server_2017_RTM" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName\SQL_Server_2017_RTM" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        
                                                                        $cmd = "$strRootFolderName\SQL_Server_2017_RTM\setup.exe /qs /ACTION=Install /FEATURES=SQLEngine,IS,AS,RS,Conn,FullText,AdvancedAnalytics,SQL_INST_MR,SQL_INST_MPY,DREPLAY_CLT,LocalDB,BC,SDK,SNAC_SDK,RS_SHP,RS_SHPWFE /INSTANCENAME='$INSTANCEName' /SECURITYMODE='SQL' /SAPWD='Pass@123' /SQLSYSADMINACCOUNTS='$currentUserName' /SQLSVCStartUpType='automatic' /ASSVCACCOUNT='$currentUserName' /ASSVCPASSWORD='$password' /ASSYSADMINACCOUNTS='$currentUserName' /ISSVCACCOUNT='NT AUTHORITY\Network Service' /RSSVCACCOUNT='$currentUserName' /AGTSVCACCOUNT='NT AUTHORITY\Network Service' /AGTSVCStartUpType='automatic' /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS=1 /IACCEPTROPENLICENSETERMS='True' /IACCEPTPYTHONLICENSETERMS='True'"
                                                                       Invoke-Expression -command $cmd | out-null;
 
                                                                     # Wait XX Seconds for the installation to finish
                                                                       write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 280
                                                                                                                                               
 
                                                                      # Remove the installer

                                                                        rm -Force  -Recurse "$strRootFolderName\SQL_Server_2017_RTM"
                                    #>
                                   }

                                    3{
                                         # Path for the workdir
                                          $workdir = "c:\installer\"

                                         # Check if work directory exists if not create it

                                             If (Test-Path -Path $workdir -PathType Container)
                                                 { #Write-Host "$workdir already exists" -ForegroundColor Red
                                                 }
                    
                                              ELSE
                                                 { New-Item -Path $workdir  -ItemType directory }

                                          # Download the installer

                                              $source =$SQLServer2017URL
                                              $destination = "$workdir\$SQLServer2017URLFileName.exe"

                                                 # Check if Invoke-Webrequest exists otherwise execute WebClient
    
                                                 if (Get-Command 'Invoke-Webrequest')
                                                     {
                                                       Invoke-WebRequest $source -OutFile $destination
                                                     }
                                                  else
                                                      {
                                                       $WebClient = New-Object System.Net.WebClient
                                                       $webclient.DownloadFile($source, $destination)
                                                      }

                                             # Start the installation
                
                                                  Start-Process -FilePath "$workdir\$SQLServer2017URLFileName.exe" -ArgumentList "/VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"
        
                                             # Wait XX Seconds for the installation to finish
                                                write-host "Please wait while setup is fully completed.."
                                                  Start-Sleep -s 60

                                             # Remove the installer

                                                     rm -Force -Recurse $workdir\"$SQLServer2017URLFileName"*
                        
                    } 
                            

                               
                             
                                    4 {                                                                    
                                               <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection #>

                                                 
                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being deleted.."

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$SQLServer17MUMFileSharePath
                                                                 $strFolderName2=$SQLServer17HYDFileSharePath
                                                                 $strFileName=$SQLServerFileName
                                                                 $strRootFolderName="c:\installer"

                                                                 $currentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name;
                                                                 $UserName=$env:UserName
                                                                 $PCName=$env:ComputerName
                                                                 $password = Read-Host -Prompt "Enter password for $UserName" -AsSecureString
                                                                 $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
                                                                 $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

                                                                 # Display Existing SQL Instance
                                                                       write-host -ForegroundColor Red  " Note: Existing SQL Server Instance in current machine:-" 
                                                                        
                                                                        (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances

                                                                 $INSTANCEName= Read-Host -Prompt "Enter Instance Name of SQL Server you want to uninstall" 

                                                                 New-Item -Path $strRootFolderName  -ItemType directory

                                                                                                     
                                                                    # Check if work directory exists if not create it

                                                                     If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName"
                                                                          
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being deleted.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName\SQL_Server_2017_RTM" -Force -Recurse

                                                                        write-host "Starting the Uninstallation.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         #write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName\SQL_Server_2017_RTM" -Force -Recurse

                                                                        write-host "Starting the Uninstallation.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }
                                                                       
                                                                     Else
                                                                     { 
                                                                       Appwiz
                                                                      }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        
                                                                        $cmd = "$strRootFolderName\SQL_Server_2017_RTM\setup.exe /qs /ACTION=UNINSTALL /FEATURES=SQLEngine,IS,Conn,FullText,AdvancedAnalytics,DREPLAY_CLT,LocalDB /INSTANCENAME='$INSTANCEName'"
                                                                       Invoke-Expression -command $cmd | out-null;
                                                                    
                                                                     write-host "Please wait while all the files are being removed.."

                                                                     # Wait XX Seconds for the installation to finish
                                                                       write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 160
                                                                                                                                               
 
                                                                      # Remove the installer
                                                                                       
                                                                        Remove-Item -Recurse -Force "C:\Program Files\Microsoft SQL Server\MSSQL14.$INSTANCEName\"                     
                                                                        rm -Force  -Recurse "$strRootFolderName\SQL_Server_2017_RTM"
            
                                  }

                                   
                                    5 {break
                                  }
                          
                                                        default {""}
                                                    }
                                              } 
                                         cls } while ( $choice3 -ne 5 )     
                                         cls}
                 
                 



                             

                           2 {
                                

                                 
                                         do{ cls 
                                             [int] $choice3 = 0
                                               while ( $choice3 -eq 1 -or $choice3 -eq 2 -or $choice3 -eq 0) {cls
                                                Write-Host "Please enter the software category$nl$nl
                  1 = Install SQL SERVER 2016 SP1 (Recommended if you are in office)  $nl
                  2 = Install SQL SERVER 2016 SP1 (Download online) $nl
                  3 = Uninstall Install SQL SERVER 2016 SP1$nl
                  4 = Exit/Main Menu $nl
            
            "
                                                $choice3 = read-host -prompt "Select number & press enter"
           
                                               switch ($choice3) 
                                                   {      
                                                   
                                     1 {

                                         <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection

                                                 
                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$SQLServer16MUMFileSharePath
                                                                 $strFolderName2=$SQLServer16HYDFileSharePath
                                                                 $strFileName=$SQLServerFileName
                                                                 $strRootFolderName="c:\installer"

                                                                 $currentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name;
                                                                 $UserName=$env:UserName
                                                                 $PCName=$env:ComputerName
                                                                 $password = Read-Host -Prompt "Enter password for $UserName" -AsSecureString
                                                                 #$password=Read-Host -Prompt "Enter password for $UserName";
                                                                 #$password=$password -replace '\s',''
                                                                  $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
                                                                  $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                                                                 
                                                                 # Display Existing SQL Instance
                                                                       write-host -ForegroundColor Red  " Note: Existing SQL Server Instance in current machine:-" 
                                                                        
                                                                        (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances

                                                                 $INSTANCEName= Read-Host -Prompt "Enter Instance Name for your new SQL Server" 

                                                                 New-Item -Path $strRootFolderName  -ItemType directory

                                                                                                     
                                                                    # Check if work directory exists if not create it

                                                                     If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName"
                                                                          
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        
                                                                        $cmd = "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU\setup.exe /qs /ACTION=Install /FEATURES=SQLENGINE,FULLTEXT,IS,AS,RS,BC,SDK,SNAC_SDK,ADVANCEDANALYTICS /INSTANCENAME='$INSTANCEName' /SECURITYMODE='SQL' /SAPWD='Pass@123' /SQLSYSADMINACCOUNTS='$currentUserName' /SQLSVCStartUpType=Automatic /AGTSVCACCOUNT='$currentUserName' /AGTSVCPASSWORD='$password' /ASSYSADMINACCOUNTS='$currentUserName' /RSSVCACCOUNT='$currentUserName' /RSSVCPASSWORD='$currentUserName' /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS=1 /UPDATEENABLED=True"
                                                                       Invoke-Expression -command $cmd | out-null;
                                                                                                                                                                  
 
                                                                     # Wait XX Seconds for the installation to finish
                                                                       write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 280
                                                                                                                                               
 
                                                                      # Remove the installer

                                                                        rm -Force  -Recurse "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU"
                                       #>
                                   } 

                                    2{
                                          # Path for the workdir
                                          $workdir = "c:\installer\"

                                         # Check if work directory exists if not create it

                                             If (Test-Path -Path $workdir -PathType Container)
                                                 { #Write-Host "$workdir already exists" -ForegroundColor Red
                                                 }
                    
                                              ELSE
                                                 { New-Item -Path $workdir  -ItemType directory }

                                          # Download the installer

                                              $source =$SQLServer2016URL
                                              $destination = "$workdir\$SQLServer2016URLFileName.exe"

                                                 # Check if Invoke-Webrequest exists otherwise execute WebClient
    
                                                 if (Get-Command 'Invoke-Webrequest')
                                                     {
                                                       Invoke-WebRequest $source -OutFile $destination
                                                     }
                                                  else
                                                      {
                                                       $WebClient = New-Object System.Net.WebClient
                                                       $webclient.DownloadFile($source, $destination)
                                                      }

                                             # Start the installation
                
                                                  Start-Process -FilePath "$workdir\$SQLServer2016URLFileName.exe" -ArgumentList "/VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"
        
                                             # Wait XX Seconds for the installation to finish
                                                 write-host "Please wait while setup is fully completed.."
                                                  Start-Sleep -s 60

                                             # Remove the installer

                                                     rm -Force -Recurse $workdir\"$SQLServer2016URLFileName"*
                        
                    } 
                            

                               
                             
                                    3 {   
                                             
                                                <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection

                                                 
                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$SQLServer16MUMFileSharePath
                                                                 $strFolderName2=$SQLServer16HYDFileSharePath
                                                                 $strFileName=$SQLServerFileName
                                                                 $strRootFolderName="c:\installer"

                                                                 $currentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name;
                                                                 $UserName=$env:UserName
                                                                 $PCName=$env:ComputerName
                                                                 $password = Read-Host -Prompt "Enter password for $UserName" -AsSecureString
                                                                 #$password=Read-Host -Prompt "Enter password for $UserName";
                                                                 #$password=$password -replace '\s',''
                                                                  $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
                                                                  $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

                                                                 # Display Existing SQL Instance
                                                                       write-host -ForegroundColor Red  " Note: Existing SQL Server Instance in current machine:-" 
                                                                        
                                                                        (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances

                                                                 $INSTANCEName= Read-Host -Prompt "Enter Instance Name for your new SQL Server" 

                                                                 New-Item -Path $strRootFolderName  -ItemType directory

                                                                                                     
                                                                    # Check if work directory exists if not create it

                                                                     If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName"
                                                                          
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being deleted.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU" -Force -Recurse

                                                                        write-host "Starting the Uninstallation.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         #write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU" -Force -Recurse

                                                                        write-host "Starting the Uninstallation.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                   Else
                                                                     { 
                                                                       Appwiz
                                                                      }     
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        
                                                                        $cmd = "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU\setup.exe /qs /ACTION=UNINSTALL /FEATURES=SQLEngine,IS,AS,RS,Conn,FullText,AdvancedAnalytics,DREPLAY_CLT,LocalDB,BC,SDK,SNAC_SDK,RS_SHP,RS_SHPWFE /INSTANCENAME='$INSTANCEName'"
                                                                       Invoke-Expression -command $cmd | out-null;
                                                                     
                                                                     write-host "Please wait while all the files are being removed.."

                                                                     # Wait XX Seconds for the installation to finish

                                                                        Start-Sleep -s 220
                                                                                                                                               
 
                                                                      # Remove the installer
                                                                                       
                                                                        Remove-Item -Recurse -Force "C:\Program Files\Microsoft SQL Server\MSSQL13.$INSTANCEName\"                     
                                                                        rm -Force  -Recurse "$strRootFolderName\SQLServer2016SP1-FullSlipstream-x64-ENU"
                                        #>         
            
                                  }

                                   
                                    4 {break
                                  }
                          
                                                        default {""}
                                                    }
                                              } 
                                             cls} while ( $choice3 -ne 4 )     
                                         cls

                            
                             }
                            
                          

                           3 {break}
                
                          
                                        default {""}
                                       }
                                 cls  } 
                                 cls } while ( $choice2 -ne 3 )
            
          }

        2 { #******************* SSMS (SQL Server Management Studio ) *****************************
            
            do{ cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {cls
               Write-Host "Please enter the software category$nl$nl
            1 = Install SSMS (SQL Server Management Studio) Recommended if you are in office  $nl
            2 = Install SSMS (SQL Server Management Studio) Download online $nl
            3 = Uninstall SSMS (SQL Server Management Studio)$nl
            4 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 
                 1 {                                  


                                    <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection 

                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1="$SQLSMSMUMFileSharePath"
                                                                 $strFolderName2=$SQLSMSHYDFileSharePath
                                                                 $strFileName=$SQLSMSFileName
                                                                 $strRootFolderName="c:\installer\"

                                                                        New-Item -Path $strRootFolderName  -ItemType directory                              
                                                                    # Check if work directory exists if not create it

                                                                      If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName\$SQLSMSFileName.exe"
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName1\$SQLSMSFileName.exe" -Destination "$strRootFolderName\$SQLSMSFileName.exe" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2\$SQLSMSFileName.exe" -Destination "$strRootFolderName\$SQLSMSFileName.exe" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        Start-Process -FilePath "$strRootFolderName\$strFileName.exe" -ArgumentList "/install /passive /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH "
                                                                        
                                                                        
                                                                     # Wait XX Seconds for the installation to finish
                                                                        write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 280
 
                                                                      # Remove the installer

                                                                        rm -Force -Recurse $strRootFolderName\"$SQLSMSFileName"*
                        #>
                   
                   }
                 
                 
                 2 {
                     # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                    
                    ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$SSMSURL"
                        $destination = "$workdir\$SSMSFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                
                            Start-Process -FilePath "$workdir\$SSMSFileName.exe" -ArgumentList "/install /passive /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"
                            
                        # Wait XX Seconds for the installation to finish
                            write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 60

                        # Remove the installer

                            rm -Force -Recurse $workdir\"$SSMSFileName"*
                        
                    } 
                 
            
                 
                 3 {
                         appwiz
                       
                     $name ="SQL Server Management Studio"  
                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}
            
                    }

                4 {break
                  }
                          
             default {""}
             }
        cls } 
       cls} while ( $choice2 -ne 4 )
            
          } 
        
        3 {
            

            #******************* Visual Studio *****************************
            
            do{ cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = VS Express 2015 for Web  $nl
            2 = VS Express 2015 for Desktop $nl
            3 = Visual Studio 2015 Professional $nl
            4 = Visual Studio Code $nl
            5 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 
                             1 {
                                         do{ cls 
                                             [int] $choice3 = 0
                                               while ( $choice3 -eq 1 -or $choice3 -eq 2 -or $choice3 -eq 0) {cls
                                                Write-Host "Please enter the software category$nl$nl
                  1 = Install VS Express for Web (Recommended if you are in office)  $nl
                  2 = Install VS Express for Web (Download online) $nl
                  3 = Uninstall VS Express for Web $nl
                  4 = Exit/Main Menu $nl
            
            "
                                                $choice3 = read-host -prompt "Select number & press enter"
           
                                               switch ($choice3) 
                                                   {      
                                                   
                                     1 {                      
                                               <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection 

                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$VSExpressWebMUMFileSharePath
                                                                 $strFolderName2=$VSExpressWebHYDFileSharePath
                                                                 $strFileName=$VSExpressWebFileName
                                                                 $strRootFolderName="c:\installer\"

                                                                 New-Item -Path $strRootFolderName  -ItemType directory
                                     
                                                                    # Check if work directory exists if not create it

                                                                      If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName\Express_2015_for_Web"
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        Start-Process -FilePath "$strRootFolderName\Express_2015_for_Web\$strFileName.exe" -ArgumentList "/Full /Passive /NoRestart"
                                                                        
                                                                     # Wait XX Seconds for the installation to finish
                                                                        write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 380
 
                                                                      # Remove the installer

                                                                        rm -Force -Recurse "$strRootFolderName\Express_2015_for_Web"   
                                                                                                           

                                                #>
                        
                                   } 

                                    2{
                                         # Path for the workdir
                                          $workdir = "c:\installer\"

                                         # Check if work directory exists if not create it

                                             If (Test-Path -Path $workdir -PathType Container)
                                                 { #Write-Host "$workdir already exists" -ForegroundColor Red
                                                 }
                    
                                              ELSE
                                                 { New-Item -Path $workdir  -ItemType directory }

                                          # Download the installer

                                              $source = "$VSExpressWebURL"
                                              $destination = "$workdir\$VSExpressWebURLFileName.exe"

                                                 # Check if Invoke-Webrequest exists otherwise execute WebClient
    
                                                 if (Get-Command 'Invoke-Webrequest')
                                                     {
                                                       Invoke-WebRequest $source -OutFile $destination
                                                     }
                                                  else
                                                      {
                                                       $WebClient = New-Object System.Net.WebClient
                                                       $webclient.DownloadFile($source, $destination)
                                                      }

                                             # Start the installation
                
                                                  Start-Process -FilePath "$workdir\$VSExpressWebURLFileName" -ArgumentList "/Full /Passive /NoRestart"
        
                                             # Wait XX Seconds for the installation to finish
                                                  write-host "Please wait while setup is fully completed.."
                                                  Start-Sleep -s 320

                                             # Remove the installer

                                                     rm -Force -Recurse "$workdir\$VSExpressWebURLFileName.exe"
                        
                    } 
                            

                               
                             
                                    3 {   
                                             
                                                #Firstly, we need to know the location and the file name we're going to run

                                                   $Path = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\WDExpress.exe"

                                                  # Are there any switches that the app requires?

                                                      $Switch = "/Uninstall /Force /norestart"

                                                 # We'll run the program here

                                                      $process = Start-Process -FilePath $Path -ArgumentList $Switch -Wait

                                                 #Lets get some logging going.

                                                      # Add-Content C:\LogFolder\logs\MSI\Firefox_Uninstall_1.0_001.log $LASTEXITCODE﻿
                                                
            
                                  }

                                   
                                    4 {break
                                  }
                          
                                                        default {""}
                                                    }
                                              } 
                                            cls } while ( $choice3 -ne 4 )     
                                         cls}
                 
                 





                           2 {
                                

                                 
                                         do{ cls 
                                             [int] $choice3 = 0
                                               while ( $choice3 -eq 1 -or $choice3 -eq 2 -or $choice3 -eq 0) {
                                                Write-Host "Please enter the software category$nl$nl
                  1 = Install VS Express 2017 for Desktop (Recommended if you are in office)  $nl
                  2 = Install VS Express 2015 for Desktop (Recommended if you are in office)  $nl
                  3 = Install VS Express 2017 for Desktop (Download online) $nl
                  4 = Uninstall VS Express for Desktop $nl
                  5 = Exit/Main Menu $nl
            
            "
                                                $choice3 = read-host -prompt "Select number & press enter"
           
                                               switch ($choice3) 
                                                   {      
                                                   
                                     1 {
                    
                                               <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection 

                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$VSExpressDesktop17MUMFileSharePath
                                                                 $strFolderName2=$VSExpressDesktop17HYDFileSharePath
                                                                 $strFileName=$VSExpressDesktop17FileName
                                                                 $strRootFolderName="c:\installer\"

                                                                 New-Item -Path $strRootFolderName  -ItemType directory
                                     
                                                                    # Check if work directory exists if not create it

                                                                      If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName\Express_2017_for_Desktop"
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        Start-Process -FilePath "$strRootFolderName\Express_2017_for_Desktop\$strFileName" -ArgumentList "/VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"
 
                                                                     # Wait XX Seconds for the installation to finish
                                                                        write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 280
 
                                                                      # Remove the installer

                                                                        rm -Force -Recurse "$strRootFolderName\Express_2017_for_Desktop"
                                                 #>        
                        
                                   } 

                                    2{                                   
                                                    
                                              <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection

                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$VSExpressDesktop15MUMFileSharePath
                                                                 $strFolderName2=$VSExpressProfHYDFileSharePath
                                                                 $strFileName=$VSExpressDesktop15FileName
                                                                 $strRootFolderName="c:\installer\"

                                                                 New-Item -Path $strRootFolderName  -ItemType directory
                                     
                                                                    # Check if work directory exists if not create it

                                                                      If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName\Express_2015_for_Desktop"
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        Start-Process -FilePath "$strRootFolderName\Express_2015_for_Desktop\$strFileName" -ArgumentList "/Full /Passive /NoRestart"
 
                                                                     # Wait XX Seconds for the installation to finish
                                                                       write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 280
 
                                                                      # Remove the installer

                                                                        rm -Force -Recurse "$strRootFolderName\Express_2015_for_Desktop"                                                                                                                                     
                                                                                             
                                                                            
                                         #>
                                    
                                     }
                                    
                                    
                                   3{
                                         # Path for the workdir
                                          $workdir = "c:\installer\"

                                         # Check if work directory exists if not create it

                                             If (Test-Path -Path $workdir -PathType Container)
                                                 { #Write-Host "$workdir already exists" -ForegroundColor Red
                                                 }
                    
                                              ELSE
                                                 { New-Item -Path $workdir  -ItemType directory }

                                          # Download the installer

                                              $source = "$VSExpressDesktop17URL"
                                              $destination = "$workdir\$VSExpressDesktop17FileName.exe"

                                                 # Check if Invoke-Webrequest exists otherwise execute WebClient
    
                                                 if (Get-Command 'Invoke-Webrequest')
                                                     {
                                                       Invoke-WebRequest $source -OutFile $destination
                                                     }
                                                  else
                                                      {
                                                       $WebClient = New-Object System.Net.WebClient
                                                       $webclient.DownloadFile($source, $destination)
                                                      }

                                             # Start the installation
                
                                                  Start-Process -FilePath "$workdir\$VSExpressDesktop17FileName.exe" #-ArgumentList "/VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"
        
                                             # Wait XX Seconds for the installation to finish
                                                 write-host "Please wait while setup is fully completed.."
                                                  Start-Sleep -s 60

                                             # Remove the installer

                                                     rm -Force -Recurse $workdir\"$VSExpressDesktop17FileName"*
                        
                    } 
                            

                               
                             
                                    4 {   
                                             
                                                #Firstly, we need to know the location and the file name we're going to run

                                                   $Path = "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe"

                                                  # Are there any switches that the app requires?

                                                      $Switch = "uninstall $Path"

                                                 # We'll run the program here

                                                      Start-Process -FilePath $Path 

                                                      #$process = Start-Process -FilePath $Path -ArgumentList $Switch -Wait

                                                 #Lets get some logging going.

                                                      # Add-Content C:\LogFolder\logs\MSI\Firefox_Uninstall_1.0_001.log $LASTEXITCODE﻿
                                                
            
                                  }

                                   
                                    5 {break
                                  }
                          
                                                        default {""}
                                                    }
                                              } 
                                             cls} while ( $choice3 -ne 5 )     
                                         cls

                            
                             }
                            
                           3 {  #VS_Prof_2015
                                    
                                

                                 
                                   do{ cls 
                                      [int] $choice3 = 0
                                       while ( $choice3 -eq 1 -or $choice3 -eq 2 -or $choice3 -eq 0 -or $choice3 -eq 3) {
              Write-Host "Please enter the software category:$nl$nl
                          1 = Install Visual Studio 2015 Professional (Recommended if you are in office) $nl
                          2 = Install Visual Studio 2015 Professional (Download online) $nl
                          3 = Uninstall Visual Studio 2015 Professional $nl
                          4 = Exit/Main Menu $nl
            
                                   "
                                    $choice3 = read-host -prompt "Select number & press enter"
           
                                               switch ($choice3) 
                                                    {      
                                                   
                                                                     1 {              
                                                                              <# Check to see if a connection already exists to File Share, if exists then delete the current connection 
                                                 and create a new one, else create a new connection 

                                                     $checkpath = Test-Path "\\192.168.0.0\scripts"

                                                     if($checkpath -eq "TRUE")
                                                          {
                                                              Write-Host 'Deleting the exisiting connection to File Share'
                                                               Start-Sleep -s 1
                                                                 net use \\192.168.0.0 /Delete
                                                                 Write-Host 'Initiating a new connection to File Share'
                                                                  Start-Sleep -s 1
                                                                  net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                          }
                                    
                                                     else
                                                          {
                                                             Write-Host 'Initiating a new connection to File Share'
                                                             Start-Sleep -s 1
                                                              net use \\192.168.0.0 Password /user:username /Persistent:Yes
                                                             }

                                    
                                                                write-host "Please wait while the files are being copied to c:\installer\"

                                                                #Check to see if the folder exists, if exists then delete the folder and its content
                                                                 


                                                                 $strFolderName1=$VSExpressProfMUMFileSharePath
                                                                 $strFolderName2=$VSExpressProfHYDFileSharePath
                                                                 $strFileName=$VSExpressProfFileName
                                                                 $strRootFolderName="c:\installer\"

                                                                 New-Item -Path $strRootFolderName  -ItemType directory
                                     
                                                                    # Check if work directory exists if not create it

                                                                      If (Test-Path -Path $strRootFolderName -PathType Container)
                                                                       { #Write-Host "strFolderName already exists" -ForegroundColor Red
                                                                          rm -Force -Recurse "$strRootFolderName\VS_Prof_2015"
                                                                       }
                                      
                                                                      ELSE
                                                                       { New-Item -Path $strRootFolderName  -ItemType directory }
                                                                  
                                                                  
                                                                   # Check if fileshare of Mumbai  
                                                                   
                                                                    If (Test-Path -Path $strFolderName1 -PathType Container)
                                                                       { 
                                                                            #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path  "$strFolderName1" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                
                                                                       }
                                      
                                                                   # Check if fileshare of Hyderabad
                                                                  
                                                                     ELSEIF(Test-Path -Path $strFolderName2 -PathType Container)
                                                                  
                                                                       { #Copy the updates from File Share to c:\installer\(Creates a folder if required)
                                        
                                                                         write-host -ForegroundColor Green "Kindly wait till the files are being copied into local machine.."
                                         
                                                                         Copy-Item -Path "$strFolderName2" -Destination "$strRootFolderName" -Force -Recurse

                                                                        write-host "Starting the Installations.." #Notify the user about Installations
                                                                       
                                                                       
                                                                       }         
                                    
                                                                    
                                                                           
                                                                     #write-host "If the UAC prompt shows up click 'Yes', Clicking 'No' will terminate the script.." #Notify the user about UAC prompt
                                                                        Start-Sleep -s 3 #wait for 3 seconds

                                                                     # Start the installation
                
                                                                        Start-Process -FilePath "$strRootFolderName\VS_Prof_2015\$strFileName" -ArgumentList "/Full /Passive /NoRestart"
 
                                                                     # Wait XX Seconds for the installation to finish
                                                                       write-host "Please wait while setup is fully completed.."
                                                                        Start-Sleep -s 280
 
                                                                      # Remove the installer

                                                                        rm -Force -Recurse "$strRootFolderName\VS_Prof_2015"                                                                                                                                     
                                                                                             
                                                                            
                                    
                                                                       #>                             
                                                         
                        
                                                                     } 

                                                                    2{   Write-Host 'Sorry, Currently we dont have Visual Studio 2015 Professional from Online'
                                                                         Start-Sleep -s 3
                                                                         <# Path for the workdir
                                                                          $workdir = "c:\installer\"

                                                                         # Check if work directory exists if not create it

                                                                             If (Test-Path -Path $workdir -PathType Container)
                                                                                 { Write-Host "$workdir already exists" -ForegroundColor Red}
                    
                                                                              ELSE
                                                                                 { New-Item -Path $workdir  -ItemType directory }

                                                                          # Download the installer

                                                                              $source = "http://aka.ms/vs/15/release/vs_WDExpress.exe"
                                                                              $destination = "$workdir\vs_WDExpress.exe"

                                                                                 # Check if Invoke-Webrequest exists otherwise execute WebClient
    
                                                                                 if (Get-Command 'Invoke-Webrequest')
                                                                                     {
                                                                                       Invoke-WebRequest $source -OutFile $destination
                                                                                     }
                                                                                  else
                                                                                      {
                                                                                       $WebClient = New-Object System.Net.WebClient
                                                                                       $webclient.DownloadFile($source, $destination)
                                                                                      }

                                                                             # Start the installation
                
                                                                                  Start-Process -FilePath "$workdir\vs_WDExpress.exe" -ArgumentList "/VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"
        
                                                                             # Wait XX Seconds for the installation to finish

                                                                                  Start-Sleep -s 60

                                                                             # Remove the installer

                                                                                     rm -Force $workdir\vs_WDExpress*
                                                                                     #>
                        
                                                    } 
                            

                               
                             
                                                                    3 {   appwiz
                                             
                                                                                <#Firstly, we need to know the location and the file name we're going to run

                                                                                   $Path = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"

                                                                                  # Are there any switches that the app requires?

                                                                                      $Switch = "/uninstall /force"

                                                                                 # We'll run the program here

                                                                                      Start-Process -FilePath $Path -ArgumentList $Switch -wait

                                                                                      #$process = Start-Process -FilePath $Path -ArgumentList $Switch -Wait

                                                                                 #Lets get some logging going.

                                                                                      # Add-Content C:\LogFolder\logs\MSI\Firefox_Uninstall_1.0_001.log $LASTEXITCODE﻿
                                                                                  #>
            
                                                                  }

                                   
                                                                    4 {break
                                                                  }
                          
                                                                                        default {""}
                                                                                    }
                                                                              } 
                                                                             cls} while ( $choice3 -ne 4 )     
                                                                         cls

                                         }

                                       4{
                                       
                                           do{ cls 
                                             [int] $choice3 = 0
                                               while ( $choice3 -eq 1 -or $choice3 -eq 2 -or $choice3 -eq 0) {cls
                                                Write-Host "Please enter the software category$nl$nl
                  1 = Install VS Code (Download online) $nl
                  2 = Uninstall VS Code $nl
                  3 = Exit/Main Menu $nl
            
            "
                                                $choice3 = read-host -prompt "Select number & press enter"
           
                                               switch ($choice3) 
                                                   {      
                                                   
                                     1 {                      
                                              # Path for the workdir
                                          $workdir = "c:\installer\"

                                         # Check if work directory exists if not create it

                                             If (Test-Path -Path $workdir -PathType Container)
                                                 { #Write-Host "$workdir already exists" -ForegroundColor Red
                                                 }
                    
                                              ELSE
                                                 { New-Item -Path $workdir  -ItemType directory }

                                          # Download the installer

                                              $source = "$VSCodeURL"
                                              $destination = "$workdir\$VSCodeFileName.exe"

                                                 # Check if Invoke-Webrequest exists otherwise execute WebClient
    
                                                 if (Get-Command 'Invoke-Webrequest')
                                                     {
                                                       Invoke-WebRequest $source -OutFile $destination
                                                     }
                                                  else
                                                      {
                                                       $WebClient = New-Object System.Net.WebClient
                                                       $webclient.DownloadFile($source, $destination)
                                                      }

                                             # Start the installation
                
                                                  Start-Process -FilePath "$workdir\$VSCodeFileName" -ArgumentList " /NoRestart /VERYSILENT /MERGETASKS=!runcode"
        
                                             # Wait XX Seconds for the installation to finish
                                                  write-host "Please wait while setup is fully completed.."
                                                  Start-Sleep -s 30

                                                  write-host "$nl $nl Installation is complete"
                                                  Start-Sleep -s 3
                                             # Remove the installer

                                                     rm -Force -Recurse "$workdir\$VSCodeFileName.exe"                                                             

                                                
                        
                                   } 

                     
                            

                               
                             
                                    2 {   
                                             
                                            $name ="Code"  

                              stop-process -name "Code"  -Force -ErrorAction SilentlyContinue
            
                                      # Firstly, we need to know the location and the file name we're going to run

                                         $Path = "C:\Program Files\Microsoft VS Code\unins000.exe"

                                      # Are there any switches that the app requires?

                                          $Switch = "-ms -uninstall /VERYSILENT /SP- /NOCANCEL"

                                     # We'll run the program here

                                          $process = Start-Process -FilePath $Path -ArgumentList $Switch -Wait -ErrorAction SilentlyContinue

                                      Write "$nl $nl Please wait while uninstalling the software..."

                                $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString
                                $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString

                                    if ($uninstall64) {
                                        $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                        $uninstall64 = $uninstall64.Trim()
                                        Write "Uninstalling..."
                                        start-process "msiexec.exe" -arg "/X $uninstall64 /qb /quiet" -Wait}
                                        if ($uninstall32) {
                                        $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                        $uninstall32 = $uninstall32.Trim()
                                        Write "Uninstalling..."
                                        start-process "msiexec.exe" -arg "/X $uninstall32 /qb /quiet" -Wait}
            
                             $strFolderNameS="$env:APPDATA\Code"
                             Remove-Item "$strFolderNameS" –Force -Recurse
            
                                  }

                                   
                                    3 {break
                                  }
                          
                                                        default {""}
                                                    }
                                              } 
                                            cls } while ( $choice3 -ne 3 )
                                       
                                       
                                         }

                                       5 {break}
                
                          
                                        default {""}
                                       }
                                 cls  } 
                                 cls } while ( $choice2 -ne 5 )
            
          } 

        4 {
             #*******************Microsoft Office 365*****************************
             do { cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install Microsoft Office 365$nl
            2 = Uninstall Microsoft Office 365$nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                     # Path for the workdir
                           $workdir = "c:\installer\"
                           $downloaddir="c:\installer\Microsoft_Office"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                     If (Test-Path -Path $downloaddir -PathType Container)
                        { #Write-Host "$downloaddir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $downloaddir  -ItemType directory }

                        # Download the installer

                        $source = "$Office365URL"
                        $destination = "$workdir\$Office365FileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                
                            Start-Process -FilePath "$workdir\$Office365FileName.exe" #-ArgumentList "/Install /VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"

                        # Wait XX Seconds for the installation to finish
                           write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 60

                        # Remove the installer

                            rm -Force -Recurse $workdir
                        
                    } 

                 2 { 
                     write-host "Please wait while Microsoft Office is being uninstalled.."
                                        
                     
                                     
                                       rm -Force  -Recurse "C:\Program Files\Microsoft Office"

                                       # Remove Office Automatic Updates schedule
                                        $Path = "C:\Windows\System32\schtasks.exe"
                                        $ARGS =  @(
                                          '/DELETE',
                                          "/TN ""Office Automatic Updates""",
                                          "/f"
                                         )
                                             Start-Process -FilePath $Path -ArgumentList $ARGS -Verb Runas -Wait -ErrorAction SilentlyContinue
                     
                     
                                     # Remove Office Subscription Maintenance
                                     $Path = "C:\Windows\System32\schtasks.exe"
                                        $ARGS =  @(
                                          '/DELETE',
                                          "/TN ""Office Subscription Maintenance""",
                                          "/f"
                                         )
                                             Start-Process -FilePath $Path -ArgumentList $ARGS -Verb Runas -Wait -ErrorAction SilentlyContinue

                                             Office ClickToRun Service Monitor
                 
                                      # Remove Office ClickToRun Service Monitor
                                     $Path = "C:\Windows\System32\schtasks.exe"
                                        $ARGS =  @(
                                          '/DELETE',
                                          "/TN ""Office ClickToRun Service Monitor""",
                                          "/f"
                                         )
                                             Start-Process -FilePath $Path -ArgumentList $ARGS -Verb Runas -Wait -ErrorAction SilentlyContinue

                                     # Remove Office OfficeTelemetryAgentLogOn2016
                                     $Path = "C:\Windows\System32\schtasks.exe"
                                        $ARGS =  @(
                                          '/DELETE',
                                          "/TN ""OfficeTelemetryAgentLogOn2016""",
                                          "/f"
                                         )
                                             Start-Process -FilePath $Path -ArgumentList $ARGS -Verb Runas -Wait -ErrorAction SilentlyContinue

                    
                                     # Remove OfficeTelemetryAgentFallBack2016
                                     $Path = "C:\Windows\System32\schtasks.exe"
                                        $ARGS =  @(
                                          '/DELETE',
                                          "/TN ""OfficeTelemetryAgentFallBack2016""",
                                          "/f"
                                         )
                                             Start-Process -FilePath $Path -ArgumentList $ARGS -Verb Runas -Wait -ErrorAction SilentlyContinue


                                 # Stop Click to run Task

                                    stop-process -name "OfficeClickToRun"  -Force
                                    stop-process -name "OfficeC2RClient"  -Force
                                    stop-process -name "AppVShNotify"  -Force
                                    stop-process -name "setup*"  -Force

                                Remove-Service -Name "ClickToRunSvc"

                               rm -Force  -Recurse "C:\Program Files(x86)\Microsoft Office"
                               rm -Force  -Recurse "$env:CommonProgramFiles\Microsoft Shared\ClickToRun”
                               rm -Force  -Recurse "$env:ProgramData\Microsoft\ClickToRun folder"
                               rm -Force  -Recurse "$env:ProgramData\Microsoft\Office\ClickToRunPackagerLocker"
            
                              # Removing Registry Key

                                 $Reg ="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office"
                                 $KeyName ="ClickToRun"
                                    Get-ChildItem "Registry::$Reg" | 
                                    ForEach-Object {if ($_ -match "$KeyName"){Remove-Item -Force  -Recurse -Path "Registry::$_" }}

                                
                                $Reg ="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft"
                                 $KeyName ="AppVISV"
                                    Get-ChildItem "Registry::$Reg" | 
                                    ForEach-Object {if ($_ -match "$KeyName"){Remove-Item -Force  -Recurse -Path "Registry::$_" }}

                               $Reg ="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
                                 $KeyName ="O365ProPlusRetail"
                                    Get-ChildItem "Registry::$Reg" | 
                                    ForEach-Object {if ($_ -match "$KeyName"){Remove-Item -Force  -Recurse -Path "Registry::$_" }}

                               $Reg ="HKEY_CURRENT_USER\Software\Microsoft"
                                 $KeyName = "Office"
                                    Get-ChildItem "Registry::$Reg" | 
                                    ForEach-Object {if ($_ -match "$KeyName"){Remove-Item -Force  -Recurse -Path "Registry::$_" }}




                              $PrgShortcut1="Excel 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut1*"

                              $PrgShortcut2="Word 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut2*"

                              $PrgShortcut3="PowerPoint 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut3*"

                              $PrgShortcut4="OneNote 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut4*"
                              
                              $PrgShortcut5="Outlook 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut5*"
                               
                              $PrgShortcut6="Publisher 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut6*"

                              $PrgShortcut7="Skype for Business 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut7*"

                              $PrgShortcut8="Excel 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut8*"

                              $PrgShortcut9="Excel 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut9*"

                              $PrgShortcut9="Access 2016"
                               rm -Force  -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\$PrgShortcut9*"
                              

                                                      
                         $name1 ="{90160000-007E-0000-1000-0000000FF1CE}"  

                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name1" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name1" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}
            
                      
                      $name2 ="{90160000-008C-0000-1000-0000000FF1CE}"  

                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name2" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name2" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}

                     $name3 ="{90160000-008C-0409-1000-0000000FF1CE}"  

                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name3" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name3" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}
                               
                                }
        
                             3 {break
                               }
                          
                          default {""}
                              }
                         cls} 
                            cls} while ( $choice2 -ne 3 )
            
            
          } 

        5 {#******************* Microsoft Power BI Desktop*****************************
            do { cls
                 [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {cls
               Write-Host "Please enter the software category$nl$nl
            1 = Install Microsoft Power BI Desktop $nl
            2 = Uninstall Microsoft Power BI Desktop $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                    # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$PowerBIURL"
                        $destination = "$workdir\$PowerBIFileName.msi"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                          Start-Process -FilePath "$workdir\$PowerBIFileName.msi" -ArgumentList "/Passive /norestart ACCEPT_EULA=1"
                                       
                                       
                                                 
                        # Wait XX Seconds for the installation to finish
                          write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 60

                        # Remove the installer

                            rm -Force $workdir\"$PowerBIFileName"*
                        
                    } 

                   2 {
                      $name ="Microsoft Power BI Desktop"  
                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}
                           }

                          3 {break
                          }
                          
                       default {""}
                      }
                 cls } 
                 cls } while ( $choice2 -ne 3 )
            
                 }    

        6{ cls
            #*******************Anaconda*****************************
            
            do{[int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install Anaconda3-5.0.1 $nl
            2 = Uninstall Anaconda3-5.0.1 $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                    # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$AnnocondaURL"
                        $destination = "$workdir\$AnnocondaFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                
                            Start-Process -FilePath "$workdir\$AnnocondaFileName.exe" -ArgumentList "/InstallationType=JustMe /RegisterPython=0 /S /C=%UserProfile%\Anaconda"

                        # Wait XX Seconds for the installation to finish
                           write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 360

                        # Remove the installer

                            rm -Force $workdir\"$AnnocondaFileName"*
                        
                    } 

                 2 {     appwiz
                     $name ="Python 3.6.3"  
                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}
            
                     }

                      3 {break
                          }
                          
                         default {""}
                              }
                        cls  } 
                     cls} while ( $choice2 -ne 3 )
            
          }  

        7 { #*******************Microsoft Teams***************************** 
            
            do {cls 
                [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install Micrososft Teams $nl
            2 = Uninstall Micrososft Teams $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                    # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$MicosoftTeamsURL"
                        $destination = "$workdir\$MicosoftTeamsFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                          Start-Process -FilePath "$workdir\$MicosoftTeamsFileName.exe" 
                                       
                                       
                                                 
                        # Wait XX Seconds for the installation to finish
                          write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 60

                        # Remove the installer

                            rm -Force $workdir\"$MicosoftTeamsFileName"*
                        
                    } 

                 2 {
                     stop-process -name Teams -Force

                     Start-Sleep -s 20
                     
                                           
                     $strFolderName="$env:LOCALAPPDATA\Microsoft\Teams"
                        If (Test-Path $strFolderName)
                             {
	                            Remove-Item $strFolderName -Recurse -Force
                              }
                     
                     
                     $strFolderNameS="$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Microsoft Corporation"
                     
                         If (Test-Path $strFolderNameS)    
                               { $strFileNameS="Microsoft Teams.lnk"
                                 Remove-Item "$strFolderNameS\$strFileNameS" –Force
                                 Remove-Item "C:\Users\*\Desktop\Microsoft Teams.lnk" –Force
                                 }
                     
                                                   
                    }

                3 {break
                  }
                          
             default {""}
             }
       cls  } 
      cls } while ( $choice2 -ne 3 )
            
          } 


        8 { #*******************Skype*****************************
             do { cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install Skype $nl
            2 = Uninstall Skype $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                     # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$SkypeURL"
                        $destination = "$workdir\$SkypeFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                
                            Start-Process -FilePath "$workdir\$SkypeFileName.exe" -ArgumentList "/VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"

                        # Wait XX Seconds for the installation to finish
                           write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 180

                        # Remove the installer

                            rm -Force $workdir\"$SkypeFileName"*
                        
                    } 

                 2 {
                     $name ="Skype"  

                      stop-process -name "Skype"  -Force
            
                              # Firstly, we need to know the location and the file name we're going to run

                                 $Path = "C:\Program Files (x86)\Microsoft\Skype for Desktop\unins000.exe"

                              # Are there any switches that the app requires?

                                  $Switch = "-ms /VERYSILENT /SP- /NOCANCEL"

                             # We'll run the program here

                                  $process = Start-Process -FilePath $Path -ArgumentList $Switch -Wait


                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}
            
                                }
        
                             3 {break
                               }
                          
                          default {""}
                              }
                         cls } 
                            cls} while ( $choice2 -ne 3 )
            
                      } 
        
        9 { #*******************X-Lite*****************************
                 do { cls
                 [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install X-Lite_5.1.0_89322 $nl
            2 = Uninstall X-Lite_5.1.0_89322 $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                    # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$XLiteURL"
                        $destination = "$workdir\$XLiteFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }
                            
                        # Start the installation
                          Start-Process -FilePath "$workdir\$XLiteFileName.exe" -ArgumentList "/Verysilent /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"
                                       
                                       
                                                 
                        # Wait XX Seconds for the installation to finish
                           write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 40

                        # Remove the installer

                            rm -Force $workdir\"$XLiteFileName"*
                        
                    } 

                 2 {
                     stop-process -name X-Lite -Force
                     write-host "Please wait while the files are being deleted.."
                     Start-Sleep -s 20

                     $strFolderName="$env:LOCALAPPDATA\CounterPath Corporation"
                        If (Test-Path $strFolderName)
                             {
	                            Remove-Item $strFolderName -Recurse -Force
                              }

                     $strFolderName="$env:LOCALAPPDATA\CounterPath"
                        If (Test-Path $strFolderName)
                             {
	                            Remove-Item $strFolderName -Recurse -Force
                              }
                     
                     $strFolderNameS="$env:APPDATA\Microsoft\Windows\Start Menu\Programs\CounterPath Corporation X-Lite"
                          If (Test-Path $strFolderNameS)    
                               {
                                 Remove-Item $strFolderNameS\X-Lite*
                                 Remove-Item "C:\Users\*\Desktop\X-Lite.lnk" –Force
                               }
                    }

                3 {break
                  }
                          
              default {""}
              }
         cls } 
             cls } while ( $choice2 -ne 3 )
        
           }


        10{ #*******************Mozilla firefox*****************************
              do{ cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install Mozilla firefox ) $nl
            2 = Uninstall Mozilla firefox$nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                     # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$FirefoxURL"
                        $destination = "$workdir\$FirefoxFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                
                            Start-Process -FilePath "$workdir\$FirefoxFileName.exe" -ArgumentList "/VERYSILENT /SP- /NOCANCEL /NORESTART /SUPPRESSMSGBOXES /NOLAUNCH"

                        # Wait XX Seconds for the installation to finish
                            write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 30

                        # Remove the installer

                            rm -Force $workdir\"$FirefoxFileName"*
                        
                    } 

                 2 {
                              # Firstly, we need to know the location and the file name we're going to run

                                 $Path = "C:\Program Files\Mozilla Firefox\uninstall\helper.exe"

                              # Are there any switches that the app requires?

                                  $Switch = "-ms"

                             # We'll run the program here

                                  $process = Start-Process -FilePath $Path -ArgumentList $Switch -Wait

                             #Lets get some logging going.

                                   Add-Content C:\LogFolder\logs\MSI\Firefox_Uninstall_1.0_001.log $LASTEXITCODE﻿
                
                     }
        
                         3 {break
                           }
                          
                        default {""}
                      }
               cls   } 
                 cls} while ( $choice2 -ne 3 )
            
           }
  
        11{        
               
             #*******************Zoiper *****************************
                 do { cls
                 [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install Zoiper $nl
            2 = Uninstall Zoiper $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                    # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$ZoiperURL"
                        $destination = "$workdir\$ZoiperFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }
                            
                        # Start the installation
                          Start-Process -FilePath "$workdir\$ZoiperFileName.exe"  -ArgumentList "--mode unattended --unattendedmodeui minimal"
                                       
                                       
                                                 
                        # Wait XX Seconds for the installation to finish
                            write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 80

                        # Remove the installer

                            rm -Force $workdir\"$ZoiperFileName"*
                        
                    } 

                 2 { stop-process -name "Zoiper5"  -Force
                    
                              # Firstly, we need to know the location and the file name we're going to run

                                 $Path = "C:\Program Files (x86)\Zoiper5\Uninstall.exe"

                              # Are there any switches that the app requires?

                                  $Switch = "-ms"

                             # We'll run the program here

                                  $process = Start-Process -FilePath $Path #-ArgumentList $Switch -Wait
                              Start-Sleep -s 20
                                            
                    }

                3 {break
                  }
                          
              default {""}
              }
          cls } 
             cls } while ( $choice2 -ne 3 )

        }
    
        12{                 
                 #*******************Google Chrome*****************************
             do { cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install Google Chrome $nl
            2 = Uninstall Google Chrome $nl
            3 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                       # Path for the workdir
                           $workdir = "c:\installer\"

                       
                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }
                      
                       $ChromeInstaller = "$ChromeFileName.exe"; (new-object System.Net.WebClient).DownloadFile("$ChromeURL", "$workdir\$ChromeInstaller"); & "$workdir\$ChromeInstaller" /silent /install; $Process2Monitor = "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; 
                      
                      If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 10 } 
                      
                      else { rm "$workdir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
                     
                      rm -Force $workdir\"$ChromeFileName"*
                      cls
                    } 

                 2 {
                             #Kill Task
                                taskkill /F /IM Chrome*

                             #Get Version
                               $ChromeVer = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall  |
                                Get-ItemProperty |
                                Where-Object {$_.DisplayName -match "Chrome" } |
                                Select-Object -Property DisplayName, UninstallString

                             #Uninstall
                                ForEach ($ver in $ChromeVer) {

                                If ($ver.UninstallString) {

                                 $uninst = $ver.UninstallString
                                 & cmd /c $uninst --force-uninstall --multi-install --chrome 
                                 }
     
                                }
                             cls
                        }
        
                             3 {break
                               }
                          
                          default {""}
                              }
                         cls } 
                            cls} while ( $choice2 -ne 3 )
            
           
          
          }

        13{
             #*******************SSDT*****************************
             do { cls 
               [int] $choice2 = 0
               while ( $choice2 -eq 1 -or $choice2 -eq 2 -or $choice2 -eq 0) {
               Write-Host "Please enter the software category$nl$nl
            1 = Install SSDT (SQL Server Data Tools)  for Visual Studio 2015 (17.4) $nl
            2 = Install SSDT (SQL Server Data Tools)  for Visual Studio 2017 (15.5.1) $nl
            3 = Uninstall SSDT (SQL Server Data Tools) $nl
            4 = Exit/Main Menu $nl
            
"
           $choice2 = read-host -prompt "Select number & press enter"
           
           switch ($choice2) 
              { 
                 1 {
                     # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$SSDTURL"
                        $destination = "$workdir\$SSDTFileName.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                
                            Start-Process -FilePath "$workdir\$SSDTFileName.exe" -ArgumentList "INSTALLALL=1 /qs /passive /norestart  /NOCANCEL /SUPPRESSMSGBOXES /NOLAUNCH" 

                        # Wait XX Seconds for the installation to finish
                           write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 460

                        # Remove the installer

                            rm -Force $workdir\"$SSDTFileName"*
                        
                    } 

                 2{   # Path for the workdir
                           $workdir = "c:\installer\"

                    # Check if work directory exists if not create it

                    If (Test-Path -Path $workdir -PathType Container)
                        { #Write-Host "$workdir already exists" -ForegroundColor Red
                        }
                            ELSE
                        { New-Item -Path $workdir  -ItemType directory }

                        # Download the installer

                        $source = "$SSDTURLNEW"
                        $destination = "$workdir\$SSDTFileNameNEW.exe"

                        # Check if Invoke-Webrequest exists otherwise execute WebClient

                        if (Get-Command 'Invoke-Webrequest')
                            {
                            Invoke-WebRequest $source -OutFile $destination
                            }
                        else
                            {
                           $WebClient = New-Object System.Net.WebClient
                           $webclient.DownloadFile($source, $destination)
                            }

                        # Start the installation
                
                            Start-Process -FilePath "$workdir\$SSDTFileNameNEW.exe" -ArgumentList "/qs /norestart  /NOCANCEL /SUPPRESSMSGBOXES /NOLAUNCH" 

                        # Wait XX Seconds for the installation to finish
                           write-host "Please wait while setup is fully completed.."
                            Start-Sleep -s 460

                        # Remove the installer

                            rm -Force $workdir\"$SSDTFileNameNEW"*
                 
                 
                   }

                 3 { appwiz
                   
                    <# $name ="SQL Server Data Tools"  
                        $uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString
                        $uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "$name" } | select UninstallString

                            if ($uninstall64) {
                                $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall64 = $uninstall64.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall64 /qb" -Wait}
                                if ($uninstall32) {
                                $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
                                $uninstall32 = $uninstall32.Trim()
                                Write "Uninstalling..."
                                start-process "msiexec.exe" -arg "/X $uninstall32 /qb" -Wait}
                     #>
                                }
        
                             4 {break
                               }
                          
                          default {""}
                              }
                        cls  } 
                            cls} while ( $choice2 -ne 4 )
        
           }





        14 { #*******************Exit*****************************
                $val = Get-ItemProperty -Path hklm:software\microsoft\windows\currentversion\policies\system -Name "ConsentPromptBehaviorAdmin"
                    if($val.ConsentPromptBehaviorAdmin -ne 5)
                    {
                     set-itemproperty -Path hklm:software\microsoft\windows\currentversion\policies\system -Name "ConsentPromptBehaviorAdmin" -value 5
                    }
              Remove-Item "c:\installer\" -Recurse -Force

              Write-Host "Thank You, Good Day..!!" -ForegroundColor GREEN
              Start-Sleep -s 3

              stop-process -name "powershell"  -Force
            break
           } 


        15 { #*******************Restart PC***************************** 
                  
              
                    $question = 'Are you sure you want to Restart the pc now?'

                        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
                        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

                        $decision = $Host.UI.PromptForChoice($message, $question, $choices, 1)
                        if ($decision -eq 0) {
                           
                           Write-Host 'confirmed'

                            Restart-Computer
                   $val = Get-ItemProperty -Path hklm:software\microsoft\windows\currentversion\policies\system -Name "ConsentPromptBehaviorAdmin"
                    if($val.ConsentPromptBehaviorAdmin -ne 5)
                        {
                        set-itemproperty -Path hklm:software\microsoft\windows\currentversion\policies\system -Name "ConsentPromptBehaviorAdmin" -value 5
                        }

                        } else {
                          Write-Host 'cancelled'
                        }
             
                   
                   ; break} 

        default {""}
 }
 cls}
} while ( $choice1 -ne 14 )
 

  
        
            
