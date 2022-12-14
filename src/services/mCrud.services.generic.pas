unit mCrud.services.generic;

interface

uses
  System.SysUtils,
  System.Classes,
  SimpleInterface,
  SimpleDAO,
  SimpleAttributes,
  SimpleQueryFiredac,
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
  FireDAC.Stan.StorageXML,
  Data.DB,
  FireDAC.Comp.Client,
  Datasnap.DBClient,
  mCrud.resources.interfaces,
  mCrud.Resources.Conexao,
  System.Generics.Collections;

type
  iService<T: Class> = interface
    function Listar: TDataSet;
    function ListarClientDataSet:TDataSet;
    function ListarPorId(Id: Integer): TDataSet;
    function ListarPorFiltro(Key: String; Value: Variant): TDataSet;
    function Inserir: iService<T>;
    function Atualizar: iService<T>;
    function Excluir: iService<T>; overload;
    function Excluir(Field: String; Value: String): iService<T>; overload;
    function DataSource(var aDataSource: TDataSource): iService<T>;
    function GetClientDataSet(Key: String; Value: Variant): TClientDataSet;
    function SetClientDataSet(Key: String; Value: Variant; ClientDataSet:TClientDataSet): TDataSet;
    function ListarPorDTO:TDataSet;
    function Entity: T;
    function AddSQL(aSQL:String): TDataSet;
    function ExecuteSQL(aSQL:String): TDataSet;
    function SalveToXML(aSQL, aNomeArquivo: String): TDataSet;
  end;

  TService<T: class, constructor> = class(TInterfacedObject, iService<T>)
  private
    FParent: T;
    FConexao: iConexao;
    FConn: iSimpleQuery;
    FDAO: iSimpleDAO<T>;
    FDataSource: TDataSource;
    FClientDataSet: TClientDataSet;
    FQuery:TFDQuery;
  public
    constructor Create(Parent: T);
    destructor Destroy; override;
    class function New(Parent: T): iService<T>;
    function Listar: TDataSet;
    function ListarClientDataSet:TDataSet;
    function ListarPorId(Id: Integer): TDataSet;
    function ListarPorFiltro(Key: String; Value: Variant): TDataSet;
    function Inserir: iService<T>;
    function Atualizar: iService<T>;
    function Excluir: iService<T>; overload;
    function Excluir(Field: String; Value: String): iService<T>; overload;
    function DataSource(var aDataSource: TDataSource): iService<T>;
    function ListarPorDTO:TDataSet;
    function GetClientDataSet(Key: String; Value: Variant): TClientDataSet;
    function SetClientDataSet(Key: String; Value: Variant; ClientDataSet:TClientDataSet): TDataSet;
    function Entity: T;
    function AddSQL(aSQL:String): TDataSet;
    function ExecuteSQL(aSQL:String): TDataSet;
    function SalveToXML(aSQL, aNomeArquivo: String): TDataSet;
  end;

implementation

function TService<T>.AddSQL(aSQL: String): TDataSet;
begin
  FConn.SQL.Clear;
  FConn.SQL.Text := aSQL;
  FConn.Open;
  Result := FConn.DataSet;
end;

function TService<T>.Atualizar: iService<T>;
begin
  Result := Self;
  FDAO.Update(FParent);
end;

constructor TService<T>.Create(Parent: T);
begin
  FParent := Parent;
  FDataSource := TDataSource.Create(nil);
  FConexao := TConexao.New;
  FConn := TSimpleQueryFiredac.New(TFDConnection(FConexao.Connect));
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);
  FClientDataSet := TClientDataSet.Create(Nil);

  FQuery            := TFDQuery.Create(Nil);
  FQuery.Connection := TFDConnection(FConexao.Connect);
end;

function TService<T>.DataSource(var aDataSource: TDataSource): iService<T>;
begin
  Result := Self;
  aDataSource := FDataSource;
end;

destructor TService<T>.Destroy;
begin
  FClientDataSet.Free;
  FDataSource.Free;
  FQuery.Free;
  inherited;
end;

function TService<T>.Excluir: iService<T>;
begin
  Result := Self;
  FDAO.Delete(FParent);
end;

function TService<T>.Excluir(Field, Value: String): iService<T>;
begin
  Result := Self;
  FDAO.Delete(Field, Value);
end;

function TService<T>.ExecuteSQL(aSQL: String): TDataSet;
begin
  FConn.SQL.Clear;
  FConn.SQL.Text := aSQL;
  FConn.ExecSQL;
  Result := FConn.DataSet;
end;

function TService<T>.GetClientDataSet(Key: String; Value: Variant): TClientDataSet;
var
  I:Integer;
begin
  if Key = '' then
  begin
    Listar;
  end
  else
  begin
    ListarPorFiltro(Key,Value);
  end;

  if FClientDataSet.Active then
  begin
    FClientDataSet.Close;
  end;

  if FClientDataSet.FieldDefs.Count > 0 then
  begin
    FClientDataSet.FieldDefs.Clear;
    FClientDataSet.Fields.Clear;
  end;

  for I := 0 to FDataSource.DataSet.FieldCount-1 do
  begin
    FClientDataSet.FieldDefs.Add(FDataSource.DataSet.Fields[I].FieldName, FDataSource.DataSet.Fields[I].DataType, FDataSource.DataSet.Fields[I].Size, False);
  end;

  FClientDataSet.CreateDataSet;

  FClientDataSet.EmptyDataSet;
  FDataSource.DataSet.First;
  while not FDataSource.DataSet.Eof do
  begin
    FClientDataSet.Append;

    for I := 0 to FDataSource.DataSet.FieldCount-1 do
    begin
      FClientDataSet.FieldByName(FDataSource.DataSet.Fields[I].FieldName).Value := FDataSource.DataSet.Fields[I].Value;
    end;

    FClientDataSet.Post;
    FDataSource.DataSet.Next;
  end;

  Result := FClientDataSet;
