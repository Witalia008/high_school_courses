unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, jpeg, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ball: TShape;
    leftShape: TShape;
    rightShape: TShape;
    Timer1: TTimer;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    w: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  isW, isS, isUP, isDOWN, isGame: boolean;
  ballPos, yAl, yAr, yA, speed, count : shortint;

implementation

{$R *.dfm}

procedure TForm1.N3Click(Sender: TObject);
begin
  form1.close;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  ShowMessage(''+#10''+#10'');
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = ord('W')) then
    isW := true;
  if (key = ord('S')) then
    isS := true;
  if (key = VK_DOWN) then
    isDOWN := true;
  if (key = VK_UP) then
    isUP := true;
  if (key = VK_RETURN) then
  begin
    if (ballPos = -1) then
      yA := yAl
    else
      yA := yAr;
    isGame := true;
  end;
  if (key = VK_ADD) then
    if (StrToInt(Label3.Caption) < 15*60) then
      Label3.Caption := IntToStr(StrToInt(Label3.Caption)+1);
  if (key = VK_SUBTRACT) then
    if (StrToInt(Label3.Caption) > 1) then
      Label3.Caption := IntToStr(StrToInt(Label3.Caption)-1);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = ord('W')) then
  begin
    isW := false;
    yAl := 0;
  end;
  if (key = ord('S')) then
  begin
    isS := false;
    yAl := 0;
  end;
  if (key = VK_DOWN) then
  begin
    isDOWN := false;
    yAr := 0;
  end;
  if (key = VK_UP) then
  begin
    isUP := false;
    yAr := 0;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  inc(count);
  if (isGame)and(count = 20) then
    Label3.Caption := IntToStr(StrToInt(Label3.Caption)-1);
  if (count = 20) then
    count := 0;
  if (StrToInt(label3.Caption) = 0) then
  begin
    isGame := false;
    Timer1.Enabled := false;     
    if (StrToInt(Label1.Caption) > StrToInt(Label2.Caption)) then
      ShowMessage('Player 1 won');
    if (StrToInt(Label1.Caption) < StrToInt(Label2.Caption)) then
      ShowMessage('Player 2 won');
    if (StrToInt(Label1.Caption) = StrToInt(Label2.Caption)) then
      ShowMessage('Draw!');
    Timer1.Enabled := true;
    N2Click(Sender);
  end;
  if (isGame) then
  begin
    if (ball.Left+ball.Width = rightShape.Left)and(speed > 0)and(ball.Top+ball.Height div 2 >= rightShape.Top)and(ball.Top+ball.Height div 2 <= rightShape.Top+rightShape.Height) then
    begin
      speed := -speed;
      ballPos := 1;
      yA := (yA + yAr) div 2;
    end;
    if (ball.Left = leftShape.Width) and(speed < 0)and(ball.Top+ball.Height div 2 >= leftShape.Top)and(ball.Top+ball.Height div 2 <= leftShape.Top+leftShape.Height) then
    begin
      speed := -speed;
      ballPos := -1;
      yA := (yA + yAl) div 2;
    end;
    if (ball.Left >= form1.ClientWidth) then
    begin
      isGame := false;
      speed := -speed;
      ballPos := 1;
      Label1.Caption := IntToStr(StrToInt(Label1.Caption)+1);
      ball.Left := rightShape.Left-ball.Width;
      ball.Top := rightShape.Top + 40;
    end;
    if (ball.Left < -ball.Width) then
    begin
      isGame := false;
      speed := -speed;
      ballPos := -1;
      Label2.Caption := IntToStr(StrToInt(Label2.Caption)+1);
      ball.Left := leftShape.Width;
      ball.Top := leftShape.Top + 40;
    end;
    if (ball.Top = 0) then
      yA := -yA;
    if (ball.Top = form1.ClientHeight-ball.Height) then
      yA := -yA;
    if (isGame) then
    begin
      ball.Left := ball.Left + speed;
      ball.Top := ball.Top + yA;
      if (ball.Top < 0) then
        ball.Top := 0;
      if (ball.Top > form1.ClientHeight-ball.Height) then
        ball.Top := form1.ClientHeight-ball.Height;
      if (ball.Left < leftShape.Width)and(ball.Top+ball.Height div 2 >= leftShape.Top)and(ball.Top+ball.Height div 2 <= leftShape.Top+leftShape.Height) then
        ball.Left := leftShape.Width;
      if (ball.Left > rightShape.Left-ball.Width)and(ball.Top+ball.Height div 2 >= rightShape.Top)and(ball.Top+ball.Height div 2 <= rightShape.Top+rightShape.Height) then
        ball.Left := rightShape.Left-ball.Width;
    end;
    if (ball.Left > leftShape.Width)and(ball.Left < rightShape.Left-ball.Width) then
      ballPos := 0;
  end;
  if (isW) then
    if (leftShape.Top > 0) then
    begin
      leftShape.Top := leftShape.Top - 10;
      if (ballPos = -1)and(not isGame) then
        ball.Top := ball.Top - 10;
      if (yAl <= 0) then
        dec(yAl)
      else
        yAl := 0;
    end;
  if (isS) then
    if (leftShape.Top < 330) then
    begin
      leftShape.Top := leftShape.Top + 10;
      if (ballPos = -1)and(not isGame) then
        ball.Top := ball.Top + 10;
      if (yAl >= 0) then
        inc(yAl)
      else
        yAl := 0;
    end;
  if (isUP) then
    if (rightShape.Top > 0) then
    begin
      rightShape.Top := rightShape.Top - 10;
      if (ballPos = 1)and(not isGame) then
        ball.Top := ball.Top - 10;
      if (yAr <= 0) then
        dec(yAr)
      else
        yAr := 0;
    end;
  if (isDOWN) then
    if (rightShape.Top < 330) then
    begin
      rightShape.Top := rightShape.Top + 10;
      if (ballPos = 1)and(not isGame) then
        ball.Top := ball.Top + 10;
      if (yAr >= 0) then
        inc(yAr)
      else
        yAr := 0;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ballPos := -1;
  yAr := 0;
  yAl := 0;
  isGame := false;
  speed := 10;
  count := 0;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  N6.Checked := true;
  N7.Checked := false;
  N8.Checked := false;
  if (speed > 0) then
    speed := 10
  else
    speed := -10;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  N7.Checked := true;
  N6.Checked := false;
  N8.Checked := false;
  if (speed > 0) then
    speed := 20
  else
    speed := -20;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  N8.Checked := true;
  N7.Checked := false;
  N6.Checked := false;
  if (speed > 0) then
    speed := 30
  else
    speed := -30;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  if (isGame) then
    timer1.Enabled := not Timer1.Enabled;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  count := 0;
  leftShape.Top := 160;
  rightShape.Top := 160;
  ball.Top := 200;
  ball.Left := leftShape.Width;
  if (speed < 0) then
    speed := -speed;
  ballPos := -1;
  isGame := false;
  yA := 0;
  yAl := 0;
  yAr := 0;
  Label1.Caption := '0';
  Label2.Caption := '0';
  Label3.Caption := '120';
end;

end.
