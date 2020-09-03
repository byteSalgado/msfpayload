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
pkg update -y && pkg upgrade -y
clear
echo -e "$purple(*)$blue Sistema actualizado.."
sleep 4
echo -e "$purple(*)$blue Instalando dependencias secundarias.."
sleep 2
pkg install unstable-repo -y
pkg install wget -y
pḱg install git -y
pkg install curl -y
echo -e "$purple(*)$blue Dependencias secundarias instaladas.."
sleep 2
echo -e "$purple(*)$blue Comprobando dependencias principales..."
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
pkg install metasploit -y
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
mkdir dependencias_termux
cd dependencias_termux
git clone https://github.com/MasterDevX/Termux-Java
cd Termux-Java
bash installjava
echo -e "$purple(*)$blue Java instalado correctamente"
sleep 4
cd ..
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
echo -e "$purple(*)$blue Instalando apktool en 5 segundos"
sleep 5
git clone https://github.com/Lexiie/Termux-Apktool
cd Termux-Apktool
dpkg -i apktool_2.3.4_all.deb
echo -e "$purple(*)$blue Apktool instalado correctamente"
sleep 3
cd ..
cd ..
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
pkg install toilet -y
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
