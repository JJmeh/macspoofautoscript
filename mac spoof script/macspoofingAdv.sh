#!/usr/bin/env bash

cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
BlueF='\e[1;34m'

trap ctrl_c INT
ctrl_c() {
clear
echo -e $red"[*] (Ctrl + C ) Detected, Trying To Exit ..."
sleep 1
echo ""
echo -e $yellow"[*] created by nyx-meh"
sleep 2
clear
exit
}

clear

#obtain interface
function interface() { 
    echo
    echo -e $okegreen "choose the interface that you want to change it's"
    echo -n -e $okegreen" mac address $yellow(if null or invalid, will be wlan0) $okegrenn":" "
    read interface
    if test "$interface" = "eth0"
        then
        echo
    echo -e $okegreen "your choosen interface is $white"$interface""
    sleep 2
    verify
    elif test "$interface" == "wlan0"
        then
        echo
    echo -e $okegreen "your choosen interface is $white"$interface""
    sleep 2
    verify
    elif test "$interface" == "wlan1"
        then
        echo
    echo -e $okegreen "your choosen interface is $white"$interface""
    sleep 2
    verify
    elif test "$interface" == "wlan2"
        then
        echo
    echo -e $okegreen "your choosen interface is $white"$interface""
    sleep 2
    verify
    else
    interface='wlan0'
    echo
    echo -e $okegreen "your choosen interface $white"$interface""
    sleep 2
    verify
    fi
}

function verify() {

    echo
    if test $[$interface] == '0'
    then
    echo -e $yellow "[*] $white"$interface is" $green"available""
    takedown
    else
    echo -e $yellow "[*] $white"$interface is" $red"unavailable""
    menu
    fi

}


function takedown(){
    clear
    menu1
    echo
    echo -e $BlueF "$interface interface mac address : " 
    echo -e $cyan "$(macchanger -s $interface)"
    sleep 2
    echo
    echo "stopping network-manager service..."
    service network-manager stop
    sleep 2
    echo 
    echo -e $red "taking down $interface interface"
    ifconfig $interface down
    ip link set $interface down
    sleep 2
    changemac
}

function changemac(){
    menu1
    echo
    echo -e $BlueF "$interface interface mac address : " 
    echo -e $cyan "$(macchanger -s $interface)"
    echo
    echo -e $green"$interface is down"
    echo
    echo -e $yellow" [1] $white"set random mac address of the same kind of vendor""
    echo -e $yellow" [2] $white"set random mac address of an any kind of vendor""
    echo -e $yellow" [3] $white"set fully random""
    echo -e $yellow" [4] $white"restore to original""
    echo
    echo -e -n $okegreen"choose your option $yellow(1 is default) $okegreen":" "
    read response
    if test $response == '1'
    then
        sudo macchanger -a $interface
        echo
        echo "changing..."
        sleep 2
        echo
        echo "done..."
        sleep 2
        postup
    elif test $response == '2'
    then
        sudo macchanger -A $interface
        echo
        echo "changing..."
        sleep 2
        echo
        echo "done..."
        sleep 2
        postup
    elif test $response == '3'
    then
        sudo macchanger -r $interface
        echo
        echo "changing..."
        sleep 2
        echo
        echo "done..."
        sleep 2
        postup
    elif test $response == '4'
    then
        sudo macchanger -p $interface
        echo
        echo "changing..."
        sleep 2
        echo
        echo "done..."
        sleep 2
        postup
    else
    macchanger -a $interface
    echo
    echo "changing..."
    sleep 2
    echo
    echo "done..."
    sleep 2
    postup
    fi
}

function postup(){
    clear
    echo
    menu1
    echo
    echo "starting network-manager service..."
    service network-manager start
    sleep 2
    echo 
    echo -e $red "putting up $interface interface"
    ifconfig $interface up
    ip link set $interface up
    sleep 2
    echo
    echo -e $yellow"process complete, terminating script now"
    echo
    echo -e $yellow"your current mac address $okegreen'$(ifconfig $interface | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')'"
    echo
    sleep 2
    echo "good bye"
    sleep 2
    clear
    exit

}


