object Form1: TForm1
  Left = 182
  Top = 27
  Width = 258
  Height = 290
  Caption = #1055#39#1103#1090#1085#1072#1096#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object XPManifest1: TXPManifest
    Left = 256
    Top = 184
  end
  object MainMenu1: TMainMenu
    Left = 96
    Top = 112
    object NewGame1: TMenuItem
      Caption = 'New Game'
      OnClick = NewGame1Click
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 168
    Top = 168
  end
end
