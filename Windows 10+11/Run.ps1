# Run.ps1
# Entry UI for PowerShell command line repair and tool selection

function Show-Menu {
    param (
        [string]$Title = 'Command Line Repair and Tool Selection'
    )
    
    Clear-Host
    Write-Host "==================== $Title ===================="
    Write-Host "1: Repair System Files"
    Write-Host "2: Check Disk"
    Write-Host "3: Network Diagnostics"
    Write-Host "4: Advanced Tools"
    Write-Host "5: Install Software"
    Write-Host "0: Exit"
    Write-Host "================================================"
}

function Show-Advanced-Menu {
    param (
        [string]$Title = 'Advanced Tools'
    )
    
    Clear-Host
    Write-Host "==================== $Title ===================="
    Write-Host "1: System Information"
    Write-Host "2: Disk Usage"
    Write-Host "0: Back to Main Menu"
    Write-Host "================================================"
}

function Show-Software-Install-Menu {
    param (
        [string]$Title = 'Software Installation'
    )

    Clear-Host
    Write-Host "==================== $Title ===================="
    Write-Host "1: Firefox"
    Write-Host "0: Back to Main Menu"
    Write-Host "================================================"
}

function Show-Firefox-Install-Menu {
    param (
        [string]$Title = 'Firefox Installation'
    )

    Clear-Host
    Write-Host "==================== $Title ===================="
    Write-Host "1: Firefox"
    Write-Host "2: Firefox (winget)"
    Write-Host "3: Firefox (force)"
    Write-Host "0: Back to Software Installation Menu"
    Write-Host "================================================"
}

function Repair-SystemFiles {
    Write-Host "Running System File Checker (sfc /scannow)..."
    sfc /scannow
}

function Check-Disk {
    Write-Host "Running Check Disk (chkdsk /f)..."
    chkdsk /f
}

function Network-Diagnostics {
    Write-Host "Running Network Diagnostics..."
    Test-Connection google.com
}

function System-Information {
    Write-Host "Displaying System Information..."
    systeminfo
}

function Disk-Usage {
    Write-Host "Displaying Disk Usage..."
    Get-PSDrive -PSProvider FileSystem
}

function Install-Firefox {
    if (-not (Test-Path "C:\Program Files\Mozilla Firefox\firefox.exe")) {
        Write-Host "Downloading Firefox..."
        Invoke-WebRequest -Uri "https://download.mozilla.org/?product=firefox-latest-ssl&os=win&lang=en-US" -OutFile "$env:TEMP\FirefoxSetup.exe"
        Write-Host "Installing Firefox..."
        Start-Process -FilePath "$env:TEMP\FirefoxSetup.exe" -ArgumentList "/S" -Wait
    }
    else {
        Write-Host "Firefox is already installed."
    }
}

function Install-Firefox-Winget {
    winget install Mozilla.Firefox
}

function Install-Firefox-Force {
    Write-Host "Forcing Firefox installation..."
    Write-Host "Downloading Firefox..."
    Invoke-WebRequest -Uri "https://download.mozilla.org/?product=firefox-latest-ssl&os=win&lang=en-US" -OutFile "$env:TEMP\FirefoxSetup.exe"
    Write-Host "Installing Firefox..."
    Start-Process -FilePath "$env:TEMP\FirefoxSetup.exe" -ArgumentList "/S" -Wait
}

do {
    Show-Menu
    $choice = Read-Host "Enter your choice (0-5)"
    
    switch ($choice) {
        1 { Repair-SystemFiles }
        2 { Check-Disk }
        3 { Network-Diagnostics }
        4 {
            do {
                Show-Advanced-Menu
                $subChoice = Read-Host "Enter your choice (0-2)"
                
                switch ($subChoice) {
                    1 { System-Information }
                    2 { Disk-Usage }
                    0 { break }
                    default { Write-Host "Invalid choice, please try again." }
                }
                
                if ($subChoice -ne 0) {
                    Read-Host "Press Enter to continue..."
                }
            } while ($subChoice -ne 0)
        }
        5 {
            do {
                Show-Software-Install-Menu
                $subChoice = Read-Host "Enter your choice (0-1)"
                
                switch ($subChoice) {
                    1 { 
                        do {
                            Show-Firefox-Install-Menu
                            $firefoxChoice = Read-Host "Enter your choice (0-3)"

                            switch ($firefoxChoice) {
                                1 { Install-Firefox }
                                2 { Install-Firefox-Winget }
                                3 { Install-Firefox-Force }
                                0 { break }
                                default { Write-Host "Invalid choice, please try again." }
                            }
                            if ($firefoxChoice -ne 0) {
                                Read-Host "Press Enter to continue..."
                            }
                        } while ($firefoxChoice -ne 0)
                     }
                    0 { break }
                    default { Write-Host "Invalid choice, please try again." }
                }
                
                if ($subChoice -ne 0) {
                    Read-Host "Press Enter to continue..."
                }
            } while ($subChoice -ne 0)
        }
        0 { Write-Host "Exiting..."; break }
        default { Write-Host "Invalid choice, please try again." }
    }
    
    if ($choice -ne 0 -and $subChoice -ne 0) {
        Read-Host "Press Enter to continue..."
    }
} while ($choice -ne 0)
