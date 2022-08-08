unit mCrud.controller.dto.interfaces;

interface

uses
  mCrud.services.generic,
  mCrud.model.entity.cliente,
  mCrud.model.entity.endereco;

type
  iClienteDTO = interface
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
    function Build : iService<TCliente>;
    function EnviarEmail(aId:Integer):Boolean; overload;
  end;

  iEnderecoDTO = interface
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
    function DeleteEnderecos(pId:Integer):Boolean; overload;
    function BuscaCEP(pCEP:String):Boolean; overload;
    function Build : iService<TEndereco>;
  end;

implementation

end.
