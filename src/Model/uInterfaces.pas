unit uInterfaces;

interface

uses
  Data.DB
  ,FireDAC.Comp.Client;

type

  iConexao = interface
   ['{F50FC5FE-C508-4082-B8F3-39F8A7F18FC2}']
    function Connection : TCustomConnection;
  end;

  iQuery = interface
    ['{6B631364-F745-4165-A41D-F3843CEEA2F5}']
    function SQL(Value : String) : iQuery;
    function DataSet : Tdataset;
    function TextoSQl: string;
  end;

  iExecQuery = interface
    ['{68BFD924-4BD5-4A8C-BD16-F945F4A57015}']
    function ExecSQL(Value : String) : iExecQuery;
    Procedure StartTransaction;
    Procedure Commit;
    Procedure Rollback;
  end;

    iFactoryQuery = interface
    ['{D809BD52-AFE2-4F8D-B368-BE9A828CAAA5}']
    function Query(Connection : iConexao) : iQuery;
  end;

  iFactoryExecQuery = interface
    ['{41CBFC11-1AD0-47F4-8735-D8327B264BEA}']
    function ExecQuery(Connection : iConexao) : iExecQuery;
  end;
implementation

end.
