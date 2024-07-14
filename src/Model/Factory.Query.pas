unit Factory.Query;

interface

uses
uInterfaces;

Type
  TControllerFactoryQuery = class(TInterfacedObject, iFactoryQuery)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryQuery;
      function Query(Connection : iConexao) : iQuery;
  end;

  TControllerFactoryExecQuery = class(TInterfacedObject, iFactoryExecQuery)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryExecQuery;
      function ExecQuery(Connection : iConexao) : iExecQuery;
  end;


implementation

uses
  Query.Firedac;

{ TControllerFactoryQuery }

constructor TControllerFactoryQuery.Create;
begin

end;

destructor TControllerFactoryQuery.Destroy;

begin
  inherited;
end;

class function TControllerFactoryQuery.New: iFactoryQuery;

begin
  Result := Self.Create;
end;

function TControllerFactoryQuery.Query(Connection : iConexao) : iQuery;

begin
  Result := TModelQueryFiredac.New(Connection);
end;


{ TControllerFactoryExecQuery}

constructor TControllerFactoryExecQuery.Create;

begin

end;

destructor TControllerFactoryExecQuery.Destroy;

begin
  inherited;
end;

class function TControllerFactoryExecQuery.New: iFactoryExecQuery;

begin
  Result := Self.Create;
end;

function TControllerFactoryExecQuery.ExecQuery(Connection : iConexao) : iExecQuery;

begin
  Result := TModelExecQueryFiredac.New(Connection);
end;


end.

