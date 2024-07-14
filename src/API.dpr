program API;

uses
  Vcl.Forms,
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  System.JSON,
  Horse.BasicAuthentication,
  Horse.CORS,
  DataSet.Serialize,
  System.IniFiles,
  System.DateUtils,
  FMain in 'View\FMain.pas' {FormMain},
  Conexao.Firedac in 'Model\Conexao.Firedac.pas',
  Query.Firedac in 'Model\Query.Firedac.pas',
  Factory.Query in 'Model\Factory.Query.pas',
  uInterfaces in 'Model\uInterfaces.pas',
  Controller.Fornecedor in 'Controller_EndPoints\Controller.Fornecedor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
