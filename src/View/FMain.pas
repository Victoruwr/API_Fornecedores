unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls,IniFiles,
  Horse,
  Horse.Jhonson,
  System.JSON,
  Horse.BasicAuthentication,
  Horse.CORS,
  Horse.Logger,
  Horse.Logger.Provider.LogFile, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TFormMain = class(TForm)
    Label2: TLabel;
    lbStatus: TLabel;
    ChaveServidor: TToggleSwitch;
    Label1: TLabel;
    EditPortaHorse: TEdit;
    Label4: TLabel;
    EdtPathLog: TEdit;
    BbGravar: TButton;
    procedure BbGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChaveServidorClick(Sender: TObject);
  private
    procedure Lerconfigurao;
    procedure Gravarconfiguracao;
  public

  end;

var
  FormMain: TFormMain;
  LLogFileConfig: THorseLoggerLogFileConfig;

implementation
   uses Controller.Fornecedor,
        System.NetEncoding;
{$R *.dfm}


{ TFormMain }

procedure TFormMain.BbGravarClick(Sender: TObject);
begin
  Gravarconfiguracao;
end;

procedure TFormMain.ChaveServidorClick(Sender: TObject);
begin
  case ChaveServidor.State of
    tssOff:
     begin
       THorse.StopListen;
       ChaveServidor.FrameColor := clRed;
       ChaveServidor.ThumbColor := clRed;
     end ;
    tssOn:
     begin
       THorse.Listen(StrToInt(EditPortaHorse.Text));
       ChaveServidor.FrameColor := clBlue;
       ChaveServidor.ThumbColor := clBlue;

     end;
  end;

end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  THorse.Use(CORS);
  THorse.Use(Jhonson);

  Controller.Fornecedor.Registry;
  Lerconfigurao;

  LLogFileConfig := THorseLoggerLogFileConfig.New
                   .SetLogFormat('[${request_clientip}] [${time}] [${request_method}] [${request_path_info}] [${request_version}] [${response_status}] [${response_location}] [${exception}] ')
                   .SetDir( EdtPathLog.Text );
  THorseLoggerManager.RegisterProvider(THorseLoggerProviderLogFile.New(LLogFileConfig));
  THorse.Use( THorseLoggerManager.HorseCallback() );
  THorse.Use(HorseBasicAuthentication(
  function(const AUsername, APassword: string): Boolean
  var INIConf : TIniFile;
  begin
    INIConf := TIniFile.Create( extractfilepath(paramstr(0)) + 'config.ini' );
    try
      Result := AUsername.Equals(INIConf.ReadString('API', 'AUsername','user')) and
                APassword.Equals(INIConf.ReadString('API', 'APassword','123456'));
    finally
      FreeAndNil(INIConf);
    end;
  end));

  ChaveServidor.State := tssOn;
end;

procedure TFormMain.Gravarconfiguracao;
var INIConf : TIniFile;
begin
  INIConf := TIniFile.Create( extractfilepath(paramstr(0)) + 'config.ini' );
  try
    INIConf.WriteString('API', 'RestPort',EditPortaHorse.text);
    INIConf.WriteString('API', 'PathLog',EdtPathLog.Text);
  finally
    FreeAndNil(INIConf);
  end;

end;

procedure TFormMain.Lerconfigurao;
var INIConf : TIniFile;
begin
  INIConf := TIniFile.Create( extractfilepath(paramstr(0)) + 'config.ini' );
  try
    EditPortaHorse.text := INIConf.ReadString('API', 'RestPort','9000');
    EdtPathLog.Text     := INIConf.ReadString('API', 'PathLog','');
  finally
    FreeAndNil(INIConf);
  end;

end;

end.
