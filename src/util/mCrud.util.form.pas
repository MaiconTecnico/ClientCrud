unit mCrud.util.form;

interface

uses
  Winapi.Windows, vcl.forms;

type
  TFrmBase = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    function ExtrairNumeros(p:String):String;
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}

{ TFrmBase }

function TFrmBase.ExtrairNumeros(p: String): String;
var
  i: Integer;
begin
  i:=1;
  Result := '';
  While i <= Length(p) do
  begin
    if not (p[i] in ['0','1','2','3','4','5','6','7','8','9']) then
    begin
      Delete(p,i,1);
    end
    else
    begin
      Result := Result+p[i];
      Inc(i);
    end;
  end;
end;

end.
