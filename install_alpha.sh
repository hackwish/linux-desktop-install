#!/bin/bash
##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}

echo ""
echo "Bienvenid@ a ByDefault Asimilation"
echo ""
echo -ne $(ColorBlue "
==============================
| ...Resistance is Futile... |
==============================")
echo ""
echo "Antes de empezar, detectemos tu OS..."
echo ""

OS=`uname`

if [[ $OS == "darwin" ]]; then
    echo $OS
    echo "Es una máquina macOS!!"
    read -p "..Black Alert!. Presiona Enter para comenzar..."
    function mac () {
        source install_mac.sh
    }
    mac
elif [[ $OS == "Linux" ]]; then
    echo $OS
    echo "Es una máquina Linux!!"
    read -p "..Black Alert!. Presiona Enter para comenzar..."
    function linux () {
        source install.sh
    }
    linux
else
    echo 'Sin identificar. Lo siento no podemos continuar. Bye'
    exit0;
fi