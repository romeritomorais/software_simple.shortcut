program SimpleShortcut;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FMXPrincipal} ,
  Linux.Utils in 'LibLinux\Linux.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMXPrincipal, FMXPrincipal);
  Application.CreateForm(TFMXPrincipal, FMXPrincipal);
  Application.Run;

end.
