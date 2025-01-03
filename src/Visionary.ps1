# Project related variables
# Variables
[int] $menuinput # User input for menu selection
[string] $syncoptions # Sync options

# Project related variables
[string] $ProjectName = "Visionary"
[string] $ProjectVersion = "0.0.0.1"
[string] $Tempfolder = [Environment]::GetFolderPath('LocalApplicationData') + "\$ProjectName"

# Source path of the directory to be monitored
[string] $inputPath = ""


# File paths for settings and logs
[string] $settingsFilePath = "$Tempfolder\Settings.dll"
[string] $ErrorLogFilePath = "$Tempfolder\ErrorLog.log"
[string] $logFilePath = "$Tempfolder\Visionary.log"
[string] $logMessage
[int] $corrupted
function logo {
    # This function prints the logo and welcome message to the console 
    [double] $time = 0.15
    clear-host
    Write-Host ""
    Start-Sleep -Seconds $time
    Write-Host "                     ____--=====*==*##*+**+   " 
    Start-Sleep -Seconds $time                                                               
    Write-Host "              ___--======**#%%**#%%%%###**-   " 
    Start-Sleep -Seconds $time
    Write-Host "            -==++ +%%######%  +%%%%%%%%*+-   " 
    Start-Sleep -Seconds $time
    Write-Host "         -*%%%%%=  %%#####% *%%%%%%%%+-      " 
    Start-Sleep -Seconds $time
    Write-Host "       --+%%%%%%%%-       -+%%%%%%%%#=       "
    Start-Sleep -Seconds $time
    Write-Host "      ----#%%%%%%%%%%%%%%%%%%%%#*+---         " 
    Start-Sleep -Seconds $time
    Write-Host "    -:::::-=++%##############%++++-           " 
    Start-Sleep -Seconds $time
    Write-Host "           ---============---                 "
    Start-Sleep -Seconds $time
    Write-Host "                              Visionary ($ProjectVersion)"
    #Write-Host "===========================================================" -ForegroundColor blue

    [int] $i = 0
    
    do{
        $i++
        Start-Sleep -Milliseconds 5
        Write-Host "~" -NoNewline -ForegroundColor red
    }until ($i -eq 50)
    
    Write-Host "`n  Witness the unseen.`n" 
    Write-Host "  Booting Visionary" -NoNewline

    [int] $i = 0
    do {
        $i++
        Start-Sleep -Seconds 1
        Write-Host "." -NoNewline
    }until ($i -eq 3)
    Write-Host "`n"
    Read-Host
}

# This function monitors the system and reports any issues
function monitor {
    param (
        [string]$folderPath
    )

    Write-Host "Enter the path to the input file (file to be encrypted)`n(E.g. C:/Your/Path/File.txt)" -ForegroundColor Yellow
    $inputPath = Read-Host

    # Check if the input file exists
    $inputExists = Test-Path $inputPath
    if (-not $inputExists) {
        
        Write-Host "`nInput file does not exist." -ForegroundColor Red
        log -logtype 2 -logMessage "Error: Input file missing or invalid"

        Write-Host "`nPress any key to return to the menu..." -ForegroundColor Yellow
        Read-Host

        $inputExists = $false

        menu
        return
    }

}

function main {
    logo
    setup
    #menu
}



main
