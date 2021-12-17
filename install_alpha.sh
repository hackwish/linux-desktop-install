#!/bin/bash
##

echo ""
echo "Bienvenid@ a ByDefault Asimilation"
echo "
==============================
| ...Resistance is Futile... |
=============================="
echo ""
echo "Antes de empezar, detectemos tu OS..."
echo ""

OS=`uname`

if [[ $OS == "Darwin" ]]; then
    echo $OS
    echo "Es una máquina macOS!!"
    echo ""
    read -p "..Black Alert!...Presiona Enter para comenzar..."
    echo ""
    function mac () {
        source install_mac.sh
    }
    mac
elif [[ $OS == "Linux" ]]; then
    echo $OS
    echo "Es una máquina Linux!!"
    echo ""
    read -p "..Black Alert!...Presiona Enter para comenzar..."
    echo ""
    function linux () {
        source install.sh
    }
    linux
else
    echo 'Sin identificar. Lo siento no podemos continuar. Bye'
    exit0;
fi