unit Query.Firedac;

interface

uses
  uInterfaces,
  Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

Type
  TModelQueryFiredac = class(TInterfacedObject, iQuery)
    private
      FParent : iConexao;
      FQuery : TFDQuery;
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iQuery;
      function SQL(Value : String) : iQuery;
      function DataSet : Tdataset;
      function TextoSQl: string;
  end;

  TModelExecQueryFiredac = class(TInterfacedObject, iExecQuery)
    private
      FParent : iConexao;
      FExecQuery : TFDQuery;
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iExecQuery;
      function ExecSQL(Value : String) : iExecQuery;
      Procedure StartTransaction;
      Procedure Commit;
      Procedure Rollback;
   end;

implementation

uses
  System.SysUtils,
  Conexao.Firedac;

{ TModelQueryFiredac }

constructor TModelQueryFiredac.Create(Parent : iConexao);

  begin
    FParent := Parent;
    FQuery := TFDQuery.Create(nil);
    if not Assigned(FParent)
       then FParent := TModelConexaoFiredac.New;

    FQuery.Connection := TFDConnection(FParent.Connection);
  end;

function TModelQueryFiredac.DataSet: TDataSet;

  begin
    Result := FQuery;
  end;

destructor TModelQueryFiredac.Destroy;

  begin
    FreeAndNil(FQuery);
    inherited;
  end;

class function TModelQueryFiredac.New(Parent : iConexao) : iQuery;

  begin
    Result := Self.Create(Parent);
  end;

function TModelQueryFiredac.SQL(Value: String): iQuery;
  begin
    Result := Self;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(Value);
    FQuery.Active := true;
    FQuery.FetchAll;
  end;


function TModelQueryFiredac.TextoSQl: string;
begin
  Result := FQuery.sql.Text;
end;

{ TModelExecQueryFiredac }

constructor TModelExecQueryFiredac.Create(Parent : iConexao);

  begin
    FParent := Parent;
    FExecQuery := TFDQuery.Create(nil);
    if not Assigned(FParent)
       then FParent := TModelConexaoFiredac.New;

    FExecQuery.Connection := TFDConnection(FParent.Connection);
  end;

destructor TModelExecQueryFiredac.Destroy;

  begin
    FreeAndNil(FExecQuery);
    inherited;
  end;

class function TModelExecQueryFiredac.New(Parent : iConexao) : iExecQuery;

  begin
    Result := Self.Create(Parent);
  end;

function TModelExecQueryFiredac.ExecSQL(Value: String): iExecQuery;

  begin
    Result := Self;
    FExecQuery.SQL.Clear;
    FExecQuery.SQL.Add(Value);
    FExecQuery.ExecSql;
  end;


Procedure TModelExecQueryFiredac.StartTransaction;

  Begin
    FExecQuery.Connection.StartTransaction;
  End;


Procedure TModelExecQueryFiredac.Commit;

  Begin
    FExecQuery.Connection.Commit;
  End;

Procedure TModelExecQueryFiredac.Rollback;

  Begin
    FExecQuery.Connection.Rollback
  End;

end.
