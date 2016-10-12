// Class : DH Resources
// Version : 0.2
// (C) Doddy Hackman 2016

unit DH_Resources;

interface

uses Windows, SysUtils, Classes;

type
  T_DH_Resources = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function add_resource(FileName: string; resource_file: string;
      resource_name: string): boolean;
    function edit_resource(FileName: string; resource_file: string;
      resource_name: string): boolean;
    function delete_resource(FileName: string; resource_name: string): boolean;
    function save_resource(FileName: string; resource_name: string;
      savefile: string): boolean;
    function load_resource(FileName: string; resource_name: string)
      : TResourceStream;
    function check_resource(resource_name: string): boolean;
    function check_resource_another_app(FileName: string;
      resource_name: string): boolean;
    function list_all_resources(FileName: string): string;
  end;

var
  list_resources: string;

implementation

constructor T_DH_Resources.Create;
begin
  inherited Create;
  //
end;

destructor T_DH_Resources.Destroy;
begin
  //
  inherited Destroy;
end;

function T_DH_Resources.add_resource(FileName: string; resource_file: string;
  resource_name: string): boolean;
var
  handle: THandle;
  stream: TMemoryStream;
begin

  if (FileExists(FileName)) and (FileExists(resource_file)) and
    not(resource_name = '') then
  begin
    if not(check_resource_another_app(FileName, resource_name)) then
    begin
      try
        begin
          stream := TMemoryStream.Create;
          stream.LoadFromFile(Pchar(resource_file));
          stream.Seek(0, soFromBeginning);

          handle := BeginUpdateResource(Pchar(FileName), False);
          UpdateResource(handle, RT_RCDATA, Pchar(resource_name), LANG_NEUTRAL,
            stream.Memory, stream.Size);
          EndUpdateResource(handle, False);
          FreeLibrary(handle);

          stream.Free;

          Result := True;
        end;
      except
        begin
          Result := False;
        end;
      end;
    end
    else
    begin
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

function T_DH_Resources.save_resource(FileName: string; resource_name: string;
  savefile: string): boolean;
var
  stream: TResourceStream;
  handle: THandle;
begin
  if (FileExists(FileName) and not(resource_name = '') and not(savefile = ''))
  then
  begin
    try
      begin

        handle := LoadLibraryEx(Pchar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);

        stream := TResourceStream.Create(handle, resource_name, RT_RCDATA);

        stream.Position := 0;
        stream.SaveToFile(savefile);

        stream.Free;

        FreeLibrary(handle);

      end;
    except
      begin
        //
      end;
    end;

    if (FileExists(savefile)) then
    begin
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  end;
end;

function T_DH_Resources.load_resource(FileName: string; resource_name: string)
  : TResourceStream;
var
  handle: THandle;
begin
  if (FileExists(FileName) and not(resource_name = '')) then
  begin
    handle := LoadLibraryEx(Pchar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);
    FreeLibrary(handle);
    Result := TResourceStream.Create(handle, resource_name, RT_RCDATA);
  end;
end;

function T_DH_Resources.check_resource(resource_name: string): boolean;
begin
  if (FindResource(HInstance, Pchar(resource_name), RT_RCDATA) <> 0) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

function T_DH_Resources.check_resource_another_app(FileName: string;
  resource_name: string): boolean;
var
  handle: THandle;
  resultado: boolean;
begin
  handle := LoadLibraryEx(Pchar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);

  if (FindResource(handle, Pchar(resource_name), RT_RCDATA) <> 0) then
  begin
    resultado := True;
  end
  else
  begin
    resultado := False;
  end;

  FreeLibrary(handle);

  Result := resultado

end;

function T_DH_Resources.delete_resource(FileName: string;
  resource_name: string): boolean;
var
  handle: THandle;
begin
  if (FileExists(FileName) and not(resource_name = '')) then
  begin
    if (check_resource_another_app(FileName, resource_name)) then
    begin
      try
        begin
          handle := BeginUpdateResource(Pchar(FileName), False);
          UpdateResource(handle, RT_RCDATA, Pchar(resource_name),
            LANG_NEUTRAL, nil, 0);
          EndUpdateResource(handle, False);
          FreeLibrary(handle);
          Result := True;
        end;
      except
        begin
          Result := False;
        end;
      end;
    end
    else
    begin
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

function T_DH_Resources.edit_resource(FileName: string; resource_file: string;
  resource_name: string): boolean;
var
  resultado: boolean;
begin
  if (check_resource_another_app(FileName, resource_name)) then
  begin
    if (delete_resource(FileName, resource_name)) then
    begin
      if (add_resource(FileName, resource_file, resource_name)) then
      begin
        resultado := True;
      end
      else
      begin
        resultado := False;
      end;
    end
    else
    begin
      resultado := False;
    end;
  end
  else
  begin
    resultado := False;
  end;
  Result := resultado;
end;

// Function to list all resources

function get_resource_name(resource_name: Pchar): string;
var
  response: string;
begin
  if Is_IntResource(resource_name) then
  begin
    response := '#' + IntToStr(NativeUInt(resource_name))
  end
  else
  begin
    response := resource_name;
  end;
  Result := response;
end;

function get_resource_type(resource_type: Pchar): string;
var
  response: string;
begin
  if (NativeUInt(resource_type) = NativeUInt(RT_CURSOR)) then
  begin
    response := 'RT_CURSOR';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_BITMAP)) then
  begin
    response := 'RT_BITMAP';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_ICON)) then
  begin
    response := 'RT_ICON';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_DIALOG)) then
  begin
    response := 'RT_DIALOG';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_FONTDIR)) then
  begin
    response := 'RT_FONTDIR';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_FONT)) then
  begin
    response := 'RT_FONT';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_ACCELERATOR)) then
  begin
    response := 'RT_ACCELERATOR';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_RCDATA)) then
  begin
    response := 'RT_RCDATA';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_GROUP_CURSOR)) then
  begin
    response := 'RT_GROUP_CURSOR';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_GROUP_ICON)) then
  begin
    response := 'RT_GROUP_ICON';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_VERSION)) then
  begin
    response := 'RT_VERSION';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_DLGINCLUDE)) then
  begin
    response := 'RT_DLGINCLUDE';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_PLUGPLAY)) then
  begin
    response := 'RT_PLUGPLAY';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_VXD)) then
  begin
    response := 'RT_VXD';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_ANICURSOR)) then
  begin
    response := 'RT_ANICURSOR';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_ANIICON)) then
  begin
    response := 'RT_ANIICON';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_HTML)) then
  begin
    response := 'RT_HTML';
  end
  else if (NativeUInt(resource_type) = NativeUInt(RT_MANIFEST)) then
  begin
    response := 'RT_MANIFEST';
  end
  else
  begin
    response := get_resource_name(resource_type);
  end;
  Result := response;
end;

function EnumResNameProc(hModule: hModule; lpszType, lpszName: Pchar;
  lParam: LONG_PTR): BOOL; stdcall;
begin
  list_resources := list_resources + '[type]' + get_resource_type(lpszType) +
    '[type]' + '[name]' + get_resource_name(lpszName) + '[name]' + sLineBreak;
  Result := True;
end;

function T_DH_Resources.list_all_resources(FileName: string): string;
var
  handle: THandle;
begin
  list_resources := '';
  if (FileExists(FileName)) then
  begin
    handle := LoadLibraryEx(Pchar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);
    EnumResourceNames(handle, RT_RCDATA, @EnumResNameProc, 0);
    FreeLibrary(handle);
  end;
  Result := list_resources;
end;

//

end.

// The End ?
