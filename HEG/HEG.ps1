# Run cleanup incase previous run finished prematurely - will cause errors (This needs to be kept ahead of $EventLogStamp been declared or cleanup will be caught in the log export at end.)
& ".\Scripts\CleanUp.ps1" *>$null


# Loading Function
function Show-Progress {
    param (
        [int]$Count,
        [string[]]$Colors
    )

    $colorIndex = 0

    for ($i = 1; $i -le $Count; $i++) {
        Write-Host "'." -ForegroundColor ($Colors[$colorIndex])
        Start-Sleep -Seconds 1
        $colorIndex = ($colorIndex + 1) % $Colors.Count
    }
}


Clear
Start-Sleep -Seconds 1
Show-Progress -Count 7 -Colors @("red", "Green")
Clear



# Width for the description column
$descriptionWidth = 40

# Pointer to the CSV file
$items = Import-Csv -Path ".\Scripts\Data.csv"


# Timestamp created at runtime (Dont move this to any other part of script)
$timestamp = Get-Date -Format "yyyy-MM-dd -- HH-mm" 


# Create Ouput File
New-Item -ItemType Directory -Path ".\Logs\$timestamp" | Out-Null
New-Item -ItemType File -Path ".\Logs\$timestamp\Events_TimeLine.txt" | Out-Null

# Pointer to Output File
$logfile = ".\Logs\$timestamp\Events_TimeLine.txt"




# Functionality for log export after HEG completes
$EventLogStamp = Get-Date
$workingdirectory = pwd
$logsdirectory = "$workingdirectory\Logs\$timestamp\"




# Error Handling
$ErrorActionPreference = "SilentlyContinue"




# UI
$TacticColourFG = 'DarkBlue'
$TacticColourBG = 'DarkCyan'
$TacticDescColour = "DarkCyan"
$TechniqueColour = "Gray"
$EIDColour = "Yellow"
$StatusColour = "Gray"
$LogoTextColour = "Cyan"
$LogoText_FG_Colour = "White"
$LogoText_BG_Colour = "DarkCyan"
$LogoColour = "White"






Write-Output "`n`n`n`n"





Write-Host "          ██╗  ██╗   ███████╗    ██████╗    " -ForegroundColor $LogoColour
Start-Sleep -Seconds 1
Write-Host "          ██║  ██║   ██╔════╝   ██╔════╝    " -ForegroundColor $LogoColour -NoNewline; Write-Host "	Hunt Event Generator"     -ForegroundColor $LogoText_FG_Colour -BackgroundColor $LogoText_BG_Colour
Start-Sleep -Seconds 1
Write-Host "          ███████║   █████╗     ██║  ███╗   " -ForegroundColor $LogoColour -NoNewline; Write-Host "	For Verification and Validation"  -ForegroundColor $LogoText_FG_Colour -BackgroundColor $LogoText_BG_Colour
Start-Sleep -Seconds 1
Write-Host "          ██╔══██║   ██╔══╝     ██║   ██║   " -ForegroundColor $LogoColour -NoNewline; Write-Host "	Across Security, System, PowerShell & Sysmon Logs" -ForegroundColor $LogoText_FG_Colour -BackgroundColor $LogoText_BG_Colour
Start-Sleep -Seconds 1
Write-Host "          ██║  ██║██╗███████╗██╗╚██████╔╝██╗" -ForegroundColor $LogoColour
Start-Sleep -Seconds 1
Write-Host "          ╚═╝  ╚═╝╚═╝╚══════╝╚═╝ ╚═════╝ ╚═╝" -ForegroundColor $LogoColour



Write-Output "`n`n`n`n"

Start-Sleep -Seconds 1




# Define the script directory
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent

# Keep track of the current section to print headers
$currentSection = ""



