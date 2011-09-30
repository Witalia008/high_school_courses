unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, unit2;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Timer1: TTimer;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure DrawPole;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N5Click(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N3Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SetSize;
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pole, tags: array [1 .. 100, 1 .. 100] of shortint;
  opened: array [1 .. 100, 1 .. 100] of boolean;
  images: array [0 .. 15] of TBitMap;
  width1, height1, minecou: shortint;
  isGame: boolean;

implementation

{$R *.dfm}

procedure TForm1.DrawPole;
var
  i: Integer;
  j: Integer;
begin
  for i := 1 to height1 do
    for j := 1 to width1 do
    begin
      if not isGame then
        Form1.Canvas.Draw((i - 1) * 16, (j - 1) * 16, images[10])
      else
      begin
        if opened[i, j] then
          Form1.Canvas.Draw((i - 1) * 16, (j - 1) * 16, images[pole[i, j]])
        else
          Form1.Canvas.Draw((i - 1) * 16, (j - 1) * 16, images[tags[i, j]]);
      end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to 20 do
    images[i] := TBitMap.Create;
  for i := 0 to 8 do
    images[i].LoadFromFile('icons/sq' + inttostr(i) + '.bmp');
  images[9].LoadFromFile('icons/sq0.bmp');
  for i := 1 to 3 do
    images[i + 9].LoadFromFile('icons/sqt' + inttostr(i - 1) + '.bmp');
  images[13].LoadFromFile('icons/nomine.bmp');
  images[14].LoadFromFile('icons/minered.bmp');
  images[15].LoadFromFile('icons/mine.bmp');
  width1 := 10;
  height1 := 10;
  isGame := false;
  minecou := 10;
end;

procedure openpole(i, j: shortint);
begin
  opened[i, j] := true;
  tags[i, j] := 10;
  if (pole[i, j] <> 0) then
    exit;
  if (i > 1) then
    if (not opened[i - 1, j]) then
      openpole(i - 1, j);
  if (j > 1) then
    if (not opened[i, j - 1]) then
      openpole(i, j - 1);
  if (i < height1) then
    if (not opened[i + 1, j]) then
      openpole(i + 1, j);
  if (j < width1) then
    if (not opened[i, j + 1]) then
      openpole(i, j + 1);
  if (i > 1) and (j > 1) then
    if (not opened[i - 1, j - 1]) then
      openpole(i - 1, j - 1);
  if (i < height1) and (j > 1) then
    if (not opened[i + 1, j - 1]) then
      openpole(i + 1, j - 1);
  if (i > 1) and (j < width1) then
    if (not opened[i - 1, j + 1]) then
      openpole(i - 1, j + 1);
  if (i < height1) and (j < width1) then
    if (not opened[i + 1, j + 1]) then
      openpole(i + 1, j + 1);
end;

procedure countMines;
var
  xx, yy, i: shortint;
begin
  for xx := 1 to height1 do
    for yy := 1 to width1 do
      if pole[xx, yy] <> 15 then
      begin
        i := 0;
        if xx > 1 then
          if pole[xx - 1, yy] = 15 then
            inc(i);
        if xx < height1 then
          if pole[xx + 1, yy] = 15 then
            inc(i);
        if yy > 1 then
          if pole[xx, yy - 1] = 15 then
            inc(i);
        if yy < width1 then
          if pole[xx, yy + 1] = 15 then
            inc(i);
        if (xx > 1) and (yy < width1) then
          if pole[xx - 1, yy + 1] = 15 then
            inc(i);
        if (xx > 1) and (yy > 1) then
          if pole[xx - 1, yy - 1] = 15 then
            inc(i);
        if (xx < height1) and (yy > 1) then
          if pole[xx + 1, yy - 1] = 15 then
            inc(i);
        if (xx < height1) and (yy < width1) then
          if pole[xx + 1, yy + 1] = 15 then
            inc(i);
        pole[xx, yy] := i;
      end;
end;

procedure setmines(xpos, ypos: shortint);
var
  xx, yy, i: shortint;
begin
  randomize;
  for i := 1 to minecou do
  begin
    xx := random(height1);
    yy := random(width1);
    while (pole[xx, yy] <> 0) or ((xx = xpos) and (yy = ypos)) do
    begin
      xx := random(height1);
      yy := random(width1);
    end;
    pole[xx, yy] := 15;
  end;
end;

function countflags: shortint;
var
  cou, i, j: shortint;
begin
  cou := 0;
  for i := 1 to height1 do
    for j := 1 to width1 do
      if tags[i, j] = 11 then
        inc(cou);
  result := cou;
end;

procedure fault;
var
  xx, yy: shortint;
begin
  for xx := 1 to height1 do
    for yy := 1 to width1 do
    begin
      if (not(pole[xx, yy] in [14, 15])) and (tags[xx, yy] = 11) then
        pole[xx, yy] := 13;
      if (pole[xx, yy] = 15) and (tags[xx, yy] = 11) then
        pole[xx, yy] := 11;
      opened[xx, yy] := true;
    end;
end;

procedure win;
var
  i, j: shortint;
begin
  for i := 1 to height1 do
    for j := 1 to width1 do
    begin
      if pole[i, j] = 15 then
        pole[i, j] := 11;
      opened[i, j] := true;
    end;
end;

function checkwin: boolean;
var
  i, j: shortint;
begin
  result := true;
  for i := 1 to height1 do
    for j := 1 to width1 do
      if (pole[i, j] = 15) and (tags[i, j] <> 11) then
        result := false;
  if not result then
  begin
    result := true;
    for i := 1 to height1 do
      for j := 1 to width1 do
        if (pole[i, j] <> 15) and (not opened[i, j]) then
          result := false;
  end;
  if result then
    win;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  xpos, ypos, i, xx, yy: shortint;
begin
  if not isGame then
    exit;
  if (X > 16 * height1) or (Y > 16 * width1) then
    exit;
  xpos := X div 16;
  if (X mod 16 <> 0) then
    inc(xpos);
  ypos := Y div 16;
  if (Y mod 16 <> 0) then
    inc(ypos);
  if Button = mbLeft then
  begin
    if Timer1.Enabled then
    begin
      if pole[xpos, ypos] = 15 then
      begin
        Image1.Picture.LoadFromFile('icons/btndead.bmp');
        Timer1.Enabled := false;
        fault;
        pole[xpos, ypos] := 14;
        DrawPole;
        ShowMessage('!');
        isGame := false;
        Image1Click(Sender);
        exit;
      end
      else
        openpole(xpos, ypos);
    end
    else
    begin
      setmines(xpos, ypos);
      countMines;
      openpole(xpos, ypos);
      Timer1.Enabled := true;
    end;
  end
  else
  begin
    if (not opened[xpos, ypos]) then
      if Label2.Caption <> '000' then
        tags[xpos, ypos] := ((tags[xpos, ypos] - 10) + 1) mod 3 + 10;
  end;
  Label2.Caption := inttostr(minecou - countflags);
  while length(Label2.Caption) <> 3 do
    Label2.Caption := '0' + Label2.Caption;
  if (checkwin) and (Timer1.Enabled) then
  begin
    Image1.Picture.LoadFromFile('icons/btncool.bmp');
    DrawPole;
    Timer1.Enabled := false;
    Label2.Caption := '000';
    ShowMessage('!');
    isGame := false;
    Image1Click(Sender);
  end;
  DrawPole;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  DrawPole;
end;

procedure TForm1.SetSize;
begin
  Form1.ClientHeight := width1 * 16 + 40;
  Form1.ClientWidth := height1 * 16;
  Image1.Top := Form1.ClientHeight - 35;
  Label1.Top := Form1.ClientHeight - 35;
  Label2.Top := Form1.ClientHeight - 35;
  Image1.Left := Form1.ClientWidth div 2 - Image1.Width div 2;
  Label2.Left := Form1.ClientWidth - Label2.Width;
end;

procedure TForm1.Image1Click(Sender: TObject);
var
  i, j: shortint;
begin
  SetSize;
  FillChar(opened, sizeof(opened), 0);
  Image1.Picture.LoadFromFile('icons/btnsmile.bmp');
  for i := 1 to height1 do
    for j := 1 to width1 do
    begin
      tags[i, j] := 10;
      pole[i, j] := 0;
    end;
  isGame := true;
  DrawPole;
  Label1.Caption := '000';
  Timer1.Enabled := false;
  if (N11.Checked) and (form2.Visible = false) then
  begin
    minecou := form2.minecou;
    width1 := form2.width1;
    height1 := form2.height1;
  end;
  Label2.Caption := inttostr(minecou);
  while length(Label2.Caption) <> 3 do
    Label2.Caption := '0' + Label2.Caption;

end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Picture.LoadFromFile('icons/btnsmile2.bmp');
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Picture.LoadFromFile('icons/btnsmile.bmp');
end;

procedure TForm1.N10Click(Sender: TObject);
begin
  ShowMessage('25.07.2011.');
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  N7.Checked := false;
  N6.Checked := false;
  N8.Checked := false;
  N11.Checked := true;
  form2.Visible := true;
  Image1Click(Sender);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Image1Click(Sender);
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  N7.Checked := false;
  N6.Checked := true;
  N8.Checked := false;
  N11.Checked := false;
  minecou := 10;
  width1 := 10;
  height1 := 10;
  Image1Click(Sender);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  N6.Checked := false;
  N7.Checked := true;
  N8.Checked := false;
  N11.Checked := false;
  minecou := 40;
  width1 := 16;
  height1 := 16;
  Image1Click(Sender);
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  N6.Checked := false;
  N8.Checked := true;
  N7.Checked := false;
  N11.Checked := false;
  width1 := 16;
  height1 := 30;
  minecou := 99;
  Image1Click(Sender);
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  ShowMessage('.');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Label1.Caption := inttostr(strtoint(Label1.Caption) + 1);
  while length(Label1.Caption) <> 3 do
    Label1.Caption := '0' + Label1.Caption;
  Form1.ClientHeight := width1 * 16 + 40;
  Form1.ClientWidth := height1 * 16;
  Image1.Top := Form1.ClientHeight - 35;
  Label1.Top := Form1.ClientHeight - 35;
  Label2.Top := Form1.ClientHeight - 35;
  Image1.Left := Form1.ClientWidth div 2 - Image1.Width div 2;
  Label2.Left := Form1.ClientWidth - Label2.Width;
end;

end.
