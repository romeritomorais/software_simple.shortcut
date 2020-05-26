screenshot.01
![](https://github.com/romeritomorais/software_simple.shortcut/blob/master/Screenshot/Screenshot_20200526_041837.png)
screenshot.02
1[](https://github.com/romeritomorais/software_simple.shortcut/blob/master/Screenshot/Screenshot_20200526_042115.png)

```
{
-----------------------------------------------------------------------------
+ Esse código foi escrito por romerito morais no RAD Studio Delphi Rio 10.3.3
+ https://www.linkedin.com/in/romeritomorais
+ maio de 2020
-----------------------------------------------------------------------------
}

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
    Rectangle4: TRectangle;
    Label3: TLabel;
    Label2: TLabel;
    Rectangle5: TRectangle;
    TextSalvar: TText;
    RectangleMsg: TRectangle;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle6: TRectangle;
    Text1: TText;
    Text2: TText;
    Label1: TLabel;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    Image1: TImage;
    Text3: TText;
    procedure IconClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_procurarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RectangleSobreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TextSalvarClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMXPrincipal: TFMXPrincipal;

implementation

{$R *.fmx}

uses Linux.Utils, FMUX.Api;

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

procedure TFMXPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Text := '';
  Edit_nome.Free;
  Dlg_caminho.Free;
  LinuxcmdLine.Free;
  Edit_command.Free;
  Combo_categoria.Free;
  FMXPrincipal.Free;
end;

procedure TFMXPrincipal.FormCreate(Sender: TObject);
begin
  LinuxcmdLine := TStringList.Create;
end;

procedure TFMXPrincipal.FormShow(Sender: TObject);
begin
  Combo_categoria.ItemIndex := 1;
  FMXPrincipal.Caption := 'Simple Shortcut';
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
    if DlgImage.FileName = '' then
      TextIcon.Text := 'adicione o icone'
    else
      Icon.Bitmap.LoadFromFile(DlgImage.FileName);
  end;

end;

procedure TFMXPrincipal.Image1Click(Sender: TObject);
begin
  FmuxOpenUrl
    (PChar('https://github.com/romeritomorais/software_simple.shortcut'));
end;

procedure TFMXPrincipal.RectangleSobreClick(Sender: TObject);
begin
  RectangleSobre.Visible := False;
end;

procedure TFMXPrincipal.Text1Click(Sender: TObject);
begin
  RectangleMsg.Visible := False;
end;

procedure TFMXPrincipal.TextSalvarClick(Sender: TObject);
begin
  Text := 'cd $HOME; pwd';
  LinuxcmdLine := TLinuxUtils.RunCommandLine(Text);

  if DlgImage.FileName = '' then
  begin
    RectangleMsg.Visible := True;
    Text2.Text := 'Preencha as informações antes de continuar!'
  end
  else
  begin
    Text := 'echo -e "[Desktop Entry]\nComment=Atalho criado com o Simple Shortcut\nExec='
      + Edit_command.Text + '\nIcon=' + DlgImage.FileName + '\nName=' +
      Edit_nome.Text + '\nTerminal=0\nCategories=' + Combo_categoria.Text +
      '" >> ~/.local/share/applications/' + Edit_nome.Text.LowerCase
      (Edit_nome.Text) + '.desktop';
    LinuxcmdLine := TLinuxUtils.RunCommandLine(Text);
    RectangleMsg.Visible := True;
    Text2.Text := 'O Atalho do Programa ' + Edit_nome.Text +
      ' foi criado com Sucesso, Procure agora no seu Menu de Programas'
  end;
end;

end.
