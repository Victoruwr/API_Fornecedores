unit Conexao.Firedac;

interface

uses
  uInterfaces,
  Data.DB,
  FireDAC.Phys.MySQL,
     FireDAC.Stan.Intf,
     FireDAC.Stan.Option,
     FireDAC.Stan.Error,
     FireDAC.Comp.Client;

Type
  TModelConexaoFiredac = class(TInterfacedObject, iConexao)
    private
      FConexao: TFDConnection;
      FMysqlDriverLink : TFDPhysMySQLDriverLink;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iConexao;
      function Connection : TCustomConnection;
  end;

implementation

uses
  SysUtils,
  System.IniFiles,
  Vcl.Dialogs;

{ TModelConexaoFiredac }

function TModelConexaoFiredac.Connection: TCustomConnection;

  begin
    Result := FConexao;
  end;

constructor TModelConexaoFiredac.Create;

  Var NomeIni : String;
      ArqIni : TIniFile;
      DirFile, User, Pass, DBFile, DriverID,CaminhoDLL: string;
      ConfigINI: TIniFile;

Begin
  try
     DirFile := extractfilepath(paramstr(0)) + 'config.ini';
     ConfigINI := TIniFile.Create(DirFile);
     DriverID :=  ConfigINI.ReadString('BD', 'DriverID', 'MySQL');
     User := ConfigINI.ReadString('BD', 'User', 'root');
     Pass := ConfigINI.ReadString('BD', 'Pass', '1234');
     DBFile := ConfigINI.ReadString('BD', 'DBFile', 'horse');
     CaminhoDLL:= ConfigINI.ReadString('BD', 'CaminhoDLL', '');
     ConfigINI.Free;

    FMysqlDriverLink := TFDPhysMySQLDriverLink.Create(nil);
    FMysqlDriverLink.VendorLib :=  CaminhoDLL;
    FMysqlDriverLink.DriverID := DriverID;

    FConexao := TFDConnection.Create(nil);
    FConexao.TxOptions.AutoCommit := false;
    FConexao.Params.Clear;
    FConexao.DriverName := 'MySQL';
    FConexao.Params.DriverID := DriverID;
    FConexao.Params.database := DBFile;
    FConexao.Params.UserName := User;
    FConexao.Params.Password := Pass;
    Fconexao.ConnectedStoredUsage := [];
    FConexao.Connected := true;
  except on E: Exception do
    Raise Exception.Create('Banco de Dados não Encontrado'+E.Message);
  End;
end;

destructor TModelConexaoFiredac.Destroy;
begin
  FreeAndNil(FConexao);
  freeandnil(FMysqlDriverLink);
  inherited;
end;

class function TModelConexaoFiredac.New: iConexao;

begin
  Result := Self.Create;
end;

end.
