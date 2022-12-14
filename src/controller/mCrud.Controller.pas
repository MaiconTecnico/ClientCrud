unit mCrud.Controller;

interface

uses
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
  mCrud.controller.interfaces,
  mCrud.model.entity.cliente,
  mCrud.model.entity.endereco,
  mCrud.services.generic,
  mCrud.controller.dto.interfaces,
  mCrud.controller.dto.cliente,
  mCrud.controller.dto.endereco;

type
  TController = class(TInterfacedObject, iController)
    private
      FCliente : iClienteDTO;
      FEndereco : iEnderecoDTO;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iController;
      function Cliente : iClienteDTO;
      function Endereco : iEnderecoDTO;
  end;

implementation

{ TController }

function TController.Cliente: iClienteDTO;
begin
  if not Assigned(FCliente) then
  begin
    FCliente := TClienteDTO.New;
  end;
  Result := FCliente;
end;

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

  inherited;
end;

function TController.Endereco: iEnderecoDTO;
begin
  if not Assigned(FEndereco) then
  begin
    FEndereco := TEnderecoDTO.New;
  end;
  Result := FEndereco;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

end.
