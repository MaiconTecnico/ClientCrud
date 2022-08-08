unit mCrud.controller.dto.endereco;

interface

uses
  System.SysUtils,
  RESTRequest4D,
  System.JSON,
  mCrud.model.entity.endereco,
  mCrud.controller.dto.interfaces,
  mCrud.services.generic;

type
  TEnderecoDTO = class(TInterfacedObject, iEnderecoDTO)
    private
      FEntity : TEndereco;
      FService : iService<TEndereco>;
      procedure SetViaCEP(pContent:String);
      procedure SetAPICEP(pContent:String);
      procedure SetBrasilAPI(pContent:String);
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iEnderecoDTO;
      function IdCliente(Value : Integer) : iEnderecoDTO; overload;
      function IdCliente : Integer; overload;
      function Cep(Value : String) : iEnderecoDTO; overload;
      function Cep : String; overload;
      function Logradouro(Value : String) : iEnderecoDTO; overload;
      function Logradouro : String; overload;
      function Numero(Value : Integer) : iEnderecoDTO; overload;
      function Numero : Integer; overload;
      function Complemento(Value : String) : iEnderecoDTO; overload;
      function Complemento : String; overload;
      function Bairro(Value : String) : iEnderecoDTO; overload;
      function Bairro : String; overload;
      function Cidade(Value : String) : iEnderecoDTO; overload;
      function Cidade : String; overload;
      function Estado(Value : String) : iEnderecoDTO; overload;
      function Estado : String; overload;
      function Pais(Value : String) : iEnderecoDTO; overload;
      function Pais : String; overload;
      function IndPrincipal(Value : String) : iEnderecoDTO; overload;
      function IndPrincipal : String; overload;
      function BuscaCEP(pCEP:String):Boolean;
      function DeleteEnderecos(pId:Integer):Boolean; overload;
      function Build : iService<TEndereco>;
  end;

implementation

function TEnderecoDTO.Bairro(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Bairro := Value;
end;

function TEnderecoDTO.Bairro: String;
begin
  Result := FEntity.Bairro;
end;

function TEnderecoDTO.Build: iService<TEndereco>;
begin
  Result := FService;
end;

function TEnderecoDTO.BuscaCEP(pCEP: String): Boolean;
var
  lStatus:Integer;
  lContent:String;


  procedure GetResponse(pURL:String);
  var
    LResponse: IResponse;
  begin
    LResponse := TRequest.New
                         .BaseURL(pURL)
                         .Accept('application/json')
                         .Get;
    lStatus := LResponse.StatusCode;
    if lStatus = 200 then
    begin
      lContent := LResponse.Content;
    end;
  end;
begin
  GetResponse('https://viacep.com.br/ws/'+pCEP+'/json/');
  if lStatus = 200 then
  begin
    SetViaCEP(lContent);
    Exit(True);
  end;

  GetResponse('https://ws.apicep.com/cep/'+ pCEP +'.json');
  if lStatus = 200 then
  begin
    SetAPICEP(lContent);
    Exit(True);
  end;

  GetResponse('https://brasilapi.com.br/api/cep/v1/'+ pCEP);
  if lStatus = 200 then
  begin
    SetAPICEP(lContent);
    Exit(True);
  end;

  Exit(False);
end;

function TEnderecoDTO.Cep(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Cep := Value;
end;

function TEnderecoDTO.Cidade(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Cidade := Value;
end;

constructor TEnderecoDTO.Create;
begin
  FEntity := TEndereco.Create;
  FService := TService<TEndereco>.New(FEntity);
end;

function TEnderecoDTO.DeleteEnderecos(pId: Integer): Boolean;
begin
  try
    FService.ExecuteSQL('DELETE FROM CLIENTE_ENDERECO WHERE ID_CLIENTE = '+IntToStr(pId));
    Result := True;
  except
    Result := False;
  end;
end;

destructor TEnderecoDTO.Destroy;
begin
  FEntity.Free;
  inherited;
end;

function TEnderecoDTO.Estado: String;
begin
  Result := FEntity.Estado;
end;

function TEnderecoDTO.Estado(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Estado := Value;
end;

function TEnderecoDTO.IdCliente(Value: Integer): iEnderecoDTO;
begin
  Result := Self;
  FEntity.IdCliente := Value;
end;

function TEnderecoDTO.Logradouro(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Logradouro := Value;
end;

class function TEnderecoDTO.New : iEnderecoDTO;
begin
  Result := Self.Create;
end;

function TEnderecoDTO.Numero: Integer;
begin
  Result := FEntity.Numero;
end;

function TEnderecoDTO.Numero(Value: Integer): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Numero := Value;
end;

function TEnderecoDTO.Pais(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Pais := Value;
end;

function TEnderecoDTO.Pais: String;
begin
  Result := FEntity.Pais;
end;

procedure TEnderecoDTO.SetAPICEP(pContent: String);
var
  JSONCEP: TJSONObject;
begin
  JSONCEP := TJSONObject.ParseJSONValue(pContent) as TJSONObject;
  try
    Cep(JSONCEP.GetValue<string>('code'));
    Logradouro(JSONCEP.GetValue<string>('address'));
    Bairro(JSONCEP.GetValue<string>('district'));
    Cidade(JSONCEP.GetValue<string>('city'));
    Estado(JSONCEP.GetValue<string>('state'));
    Pais('BRASIL');
  finally
    JSONCEP.Free;
  end;
end;

procedure TEnderecoDTO.SetBrasilAPI(pContent: String);
var
  JSONCEP: TJSONObject;
begin
  JSONCEP := TJSONObject.ParseJSONValue(pContent) as TJSONObject;
  try
    Cep(JSONCEP.GetValue<string>('cep'));
    Logradouro(JSONCEP.GetValue<string>('street'));
    Bairro(JSONCEP.GetValue<string>('neighborhood'));
    Cidade(JSONCEP.GetValue<string>('city'));
    Estado(JSONCEP.GetValue<string>('state'));
    Pais('BRASIL');
  finally
    JSONCEP.Free;
  end;
end;

procedure TEnderecoDTO.SetViaCEP(pContent: String);
var
  JSONCEP: TJSONObject;
begin
  JSONCEP := TJSONObject.ParseJSONValue(pContent) as TJSONObject;
  try
    Cep(JSONCEP.GetValue<string>('cep'));
    Logradouro(JSONCEP.GetValue<string>('logradouro'));
    Complemento(JSONCEP.GetValue<string>('complemento'));
    Bairro(JSONCEP.GetValue<string>('bairro'));
    Cidade(JSONCEP.GetValue<string>('localidade'));
    Estado(JSONCEP.GetValue<string>('uf'));
    Pais('BRASIL');
  finally
    JSONCEP.Free;
  end;
end;

function TEnderecoDTO.Cep: String;
begin
  Result := FEntity.Cep;
end;

function TEnderecoDTO.Cidade: String;
begin
  Result := FEntity.Cidade;
end;

function TEnderecoDTO.Complemento(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.Complemento := Value;
end;

function TEnderecoDTO.Complemento: String;
begin
  Result := FEntity.Complemento;
end;

function TEnderecoDTO.IdCliente: Integer;
begin
  Result := FEntity.IdCliente;
end;

function TEnderecoDTO.IndPrincipal: String;
begin
  Result := FEntity.IndPrincipal;
end;

function TEnderecoDTO.IndPrincipal(Value: String): iEnderecoDTO;
begin
  Result := Self;
  FEntity.IndPrincipal := Value;
end;

function TEnderecoDTO.Logradouro: String;
begin
  Result := FEntity.Logradouro;
end;

end.
