object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Form1'
  ClientHeight = 650
  ClientWidth = 1200
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 39
    Width = 1200
    Height = 611
    Align = alBottom
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 1200
    Height = 41
    Align = alTop
    Color = clSilver
    ParentBackground = False
    TabOrder = 19
    object CheckBox2: TCheckBox
      Left = 704
      Top = 16
      Width = 105
      Height = 17
      Caption = 'Additional Mode 2'
      TabOrder = 0
    end
    object CheckBox1: TCheckBox
      Left = 576
      Top = 16
      Width = 105
      Height = 17
      Caption = 'Additional Mode 1'
      TabOrder = 1
    end
  end
  object ColorGrid1: TColorGrid
    Left = 903
    Top = 3
    Width = 184
    Height = 30
    GridOrdering = go8x2
    TabOrder = 15
    OnChange = ColorGrid1Change
  end
  object Button1: TButton
    Left = 0
    Top = 8
    Width = 41
    Height = 25
    Caption = 'Pensil'
    Enabled = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 39
    Top = 8
    Width = 58
    Height = 25
    Caption = 'Rectangle'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 95
    Top = 8
    Width = 34
    Height = 25
    Caption = 'Line'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button4: TButton
    Left = 128
    Top = 8
    Width = 41
    Height = 25
    Caption = 'Ellipse'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button5: TButton
    Left = 169
    Top = 8
    Width = 24
    Height = 25
    Caption = 'Fill'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button6: TButton
    Left = 194
    Top = 8
    Width = 31
    Height = 25
    Caption = 'Text'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button7: TButton
    Left = 227
    Top = 8
    Width = 30
    Height = 25
    Caption = 'Roz'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button8: TButton
    Left = 255
    Top = 8
    Width = 50
    Height = 25
    Caption = 'PolyLine'
    TabOrder = 10
    OnClick = Button1Click
  end
  object Button9: TButton
    Left = 304
    Top = 8
    Width = 49
    Height = 25
    Caption = 'Polygon'
    TabOrder = 11
    OnClick = Button1Click
  end
  object Button10: TButton
    Left = 352
    Top = 8
    Width = 33
    Height = 25
    Caption = 'Clear'
    TabOrder = 12
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 384
    Top = 8
    Width = 41
    Height = 25
    Caption = 'Eraser'
    TabOrder = 13
    OnClick = Button1Click
  end
  object Button12: TButton
    Left = 424
    Top = 8
    Width = 41
    Height = 25
    Caption = 'Picker'
    TabOrder = 14
    OnClick = Button1Click
  end
  object Button13: TButton
    Left = 464
    Top = 8
    Width = 49
    Height = 25
    Caption = 'FromBuf'
    TabOrder = 16
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 512
    Top = 8
    Width = 41
    Height = 25
    Caption = 'ToBuf'
    TabOrder = 17
    OnClick = Button14Click
  end
  object SpinEdit1: TSpinEdit
    Left = 855
    Top = 8
    Width = 42
    Height = 22
    MaxValue = 100
    MinValue = 1
    TabOrder = 18
    Value = 1
  end
  object Panel2: TPanel
    Left = 1093
    Top = 1
    Width = 48
    Height = 32
    Color = clBlack
    ParentBackground = False
    TabOrder = 6
    OnClick = Panel2Click
  end
  object Panel1: TPanel
    Left = 1147
    Top = 1
    Width = 45
    Height = 32
    Color = clBlack
    ParentBackground = False
    TabOrder = 5
    OnClick = Panel1Click
  end
  object Edit2: TEdit
    Left = 903
    Top = 20
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'Text'
    Visible = False
    OnKeyDown = Edit2KeyDown
  end
  object ColorDialog1: TColorDialog
    Left = 1040
    Top = 64
  end
  object MainMenu1: TMainMenu
    Left = 1024
    Top = 240
    object Menu1: TMenuItem
      Caption = 'Menu'
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
    end
    object Other1: TMenuItem
      Caption = 'Other'
      object LineType1: TMenuItem
        Caption = 'Line Type'
        object Dot1: TMenuItem
          Caption = 'Dot'
          OnClick = Dot1Click
        end
        object Solid1: TMenuItem
          Caption = 'Solid'
          OnClick = Solid1Click
        end
        object DotDot1: TMenuItem
          Caption = 'DashDot'
          OnClick = DotDot1Click
        end
        object DashDotDot1: TMenuItem
          Caption = 'DashDotDot'
          OnClick = DashDotDot1Click
        end
        object Dash1: TMenuItem
          Caption = 'Dash'
          OnClick = Dash1Click
        end
      end
      object BrushType1: TMenuItem
        Caption = 'Brush Type'
        object Solid2: TMenuItem
          Caption = 'Solid'
          OnClick = Solid2Click
        end
        object Cross1: TMenuItem
          Caption = 'Cross'
          OnClick = Cross1Click
        end
        object Horisontal1: TMenuItem
          Caption = 'Horisontal'
          OnClick = Horisontal1Click
        end
        object Vertical1: TMenuItem
          Caption = 'Vertical'
          OnClick = Vertical1Click
        end
        object FDiagonal1: TMenuItem
          Caption = 'FDiagonal'
          OnClick = FDiagonal1Click
        end
        object BDiagonal1: TMenuItem
          Caption = 'BDiagonal'
          OnClick = BDiagonal1Click
        end
        object DiagonalCross1: TMenuItem
          Caption = 'DiagonalCross'
          OnClick = DiagonalCross1Click
        end
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 1032
    Top = 184
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 1056
    Top = 128
  end
end
