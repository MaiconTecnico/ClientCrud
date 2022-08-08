unit mCrud.view.cadastroclientes;

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
  mCrud.controller.interfaces,
  mCrud.Controller,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.DBCtrls,
  Datasnap.DBClient,
  Vcl.Mask,
  mCrud.view.clientes;

type
  TFrmCadCliente = class(TFrmBase)
    PCadastro: TPanel;
    Panel1: TPanel;
    SBIncluir: TSpeedButton;
    SBAlterar: TSpeedButton;
    SBExcluir: TSpeedButton;
    SBConfirmar: TSpeedButton;
    SBCancelar: TSpeedButton;
    GBEndereco: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DSEndereco: TDataSource;
    CDSEndereco: TClientDataSet;
    ECEP: TDBEdit;
    EEndereco: TDBEdit;
    EBairro: TDBEdit;
    ECidade: TDBEdit;
    EEstado: TDBEdit;
    CBEndPrincipal: TDBCheckBox;
    BSalvar: TBitBtn;
    BExcluir: TBitBtn;
    BEditar: TBitBtn;
    BIncluir: TBitBtn;
    BNext: TBitBtn;
    BPrior: TBitBtn;
    BCancel: TBitBtn;
    GBCliente: TGroupBox;
    Label1: TLabel;
    ECodigo: TEdit;
    Label2: TLabel;
    ENome: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    EIdentidade: TEdit;
    Label10: TLabel;
    ETelefone: TEdit;
    Label11: TLabel;
    EEmail: TEdit;
    SBPesquisar: TSpeedButton;
    DSCadastro: TDataSource;
    ECPF: TMaskEdit;
    Label12: TLabel;
    ENumero: TDBEdit;
    Label13: TLabel;
    EPais: TDBEdit;
    Label14: TLabel;
    EComplemento: TDBEdit;
    procedure DSEnderecoDataChange(Sender: TObject; Field: TField);
    procedure BPriorClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BIncluirClick(Sender: TObject);
    procedure BEditarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BSalvarClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure SBConfirmarClick(Sender: TObject);
    procedure CDSEnderecoAfterInsert(DataSet: TDataSet);
    procedure CDSEnderecoBeforePost(DataSet: TDataSet);
    procedure BTCancelClick(Sender: TObject);
    procedure SBAlterarClick(Sender: TObject);
    procedure SBExcluirClick(Sender: TObject);
    procedure CDSEnderecoNewRecord(DataSet: TDataSet);
    procedure SBIncluirClick(Sender: TObject);
    procedure SBCancelarClick(Sender: TObject);
    procedure SBPesquisarClick(Sender: TObject);
    procedure ECPFExit(Sender: TObject);
    procedure ECEPExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEditar : Boolean;
    FController : iController;
    procedure IncluirEndereco;
    procedure ControleBotao;
    procedure CarregaCliente;
    procedure CarregaCEP;
  public
    function ShowCliente(pId:Integer):Boolean;
  end;

var
  FrmCadCliente: TFrmCadCliente;

implementation

{$R *.dfm}

{ TFrmCadastro }

procedure TFrmCadCliente.BCancelClick(Sender: TObject);
begin
  inherited;
  CDSEndereco.Cancel;
end;

procedure TFrmCadCliente.BEditarClick(Sender: TObject);
begin
  inherited;
  ECEP.SetFocus;
  CDSEndereco.Edit;
end;

procedure TFrmCadCliente.BExcluirClick(Sender: TObject);
begin
  inherited;
  CDSEndereco.Delete;
end;

procedure TFrmCadCliente.BIncluirClick(Sender: TObject);
begin
  inherited;
  ECEP.SetFocus;
  CDSEndereco.Insert;
end;

procedure TFrmCadCliente.BNextClick(Sender: TObject);
begin
  inherited;
  CDSEndereco.Next;
end;

procedure TFrmCadCliente.BPriorClick(Sender: TObject);
begin
  inherited;
  CDSEndereco.Prior;
end;

procedure TFrmCadCliente.BSalvarClick(Sender: TObject);
begin
  inherited;
  CDSEndereco.Post;
end;

procedure TFrmCadCliente.BTCancelClick(Sender: TObject);
begin
  inherited;
  CDSEndereco.Cancel;
end;

procedure TFrmCadCliente.CarregaCEP;
begin
  CDSEndereco.FieldByName('LOGRADOURO').AsString  := FController.Endereco.Logradouro;
  CDSEndereco.FieldByName('COMPLEMENTO').AsString := FController.Endereco.Complemento;
  CDSEndereco.FieldByName('BAIRRO').AsString      := FController.Endereco.Bairro;
  CDSEndereco.FieldByName('CIDADE').AsString      := FController.Endereco.Cidade;
  CDSEndereco.FieldByName('ESTADO').AsString      := FController.Endereco.Estado;
  CDSEndereco.FieldByName('PAIS').AsString        := FController.Endereco.Pais;
end;

