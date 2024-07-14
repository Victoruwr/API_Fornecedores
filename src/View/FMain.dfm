object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'API'
  ClientHeight = 191
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 388
    Height = 25
    Align = alTop
    Alignment = taCenter
    Caption = 'API Server'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 111
  end
  object lbStatus: TLabel
    Left = 68
    Top = 41
    Width = 35
    Height = 13
    Caption = 'Status:'
  end
  object Label1: TLabel
    Left = 15
    Top = 97
    Width = 88
    Height = 13
    Caption = 'Porta do Servidor:'
  end
  object Label4: TLabel
    Left = 37
    Top = 124
    Width = 66
    Height = 13
    Caption = 'Path Log uso:'
  end
  object ChaveServidor: TToggleSwitch
    Left = 107
    Top = 36
    Width = 72
    Height = 20
    FrameColor = clRed
    TabOrder = 0
    ThumbColor = clRed
    OnClick = ChaveServidorClick
  end
  object EditPortaHorse: TEdit
    Left = 107
    Top = 94
    Width = 65
    Height = 21
    TabOrder = 1
  end
  object EdtPathLog: TEdit
    Left = 107
    Top = 120
    Width = 260
    Height = 21
    TabOrder = 2
  end
  object BbGravar: TButton
    Left = 292
    Top = 154
    Width = 75
    Height = 25
    Caption = '&Gravar'
    TabOrder = 3
    OnClick = BbGravarClick
  end
end
