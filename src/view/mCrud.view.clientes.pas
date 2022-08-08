unit mCrud.view.clientes;

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
  mCrud.util.form,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Buttons,
  Vcl.WinXPanels,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  mCrud.Controller,
  mCrud.controller.interfaces;

type
  TFrmClientes = class(TFrmBase)
    Panel1: TPanel;
    PToolBar: TPanel;
    LCaption: TLabel;
    CPClient: TCardPanel;
    CardVisualizar: TCard;
    PBottom: TPanel;
    PFiltro: TPanel;
    CardCadastro: TCard;
    DBGrid1: TDBGrid;
    dsCliente: TDataSource;
    EdCodigo: TEdit;
    SBCancelar: TSpeedButton;
    SPSelecionar: TSpeedButton;
    SBPesquisar: TSpeedButton;
    lCodigo: TLabel;
    EdNome: TEdit;
    lNome: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SBCancelarClick(Sender: TObject);
    procedure SPSelecionarClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure SBPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
    FCampo:String;
  public
    { Public declarations }
  end;

var
  FrmClientes: TFrmClientes;

implementation

{$R *.dfm}

procedure TFrmClientes.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  SPSelecionar.Click;
end;

procedure TFrmClientes.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  FCampo      := Column.FieldName;
end;

procedure TFrmClientes.FormCreate(Sender: TObject);
begin
  inherited;
  FController       := TController.New;
  dsCliente.DataSet := FController.Cliente.Build.ListarPorDTO;
end;

procedure TFrmClientes.SBCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmClientes.SBPesquisarClick(Sender: TObject);
var
  lFilter:String;
  procedure AddAnd;
  begin
    if not lFilter.IsEmpty then
    begin
      lFilter := lFilter + ' AND ';
    end;
  end;
begin
  inherited;
  FController.Cliente.Build.Listar;

  dsCliente.DataSet.Filtered := False;
  dsCliente.DataSet.Filter   := EmptyStr;
  try
    lFilter := EmptyStr;

    if not String(EdCodigo.text).Trim.IsEmpty then
    begin
      AddAnd;
      lFilter := lFilter + ' ID = '+EdCodigo.Text;
    end;

    if not String(EdNome.text).Trim.IsEmpty then
    begin
      AddAnd;
      lFilter := lFilter + ' NOME LIKE '+QuotedStr(EdCodigo.Text+'%');
    end;

    dsCliente.DataSet.Filter   := lFilter;
  finally
    if not String(dsCliente.DataSet.Filter).Trim.IsEmpty then
    begin
      dsCliente.DataSet.Filtered := True;
    end;
  end;
end;

procedure TFrmClientes.SPSelecionarClick(Sender: TObject);
begin
  inherited;
  if dsCliente.DataSet.IsEmpty then
  begin
    raise Exception.Create('Selecione um cliente.');
  end;
  ModalResult := mrOk;
end;

end.
