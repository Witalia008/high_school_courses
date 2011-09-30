unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ExtDlgs, Menus, JPEG, ColorGrd, ClipBrd, ComCtrls,
  Spin, pngimage;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel1: TPanel;
    ColorDialog1: TColorDialog;
    Panel2: TPanel;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    Button6: TButton;
    Edit2: TEdit;
    Button7: TButton;
    Other1: TMenuItem;
    LineType1: TMenuItem;
    Dot1: TMenuItem;
    Solid1: TMenuItem;
    DotDot1: TMenuItem;
    DashDotDot1: TMenuItem;
    Dash1: TMenuItem;
    BrushType1: TMenuItem;
    Solid2: TMenuItem;
    Cross1: TMenuItem;
    Horisontal1: TMenuItem;
    Vertical1: TMenuItem;
    FDiagonal1: TMenuItem;
    BDiagonal1: TMenuItem;
    DiagonalCross1: TMenuItem;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    ColorGrid1: TColorGrid;
    Button13: TButton;
    Button14: TButton;
    SpinEdit1: TSpinEdit;
    Panel3: TPanel;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Image1Paint(Sender: TObject);
    procedure Dot1Click(Sender: TObject);
    procedure Solid1Click(Sender: TObject);
    procedure DotDot1Click(Sender: TObject);
    procedure DashDotDot1Click(Sender: TObject);
    procedure Dash1Click(Sender: TObject);
    procedure Solid2Click(Sender: TObject);
    procedure Cross1Click(Sender: TObject);
    procedure Horisontal1Click(Sender: TObject);
    procedure Vertical1Click(Sender: TObject);
    procedure FDiagonal1Click(Sender: TObject);
    procedure BDiagonal1Click(Sender: TObject);
    procedure DiagonalCross1Click(Sender: TObject);
    procedure DrawBezier(x, y : integer);
    procedure Button10Click(Sender: TObject);
    procedure ColorGrid1Change(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  drawer: string = 'Pensil';
  flag: boolean = false;
  lastx, lasty, lx, ly, num: Integer;
  p : array of TPoint;
  p1 : array of TPoint;
  imJPG: TJPEGImage;

implementation

{$R *.dfm}

procedure TForm1.DrawBezier(x, y : integer);
begin
  SetLength(p, 4);
  p[num].X := x;
  p[num].Y := y;
  Image1.Canvas.PolyBezier(p);
end;

procedure TForm1.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_RETURN)and(ssShift in Shift) then
  begin
    Image1.Canvas.Font.Color := Image1.Canvas.Pen.Color;
    Image1.Canvas.TextOut(lx, ly, Edit2.Text);
    Edit2.Visible := false;
  end;
end;

procedure TForm1.BDiagonal1Click(Sender: TObject);
begin
  Image1.Canvas.Brush.Style := bsBDiagonal;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  Image1.Canvas.Pen.Mode := pmCopy;
  Image1.Canvas.Brush.Color := Panel1.Color;
  Image1.Canvas.Pen.Color := Panel1.Color;
  Image1.Canvas.Rectangle(0, 0, Image1.Width, Image1.Height);
  num := 0;
  SetLength(p, 0);
  SetLength(p1, 0);
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  Image1.Picture.Assign(Clipboard);
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  Clipboard.Assign(Image1.Picture);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  drawer := (Sender as TButton).Caption;
  Button1.Enabled := true;
  Button2.Enabled := true;
  Button3.Enabled := true;
  Button4.Enabled := true;
  Button5.Enabled := true;
  Button6.Enabled := true;
  Button7.Enabled := true;
  Button8.Enabled := true;
  Button9.Enabled := true;
  Button11.Enabled := true;
  Button12.Enabled := true;
  (Sender as TButton).Enabled := false;
  num := 0;
  SetLength(p, 0);
  SetLength(p1, 0);
  Edit2.Visible := false;
end;

procedure TForm1.ColorGrid1Change(Sender: TObject);
begin
  Panel2.Color := ColorGrid1.ForegroundColor;
  Panel1.Color := ColorGrid1.BackgroundColor;
end;

procedure TForm1.Cross1Click(Sender: TObject);
begin
  Image1.Canvas.Brush.Style := bsCross;
end;

procedure TForm1.Dash1Click(Sender: TObject);
begin
  Image1.Canvas.Pen.Style := psDash;
end;

procedure TForm1.DashDotDot1Click(Sender: TObject);
begin
  Image1.Canvas.Pen.Style := psDashDotDot;
