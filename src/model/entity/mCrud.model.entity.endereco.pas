unit mCrud.model.entity.endereco;

interface

uses
  SimpleAttributes;

type
  [Tabela('CLIENTE_ENDERECO')]
  TEndereco = class
  private
    FLogradouro: String;
    FBairro: String;
    FCep: String;
    FIdCliente: Integer;
    FCidade: String;
    FEstado: String;
    FId: Integer;
    FIndPrincipal: String;
    FNumero: Integer;
    FComplemento: String;
    FPais: String;

    procedure SetBairro(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetIdCliente(const Value: Integer);
    procedure SetLogradouro(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetIndPrincipal(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetNumero(const Value: Integer);
    procedure SetPais(const Value: String);
  public
    [Campo('ID'), PK, AutoInc]
    property Id : Integer read FId write SetId;
    [Campo('ID_CLIENTE'), FK, NotNull]
    property IdCliente : Integer read FIdCliente write SetIdCliente;
    [Campo('CEP')]
    property Cep : String read FCep write SetCep;
    [Campo('LOGRADOURO')]
    property Logradouro : String read FLogradouro write SetLogradouro;
    [Campo('NUMERO')]
    property Numero : Integer read FNumero write SetNumero;
    [Campo('COMPLEMENTO')]
    property Complemento : String read FComplemento write SetComplemento;
    [Campo('BAIRRO')]
    property Bairro : String read FBairro write SetBairro;
    [Campo('CIDADE')]
    property Cidade : String read FCidade write SetCidade;
    [Campo('ESTADO')]
    property Estado : String read FEstado write SetEstado;
    [Campo('PAIS')]
    property Pais : String read FPais write SetPais;
    [Campo('IND_PRINCIPAL')]
    property IndPrincipal : String read FIndPrincipal write SetIndPrincipal;
  end;

implementation

{ TEndereco }

procedure TEndereco.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TEndereco.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TEndereco.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TEndereco.SetIdCliente(const Value: Integer);
begin
  FIdCliente := Value;
end;

procedure TEndereco.SetIndPrincipal(const Value: String);
begin
  FIndPrincipal := Value;
end;

procedure TEndereco.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetNumero(const Value: Integer);
begin
  FNumero := Value;
end;

procedure TEndereco.SetPais(const Value: String);
begin
  FPais := Value;
end;

end.


