unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Timer1: TTimer;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure DrawPole();
    procedure SetLevel();
    procedure N7Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  point = record
    x, y : shortint;
  end;

const
  width1 = 25;
  height1 = 17;

var
  Form1: TForm1;
  wall, snake, floor, food, h : TBitMap;
  pole : array [1..width1, 1..height1] of shortint;
  head, tail, add: point;
  state : string;
  losed, isGame : boolean;
  curLevel : shortint;
  levels : array[1..5] of string;


implementation

{$R *.dfm}

procedure TForm1.DrawPole;
var
  i, j : shortint;
begin
  for i := 1 to width1 do
    for j := 1 to height1 do
      begin
        if (pole[i, j] = 0) then
        begin
          Form1.Canvas.Draw((i-1)*36, (j-1)*36, floor);
        end;
        if (pole[i, j] = -1) then
        begin
          Form1.Canvas.Draw((i-1)*36, (j-1)*36, wall);
        end;
        if (pole[i, j] = 1) then
        begin
         Form1.Canvas.Draw((i-1)*36, (j-1)*36, snake);
        end;
        if (pole[i, j] = 3) then
        begin
          Form1.Canvas.Draw((i-1)*36, (j-1)*36, food);
        end;
        if (pole[i, j] = 4) then
        begin
          Form1.Canvas.Draw((i-1)*36, (j-1)*36, h);
        end;
      end;
end;

procedure TForm1.SetLevel;
var
  i, j : shortint;
  cou : integer;
  s : string;
begin
  s := levels[curLevel];
  for i := 1 to width1 do
    for j := 1 to height1 do
    begin
      if s[1] = '0' then
        pole[i, j] := 0
      else
        pole[i, j] := -1;
      delete(s, 1, 1);
    end;
end;

procedure NewEat;
var
  i, j : shortint;
begin
  randomize;
  i := random(width1)+1;
  j := random(height1)+1;
  while (pole[i, j] <> 0) do
    begin
      i := random(width1)+1;
      j := random(height1)+1;
    end;
  pole[i, j] := 3;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : shortint;
  inp : textfile;
begin
  timer1.Enabled := false;
  wall := TBitMap.Create;
  snake := TBitMap.Create;
  floor := TBitMap.Create;
  food := TBitMap.Create;
  h := TBitMap.Create;
  wall.LoadFromFile('img\wall.bmp');
  snake.LoadFromFile('img\snake.bmp');
  floor.LoadFromFile('img\floor.bmp');
  food.LoadFromFile('img\food.bmp');
  h.LoadFromFile('img\head.bmp');
  curLevel := 1;
  isGame := false;
  AssignFile(inp, 'levels.lvls');
  Reset(inp);
  readln(inp, levels[1]);
  readln(inp, levels[2]);
  readln(inp, levels[3]);
  readln(inp, levels[4]);
  readln(inp, levels[5]);
  CloseFile(inp);
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.N4Click(Sender: TObject);
var
  i : shortint;
begin
  timer1.Enabled := false;
  fillchar (pole, sizeof (pole), 0);
  SetLevel;
  losed := false;
  if (not N7.Checked)and(pole[1, 1] = 0) then
  begin
    tail.x := 1;
    tail.y := 1;
  end else
  begin
    tail.x := 2;
    tail.y := 2;
    for i := 1 to width1 do
    begin
      pole[i, height1] := -1;
      pole[i, 1] := -1;
    end;
    for i := 2 to height1-1 do
    begin
      pole[width1, i] := -1;
      pole[1, i] := -1;
    end;
  end;
  head := tail;
  pole[head.x, head.y] := 4;
  state := '';
  NewEat;
  DrawPole;
end;

procedure TForm1.N7Click(Sender: TObject);
var
  i : shortint;
begin
  N7.Checked := not N7.Checked;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not losed) then
  begin
  if (key = VK_UP)or(key = VK_DOWN)or(key = VK_LEFT)or(key = VK_RIGHT) then
  begin
    if (not timer1.Enabled) then
    begin
      isGame := true;
      timer1.Enabled := true;
    end;
    if (key = VK_UP) then
      begin
        add.x := 0;
        add.y := -1;
      end;
    if (key = VK_DOWN) then
      begin
        add.x := 0;
        add.y := 1;
      end;
    if (key = VK_LEFT) then
      begin
        add.x := -1;
        add.y := 0;
      end;
    if (key = VK_RIGHT) then
      begin
        add.x := 1;
        add.y := 0;
      end;
  end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