function check(){
    ifconfig | grep "eth0"
    eth0=$?
    ifconfig | grep "wlan0"
    wlan0=$?
    ifconfig | grep "wlan1"
    wlan1=$?
    ifconfig | grep "wlan2"
    wlan2=$?
    ifconfig | grep "wlan3"
    wlan3=$?
    clear
}


function menu(){
    check
    clear
    echo -e $okegreen "    ========================="
    echo -e $okegreen "    =                       ="
    echo -e $okegreen "    =      $white"Mac Spoofing"     $okegreen="
    echo -e $okegreen "    =                       ="
    echo -e $okegreen "    ========================="
    echo -e $yellow ""
    echo -e $yellow   "    Available Interface : "
    echo
    if test $eth0 == '0'
        then
        echo -e $yellow "[*] $white"eth0 is" $green"available""
        else
        echo -e $yellow "[*] $white"eth0 is" $red"unavailable""
        fi
    if test $wlan0 == '0'
        then
        echo -e $yellow "[*] $white"wlan0 is" $green"available""
        else
        echo -e $yellow "[*] $white"wlan0 is" $red"unavailable""
        fi
    if test $wlan1 == '0'
        then
        echo -e $yellow "[*] $white"wlan1 is" $green"available""
        else
        echo -e $yellow "[*] $white"wlan1 is" $red"unavailable""
        fi
    if test $wlan2 == '0'
        then
        echo -e $yellow "[*] $white"wlan2 is" $green"available""
        else
        echo -e $yellow "[*] $white"wlan2 is" $red"unavailable""
        fi
    interface


}

function menu1(){
    check
    echo -e $okegreen "    ========================="
    echo -e $okegreen "    =                       ="
    echo -e $okegreen "    =      $white"Mac Spoofing"     $okegreen="
    echo -e $okegreen "    =                       ="
    echo -e $okegreen "    ========================="
    echo -e $yellow ""
    echo -e $yellow   "    Available Interface : "
    echo
    if test $eth0 == '0'
        then
        echo -e $yellow "[*] $white"eth0 is" $green"available""
        else
        echo -e $yellow "[*] $white"eth0 is" $red"unavailable""
        fi
    if test $wlan0 == '0'
        then
        echo -e $yellow "[*] $white"wlan0 is" $green"available""
        else
        echo -e $yellow "[*] $white"wlan0 is" $red"unavailable""
        fi
    if test $wlan1 == '0'
        then
        echo -e $yellow "[*] $white"wlan1 is" $green"available""
        else
        echo -e $yellow "[*] $white"wlan1 is" $red"unavailable""
        fi
    if test $wlan2 == '0'
        then
        echo -e $yellow "[*] $white"wlan2 is" $green"available""
        else
        echo -e $yellow "[*] $white"wlan2 is" $red"unavailable""
        fi
}




#actual output
check
echo -e $okegreen "    ========================="
echo -e $okegreen "    =                       ="
echo -e $okegreen "    =      $white"Mac Spoofing"     $okegreen="
echo -e $okegreen "    =                       ="
echo -e $okegreen "    ========================="
echo -e $yellow ""
echo -e $yellow   "    Available Interface : "
echo
if test $eth0 == '0'
    then
    echo -e $yellow "[*] $white"eth0 is" $green"available""
    else
    echo -e $yellow "[*] $white"eth0 is" $red"unavailable""
    fi
if test $wlan0 == '0'
    then
    echo -e $yellow "[*] $white"wlan0 is" $green"available""
    else
    echo -e $yellow "[*] $white"wlan0 is" $red"unavailable""
    fi
if test $wlan1 == '0'
    then
    echo -e $yellow "[*] $white"wlan1 is" $green"available""
    else
    echo -e $yellow "[*] $white"wlan1 is" $red"unavailable""
    fi
if test $wlan2 == '0'
    then
    echo -e $yellow "[*] $white"wlan2 is" $green"available""
    else
    echo -e $yellow "[*] $white"wlan2 is" $red"unavailable""
    fi
interface



