unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    XPManifest1: TXPManifest;
    MainMenu1: TMainMenu;
    NewGame1: TMenuItem;
    Timer1: TTimer;
    procedure ButtonClick(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewGame1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  c : array[1..4, 1..2] of shortint =
  ((1, 0), (0, 1), (-1, 0), (0, -1));

var
  Form1: TForm1;
  cells : array[1..4, 1..4] of TButton;
  h, w, curTime, couSteps : integer;
  isGame : boolean;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j : shortint;
begin
  h := 50;
  w := 50;
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      cells[i, j] := TButton.Create(nil);
      cells[i, j].ParentWindow := Handle;
      cells[i, j].Height := h;
      cells[i, j].Width := w;
      cells[i, j].Left := (j-1)*(w + 3);
      cells[i, j].Top := (i-1)*(h + 3);
      cells[i, j].Tag := (i-1)*4+j;
      cells[i, j].Font.Name := 'Ravie';
      cells[i, j].Font.Size := 16;
      cells[i, j].Show;
      cells[i, j].OnClick := ButtonClick;
      if ((i-1)*4+j < 16) then
        cells[i, j].Caption := inttostr((i-1)*4+j)
      else
        cells[i, j].Caption := '';
    end;
  isGame := false;
  curTime := 0;
  couSteps := 0;
  randomize;
end;

function good (x, y : shortint) : boolean;
begin
  if (x > 0)and(y > 0)and(x <= 4)and(y <= 4) then
    good := true
  else
    good := false;
end;

procedure Shake;
var
  i, j, x, y : integer;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      if (cells[i, j].Caption = '') then
      begin
        x := i;
        y := j;
      end;
  i := 1;
  while (i < 2000) do
  begin
    j := random(4)+1;
    if (good(x+c[j, 1], y+c[j, 2])) then
    begin
      cells[x, y].Caption := cells[x+c[j, 1], y+c[j, 2]].Caption;
      cells[x+c[j, 1], y+c[j, 2]].Caption := '';
      x := x + c[j, 1];
      y := y + c[j, 2];
    end;
    if (x = 4)and(y = 4)and(i > 1000) then
      i := 2000;    
    inc(i);
  end;
end;

procedure TForm1.NewGame1Click(Sender: TObject);
var
  i, j : shortint;
begin
  isGame := true;
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      cells[i, j].Tag := (i-1)*4+j;
      if ((i-1)*4+j < 16) then
        cells[i, j].Caption := inttostr((i-1)*4+j)
      else
        cells[i, j].Caption := '';
    end;
  Shake;
  curTime := 0;
  couSteps := 0;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  i, j : shortint;
begin
  h := (ClientHeight - 9) div 4;
  w := (ClientWidth - 9) div 4;
  if (h < w) then
    w := h
  else
    h := w;
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      cells[i, j].Height := h;
      cells[i, j].Width := w;
      cells[i, j].Left := (j-1)*(w + 3);
      cells[i, j].Top := (i-1)*(h + 3);
      cells[i, j].Font.Size := h div 3;
    end;
end;

procedure TForm1.ButtonClick(Sender : TObject);
var
  i, j, n : shortint;
  flag : boolean;
begin
  if (not isGame) then exit;
  n := (sender as tbutton).tag;
  i := (n-1) div 4 + 1;
  j := (n-1) mod 4 + 1;
  for n := 1 to 4 do
    if (good(i-c[n, 1], j-c[n, 2])) then
      if (cells[i-c[n, 1], j-c[n, 2]].Caption = '') then
      begin
        cells[i-c[n, 1], j-c[n, 2]].Caption := cells[i, j].Caption;
        cells[i, j].Caption := '';
        inc(couSteps);
      end;
  flag := true;
  for i := 1 to 4 do
    for j := 1 to 4 do
      if (cells[i, j].Caption <> '')and(cells[i, j].Caption <> inttostr(cells[i, j].Tag)) then
        flag := false;
  if (flag) then
  begin
    isGame := false;
    ShowMessage('You won! Time: '+#10+inttostr(curTime div 3600)+' h '+IntToStr(curTime div 60)+' min '+intToStr(curTime mod 60)+' sec.'+#10'Ste[s]: '+inttostr(couSteps));
    curTime := 0;
    couSteps := 0;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  inc(curTime);
end;

end.