procedure TFrmCadCliente.CarregaCliente;
begin
  ECodigo.Text     := DSCadastro.DataSet.FieldByName('ID').AsString;
  ENome.Text       := DSCadastro.DataSet.FieldByName('NOME').AsString;
  EIdentidade.Text := DSCadastro.DataSet.FieldByName('IDENTIDADE').AsString;
  ECPF.Text        := DSCadastro.DataSet.FieldByName('CPF').AsString;
  ETelefone.Text   := DSCadastro.DataSet.FieldByName('TELEFONE').AsString;
  EEmail.Text      := DSCadastro.DataSet.FieldByName('EMAIL').AsString;
end;

procedure TFrmCadCliente.CDSEnderecoAfterInsert(DataSet: TDataSet);
begin
  inherited;
  CDSEndereco.FieldByName('IND_PRINCIPAL').AsString := 'N';
end;

procedure TFrmCadCliente.CDSEnderecoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CDSEndereco.FieldByName('CEP').AsString.IsEmpty then
  begin
    ShowMessage('CEP em branco. Verifique!');
    ECEP.SetFocus;
    Abort;
  end;
  if CDSEndereco.FieldByName('LOGRADOURO').AsString.IsEmpty then
  begin
    ShowMessage('Endereço em branco. Verifique!');
    EEndereco.SetFocus;
    Abort;
  end;
  if CDSEndereco.FieldByName('BAIRRO').AsString.IsEmpty then
  begin
    ShowMessage('Bairro em branco. Verifique!');
    EBairro.SetFocus;
    Abort;
  end;
  if CDSEndereco.FieldByName('CIDADE').AsString.IsEmpty then
  begin
    ShowMessage('Cidade em branco. Verifique!');
    ECidade.SetFocus;
    Abort;
  end;
  if CDSEndereco.FieldByName('ESTADO').AsString.IsEmpty then
  begin
    ShowMessage('Estado em branco. Verifique!');
    EEstado.SetFocus;
    Abort;
  end;
end;

procedure TFrmCadCliente.CDSEnderecoNewRecord(DataSet: TDataSet);
begin
  inherited;
  if ECodigo.Text = EmptyStr then
  begin
    ShowMessage('Nenhum registro selecionado. Verifique!');
    Abort;
  end;
end;

procedure TFrmCadCliente.ControleBotao;
begin
  if not SBConfirmar.Visible then
  begin
    SBConfirmar.Visible := True;
    SBCancelar.Visible  := True;
    SBIncluir.Visible   := False;
    SBAlterar.Visible   := False;
    SBExcluir.Visible   := False;
    SBPesquisar.Visible := False;
    GBEndereco.Enabled  := True;
    GBCliente.Enabled   := True;
  end
  else
  begin
    SBPesquisar.Visible := True;
    SBConfirmar.Visible := False;
    SBCancelar.Visible  := False;
    SBIncluir.Visible   := True;
    SBAlterar.Visible   := True;
    SBExcluir.Visible   := True;
    GBEndereco.Enabled  := False;
    GBCliente.Enabled   := False;
  end;

  SBPesquisar.Top := 0;
  SBConfirmar.Top := 100;
  SBCancelar.Top  := 200;
  SBIncluir.Top   := 300;
  SBAlterar.Top   := 400;
  SBExcluir.Top   := 500;
end;

procedure TFrmCadCliente.DSEnderecoDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  BIncluir.Enabled := CDSEndereco.State in [dsBrowse];
  BEditar.Enabled  := (CDSEndereco.State in [dsBrowse]) and (not (CDSEndereco.IsEmpty));
  BExcluir.Enabled := (not (CDSEndereco.State in [dsInsert, dsEdit])) and (not (CDSEndereco.IsEmpty));
  BSalvar.Enabled  := (CDSEndereco.State in [dsInsert, dsEdit]);
  BCancel.Enabled  := (CDSEndereco.State in [dsInsert, dsEdit]);
  BNext.Enabled    := CDSEndereco.State in [dsBrowse];
  BPrior.Enabled   := CDSEndereco.State in [dsBrowse];
end;

procedure TFrmCadCliente.ECEPExit(Sender: TObject);
begin
  inherited;
  if FController.Endereco.BuscaCEP(ExtrairNumeros(CDSEndereco.FieldByName('CEP').AsString)) then
  begin
    CarregaCEP;
  end;
end;

procedure TFrmCadCliente.ECPFExit(Sender: TObject);
begin
  inherited;
  if not FController.Cliente.ValidarCPF(ExtrairNumeros(ECPF.Text)) then
  begin
    raise Exception.Create('CPF Invalido. Verifique');
  end;
end;

procedure TFrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadCliente := Nil;
  Action := caFree;
end;

