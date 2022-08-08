unit mCrud.controller.dto.cliente;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  Data.DB,
  FireDAC.Comp.Client,
  mCrud.model.entity.cliente,
  mCrud.controller.dto.interfaces,
  mCrud.Services.Generic,
  ACBrBase,
  ACBrMail;

type
  TClienteDTO = class(TInterfacedObject, iClienteDTO)
    private
      FEmail:TACBrMail;
      FEntity : TCliente;
      FSQL:String;
      FService : iService<TCliente>;
      function SQLCliente(aId:Integer): String;
      function EnviandoEmail(aAuth:Boolean): Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iClienteDTO;
      function Id(Value : Integer)  : iClienteDTO; overload;
      function Id : Integer; overload;
      function Nome(Value : String) : iClienteDTO; overload;
      function Nome : String; overload;
      function Identidade(Value : String) : iClienteDTO; overload;
      function Identidade : String; overload;
      function Cpf(Value : String) : iClienteDTO; overload;
      function Cpf : String; overload;
      function Telefone(Value : String) : iClienteDTO; overload;
      function Telefone : String; overload;
      function Email(Value : String) : iClienteDTO; overload;
      function Email : String; overload;
      function SQLConsulta(Value : String) : iClienteDTO; overload;
      function SQLConsulta : String; overload;
      function ValidarCPF(pCPF:String):Boolean;
      function EnviarEmail(aId:Integer):Boolean; overload;
      function Build : iService<TCliente>;
  end;

implementation

function TClienteDTO.Build: iService<TCliente>;
begin
  Result := FSErvice;
end;

function TClienteDTO.Cpf(Value: String): iClienteDTO;
begin
  Result      := Self;
  FEntity.Cpf := Value;
end;

function TClienteDTO.Cpf: String;
begin
  Result := FEntity.Cpf;
end;

constructor TClienteDTO.Create;
begin
  FEntity  := TCliente.Create;
  FService := TService<TCliente>.New(FEntity);
  FEmail   := TACBrMail.Create(Nil);
end;

destructor TClienteDTO.Destroy;
begin
  FEntity.Free;
  FEmail.Free;
  inherited;
end;

function TClienteDTO.Email: String;
begin
  Result := FEntity.Email;
end;

function TClienteDTO.EnviandoEmail(aAuth:Boolean): Boolean;
var
  S,M: string;
  P, I: Integer;
begin
  FEmail.Clear;                {Colocar um dado de email valido}
  FEmail.Host               := '';
  FEmail.Port               := '';
  FEmail.Username           := '';
  FEmail.Password           := '';
  if aAuth then
  begin
    FEmail.SetTLS := True;
  end
  else
  begin
    FEmail.SetTLS := False;
  end;

  S := Email;
  I := 0;
  repeat
    Inc(I);
    P := Pos(',', S);
    if P = 0 then
      P := Length(S) + 1;
    M := Copy(S, 1, Pred(P));
    Delete(S, 1, P);
  until P >= Length(S);

  FEmail.Body.Add('<html><body>Cadastro do Cliente</body></html>');
  FEmail.From    := '';
  FEmail.AddAddress(M);
  FEmail.AddAttachment(ExtractFilePath(ParamStr(0))+'CadastroCliente.xml');
  FEmail.Subject := 'Cadastro do Cliente '+Nome;

  try FEmail.Send; except end;
end;

function TClienteDTO.EnviarEmail(aId: Integer): Boolean;
begin
  FService.SalveToXML(SQLCliente(aId),'CadastroCliente');
  EnviandoEmail(True);
end;

function TClienteDTO.Email(Value: String): iClienteDTO;
begin
  Result         := Self;
  FEntity.Email  := Value;
end;

function TClienteDTO.Id: Integer;
begin
  Result := FEntity.Id;
end;

function TClienteDTO.Identidade(Value: String): iClienteDTO;
begin
  Result             := Self;
  FEntity.Identidade := Value;
end;

function TClienteDTO.Identidade: String;
begin
  Result := FEntity.Identidade;
end;

function TClienteDTO.Id(Value: Integer): iClienteDTO;
begin
  Result     := Self;
  FEntity.Id := Value;
end;

class function TClienteDTO.New : iClienteDTO;
begin
  Result := Self.Create;
end;

function TClienteDTO.Nome: String;
begin
  Result := FEntity.Nome;
end;

function TClienteDTO.SQLCliente(aId:Integer): String;
begin
  Result := 'SELECT  ' +
            ' C.ID AS CODIGO, ' +
            ' C.NOME,  ' +
            ' C.CPF, ' +
            ' C.IDENTIDADE,  ' +
            ' C.TELEFONE, ' +
            ' C.EMAIL, ' +
            ' CE.CEP, ' +
            ' CE.LOGRADOURO AS ENDERECO, ' +
            ' CE.BAIRRO,  ' +
            ' CE.CIDADE, ' +
            ' CE.COMPLEMENTO, ' +
            ' CE.NUMERO, ' +
            ' CE.ESTADO, ' +
            ' CE.PAIS  ' +
            ' FROM CLIENTE C  ' +
            '   LEFT JOIN CLIENTE_ENDERECO CE  ' +
            '     ON CE.ID_CLIENTE = C.ID  ' +
            '    AND CE.IND_PRINCIPAL = ''S'' ' +
            '  WHERE C.ID = '+IntToStr(aId);
end;

function TClienteDTO.SQLConsulta: String;
begin
  Result := FSQL;
end;

function TClienteDTO.Telefone(Value: String): iClienteDTO;
begin
  Result := Self;
  FEntity.Telefone := Value;
end;

function TClienteDTO.Telefone: String;
begin
  Result := FEntity.Telefone;
end;

function TClienteDTO.ValidarCPF(pCPF:String):Boolean;
var
  dig10,
  dig11: string;
  s,
  i,
  r,
  peso: integer;
begin
  if ((pCPF = '00000000000') or (pCPF = '11111111111') or
      (pCPF = '22222222222') or (pCPF = '33333333333') or
      (pCPF = '44444444444') or (pCPF = '55555555555') or
      (pCPF = '66666666666') or (pCPF = '77777777777') or
      (pCPF = '88888888888') or (pCPF = '99999999999') or
      (length(pCPF) <> 11))
  then
  begin
    Exit(False)
  end;

  try
    s    := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
      s    := s + (StrToInt(pCPF[i]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if ((r = 10) or (r = 11))then
    begin
      dig10 := '0';
    end
    else
    begin
      str(r:1, dig10);
    end;

    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(pCPF[i]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if ((r = 10) or (r = 11)) then
    begin
      dig11 := '0';
    end
    else
    begin
      str(r:1, dig11);
    end;


    if ((dig10 = pCPF[10]) and
       (dig11 = pCPF[11]))
    then
    begin
      Exit(True);
    end
    else
    begin
      Exit(False);
    end;
  except
    Exit(False);
  end;
end;

function TClienteDTO.SQLConsulta(Value: String): iClienteDTO;
begin
  Result := Self;
  FSQL   := Value;
end;

function TClienteDTO.Nome(Value: String): iClienteDTO;
begin
  Result       := Self;
  FEntity.Nome := Value;
end;

end.
