#!/bin/bash
#Script created for Facu Salgado: https://github.com/ByteSalgado


#Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"

sleep 2
echo -e "$purple(*)$blue Gracias por usar mi Script by$red Facu Salgado$nc"
sleep 1
echo -e "$purple(*)$blue Actualizando sistema..."
sleep 4
apt-get update -y && apt-get upgrade -y
clear
echo -e "$purple(*)$blue Sistema actualizado.."
sleep 4
echo -e "$purple(*)$blue Comprobando dependencias..."
sleep 3

if which msfconsole >/dev/null; then
sleep 1
echo -e "$blue(Metasploit)$nc ................................................... Instalado [$green✓$nc]"
sleep 3
else
sleep 1
echo -e "$red(Metasploit)$nc ................................................... No Instalado [$red✗$nc]"
sleep 3
echo -e "$purple(*)$blue instalando Metasploit en 5 segundos.."
sleep 5
apt-get install metasploit-framework -y
clear
echo -e "$purple(*)$blue Metasploit instalado correctamente.."
sleep 3
clear
fi


if which java >/dev/null; then
sleep 1
echo -e "$blue(Java)$nc ................................................... Instalado [$green✓$nc]"
sleep 3
else
sleep 1
echo -e "$red(Java)$nc ................................................... No Instalado [$red✗$nc]"
sleep 3
echo -e "$purple(*)$blue instalando Java en 5 segundos.."
sleep 5
sudo apt install software-properties-common -y
sudo apt install default-jdk -y
echo -e "$purple(*)$blue Java instalado correctamente"
sleep 3
clear
fi

if which apktool >/dev/null; then
sleep 1
echo -e "$blue(Apktool)$nc ................................................... Instalado [$green✓$nc]"
sleep 3
else
sleep 1
echo -e "$red(apktool)$nc ................................................... No Instalado [$red✗$nc]"
sleep 3
echo -e "$purple(*)$blue Instalando apktool"
sleep 5
sudo apt install apktool -y
echo -e "$purple(*)$blue Apktool instalado correctamente"
sleep 3
clear
fi

if which toilet >/dev/null; then
sleep 1
echo -e "$blue(Toilet)$nc ................................................... Instalado [$green✓$nc]"
sleep 3
else
sleep 1
echo -e "$red(Toilet)$nc ................................................... No Instalado [$red✗$nc]"
sleep 3
echo -e "$purple(*)$blue instalando Toilet en 5 segundos.."
sleep 5
apt-get install toilet -y
echo -e "$purple(*)$blue TOilet instalado correctamente"
sleep 3
clear
fi
clear
echo -e "$purple(*)$blue Creando directorios y subcarpetas..."
mkdir listeners
sleep 2
mkdir payloads
sleep 2
cd payloads
mkdir android_custom
mkdir android_original
mkdir python
mkdir windows_custom
mkdir windows_defender_bypass
echo -e "$purple(*)$blue Directorios creados correctamente..."
sleep 2
cd ..
chmod +x msfpayload.sh
echo -e "$purple(*)$blue Lanzando programa en 5 segundos.."
sleep 5
bash msfpayload.sh
