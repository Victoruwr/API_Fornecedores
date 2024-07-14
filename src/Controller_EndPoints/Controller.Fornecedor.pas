unit Controller.Fornecedor;

interface
   uses Horse,
        System.JSON,
        DataSet.Serialize,
        System.SysUtils;

procedure Registry;

implementation
 uses
 uinterfaces,
 Factory.Query;

procedure EnviarTodos( Req : THorseRequest; res : THorseResponse; Next : TProc);
 var
  RegFornecedor : TJSONArray;
  LJsonObjectResponse: TJSONObject;
  FQuery : iQuery;
  Paginas, TotRegistros, PosIni, PosFin : Integer;
  LLimit, LPage: string;
 begin
   try
     FQuery := TControllerFactoryQuery.New.Query(nil);
     if UpperCase(Req.Headers['X-Paginate']) = 'TRUE'
        then begin
               if not Req.Query.TryGetValue('limit', LLimit)
                  then LLimit := '50';
               if not Req.Query.TryGetValue('page', LPage)
                  then LPage := '1';
             end
        else begin
               LLimit := '50';
               LPage := '1';
             end;

     PosIni := (StrToInt(LPage)-1)*StrToInt(LLimit)+1;
     PosFin  := PosIni + StrToInt(LLimit)-1;

     //Calcular o total de registros e paginas que tem a tabela
     FQuery.SQL('SELECT Count(*) as TotRegistros FROM tbl_fornecedores F');
     TotRegistros := FQuery.DataSet.FieldByName('TotRegistros').AsInteger;
     Paginas      := Trunc(TotRegistros / StrToInt(LLimit)) + Byte((TotRegistros mod StrToInt(LLimit) <> 0));

     // Agora ler os dados da quantidade e página selecionada
     FQuery.Sql( 'Select * From (SELECT Row_number() over (order by CODIGO asc) NumLinha, F.* FROM tbl_fornecedores F Order by CODIGO) As TP '+
                 'Where TP.NumLinha Between '+QuotedStr(PosIni.ToString)+ ' and '+ QuotedStr(PosFin.ToString));
     RegFornecedor := FQuery.DataSet.ToJSONArray();

     LJsonObjectResponse := TJsonObject.Create;
     LJsonObjectResponse.AddPair('docs', RegFornecedor);
     LJsonObjectResponse.AddPair('total', TJSONNumber.Create(TotRegistros));
     LJsonObjectResponse.AddPair('limit', TJSONNumber.Create(LLimit));
     LJsonObjectResponse.AddPair('page', TJSONNumber.Create(LPage));
     LJsonObjectResponse.AddPair('pages', TJSONNumber.Create(Paginas));
     Res.Send<TJSONValue>(LJsonObjectResponse);
   except
    on E: Exception do
     Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro ao pegar dados ['+e.Message+']')).Status(THTTPStatus.BadRequest);

   end;
 end;

procedure EnviarSelecionado( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var RegFornecedor: TJSONArray;
      FQuery : iQuery;
      codigo  :string;
  begin
    Try
      codigo := Req.Params.Items['codigo'];

      FQuery := TControllerFactoryQuery.New.Query(nil);
      FQuery.SQL('SELECT * FROM tbl_fornecedores Where codigo='+QuotedStr(codigo));
      RegFornecedor := FQuery.DataSet.ToJSONArray();
      res.Send( RegFornecedor );
    except on E: Exception do
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro pegar Dados ['+e.Message+']')).Status(THTTPStatus.BadRequest);
    End;
  end;

procedure AlterarSelecionado( Req : THorseRequest; res : THorseResponse; Next : TProc);
 var
   FQuery : iQuery;
   codigo  :string;
 begin
   Try
     codigo := Req.Params.Items['codigo'];

     FQuery := TControllerFactoryQuery.New.Query(nil);
     FQuery.SQL('SELECT * FROM tbl_fornecedores Where codigo='+QuotedStr(codigo));

     FQuery.DataSet.MergeFromJSONObject( Req.Body<TJSONObject>);
     Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Atualizado com sucesso')).Status(THTTPStatus.Ok);
   except  on E: Exception do
     Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Alterar Dados ['+e.Message+']')).Status(THTTPStatus.BadRequest);
   End;
 end;

procedure ExcluirSelecionado( Req : THorseRequest; res : THorseResponse; Next : TProc);
 var
   FQueryExec : iExecQuery;
   codigo  :string;
 begin
   codigo := Req.Params.Items['codigo'];
   try
     FQueryExec := TControllerFactoryExecQuery.New.ExecQuery(nil);

     FqueryExec.StartTransaction;  // Prepara para que se ocorrer algum erro nas exclusões abaixo, possa desfazê-las para que seja verificado os erros ocorrido
     FQueryExec.ExecSQL('Delete from tbl_fornecedores Where codigo='+QuotedStr(codigo));
     FQueryExec.Commit;     // Confirmar as esclusões
     Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Deletado com sucesso')).Status(THTTPStatus.Ok);
   except  on E: Exception do
     begin
       FQueryExec.Rollback; // Desfazer exclusões acima realizadas
       Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Deletar Dados ['+e.Message+']')).Status(THTTPStatus.BadRequest);
     end;
   End;
 end;

procedure IncluirRecebido( Req : THorseRequest; res : THorseResponse; Next : TProc);
var FQuery : iQuery;
begin
  try
    FQuery := TControllerFactoryQuery.New.Query(nil);
    FQuery.SQL('SELECT * FROM tbl_fornecedores');
    FQuery.DataSet.LoadFromJSON(Req.Body<TJSONObject>);
    FQuery.DataSet.Insert;
    Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Inserido com sucesso')).Status(THTTPStatus.Ok);
  except
    on E: Exception do
    Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Incluir Dados ['+e.Message+']')).Status(THTTPStatus.BadRequest);
  end;
end;

procedure Registry;
 begin
   THorse.Get('/Fornecedores/', EnviarTodos)
         .Get('/Fornecedor/:codigo',   EnviarSelecionado)
         .Put('/Fornecedor/:codigo',   AlterarSelecionado)
         .Delete('/Fornecedor/:codigo',ExcluirSelecionado)
         .Post('/Fornecedor',            IncluirRecebido);
 end;

end.