# Print Tactic and Tactic Description when testing moves to next Tactic
foreach ($item in $items) {
    if ($currentSection -ne $item.Tactic) {
        $currentSection = $item.Tactic
        $tacticDescription = $item.TacticDescription
        Write-Host "`n`n   " -NoNewline
        Write-Host "$currentSection" -ForegroundColor $TacticColourFG -BackgroundColor $TacticColourBG -NoNewline
        Write-Host "     " -NoNewline
        Write-Host "$tacticDescription`n`n" -ForegroundColor $TacticDescColour
    }







    # Pad the description so EventIDs dont overcrowd it 
    $description = $item.Description.PadRight($descriptionWidth)

    # Extract the EventID values from CSV
    $Security = $item.Security
    $Sysmon = $item.Sysmon
    $PowerShell = $item.PowerShell
    $BITS = $item.BITS
    $System = $item.System
    $Firewall = $item.'firewall Windows Firewall With Advanced Security'



    # Initialize an array
    $detailsArray = @()

    # Add each EventID to its respective section in array
    if ($Security) { $detailsArray += "Security $Security" }
    if ($Sysmon) { $detailsArray += "Sysmon $Sysmon" }
    if ($PowerShell) { $detailsArray += "PowerShell $PowerShell" }
    if ($BITS) { $detailsArray += "BITS $BITS" }
    if ($System) { $detailsArray += "System $System" }
    if ($Firewall) { $detailsArray += "Firewall/Opertational $Firewall" }


    # Join the array into a single string with separators
    $EventID = $detailsArray -join " | "

    # Print the timestamp, description and EventID to screen along with appending it into the events_timeline.txt fiel
    Write-Host "         $(Get-Date -Format G) - $description   " -ForegroundColor $TechniqueColour -NoNewline
    if ($EventID) {
        Write-Host " $EventID" -ForegroundColor $EIDColour
    } else {
        Write-Host "" # This ensures a new line if an edge case with  no eventids listed.
    }
    "$(Get-Date -Format G) - $Description - $EventID" | Out-File -FilePath "$logfile" -Append
   
   
   
   


     # Execute the associated script
    if ($item.Script -and $item.Script.Trim() -ne "") {
        $filePath = Join-Path -Path $scriptDir -ChildPath $item.Script.Trim()
        Start-Sleep -Seconds 4
        if (Test-Path $filePath) {
            $extension = [System.IO.Path]::GetExtension($filePath)
            if ($extension -eq ".bat") {
                & "$filePath" > $null 2>&1 -Wait
            } elseif ($extension -eq ".ps1") {
                & "$filePath" -Wait | Out-Null
            } elseif ($extension -eq ".vbs") {
                Start-Process $filePath
            }
            
        }
    }






    # Write Timestamp and 'Complete' after each iteration and also append that data into the events_timeline.txt file.
    Write-Host "         $(Get-Date -Format G) - Complete`n`n " -ForegroundColor $StatusColour
    "$(Get-Date -Format G) - $Description - Complete `n" | Out-File -FilePath "$logfile" -Append
}






$BarColours = "Magenta"
$CleanUpTxtColours = "White"
$LogExportColour = "Gray"


Start-Sleep -Seconds 3




Write-Host "     ======================================================================================================`n`n`n  " -ForegroundColor $BarColours

Start-Sleep -Seconds 1






Write-Host "     |||  " -ForegroundColor $BarColours -NoNewline; Write-Host "EXPORTING LOG FILES TO:" -ForegroundColor $CleanUpTxtColours -NoNewline; Write-Host " $logsdirectory  `n`n" -ForegroundColor Gray

Start-Sleep -Seconds 2



# Taking the timestamp that was generated when script was run, and subtract a minute. Export all generated logs since that time.
$StartTime = $EventLogStamp.AddMinutes(-1)


####
#
# Following section is log extraction and log export.
# Default logs that HEG pulls are Security, System, PowerShell, Sysmon, BITS and Firewall
#
#
# Additional log files can added where needed. 
# Ensure that you make the update across the 3 sections - DECLARATION, EXTRACTION, EXPORT)
#
####