end;

procedure TForm1.DiagonalCross1Click(Sender: TObject);
begin
  Image1.Canvas.Brush.Style := bsDiagCross;
end;

procedure TForm1.Dot1Click(Sender: TObject);
begin
  Image1.Canvas.Pen.Style := psDot;
end;

procedure TForm1.DotDot1Click(Sender: TObject);
begin
  Image1.Canvas.Pen.Style := psDashDot;
end;

procedure TForm1.FDiagonal1Click(Sender: TObject);
begin
  Image1.Canvas.Brush.Style := bsFDiagonal;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  imJPG := TJPEGImage.Create;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Image1.Height := ClientHeight - 39;
end;

procedure TForm1.Horisontal1Click(Sender: TObject);
begin
  Image1.Canvas.Brush.Style := bsHorizontal;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imJPG.LoadFromFile(OpenPictureDialog1.FileName);
    Image1.Canvas.Draw(0, 0, imJPG);
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flag := true;
  Image1.Canvas.MoveTo(X, Y);
  if (drawer = 'Pensil')or(drawer = 'Line') then
    Image1.Canvas.LineTo(x + 1, y + 1);
  lastx := X;
  lasty := Y;
  Image1.Canvas.Pen.Width := SpinEdit1.Value;
  if drawer <> 'PolyLine' then
  begin
    lx := X;
    ly := Y;
  end;
  if drawer = 'Picker' then
  begin
    if button = mbLeft then
      Panel2.Color := Image1.Canvas.Pixels[x, y]
    else
      Panel1.Color := Image1.Canvas.Pixels[x, y];
  end;
  if drawer = 'Fill' then
  begin
    if Button = mbRight then
      Image1.Canvas.Brush.Color := Panel1.Color
    else
      Image1.Canvas.Brush.Color := Panel2.Color;
    Image1.Canvas.FloodFill(X, Y, Image1.Canvas.Pixels[X, Y], fsSurface);
  end;
  if drawer = 'Text' then
  begin
    Edit2.Top := Image1.Top + y;
    Edit2.Left := x;
    Edit2.Visible:=true;
  end;
  if drawer = 'PolyLine' then
  begin
    Image1.Canvas.Pen.Mode := pmNotXor;
    if num <> 0 then
      DrawBezier(lx, ly);
    num := (num + 1) mod 4;
    DrawBezier(x, y);
    lx := x; ly := y;
  end;
  if drawer = 'Polygon' then
  begin
    inc(num);
    SetLength(p1, num);
    p1[num - 1].X := x;
    p1[num - 1].Y := y;
    Image1.Canvas.Polygon(p1);
  end;
  if Button = mbRight then
    Image1.Canvas.Pen.Color := Panel1.Color
  else
    Image1.Canvas.Pen.Color := Panel2.Color;
end;

function min (a, b : integer) : integer;
begin
  if a < b then
    result := a
  else
    result := b;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  i, j, k: Integer;
  nX, nY, sub : integer;
