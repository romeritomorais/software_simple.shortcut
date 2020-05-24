{---------------------------------------------------------------------------

 + Esse código foi escrito por romerito morais no RAD Studio Delphi Rio 10.3.3

 + https://www.linkedin.com/in/romeritomorais
 + maio de 2020
---------------------------------------------------------------------------}

unit Linux.Utils;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Character,
  Posix.Base,
  Posix.Fcntl,
  System.IOUtils;

type
  TStreamHandle = pointer;

  TLinuxUtils = class

  private

  public
    class function RunCommandLine(const ACommand: string): TStringList;
      overload;
    class function RunCommandLine(const ACommand: string; Return: TProc<String>)
      : boolean; overload;
  end;

function popen(const command: MarshaledAString; const _type: MarshaledAString)
  : TStreamHandle; cdecl; external libc name _PU + 'popen';
function pclose(filehandle: TStreamHandle): int32; cdecl;
  external libc name _PU + 'pclose';
function fgets(buffer: pointer; size: int32; Stream: TStreamHandle): pointer;
  cdecl; external libc name _PU + 'fgets';

implementation

class function TLinuxUtils.RunCommandLine(const ACommand: string): TStringList;
var
  Handle: TStreamHandle;
  Data: array [0 .. 511] of uint8;
  M: TMarshaller;

begin
  Result := TStringList.Create;
  try
    Handle := popen(M.AsAnsi(PWideChar(ACommand)).ToPointer, 'r');
    try
      while fgets(@Data[0], Sizeof(Data), Handle) <> nil do
      begin
        Result.Add(Copy(UTF8ToString(@Data[0]), 1, UTF8ToString(@Data[0])
          .Length - 1));
      end;
    finally
      pclose(Handle);
    end;
  except
    on E: Exception do
      Result.Add(E.ClassName + ': ' + E.Message);
  end;
end;

class function TLinuxUtils.RunCommandLine(const ACommand: string;
  Return: TProc<string>): boolean;
var
  Handle: TStreamHandle;
  Data: array [0 .. 511] of uint8;
  M: TMarshaller;

begin
  Result := False;
  try
    Handle := popen(M.AsAnsi(PWideChar(ACommand)).ToPointer, 'r');
    try
      while fgets(@Data[0], Sizeof(Data), Handle) <> nil do
      begin
        Return(Copy(UTF8ToString(@Data[0]), 1, UTF8ToString(@Data[0])
          .Length - 1));
      end;
    finally
      pclose(Handle);
    end;
  except
    on E: Exception do
      Return(E.ClassName + ': ' + E.Message);
  end;
end;

end.