# --DECLARATION-- 
# This section declares which logfiles that will be copied and saved. 
$SecurityLogName = "Security" 
$SystemLogName = "System"
$PowerShellOperationalLogName = "Microsoft-Windows-PowerShell/Operational"
$SysmonLogName = "Microsoft-Windows-Sysmon/Operational"
$BitsClientLogName = "Microsoft-Windows-Bits-Client/Operational"
$FirewallLogName = "Microsoft-Windows-Windows Firewall With Advanced Security/Firewall"


# Declaring the specific fields from the logfiles that will be useful. (Additional fields can be added if needed)
$selectedProperties = "TimeCreated", "Id", "Message"



Write-Host "             - - - COMPILING EVENTS" -ForegroundColor Cyan -NoNewline; Write-Host "   (This process may take a few minutes)`n "  -ForegroundColor Red


# --EXTRACTION-- 
# Extracting the data from those logs and saving to hashtables
$SecurityEvents = Get-WinEvent -FilterHashtable @{LogName=$SecurityLogName; StartTime=$StartTime}
$SystemEvents = Get-WinEvent -FilterHashtable @{LogName=$SystemLogName; StartTime=$StartTime}
$PowerShellOperationalEvents = Get-WinEvent -FilterHashtable @{LogName=$PowerShellOperationalLogName; StartTime=$StartTime} 
$SysmonEvents = Get-WinEvent -FilterHashtable @{LogName=$SysmonLogName; StartTime=$StartTime} 
$BitsClientEvents = Get-WinEvent -FilterHashtable @{LogName=$BitsClientLogName; StartTime=$StartTime} 
$FirewallEvents = Get-WinEvent -FilterHashtable @{LogName=$FirewallLogName; StartTime=$StartTime} 



# -- EXPORT--  
# Export the hashtables to their respective .csv files
Write-Host "                       *  Exporting Security Logs " -ForegroundColor $LogExportColour
$SecurityEvents | Select-Object $selectedProperties | Export-Csv -Path ".\Logs\$timestamp\security_logs.csv" -NoTypeInformation
Write-Host "                       *  Exporting System Logs " -ForegroundColor $LogExportColour
$SystemEvents | Select-Object $selectedProperties | Export-Csv -Path ".\Logs\$timestamp\system_logs.csv" -NoTypeInformation
Write-Host "                       *  Exporting Powershell Logs " -ForegroundColor $LogExportColour
$PowerShellOperationalEvents | Select-Object $selectedProperties | Export-Csv -Path ".\Logs\$timestamp\powershell_operational_logs.csv" -NoTypeInformation
Write-Host "                       *  Exporting Sysmon Logs " -ForegroundColor $LogExportColour
$SysmonEvents | Select-Object $selectedProperties | Export-Csv -Path ".\Logs\$timestamp\sysmon_logs.csv" -NoTypeInformation
Write-Host "                       *  Exporting Bits Client Logs " -ForegroundColor $LogExportColour
$BitsClientEvents | Select-Object $selectedProperties | Export-Csv -Path ".\Logs\$timestamp\bitsclient_logs.csv" -NoTypeInformation
Write-Host "                       *  Exporting Firewall Logs" -ForegroundColor $LogExportColour
$FirewallEvents | Select-Object $selectedProperties | Export-Csv -Path ".\Logs\$timestamp\firewall_logs.csv" -NoTypeInformation

Write-Host "`n`n`n"






Write-Host "     |||  " -ForegroundColor $BarColours -NoNewline; Write-Host "Running Cleanup" -ForegroundColor $CleanUpTxtColours
"$(Get-Date -Format G) - Running a cleanup ||||" | Out-File -FilePath "$logfile" -Append
Start-Sleep -Seconds 3
& ".\Scripts\CleanUp.ps1" *>$null
"$(Get-Date -Format G) - Cleanup completed ||||" | Out-File -FilePath "$logfile" -Append
Write-Host "     |||  " -ForegroundColor $BarColours -NoNewline; Write-Host "Cleanup Completed`n`n`n" -ForegroundColor $CleanUpTxtColours




Start-Sleep -Seconds 3