begin
  if (flag) then
  begin
    if drawer = 'Eraser' then
    begin
      Image1.Canvas.Pen.Mode := pmCopy;
      Image1.Canvas.Pen.Color := Panel1.Color;
      Image1.Canvas.Brush.Color := Panel1.Color;
      Image1.Canvas.Rectangle(x - SpinEdit1.Value, y - SpinEdit1.Value, x + SpinEdit1.Value, y + SpinEdit1.Value);
    end;
    if drawer = 'PolyLine' then
    begin
      Image1.Canvas.Pen.Mode := pmNotXor;
      DrawBezier(lx, ly);
      DrawBezier(x, y);
      lx := x; ly := y;
    end;
    if drawer = 'Line' then
    begin
      if not CheckBox2.Checked then
      begin
        Image1.Canvas.Pen.Mode := pmNotXor;
        Image1.Canvas.MoveTo(lastx, lasty);
        Image1.Canvas.LineTo(lx, ly);
        lx := X;
        ly := Y;
      end;
      Image1.Canvas.MoveTo(lastx, lasty);
      Image1.Canvas.LineTo(X, Y);
    end;
    if drawer = 'Rectangle' then
    begin
      nX := X; nY := Y;
      sub := min (abs(x - lastx), abs(y - lasty));
      if (ssShift in Shift) and (sub <> 0) then
      begin
        nX := lastx + sub * (abs(x - lastx) div (x - lastx));
        nY := lasty + sub * (abs(y - lasty) div (y - lasty));
      end;
      if not CheckBox2.Checked then
      begin
        Image1.Canvas.Pen.Mode := pmNotXor;
        Image1.Canvas.Brush.Style := bsClear;
        Image1.Canvas.Rectangle(lastx, lasty, lx, ly);
        lx := nX;
        ly := nY;
      end;
      Image1.Canvas.Rectangle(lastx, lasty, nX, nY);
    end;
    if drawer = 'Ellipse' then
    begin
      nX := X; nY := Y;
      sub := min (abs(x - lastx), abs(y - lasty));
      if (ssShift in Shift) and (sub <> 0) then
      begin
        nX := lastx + sub * (abs(x - lastx) div (x - lastx));
        nY := lasty + sub * (abs(y - lasty) div (y - lasty));
      end;
      if not CheckBox2.Checked then
      begin
        Image1.Canvas.Pen.Mode := pmNotXor;
        Image1.Canvas.Brush.Style := bsClear;
        Image1.Canvas.Ellipse(lastx, lasty, lx, ly);
        lx := nX;
        ly := nY;
      end;
      Image1.Canvas.Ellipse(lastx, lasty, nX, nY);
    end;
    if drawer = 'Pensil' then
    begin
      if CheckBox1.Checked then
        Image1.Canvas.Pen.Mode := pmNotXor
      else
        Image1.Canvas.Pen.Mode := pmCopy;
      Image1.Canvas.LineTo(X, Y);
      Image1.Canvas.MoveTo(X, Y);
    end;
    if drawer = 'Roz' then
    begin
      Image1.Canvas.Pen.Mode := pmCopy;
      for k := 1 to SpinEdit1.Value * 10 do
      begin
        i := random(SpinEdit1.Value * 10) + X - SpinEdit1.Value * 5;
        j := random(SpinEdit1.Value * 10) + Y - SpinEdit1.Value * 5;
        if (i > 0) and (j > 0) and (i <= Image1.Width) and
          (j <= Image1.Height) and (trunc (sqrt (sqr(i - x) + sqr(j - y))) <= SpinEdit1.Value * 5) then
          Image1.Canvas.Pixels[i, j] := Image1.Canvas.Pen.Color;
      end;
    end;
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  oldbrush: TBrushStyle;
  nX, nY, sub : integer;
begin
  oldbrush := Image1.Canvas.Brush.Style;
  Image1.Canvas.Brush.Style := bsClear;
  if not CheckBox1.Checked then
  begin
    Image1.Canvas.Pen.Mode := pmCopy;
    nX := X; nY := Y;
    sub := min (abs(x - lastx), abs(y - lasty));
    if (ssShift in Shift) and (sub <> 0) then
    begin
      nX := lastx + sub * (abs(x - lastx) div (x - lastx));
      nY := lasty + sub * (abs(y - lasty) div (y - lasty));
    end;
    if drawer = 'Rectangle' then
      Image1.Canvas.Rectangle(lastx, lasty, nX, nY);
    if drawer = 'Line' then
    begin
      Image1.Canvas.MoveTo(lastx, lasty);
      Image1.Canvas.LineTo(X, Y);
    end;
    if drawer = 'Ellipse' then
      Image1.Canvas.Ellipse(lastx, lasty, nX, nY);
  end;
  flag := false;
  Image1.Canvas.Brush.Style := oldbrush;
end;

procedure TForm1.Image1Paint(Sender: TObject);
begin
  with Image1 do
    begin
    Canvas.Pen.Color := clWhite;
    Canvas.Brush.Color := clWhite;
    Canvas.Rectangle(0, 0, Width, Height);
    end;
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Panel1.Color := ColorDialog1.Color;
end;

procedure TForm1.Panel2Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Panel2.Color := ColorDialog1.Color;
end;

procedure TForm1.Save1Click(Sender: TObject);
var
  i, j: Integer;
begin
  if SavePictureDialog1.Execute then
  begin
    imJPG.Assign(Image1.Picture.Bitmap);
    imJPG.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TForm1.Solid1Click(Sender: TObject);
begin
  Image1.Canvas.Pen.Style := psSolid;
end;

procedure TForm1.Solid2Click(Sender: TObject);
begin
  Image1.Canvas.Brush.Style := bsSolid;
end;

procedure TForm1.Vertical1Click(Sender: TObject);
begin
  Image1.Canvas.Brush.Style := bsVertical;
end;

end.
