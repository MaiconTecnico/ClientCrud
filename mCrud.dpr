program mCrud;

uses
  Vcl.Forms,
  mCrud.view.principal in 'src\view\mCrud.view.principal.pas' {FrmPrincipal},
  mCrud.util.form in 'src\util\mCrud.util.form.pas' {FrmBase},
  mCrud.services.generic in 'src\services\mCrud.services.generic.pas',
  mCrud.resources.interfaces in 'src\resources\mCrud.resources.interfaces.pas',
  mCrud.resources.conexao in 'src\resources\mCrud.resources.conexao.pas',
  mCrud.controller.interfaces in 'src\controller\mCrud.controller.interfaces.pas',
  mCrud.controller.dto.cliente in 'src\dto\mCrud.controller.dto.cliente.pas',
  mCrud.model.entity.cliente in 'src\model\entity\mCrud.model.entity.cliente.pas',
  mCrud.controller.dto.interfaces in 'src\dto\mCrud.controller.dto.interfaces.pas',
  mCrud.Controller in 'src\controller\mCrud.Controller.pas',
  mCrud.view.clientes in 'src\view\mCrud.view.clientes.pas' {FrmClientes},
  mCrud.view.cadastroclientes in 'src\view\mCrud.view.cadastroclientes.pas' {FrmCadCliente},
  mCrud.model.entity.endereco in 'src\model\entity\mCrud.model.entity.endereco.pas',
  mCrud.controller.dto.endereco in 'src\dto\mCrud.controller.dto.endereco.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
