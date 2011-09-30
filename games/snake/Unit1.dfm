object Form1: TForm1
  Left = 307
  Top = 34
  BorderStyle = bsSingle
  Caption = #1047#1084#1110#1081#1082#1072
  ClientHeight = 611
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 448
    Top = 224
    object N1: TMenuItem
      Caption = #1043#1088#1072
      object N4: TMenuItem
        Caption = #1053#1086#1074#1072
        OnClick = N4Click
      end
      object N14: TMenuItem
        Caption = #1056#1110#1074#1077#1085#1100
        object N15: TMenuItem
          Caption = #1055#1077#1088#1096#1080#1081
          Checked = True
          OnClick = N15Click
        end
        object N16: TMenuItem
          Caption = #1044#1088#1091#1075#1080#1081
          OnClick = N16Click
        end
        object N17: TMenuItem
          Caption = #1058#1088#1077#1090#1110#1081
          OnClick = N17Click
        end
        object N18: TMenuItem
          Caption = #1063#1077#1090#1074#1077#1088#1090#1080#1081
          OnClick = N18Click
        end
        object N19: TMenuItem
          Caption = #1055#39#1103#1090#1080#1081
          OnClick = N19Click
        end
      end
      object N10: TMenuItem
        Caption = #1055#1072#1091#1079#1072'/'#1055#1088#1086#1076#1086#1074#1078#1080#1090#1080
        OnClick = N10Click
      end
      object N5: TMenuItem
        Caption = #1042#1080#1081#1090#1080
        OnClick = N5Click
      end
    end
    object N2: TMenuItem
      Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
      object N6: TMenuItem
        Caption = #1064#1074#1080#1076#1082#1110#1089#1090#1100
        object N11: TMenuItem
          Caption = #1055#1086#1074#1110#1083#1100#1085#1086
          Checked = True
          OnClick = N11Click
        end
        object N12: TMenuItem
          Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1086
          OnClick = N12Click
        end
        object N13: TMenuItem
          Caption = #1064#1074#1080#1076#1082#1086
          OnClick = N13Click
        end
      end
      object N7: TMenuItem
        Caption = #1053#1072#1103#1074#1085#1110#1089#1090#1100' '#1089#1090#1110#1085
        OnClick = N7Click
      end
    end
    object N3: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N8: TMenuItem
        Caption = #1055#1088#1086' '#1087#1088#1086#1075#1088#1072#1084#1091
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = #1044#1086#1074#1110#1076#1082#1072
        OnClick = N9Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 528
    Top = 224
  end
end
