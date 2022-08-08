unit mCrud.view.principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Menus, mCrud.view.clientes,
  mCrud.view.cadastroclientes;

type
  TFrmPrincipal = class(TForm)
    pButton: TPanel;
    LName: TLabel;
    MMPrincipal: TMainMenu;
    MNCadastro: TMenuItem;
    MNClientes: TMenuItem;
    Cadastrar1: TMenuItem;
    procedure Cadastrar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.Cadastrar1Click(Sender: TObject);
begin
  if not Assigned(FrmCadCliente) then
  begin
    FrmCadCliente := TFrmCadCliente.Create(Self);
    FrmCadCliente.ShowCliente(-1);
  end;
  FrmCadCliente.Show;
end;

end.