function newx (x : shortint) : shortint;
begin
  if (x = 0) then result := width1 else
  if (x = width1+1) then result := 1 else
    result := x;
end;
function newy (y : shortint) : shortint;
begin
  if (y = 0) then result := height1 else
  if (y = height1+1) then result := 1 else
    result := y;
end;
begin
  if (pole[newx(head.x+add.x), newy(head.y+add.y)] in [0, 3]) then
  begin
    head.x := newx(head.x+add.x);
    head.y := newy(head.y+add.y);
    if (add.x = -1) then
      state := state + 'L';
    if (add.x = 1) then
      state := state + 'R';
    if (add.y = -1) then
      state := state + 'U';
    if (add.y = 1) then
      state := state + 'D';
    if (pole[head.x, head.y] = 0){or((head.x = tail.x)and(head.y = tail.y))} then
    begin
      pole[tail.x, tail.y] := 0;
      if (state[1] = 'U') then
        tail.y := newy(tail.y-1);
      if (state[1] = 'D') then
        tail.y := newy(tail.y+1);
      if (state[1] = 'L') then
        tail.x := newx(tail.x-1);
      if (state[1] = 'R') then
        tail.x := newx(tail.x+1);
      delete(state, 1, 1);
    end else
      NewEat;

    pole[head.x, head.y] := 4;
    if (tail.x <> head.x)or(tail.y <> head.y) then
      pole[newx(head.x-add.x), newy(head.y-add.y)] := 1;
    if (length(state) = 40-3*curLevel) then
    begin
      DrawPole;
      timer1.Enabled := false;
      isGame := false;
      ShowMessage('žž žžžžžžž žžžžž!');
      if (curLevel < 5) then
      begin
        inc(curLevel);
        N4Click(Sender);   {žžžžžžžžž žžžžžžž žžžžž žžžž ž žžžž}
      end else
        ShowMessage('žžžžžžžž!');
    end;
  end else
  begin
    timer1.Enabled := false;
    ShowMessage('žž žžžžžžžž!');
    losed := true;
    isGame := false;
  end;
  drawpole;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
  if (isGame) then
    timer1.Enabled := not timer1.Enabled;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  Timer1.Interval := 300;
  N11.Checked := true;
  N12.Checked := false;
  N13.Checked := false;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
  Timer1.Interval := 200;
  N12.Checked := true;
  N11.Checked := false;
  N13.Checked := false;
end;

procedure TForm1.N13Click(Sender: TObject);
begin
  Timer1.Interval := 100;
  N13.Checked := true;
  N12.Checked := false;
  N11.Checked := false;
end;

procedure TForm1.N15Click(Sender: TObject);
begin
  N15.Checked := true;
  N16.Checked := false;
  N17.Checked := false;
  N18.Checked := false;
  N19.Checked := false;
  curLevel := 1;
  N4Click(Sender);
end;

procedure TForm1.N16Click(Sender: TObject);
begin
  N16.Checked := true;
  N15.Checked := false;
  N17.Checked := false;
  N18.Checked := false;
  N19.Checked := false;
  curLevel := 2;  
  N4Click(Sender);
end;

procedure TForm1.N17Click(Sender: TObject);
begin
  N17.Checked := true;
  N16.Checked := false;
  N15.Checked := false;
  N18.Checked := false;
  N19.Checked := false;
  curLevel := 3;  
  N4Click(Sender);
end;

procedure TForm1.N18Click(Sender: TObject);
begin
  N18.Checked := true;
  N16.Checked := false;
  N17.Checked := false;
  N15.Checked := false;
  N19.Checked := false;
  curLevel := 4;  
  N4Click(Sender);
end;

procedure TForm1.N19Click(Sender: TObject);
begin
  N19.Checked := true;
  N16.Checked := false;
  N17.Checked := false;
  N18.Checked := false;
  N15.Checked := false;
  curLevel := 5;  
  N4Click(Sender);
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  ShowMessage('<2011>');
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  ShowMessage('');
end;

end.
