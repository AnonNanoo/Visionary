# Project related variables
[string] $ProjectName = "Visionary"
[string] $ProjectVersion = "0.0.0.1"
function logo {
    # This function prints the logo and welcome message to the console 
    [double] $time = 0.2
    clear-host
    Write-Host ""
    Start-Sleep -Seconds $time
    Write-Host "                :===**#**++++++++=-:       "                                                                      
    Start-Sleep -Seconds $time
    Write-Host "          :=-:-:       : :    ::::---==-   " 
    Start-Sleep -Seconds $time
    Write-Host "        :-==++:+%%#+#%%**#+:+%%%%%%%%*+-   " 
    Start-Sleep -Seconds $time
    Write-Host "      -::*%%%%=:+%%#####*=:*%%%%%%%%+-:    " 
    Start-Sleep -Seconds $time
    Write-Host "    -- +%%%%%%%*-=:-=::-+%%%%%%%%#=:::     "
    Start-Sleep -Seconds $time
    Write-Host "   ----#%%%%%%%%%%%%%%%%%%%%#*+---::       " 
    Start-Sleep -Seconds $time
    Write-Host " ::::::-=+*++=+*#####%++++-::::::          " 
    Start-Sleep -Seconds $time
    Write-Host " ==-          : :  ::: ::  :               "
    Start-Sleep -Seconds $time
    Write-Host "                                             ($ProjectVersion)"
    #Write-Host "===========================================================" -ForegroundColor blue

    [int] $i = 0
    do{
        $i++
        Start-Sleep -Milliseconds 5
        Write-Host "=" -NoNewline -ForegroundColor blue
    }until ($i -eq 50)
    Write-Host "`nWitness the unseen.`n" 
    Write-Host "Booting Visionary" -NoNewline

    [int] $i = 0
    do {
        $i++
        Start-Sleep -Seconds 1
        Write-Host "." -NoNewline
    }until ($i -eq 3)
    Write-Host "`n"
    Read-Host
}

logo
