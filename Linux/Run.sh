#!/bin/bash
# Entry UI for Linux command line repair and tool selection

function show_menu {
    local title="Command Line Repair and Tool Selection"
    clear
    echo "==================== $title ===================="
    echo "1: Repair System Files"
    echo "2: Check Disk"
    echo "3: Network Diagnostics"
    echo "4: Exit"
    echo "================================================"
}

function repair_system_files {
    echo "Running System File Checker (sudo fsck -fy)..."
    sudo fsck -fy
}

function check_disk {
    echo "Running Disk Utility (sudo e2fsck -f /dev/sda1)..."
    sudo e2fsck -f /dev/sda1
}

function network_diagnostics {
    echo "Running Network Diagnostics (ping -c 4 google.com)..."
    ping -c 4 google.com
}

while true; do
    show_menu
    read -p "Enter your choice (1-4): " choice
    
    case $choice in
        1) repair_system_files ;;
        2) check_disk ;;
        3) network_diagnostics ;;
        4) echo "Exiting..."; break ;;
        *) echo "Invalid choice, please try again." ;;
    esac
    
    if [ "$choice" -ne 4 ]; then
        read -p "Press Enter to continue..."
    fi
done
