object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Calc'
  ClientHeight = 352
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 352
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tempus Sans ITC'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Edit1: TEdit
      Left = 9
      Top = 32
      Width = 480
      Height = 35
      Cursor = crIBeam
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tempus Sans ITC'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object Button1: TButton
      Tag = 1
      Left = 177
      Top = 241
      Width = 50
      Height = 50
      Caption = '1'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Tag = 2
      Left = 233
      Top = 241
      Width = 50
      Height = 50
      Caption = '2'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button3: TButton
      Tag = 3
      Left = 289
      Top = 241
      Width = 50
      Height = 50
      Caption = '3'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button4: TButton
      Tag = 4
      Left = 177
      Top = 185
      Width = 50
      Height = 50
      Caption = '4'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button5: TButton
      Tag = 5
      Left = 233
      Top = 185
      Width = 50
      Height = 50
      Caption = '5'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button6: TButton
      Tag = 6
      Left = 289
      Top = 185
      Width = 50
      Height = 50
      Caption = '6'
      TabOrder = 6
      OnClick = Button1Click
    end
    object Button7: TButton
      Tag = 7
      Left = 177
      Top = 129
      Width = 50
      Height = 50
      Caption = '7'
      TabOrder = 7
      OnClick = Button1Click
    end
    object Button8: TButton
      Tag = 8
      Left = 233
      Top = 129
      Width = 50
      Height = 50
      Caption = '8'
      TabOrder = 8
      OnClick = Button1Click
    end
    object Button9: TButton
      Tag = 9
      Left = 289
      Top = 129
      Width = 50
      Height = 50
      Caption = '9'
      TabOrder = 9
      OnClick = Button1Click
    end
    object Button10: TButton
      Left = 177
      Top = 297
      Width = 106
      Height = 50
      Caption = '0'
      TabOrder = 10
      OnClick = Button1Click
    end
    object Button11: TButton
      Left = 289
      Top = 297
      Width = 50
      Height = 50
      Caption = '.'
      TabOrder = 11
      OnClick = Button1Click
    end
    object Button12: TButton
      Left = 345
      Top = 185
      Width = 50
      Height = 50
      Caption = '*'
      TabOrder = 12
      OnClick = Button1Click
    end
    object Button13: TButton
      Left = 345
      Top = 241
      Width = 50
      Height = 50
      Caption = '-'
      TabOrder = 13
      OnClick = Button1Click
    end
    object Button14: TButton
      Left = 345
      Top = 297
      Width = 50
      Height = 50
      Caption = '+'
      TabOrder = 14
      OnClick = Button1Click
    end
    object Button15: TButton
      Left = 345
      Top = 129
      Width = 50
      Height = 50
      Caption = '/'
      TabOrder = 15
      OnClick = Button1Click
    end
    object Button16: TButton
      Left = 457
      Top = 241
      Width = 50
      Height = 106
      Caption = '='
      TabOrder = 16
      OnClick = Button16Click
    end
    object Button17: TButton
      Left = 457
      Top = 185
      Width = 50
      Height = 50
      Caption = '%'
      TabOrder = 17
      OnClick = Button1Click
    end
    object Button18: TButton
      Left = 457
      Top = 129
      Width = 50
      Height = 50
      Caption = 'root'
      TabOrder = 18
      OnClick = Button1Click
    end
    object Button19: TButton
      Left = 177
      Top = 73
      Width = 50
      Height = 50
      Caption = #8592
      TabOrder = 19
      OnClick = Button19Click
    end
    object Button20: TButton
      Left = 233
      Top = 73
      Width = 50
      Height = 50
      Caption = 'CE'
      TabOrder = 20
      OnClick = Button20Click
    end
    object Button21: TButton
      Left = 289
      Top = 73
      Width = 50
      Height = 50
      Caption = 'C'
      TabOrder = 21
      OnClick = Button21Click
    end
    object Button22: TButton
      Left = 401
      Top = 73
      Width = 50
      Height = 50
      Caption = 'MS'
      TabOrder = 22
      OnClick = Button22Click
    end
    object Button23: TButton
      Left = 401
      Top = 129
      Width = 50
      Height = 50
      Caption = 'MR'
      TabOrder = 23
      OnClick = Button23Click
    end
    object Button24: TButton
      Left = 121
      Top = 73
      Width = 50
      Height = 50
      Caption = ')'
      TabOrder = 24
      OnClick = Button1Click
    end
    object Button25: TButton
      Left = 121
      Top = 129
      Width = 50
      Height = 50
      Caption = '!'
      TabOrder = 25
      OnClick = Button1Click
    end
    object Button26: TButton
      Left = 121
      Top = 185
      Width = 50
      Height = 50
      Caption = 'ln'
      TabOrder = 26
      OnClick = Button1Click
    end
    object Button27: TButton
      Left = 121
      Top = 241
      Width = 50
      Height = 50
      Caption = 'exp'
      TabOrder = 27
      OnClick = Button1Click
    end
    object Button28: TButton
      Left = 121
      Top = 297
      Width = 50
      Height = 50
      Caption = 'lg'
      TabOrder = 28
      OnClick = Button1Click
    end
    object Button29: TButton
      Left = 65
      Top = 73
      Width = 50
      Height = 50
      Caption = '('
      TabOrder = 29
      OnClick = Button1Click
    end
    object Button30: TButton
      Left = 9
      Top = 73
      Width = 50
      Height = 50
      Enabled = False
      TabOrder = 30
    end
    object Button31: TButton
      Left = 65
      Top = 129
      Width = 50
      Height = 50
      Caption = 'sin'
      TabOrder = 31
      OnClick = Button1Click
    end
    object Button32: TButton
      Left = 65
      Top = 185
      Width = 50
      Height = 50
      Caption = 'cos'
      TabOrder = 32
      OnClick = Button1Click
    end
    object Button33: TButton
      Left = 65
      Top = 241
      Width = 50
      Height = 50
      Caption = 'tg'
      TabOrder = 33
      OnClick = Button1Click
    end
    object Button34: TButton
      Left = 65
      Top = 297
      Width = 50
      Height = 50
      Caption = 'ctg'
      TabOrder = 34
      OnClick = Button1Click
    end
    object Button35: TButton
      Left = 9
      Top = 129
      Width = 50
      Height = 50
      Caption = 'asin'
      TabOrder = 35
      OnClick = Button1Click
    end
    object Button36: TButton
      Left = 9
      Top = 185
      Width = 50
      Height = 50
      Caption = 'acos'
      TabOrder = 36
      OnClick = Button1Click
    end
    object Button37: TButton
      Left = 8
      Top = 241
      Width = 51
      Height = 50
      Caption = 'atg'
      TabOrder = 37
      OnClick = Button1Click
    end
    object Button38: TButton
      Left = 9
      Top = 297
      Width = 50
      Height = 50
      Caption = 'actg'
      TabOrder = 38
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 483
      Top = 32
      Width = 24
      Height = 35
      Enabled = False
      ReadOnly = True
      TabOrder = 39
    end
    object Edit6: TEdit
      Left = 9
      Top = 0
      Width = 480
      Height = 30
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tempus Sans ITC'
      Font.Style = []
      ParentFont = False
      TabOrder = 40
      Text = 'Result will appear here!'
    end
    object Edit8: TEdit
      Left = 483
      Top = 0
      Width = 24
      Height = 30
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tempus Sans ITC'
      Font.Style = []
      ParentFont = False
      TabOrder = 41
    end
    object Button61: TButton
      Left = 457
      Top = 73
      Width = 50
      Height = 50
      Caption = '^'
      TabOrder = 42
      OnClick = Button1Click
    end
    object Button62: TButton
      Left = 401
      Top = 185
      Width = 50
      Height = 50
      Caption = 'M-'
      TabOrder = 43
      OnClick = Button62Click
    end
    object Button63: TButton
      Left = 401
      Top = 241
      Width = 50
      Height = 50
      Caption = 'M+'
      TabOrder = 44
      OnClick = Button63Click
    end
    object Button64: TButton
      Left = 401
      Top = 297
      Width = 50
      Height = 50
      Caption = 'MC'
      TabOrder = 45
      OnClick = Button64Click
    end
    object Button65: TButton
      Left = 345
      Top = 73
      Width = 50
      Height = 50
      Caption = 'abs'
      TabOrder = 46
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 352
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tempus Sans ITC'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    ExplicitTop = 328
    object Edit3: TEdit
      Left = 8
      Top = 32
      Width = 305
      Height = 35
      TabOrder = 0
      Text = '0'
    end
    object Edit4: TEdit
      Left = 314
      Top = 32
      Width = 25
      Height = 35
      Enabled = False
      TabOrder = 1
    end
    object Button39: TButton
      Left = 9
      Top = 129
      Width = 50
      Height = 50
      Caption = '7'
      TabOrder = 2
      OnClick = Button40Click
    end
    object Button40: TButton
      Left = 65
      Top = 129
      Width = 50
      Height = 50
      Caption = '8'
      TabOrder = 3
      OnClick = Button40Click
    end
    object Button41: TButton
      Left = 121
      Top = 129
      Width = 50
      Height = 50
      Caption = '9'
      TabOrder = 4
      OnClick = Button40Click
    end
    object Button42: TButton
      Left = 9
      Top = 185
      Width = 50
      Height = 50
      Caption = '4'
      TabOrder = 5
      OnClick = Button40Click
    end
    object Button43: TButton
      Left = 65
      Top = 185
      Width = 50
      Height = 50
      Caption = '5'
      TabOrder = 6
      OnClick = Button40Click
    end
    object Button44: TButton
      Left = 121
      Top = 185
      Width = 50
      Height = 50
      Caption = '6'
      TabOrder = 7
      OnClick = Button40Click
    end
    object Button45: TButton
      Left = 9
      Top = 241
      Width = 50
      Height = 50
      Caption = '1'
      TabOrder = 8
      OnClick = Button40Click
    end
    object Button46: TButton
      Left = 65
      Top = 241
      Width = 50
      Height = 50
      Caption = '2'
      TabOrder = 9
      OnClick = Button40Click
    end
    object Button47: TButton
      Left = 121
      Top = 241
      Width = 50
      Height = 50
      Caption = '3'
      TabOrder = 10
      OnClick = Button40Click
    end
    object Button48: TButton
      Left = 9
      Top = 297
      Width = 106
      Height = 50
      Caption = '0'
      TabOrder = 11
      OnClick = Button40Click
    end
    object Button49: TButton
      Left = 121
      Top = 297
      Width = 50
      Height = 50
      Caption = '.'
      TabOrder = 12
      OnClick = Button40Click
    end
    object Button50: TButton
      Left = 177
      Top = 129
      Width = 50
      Height = 50
      Caption = '+'
      TabOrder = 13
      OnClick = Button50Click
    end
    object Button51: TButton
      Left = 177
      Top = 185
      Width = 50
      Height = 50
      Caption = '-'
      TabOrder = 14
      OnClick = Button50Click
    end
    object Button52: TButton
      Left = 177
      Top = 241
      Width = 50
      Height = 50
      Caption = '/'
      TabOrder = 15
      OnClick = Button50Click
    end
    object Button53: TButton
      Left = 177
      Top = 297
      Width = 50
      Height = 50
      Caption = '*'
      TabOrder = 16
      OnClick = Button50Click
    end
    object Button54: TButton
      Left = 233
      Top = 241
      Width = 50
      Height = 50
      Caption = 'sqrt'
      TabOrder = 17
      OnClick = Button54Click
    end
    object Button55: TButton
      Left = 233
      Top = 297
      Width = 50
      Height = 50
      Caption = '^'
      TabOrder = 18
      OnClick = Button50Click
    end
    object Button56: TButton
      Left = 65
      Top = 73
      Width = 50
      Height = 50
      Caption = 'MS'
      TabOrder = 19
      OnClick = Button56Click
    end
    object Button57: TButton
      Left = 121
      Top = 73
      Width = 50
      Height = 50
      Caption = 'MR'
      TabOrder = 20
      OnClick = Button57Click
    end
    object Button58: TButton
      Left = 289
      Top = 129
      Width = 50
      Height = 50
      Caption = 'CE'
      TabOrder = 21
      OnClick = Button58Click
    end
    object Button59: TButton
      Left = 233
      Top = 129
      Width = 50
      Height = 50
      Caption = 'C'
      TabOrder = 22
      OnClick = Button59Click
    end
    object Button60: TButton
      Left = 289
      Top = 241
      Width = 50
      Height = 106
      Caption = '='
      TabOrder = 23
      OnClick = Button60Click
    end
    object Edit5: TEdit
      Left = 8
      Top = 0
      Width = 305
      Height = 30
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tempus Sans ITC'
      Font.Style = []
      ParentFont = False
      TabOrder = 24
      Text = 'Result will appear here!'
    end
    object Edit7: TEdit
      Left = 314
      Top = 0
      Width = 25
      Height = 30
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tempus Sans ITC'
      Font.Style = []
      ParentFont = False
      TabOrder = 25
    end
    object Button66: TButton
      Left = 177
      Top = 73
      Width = 50
      Height = 50
      Caption = 'M+'
      TabOrder = 26
      OnClick = Button66Click
    end
    object Button67: TButton
      Left = 233
      Top = 73
      Width = 50
      Height = 50
      Caption = 'M-'
      TabOrder = 27
      OnClick = Button67Click
    end
    object Button68: TButton
      Left = 289
      Top = 73
      Width = 50
      Height = 50
      Caption = 'MC'
      TabOrder = 28
      OnClick = Button68Click
    end
    object Button69: TButton
      Left = 9
      Top = 73
      Width = 50
      Height = 50
      Caption = '!'
      TabOrder = 29
      OnClick = Button69Click
    end
    object Button70: TButton
      Left = 233
      Top = 185
      Width = 106
      Height = 50
      Caption = 'Backspace'
      TabOrder = 30
      OnClick = Button70Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 464
    Top = 336
    object N1: TMenuItem
      Caption = 'Menu'
      object N3: TMenuItem
        Caption = 'Usual'
        Checked = True
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = 'Long Numbers'
        OnClick = N4Click
      end
    end
    object Additional1: TMenuItem
      Caption = 'Additional'
      object NumberPI1: TMenuItem
        Caption = 'Number PI'
        OnClick = NumberPI1Click
      end
      object Numbere1: TMenuItem
        Caption = 'Number e'
        OnClick = Numbere1Click
      end
    end
    object N2: TMenuItem
      Caption = 'Help'
      object N5: TMenuItem
        Caption = 'Call Help'
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = 'About'
        OnClick = N6Click
      end
    end
  end
end
