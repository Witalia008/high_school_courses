object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Graph builder'
  ClientHeight = 712
  ClientWidth = 1034
  Color = clSkyBlue
  Font.Charset = ANSI_CHARSET
  Font.Color = clMenuHighlight
  Font.Height = -16
  Font.Name = 'Monotype Corsiva'
  Font.Style = [fsItalic]
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 18
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 851
    Height = 712
    Align = alLeft
    OnMouseDown = FormMouseDown
    OnMouseMove = FormMouseMove
    OnMouseUp = FormMouseUp
    ExplicitHeight = 547
  end
  object Panel1: TPanel
    Left = 849
    Top = 0
    Width = 185
    Height = 712
    Align = alRight
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 96
      Width = 169
      Height = 33
      Caption = 'Oriented'
      Transparent = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 8
      Top = 135
      Width = 169
      Height = 34
      Caption = 'Weighted'
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 8
      Top = 215
      Width = 169
      Height = 34
      Caption = 'Delete a vertex'
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 8
      Top = 255
      Width = 169
      Height = 34
      Caption = 'Delete an edge'
      OnClick = SpeedButton4Click
    end
    object SpeedButton5: TSpeedButton
      Left = 8
      Top = 295
      Width = 169
      Height = 34
      Caption = 'Replace an edge'
      OnClick = SpeedButton5Click
    end
    object SpeedButton6: TSpeedButton
      Left = 8
      Top = 335
      Width = 169
      Height = 34
      Caption = 'Clear results'
      OnClick = SpeedButton6Click
    end
    object SpeedButton7: TSpeedButton
      Left = 8
      Top = 175
      Width = 169
      Height = 34
      Caption = 'Add an edge'
      OnClick = SpeedButton7Click
    end
    object SpeedButton8: TSpeedButton
      Left = 8
      Top = 56
      Width = 105
      Height = 34
      Caption = 'Step by step'
      OnClick = SpeedButton8Click
    end
    object SpeedButton9: TSpeedButton
      Left = 119
      Top = 56
      Width = 58
      Height = 34
      Caption = 'Next'
      OnClick = SpeedButton9Click
    end
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 169
      Height = 42
      Caption = 'Run algorithm'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 144
      Top = 393
      Width = 33
      Height = 25
      Caption = #1054#1050
      TabOrder = 1
      OnClick = Button3Click
    end
    object LabeledEdit2: TLabeledEdit
      Left = 8
      Top = 392
      Width = 130
      Height = 26
      EditLabel.Width = 74
      EditLabel.Height = 18
      EditLabel.Caption = 'Edge weight'
      NumbersOnly = True
      TabOrder = 2
      Text = '1'
    end
    object Button4: TButton
      Left = 8
      Top = 674
      Width = 169
      Height = 33
      Caption = 'Clear'
      TabOrder = 3
      OnClick = Button4Click
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 424
      Width = 169
      Height = 72
      Caption = 'Mouse position'
      TabOrder = 4
      object Label1: TLabel
        Left = 3
        Top = 24
        Width = 28
        Height = 18
        Caption = 'X : 0'
      end
      object Label2: TLabel
        Left = 3
        Top = 48
        Width = 28
        Height = 18
        Caption = 'Y : 0'
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 502
      Width = 169
      Height = 57
      Caption = 'Save as...'
      TabOrder = 5
      object Button5: TButton
        Left = 3
        Top = 29
        Width = 75
        Height = 25
        Caption = 'Picture'
        TabOrder = 0
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 84
        Top = 29
        Width = 75
        Height = 25
        Caption = 'Describing'
        TabOrder = 1
        OnClick = Button6Click
      end
    end
    object Button7: TButton
      Left = 8
      Top = 632
      Width = 169
      Height = 25
      Caption = 'Upload from file'
      TabOrder = 6
      OnClick = Button7Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 565
      Width = 169
      Height = 61
      Caption = 'Click on this coordinates'
      TabOrder = 7
      object Edit1: TEdit
        Left = 3
        Top = 24
        Width = 47
        Height = 26
        NumbersOnly = True
        TabOrder = 0
        Text = 'X'
        OnKeyDown = Edit1KeyDown
      end
      object Edit2: TEdit
        Left = 56
        Top = 24
        Width = 49
        Height = 26
        NumbersOnly = True
        TabOrder = 1
        Text = 'Y'
        OnKeyDown = Edit1KeyDown
      end
      object Button2: TButton
        Left = 124
        Top = 25
        Width = 42
        Height = 33
        Caption = 'OK'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 792
    Top = 480
  end
  object SaveDialog1: TSaveDialog
    Left = 816
    Top = 520
  end
  object OpenDialog1: TOpenDialog
    Left = 744
    Top = 536
  end
  object PopupMenu1: TPopupMenu
    Left = 680
    Top = 468
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 512
    Top = 296
  end
  object MainMenu1: TMainMenu
    Left = 552
    Top = 400
    object Menu1: TMenuItem
      Caption = 'Menu'
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Button7Click
      end
      object Saveas1: TMenuItem
        Caption = 'Save as...'
        object Picture1: TMenuItem
          Caption = 'Picture'
          OnClick = Button5Click
        end
        object Describng1: TMenuItem
          Caption = 'Describng'
          OnClick = Button6Click
        end
      end
      object New1: TMenuItem
        Caption = 'New'
        OnClick = Button4Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object About1: TMenuItem
      Caption = 'About'
      OnClick = About1Click
    end
  end
end
