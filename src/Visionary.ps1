# Project related variables
# Variables
[int] $menuinput # User input for menu selection
[string] $syncoptions # Sync options

# Project related variables
[string] $ProjectName = "Visionary"
[string] $ProjectVersion = "0.0.0.1"
[string] $Tempfolder = [Environment]::GetFolderPath('LocalApplicationData') + "\Visionary"

# Source path of the directory to be monitored
[string] $inputPath = ""


# File paths for settings and logs
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

function menu {
    clear-host
    do {
        clear-host
        Write-Host "`n==========================================="
        Write-Host "| $ProjectName (ver.$ProjectVersion)                 |"
        Write-Host "|_________________________________________|"
        Write-Host "| (1) Monitor now                         |"
        Write-Host "| (2) Open Log                            |"
        Write-Host "| (3) Sourcecode                          |"
        Write-Host "|                                         |"
        Write-Host "| (95) Deletion                           |"
        Write-Host "| (99) Exit                               |"
        Write-Host "|_________________________________________|`n"
        $menuinput = read-host "Please select an option"
        switch ( $menuinput ) {
            1 {
                log -logtype 1 -logMessage "Log: Initialized encryption dialogue"
                monitor
            }
            2 {
                log -logtype 1 -logMessage "Log: Printed log"
                printlog
            }
            3{
                log -logtype 1 -logMessage "Log: Printed source code"
                printSourceCode
            }
            95 {
                log -logtype 1 -logMessage "Log: Initialized deletion dialogue"
                Write-Host "Are you sure you want to delete all the files in the Temp folder? (Y/N)" -ForegroundColor Red
                $syncoptions = Read-Host
                if ($syncoptions -eq "Y" -or $syncoptions -eq "y") {
                    Remove-Item -Path $Tempfolder -Recurse -Force

                    Write-Host "`nDeletion in progress" -ForegroundColor Red -NoNewline
                    [int] $i = 0
                    [int] $j = 0
                    do {
                        $i++
                        Start-Sleep -Seconds 0.2
                        Write-Host "." -NoNewline -ForegroundColor Red
                        if ($i -eq 3) {
                            Start-Sleep -Seconds 0.2
                            Write-Host "`b`b`b   `b`b`b" -NoNewline  # Remove the 3 dots
                            $i = 0
                            $j++
                        }
                    } until ($j -eq 3)

                    Write-Host "`n`nAll files in the Temp folder have been deleted." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "`nGoodbye!" -ForegroundColor Green
                    exit
                } else {
                    log -logtype 1 -logMessage "Log: Deletion cancelled"
                    Write-Host "`nDeletion cancelled." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                }
            }
            99 {
                log -logtype 1 -logMessage "Log: Ended Visonary"
                Write-Host "Bye!"
                Start-Sleep -Seconds 1
                exit
            }
            default {
                log -logtype 1 -logMessage "Error: Invalid input in Menu"
                Write-host "Invalid input. Try again"
                Write-host "To exit, enter 99" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
            }
        }
        $menuinput = 0
    } until (0 -eq 1)
}

function printSourceCode {
    clear-host
    Write-Host "Source code for Visionary" -ForegroundColor Yellow
    Write-Host "=============================" -ForegroundColor Yellow
    Write-Host "Visionary is designed to provide a simple yet effective way to monitor and log specific activities in your environment.`nWhether you need to keep an eye on file changes, user actions, or other critical events,`nVisionary offers a streamlined solution to help you stay informed."
    Write-Host "`nBe advised, this script will only actively log activities while it is running (duh)." -ForegroundColor Red
    Write-Host "`nSource code for Visionary can be found at the following link:" -ForegroundColor Yellow
    Write-Host "https://github.com/AnonNanoo/Visionary/blob/main/src/Visionary.ps1"
    Write-Host "`nPress any key to return to the menu..." -ForegroundColor Yellow
    read-host
    menu
}

function log {
    # This function logs messages to the log file or error log file based on the given log type.
    param(
        [int]$logtype,
        [string]$logMessage
    )
    try {
        if ((test-path -path $logFilePath) -and $logtype -eq 1) {    # 1 is for normal log
            [string] $timestamp = Get-Date -Format "dd-MM-yyyy HH:mm.sss"
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $logFilePath -Append -Encoding utf8
        } elseif ((test-path -path $ErrorLogFilepath) -and $logtype -eq 2) {   # 2 is for error log
            [string] $timestamp = Get-Date -Format "dd-MM-yyyy HH:mm.sss"
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $ErrorLogFilePath -Append -Encoding utf8
        }
    } catch {
        return
    }
}

function printlog {
    # This function prints the log file into the console.

    Clear-Host
    $logContent = Get-Content -Path $logFilePath
    foreach ($line in $logContent) {
        if ($line -match "Start:") {
            $originalColor = $Host.UI.RawUI.ForegroundColor
            $Host.UI.RawUI.ForegroundColor = "Green"
            $line | Out-Host
            $Host.UI.RawUI.ForegroundColor = $originalColor
        } elseif ($line -match "Error:") {
            $originalColor = $Host.UI.RawUI.ForegroundColor
            $Host.UI.RawUI.ForegroundColor = "Red"
            $line | Out-Host
            $Host.UI.RawUI.ForegroundColor = $originalColor
        } else {
            $line | Out-Host
        }
    }
    Write-Host "`nPress Enter to return to menu..."
    Read-Host
}

# This function monitors the system and reports any issues
function monitor {
    param (
        [string]$folderPath
    )
    
    Clear-Host

    Write-Host "Enter the path to the input file (file to be encrypted)`n(E.g. C:/Your/Path/File.txt)" -ForegroundColor Yellow
    $inputPath = Read-Host

    # Check if the input file exists
    $inputExists = Test-Path $inputPath
    if (-not $inputExists) {
        
        Write-Host "`nInput file does not exist." -ForegroundColor Red
        log -logtype 1 -logMessage "Error: Input folder missing or invalid"

        Write-Host "`nPress any key to return to the menu..." -ForegroundColor Yellow
        Read-Host

        $inputExists = $false

        menu
        return
    }

}

function setup {
    # This function sets up the environment for Visonary, it creates the necessary directories and files.

    if (-not (Test-Path $Tempfolder)) {
        New-Item -Path $Tempfolder -ItemType Directory -Force
    }
    if (-not (Test-Path $logFilePath)) {
        New-Item -Path $logFilePath -ItemType File -Force
    }
    read-host

}

function main {
    log -logtype 1 -logMessage "Start: Visionary started"
    logo
    setup
    menu
}



main
