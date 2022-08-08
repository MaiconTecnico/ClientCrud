unit mCrud.model.entity.cliente;

interface

uses
  SimpleAttributes;

type
  [Tabela('CLIENTE')]
  TCliente = class
  private
    FId: Integer;
    FNome: String;
    FEmail: String;
    FCpf: String;
    FIdentidade: String;
    FTelefone: String;
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetCpf(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetIdentidade(const Value: String);
    procedure SetTelefone(const Value: String);
  public
    [Campo('ID'), PK, AutoInc]
    property Id : Integer read FId write SetId;
    [Campo('NOME')]
    property Nome : String read FNome write SetNome;
    [Campo('IDENTIDADE')]
    property Identidade : String read FIdentidade write SetIdentidade;
    [Campo('CPF')]
    property Cpf : String read FCpf write SetCpf;
    [Campo('TELEFONE')]
    property Telefone : String read FTelefone write SetTelefone;
    [Campo('EMAIL')]
    property Email : String read FEmail write SetEmail;
  end;

implementation

{ TCliente }

procedure TCliente.SetCpf(const Value: String);
begin
  FCpf := Value;
end;

procedure TCliente.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCliente.SetIdentidade(const Value: String);
begin
  FIdentidade := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

end.