end;

function TService<T>.Inserir: iService<T>;
begin
  Result := Self;
  FDAO.Insert(FParent);
end;

function TService<T>.Listar: TDataSet;
begin
  FDAO.Find;
  Result := FDataSource.DataSet;
end;

function TService<T>.ListarClientDataSet: TDataSet;
var
  I:Integer;
begin
  if FClientDataSet.Active then
  begin
    FClientDataSet.Close;
  end;

  if FClientDataSet.FieldDefs.Count > 0 then
  begin
    FClientDataSet.FieldDefs.Clear;
    FClientDataSet.Fields.Clear;
  end;

  FClientDataSet.FieldDefs.Add('SEL', ftString, 1, False);
  for I := 0 to FDataSource.DataSet.FieldCount-1 do
  begin
    if FDataSource.DataSet.Fields[I].DataType = ftAutoInc then
    begin
      FClientDataSet.FieldDefs.Add(FDataSource.DataSet.Fields[I].FieldName, ftInteger, FDataSource.DataSet.Fields[I].Size, False);
    end
    else
    begin
      FClientDataSet.FieldDefs.Add(FDataSource.DataSet.Fields[I].FieldName, FDataSource.DataSet.Fields[I].DataType, FDataSource.DataSet.Fields[I].Size, False);
    end;
  end;

  FClientDataSet.CreateDataSet;

  FClientDataSet.EmptyDataSet;
  FDataSource.DataSet.First;
  while not FDataSource.DataSet.Eof do
  begin
    FClientDataSet.Append;
    FClientDataSet.FieldByName('SEL').AsString := 'N';

    for I := 0 to FDataSource.DataSet.FieldCount-1 do
    begin
      FClientDataSet.FieldByName(FDataSource.DataSet.Fields[I].FieldName).Value := FDataSource.DataSet.Fields[I].Value;
    end;

    FClientDataSet.Post;
    FDataSource.DataSet.Next;
  end;

  Result := FClientDataSet;
end;

function TService<T>.ListarPorDTO: TDataSet;
begin
  Listar;
  Result := ListarClientDataSet;
end;

function TService<T>.ListarPorFiltro(Key: String; Value: Variant): TDataSet;
begin
  FDAO.Find(Key, Value);
  Result := FDataSource.DataSet;
end;

function TService<T>.ListarPorId(Id: Integer): TDataSet;
begin
  FDAO.Find(Id);
  Result := FDataSource.DataSet;
end;

class function TService<T>.New(Parent: T): iService<T>;
begin
  Result := Self.Create(Parent);
end;

function TService<T>.SalveToXML(aSQL, aNomeArquivo: String): TDataSet;
var
  lXML:TStringList;
  I:Integer;
begin
  FQuery.SQL.Text := aSQL;
  FQuery.Open;

  lXML := TStringList.Create;
  try
    lXML.Add('<?xml version="1.0" encoding="utf-8"?>');
    lXML.Add('<'+aNomeArquivo+'>');
    lXML.Add('<Cadastro ');

    FQuery.First;
    for I := 0 to FQuery.FieldCount-1 do
    begin
      lXML.Add(UpperCase(FQuery.Fields[I].FieldName)+'="'+UpperCase(FQuery.Fields[I].AsString)+'" ');
    end;
    lXML.Add('/>');
    lXML.Add('</'+aNomeArquivo+'>');

    lXML.SaveToFile(ExtractFilePath(ParamStr(0))+aNomeArquivo+'.xml');
  finally
    lXML.Free;
  end;
  Result := FQuery;
end;

function TService<T>.SetClientDataSet(Key: String; Value: Variant; ClientDataSet:TClientDataSet): TDataSet;
var
  I:Integer;
begin
  if Key = '' then
  begin
    Listar;
  end
  else
  begin
    ListarPorFiltro(Key,Value);
  end;

  if ClientDataSet.Active then
  begin
    ClientDataSet.Close;
  end;

  if ClientDataSet.FieldDefs.Count > 0 then
  begin
    ClientDataSet.FieldDefs.Clear;
    ClientDataSet.Fields.Clear;
  end;

  for I := 0 to FDataSource.DataSet.FieldCount-1 do
  begin
    ClientDataSet.FieldDefs.Add(FDataSource.DataSet.Fields[I].FieldName, FDataSource.DataSet.Fields[I].DataType, FDataSource.DataSet.Fields[I].Size, False);
  end;

  ClientDataSet.CreateDataSet;

  ClientDataSet.EmptyDataSet;
  FDataSource.DataSet.First;
  while not FDataSource.DataSet.Eof do
  begin
    ClientDataSet.Append;

    for I := 0 to FDataSource.DataSet.FieldCount-1 do
    begin
      ClientDataSet.FieldByName(FDataSource.DataSet.Fields[I].FieldName).Value := FDataSource.DataSet.Fields[I].Value;
    end;

    ClientDataSet.Post;
    FDataSource.DataSet.Next;
  end;

  Result := FClientDataSet;
end;

function TService<T>.Entity: T;
begin
  Result := FParent;
end;

end.