procedure TFrmCadCliente.IncluirEndereco;
begin
  if ECodigo.Text <> EmptyStr then
  begin
    FController.Endereco.DeleteEnderecos(FController.Cliente.Id);
  end;
  CDSEndereco.First;
  while not CDSEndereco.Eof do
  begin
    FController.Endereco
               .IdCliente(FController.Cliente.Id)
               .Logradouro(CDSEndereco.FieldByName('LOGRADOURO').AsString)
               .Cep(CDSEndereco.FieldByName('CEP').AsString)
               .Bairro(CDSEndereco.FieldByName('BAIRRO').AsString)
               .Cidade(CDSEndereco.FieldByName('CIDADE').AsString)
               .Estado(CDSEndereco.FieldByName('ESTADO').AsString)
               .IndPrincipal(CDSEndereco.FieldByName('IND_PRINCIPAL').AsString)
               .Build
               .Inserir;

    CDSEndereco.Next;
  end;
end;


procedure TFrmCadCliente.SBAlterarClick(Sender: TObject);
begin
  inherited;
  if String(ECodigo.Text).Trim.IsEmpty then
  begin
    ShowMessage('Nenhum registro para alterar. Verifique!');
    Abort;
  end;

  FEditar := True;

  DSCadastro.DataSet := FController.Cliente
                                   .Build
                                   .ListarPorId(StrToInt(ECodigo.Text));

  CarregaCliente;

  CDSEndereco.BeforePost := Nil;
  FController.Endereco.Build.SetClientDataSet('ID_CLIENTE', DSCadastro.DataSet.FieldByName('ID').AsInteger, CDSEndereco);
  CDSEndereco.BeforePost := CDSEnderecoBeforePost;
  ControleBotao;
  ENome.SetFocus;
end;

procedure TFrmCadCliente.SBCancelarClick(Sender: TObject);
begin
  inherited;
  ControleBotao;
end;

procedure TFrmCadCliente.SBConfirmarClick(Sender: TObject);
begin
  inherited;
  if not FEditar then
  begin
    FController.Cliente
               .Nome(ENome.Text)
               .Identidade(EIdentidade.Text)
               .Cpf(ECPF.Text)
               .Telefone(ETelefone.Text)
               .Email(EEmail.Text)
               .Build
               .Inserir;
  end
  else
  begin
    FController.Cliente
               .Id(StrToInt(ECodigo.Text))
               .Nome(ENome.Text)
               .Identidade(EIdentidade.Text)
               .Cpf(ECPF.Text)
               .Telefone(ETelefone.Text)
               .Email(EEmail.Text)
               .Build
               .Atualizar;
  end;
  IncluirEndereco;

  if MessageDlg('Deseja enviar por email?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FController.Cliente.EnviarEmail(FController.Cliente.Id);
  end;

  ControleBotao;
end;

procedure TFrmCadCliente.SBExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja mesmo deletar o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FController.Endereco.DeleteEnderecos(DSCadastro.DataSet.FieldByName('ID').AsInteger);
    FController.Cliente.Build.Excluir;

    CarregaCliente;
    CDSEndereco.EmptyDataSet;
  end;
end;

procedure TFrmCadCliente.SBIncluirClick(Sender: TObject);
begin
  inherited;
  FEditar := False;

  DSCadastro.DataSet := FController.Cliente.Build.ListarPorId(0);

  CDSEndereco.EmptyDataSet;
  CDSEndereco.BeforePost := Nil;
  FController.Endereco.Build.SetClientDataSet('ID_CLIENTE', 0, CDSEndereco);
  CDSEndereco.BeforePost := CDSEnderecoBeforePost;
  ControleBotao;
  CarregaCliente;
  ENome.SetFocus;
end;

procedure TFrmCadCliente.SBPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmClientes := TFrmClientes.Create(Self);
  try
    FrmClientes.ShowModal;
    if FrmClientes.ModalResult = mrOk then
    begin
      DSCadastro.DataSet     := FController.Cliente.Build.ListarPorId(FrmClientes.dsCliente.DataSet.FieldByName('ID').AsInteger);
      CarregaCliente;
      CDSEndereco.BeforePost := Nil;
      FController.Endereco.Build.SetClientDataSet('ID_CLIENTE', DSCadastro.DataSet.FieldByName('ID').AsInteger, CDSEndereco);
      CDSEndereco.BeforePost := CDSEnderecoBeforePost;
    end;
  finally
    FreeAndNil(FrmClientes);
  end;
end;

function TFrmCadCliente.ShowCliente(pId: Integer): Boolean;
var
  lId:Integer;
begin
  FController := TController.New;
  if pId > 0 then
  begin
    DSCadastro.DataSet := FController.Cliente.Build.ListarPorId(pId);
    lId     := DSCadastro.DataSet.FieldByName('ID').AsInteger;
    FEditar := True;
    GBEndereco.Enabled := True;
    GBCliente.Enabled  := True;
  end
  else
  begin
    lId     := 0;
    FEditar := False;
  end;
  CDSEndereco.BeforePost := Nil;
  FController.Endereco.Build.SetClientDataSet('ID_CLIENTE', lId, CDSEndereco);
  CDSEndereco.BeforePost := CDSEnderecoBeforePost;
  ControleBotao;
end;

end.
