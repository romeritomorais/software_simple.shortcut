{ ---------------------------------------------------------------------------

  + Esse código foi escrito por romerito morais no RAD Studio Delphi Rio 10.3.3

  + https://www.linkedin.com/in/romeritomorais
  + maio de 2020
  --------------------------------------------------------------------------- }

unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Menus, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  FMX.Ani, FMX.ComboEdit, FMX.Effects, FMX.Filter.Effects, FMX.ListBox;

type
  TFMXPrincipal = class(TForm)
    LyPrincipal: TLayout;
    LyMenu: TLayout;
    LyImage: TLayout;
    DlgImage: TOpenDialog;
    Icon: TImage;
    Layout1: TLayout;
    Edit_nome: TEdit;
    Combo_categoria: TComboEdit;
    Edit_command: TEdit;
    Button_salvar: TSpeedButton;
    Dlg_caminho: TOpenDialog;
    ShadowEffect1: TShadowEffect;
    Rectangle1: TRectangle;
    TextIcon: TText;
    DlgDirecticones: TOpenDialog;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    SearchEditButton1: TSearchEditButton;
    RectangleSobre: TRectangle;
    Layout8: TLayout;
    Image1: TImage;
    Layout9: TLayout;
    Label1: TLabel;
    MenuBar1: TMenuBar;
    mSobre: TMenuItem;
    Rectangle4: TRectangle;
    Label3: TLabel;
    Label2: TLabel;
    procedure IconClick(Sender: TObject);
    procedure mSobreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_procurarClick(Sender: TObject);
    procedure Button_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RectangleSobreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMXPrincipal: TFMXPrincipal;

implementation

{$R *.fmx}

uses Linux.Utils;

var
  Text: String;
  LinuxcmdLine: TStringList;

procedure TFMXPrincipal.Button_procurarClick(Sender: TObject);
begin
  Dlg_caminho.Title := 'Selecione o Executável';
  Dlg_caminho.Execute;
  Edit_command.Text := Dlg_caminho.FileName;
  Edit_command.selstart := Length(Edit_command.Text);
end;

procedure TFMXPrincipal.Button_salvarClick(Sender: TObject);
begin
  Text := 'cd $HOME; pwd';
  LinuxcmdLine := TLinuxUtils.RunCommandLine(Text);

  if DlgImage.FileName = '' then
  begin
    showmessage('Selecione o icone do Programa antes de Salvar')
  end
  else
  begin
    Text := 'echo -e "[Desktop Entry]\nComment=\nExec=' + Edit_command.Text +
      '\nIcon=' + DlgImage.FileName + '\nName=' + Edit_nome.Text +
      '\nTerminal=0\nCategories=' + Combo_categoria.Text +
      '" >> ~/.local/share/applications/' + Edit_nome.Text.LowerCase
      (Edit_nome.Text) + '.desktop';
    LinuxcmdLine := TLinuxUtils.RunCommandLine(Text);
  end;

  if Combo_categoria.Text = 'Categoria' then
    Combo_categoria.SetFocus;

end;

procedure TFMXPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LinuxcmdLine.Free;
end;

procedure TFMXPrincipal.FormCreate(Sender: TObject);
begin
  LinuxcmdLine := TStringList.Create;
end;

procedure TFMXPrincipal.FormShow(Sender: TObject);
begin
  Combo_categoria.ItemIndex := 1;
  FMXPrincipal.Caption := 'Simple Shortcut v1.0';
end;

procedure TFMXPrincipal.IconClick(Sender: TObject);
begin
  if Edit_nome.Text = '' then
  begin
    Edit_nome.SetFocus;
  end
  else
  begin
    DlgImage.Title := '';
    DlgImage.Title := 'Selecione a Imagem para seu programa';
    DlgImage.Execute;
    TextIcon.Text := '';
    Icon.Bitmap.LoadFromFile(DlgImage.FileName);
  end;

end;

procedure TFMXPrincipal.mSobreClick(Sender: TObject);
begin
  RectangleSobre.Visible := True;
end;

procedure TFMXPrincipal.RectangleSobreClick(Sender: TObject);
begin
  RectangleSobre.Visible := False;
end;

end.
