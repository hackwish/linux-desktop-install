#!/bin/bash
##

echo "
============================
| ByDefault Meta-Installer |
============================"
echo ""
echo "Before we start, let's detect your OS..."
echo ""

OS=`uname`

if [[ $OS == "Darwin" ]]; then
    echo $OS
    echo "It's a macOS system!!"
    echo ""
    read -p "...Press Enter to start..."
    echo ""
    function mac () {
        source install_mac.sh
    }
    mac
elif [[ $OS == "Linux" ]]; then
    echo $OS
    echo "It's a Linux machine!!"
    echo ""
    read -p "...Press Enter to start..."
    echo ""
    function linux () {
        source install_linux.sh
    }
    linux
else
    echo 'Unidentified OS. Sorry, we cannot continue. Bye'
    exit0;
fi