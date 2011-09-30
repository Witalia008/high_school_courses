unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, math, JPEG, ExtDlgs, Buttons, Menus;

const
  max = 100;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button3: TButton;
    LabeledEdit2: TLabeledEdit;
    Button4: TButton;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    Button5: TButton;
    Button6: TButton;
    SavePictureDialog1: TSavePictureDialog;
    SaveDialog1: TSaveDialog;
    Button7: TButton;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    PopupMenu1: TPopupMenu;
    SpeedButton5: TSpeedButton;
    Timer1: TTimer;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Saveas1: TMenuItem;
    Picture1: TMenuItem;
    Describng1: TMenuItem;
    Exit1: TMenuItem;
    New1: TMenuItem;
    About1: TMenuItem;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Open1: TMenuItem;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawPole;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure PopupMenuClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  coll = (white, gray, black);

  vertex = record
    X, Y: Integer;
    colour: coll;
    active: boolean;
  end;

  list = record
    cou: Integer;
    edges: array [1 .. max] of Integer;
  end;

var
  Form1: TForm1;
  CountOfVertex, RadiusOfVertex, Actived, CountOfEdges, EdgeWeight, Last,
    Timer, STop: Integer;
  ArrayOfVertex: array [1 .. max] of vertex;
  BackGroundColor, VertexColor, ActiveVertexColor, EdgeColor: TColor;
  matrix: array [1 .. max, 1 .. max] of list;
  Clicked, Moved, Oriented, Weighted, Runned: boolean;
  used, is_ans: array [1 .. max] of boolean;
  tin, tup, stack, sons: array [1 .. max] of Integer;

implementation

{$R *.dfm}

procedure TForm1.PopupMenuClick(Sender: TObject);
var
  nom, i: Integer;
begin
  if SpeedButton4.Flat then
  begin
    nom := (Sender as TMenuItem).Tag;
    dec(matrix[Actived][Last].cou);
    for i := nom to matrix[Actived][Last].cou do
      matrix[Actived][Last].edges[i] := matrix[Actived][Last].edges[i + 1];
    if not Oriented then
    begin
      dec(matrix[Last][Actived].cou);
      for i := nom to matrix[Last][Actived].cou do
        matrix[Last][Actived].edges[i] := matrix[Last][Actived].edges[i + 1];
    end;
  end;
  if SpeedButton5.Flat then
  begin
    nom := (Sender as TMenuItem).Tag;
    matrix[Last][Actived].edges[nom] := EdgeWeight;
    if not Oriented then
      matrix[Actived][Last].edges[nom] := EdgeWeight;
  end;
  ArrayOfVertex[Actived].active := false;
  Actived := -1;
  PopupMenu1.Items.Clear;
  DrawPole;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  SpeedButton1.Flat := not SpeedButton1.Flat;
  Oriented := not Oriented;
  DrawPole;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Weighted := not Weighted;
  SpeedButton2.Flat := not SpeedButton2.Flat;
  DrawPole;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  SpeedButton3.Flat := not SpeedButton3.Flat;
  SpeedButton5.Flat := false;
  SpeedButton4.Flat := false;
  SpeedButton7.Flat := false;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  SpeedButton4.Flat := not SpeedButton4.Flat;
  SpeedButton5.Flat := false;
  SpeedButton3.Flat := false;
  SpeedButton7.Flat := false;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  SpeedButton5.Flat := not SpeedButton5.Flat;
  SpeedButton4.Flat := false;
  SpeedButton3.Flat := false;
  SpeedButton7.Flat := false;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var
  i: Integer;
begin
  Runned := false;
  for i := 1 to CountOfVertex do
    ArrayOfVertex[i].colour := white;
  DrawPole;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  SpeedButton7.Flat := not SpeedButton7.Flat;
  SpeedButton3.Flat := false;
  SpeedButton4.Flat := false;
  SpeedButton5.Flat := false;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  SpeedButton8.Flat := not SpeedButton8.Flat;
  if Runned then
    Timer1.Enabled := not Timer1.Enabled;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
  Timer1Timer(Sender);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  j, v: Integer;
  flag: boolean;
begin
  if STop > 0 then
  begin
    j := 1;
    v := stack[STop];
    ArrayOfVertex[v].colour := gray;
    if tin[v] = 0 then
    begin
      inc(Timer);
      tin[v] := Timer;
      tup[v] := tin[v];
    end;
    while (j <= CountOfVertex) and ((matrix[v][j].cou = 0) or (used[j])) do
      inc(j);
    if j > CountOfVertex then
    begin
      flag := false;
      for j := 1 to CountOfVertex do
        if matrix[v][j].cou <> 0 then
        begin
          if (ArrayOfVertex[j].colour = gray) and
            ((STop = 1) or (stack[STop - 1] <> j)) then
            if tin[j] < tup[v] then
              tup[v] := tin[j];
          if ArrayOfVertex[j].colour = black then
            if tup[j] < tup[v] then
              tup[v] := tup[j];
          if (STop > 1) and (tup[j] >= tin[v]) and
            (ArrayOfVertex[j].colour = black) then
            flag := true;
        end;
      if STop = 1 then
        if sons[v] > 1 then
          flag := true;
      is_ans[v] := flag;
      dec(STop);
      ArrayOfVertex[v].colour := black;
      ArrayOfVertex[v].active := false;
      if STop > 0 then
        ArrayOfVertex[stack[STop]].active := true;
    end
    else
    begin
      inc(sons[v]);
      inc(STop);
      used[j] := true;
      stack[STop] := j;
      ArrayOfVertex[j].active := true;
      ArrayOfVertex[v].active := false;
    end;
  end
  else
    Timer1.Enabled := false;
  if SpeedButton8.Flat then
    Timer1.Enabled := false;
  DrawPole;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BackGroundColor := clSkyBlue;
  VertexColor := clGreen;
  ActiveVertexColor := clRed;
  EdgeColor := clBlack;
  RadiusOfVertex := 15;
  CountOfVertex := 0;
  Actived := -1;
  Clicked := false;
  Moved := false;
  CountOfEdges := 0;
  EdgeWeight := 1;
  Runned := false;
end;

procedure AddEdge(u, v: Integer; wei: Integer);
begin
  inc(matrix[u][v].cou);
  matrix[u][v].edges[matrix[u][v].cou] := wei;
end;

procedure ReplaceEdge(u, v: Integer; wei, nom: Integer);
var
  j: Integer;
begin
  matrix[u][v].edges[nom] := wei;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageBox(0,
    'This is my program, which can help you to build graphs.'
      + #10'Creator - Kojuhivskij Vitalij',
    'About Graph Builder', MB_ICONINFORMATION or MB_OK);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  if Oriented then
  begin
    ShowMessage('Graph can''t be oriented for this algorithm!');
    exit;
  end;
  Timer := 0;
  FillChar(used, sizeof(used), 0);
  FillChar(tin, sizeof(tin), 0);
  FillChar(tup, sizeof(tup), 0);
  FillChar(is_ans, sizeof(is_ans), 0);
  FillChar(sons, sizeof(sons), 0);
  for i := 1 to CountOfVertex do
    ArrayOfVertex[i].colour := white;

  if Actived <> -1 then
  begin
    STop := 1;
    stack[1] := Actived;
    used[Actived] := true;
    if not SpeedButton8.Flat then
      Timer1.Enabled := true;
    ArrayOfVertex[Actived].active := false;
    Runned := true;
    Last := Actived;
  end;
  Actived := -1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OnMouseDown(Sender, mbLeft, [], StrToInt(Edit1.Text), StrToInt(Edit2.Text));
  Edit1.Text := 'X';
  Edit2.Text := 'Y';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if length(LabeledEdit2.Text) > 6 then
    LabeledEdit2.Text := '999999';
  EdgeWeight := StrToInt(LabeledEdit2.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  CountOfVertex := 0;
  CountOfEdges := 0;
  Actived := -1;
  FillChar(ArrayOfVertex, sizeof(ArrayOfVertex), 0);
  FillChar(matrix, sizeof(matrix), 0);
  Runned := false;
  DrawPole;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  jpgIm: TJPEGImage;
begin
  if SavePictureDialog1.Execute then
  begin
    jpgIm := TJPEGImage.Create;
    jpgIm.Assign(Image1.Picture.Bitmap);
    jpgIm.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
  function booltoint(a: boolean): Integer;
  begin
    if a then
      booltoint := 1
    else
      booltoint := 0;
  end;

var
  i, j, sj: Integer;
begin
  if SaveDialog1.Execute then
  begin
    AssignFile(Output, SaveDialog1.FileName);
    Rewrite(Output);
    Writeln(CountOfVertex, ' ', RadiusOfVertex, ' ', Actived, ' ',
      CountOfEdges, ' ', EdgeWeight);
    Writeln(BackGroundColor, ' ', VertexColor, ' ', ActiveVertexColor, ' ',
      EdgeColor);
    Writeln(booltoint(Oriented));
    Writeln(booltoint(Weighted));
    for i := 1 to CountOfVertex do
    begin
      for j := 1 to CountOfVertex do
      begin
        Writeln(matrix[i][j].cou);
        for sj := 1 to matrix[i][j].cou do
          Write(matrix[i][j].edges[sj], ' ');
      end;
      Writeln;
    end;
    for i := 1 to CountOfVertex do
      Writeln(ArrayOfVertex[i].X, ' ', ArrayOfVertex[i].Y);
    CloseFile(Output);
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
  function inttobool(a: Integer): boolean;
  begin
    if a = 1 then
      inttobool := true
    else
      inttobool := false;
  end;

var
  i, j, wei, c, sj: Integer;
begin
  if OpenDialog1.Execute then
  begin
    FillChar(ArrayOfVertex, sizeof(ArrayOfVertex), 0);
    FillChar(matrix, sizeof(matrix), 0);
    AssignFile(Input, OpenDialog1.FileName);
    Reset(Input);
    Read(CountOfVertex, RadiusOfVertex, Actived, CountOfEdges, EdgeWeight);
    Read(BackGroundColor, VertexColor, ActiveVertexColor, EdgeColor);
    Read(i);
    Oriented := inttobool(i);
    Read(i);
    Weighted := inttobool(i);
    for i := 1 to CountOfVertex do
      for j := 1 to CountOfVertex do
      begin
        Read(c);
        for sj := 1 to c do
        begin
          read(wei);
          AddEdge(i, j, wei);
        end;
      end;
    for i := 1 to CountOfVertex do
      Read(ArrayOfVertex[i].X, ArrayOfVertex[i].Y);
    CloseFile(Input);
    Runned := false;
    DrawPole;
  end;
end;

procedure TForm1.DrawPole;
var
  i, j, nX, nY, sj: Integer;
  angle: real;
  edges: string;
begin
  with Image1 do
  begin
    Canvas.Brush.Color := BackGroundColor;
    Canvas.Pen.Color := BackGroundColor;
    Canvas.Rectangle(0, 0, Width, Height);
    Canvas.Pen.Color := EdgeColor;
    for i := 1 to CountOfVertex do
      for j := 1 to CountOfVertex do
        if (matrix[i][j].cou <> 0) then
        begin
          if (Oriented) or (matrix[j][i].cou <> 0) then
          begin
            Canvas.MoveTo(ArrayOfVertex[i].X, ArrayOfVertex[i].Y);
            Canvas.LineTo(ArrayOfVertex[j].X, ArrayOfVertex[j].Y);
          end;
          if Oriented then
          begin
            angle := ArcTan2(ArrayOfVertex[j].Y - ArrayOfVertex[i].Y,
              ArrayOfVertex[j].X - ArrayOfVertex[i].X);
            nX := ArrayOfVertex[j].X - trunc(RadiusOfVertex * cos(angle));
            nY := ArrayOfVertex[j].Y - trunc(RadiusOfVertex * sin(angle));
            Canvas.MoveTo(nX - round(10 * cos(angle + Pi / 6)),
              nY - round(10 * sin(angle + Pi / 6)));
            Canvas.LineTo(nX, nY);
            Canvas.MoveTo(nX - round(10 * cos(angle - Pi / 6)),
              nY - round(10 * sin(angle - Pi / 6)));
            Canvas.LineTo(nX, nY);
          end;
          if Weighted then
          begin
            edges := IntToStr(matrix[i][j].edges[1]);
            for sj := 2 to matrix[i][j].cou do
              edges := edges + ', ' + IntToStr(matrix[i][j].edges[sj]);
            if not Oriented then
              Canvas.TextOut((ArrayOfVertex[i].X + ArrayOfVertex[j].X) div 2,
                (ArrayOfVertex[i].Y + ArrayOfVertex[j].Y) div 2, edges)
            else
              Canvas.TextOut
                ((((ArrayOfVertex[i].X + ArrayOfVertex[j].X) div 2)
                    + ArrayOfVertex[j].X) div 2,
                (((ArrayOfVertex[i].Y + ArrayOfVertex[j].Y) div 2)
                    + ArrayOfVertex[j].Y) div 2, edges);
          end;
        end;
    for i := 1 to CountOfVertex do
    begin

      if (Runned) and (is_ans[i]) then
      begin
        Canvas.Brush.Color := clYellow;
        Canvas.Ellipse(ArrayOfVertex[i].X - 20, ArrayOfVertex[i].Y - 20,
          ArrayOfVertex[i].X + 20, ArrayOfVertex[i].Y + 20);
      end;

      if ArrayOfVertex[i].active then
        Canvas.Brush.Color := ActiveVertexColor
      else
      begin
        if ArrayOfVertex[i].colour = white then
          Canvas.Brush.Color := VertexColor;
        if ArrayOfVertex[i].colour = gray then
          Canvas.Brush.Color := clGray;
        if ArrayOfVertex[i].colour = black then
          Canvas.Brush.Color := clBlack;
      end;

      Canvas.Ellipse(ArrayOfVertex[i].X - RadiusOfVertex,
        ArrayOfVertex[i].Y - RadiusOfVertex,
        ArrayOfVertex[i].X + RadiusOfVertex,
        ArrayOfVertex[i].Y + RadiusOfVertex);
      Canvas.Brush.Style := bsSolid;
      if used[i] then
        Canvas.Font.Color := clAqua;
      Canvas.TextOut(ArrayOfVertex[i].X - 10, ArrayOfVertex[i].Y - 10,
        IntToStr(i));
      if Runned then
        Image1.Canvas.TextOut(ArrayOfVertex[i].X + RadiusOfVertex,
          ArrayOfVertex[i].Y - RadiusOfVertex,
          IntToStr(tin[i]) + ' / ' + IntToStr(tup[i]));
    end;
  end;
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Sender as TEdit).Text = 'X') or ((Sender as TEdit).Text = 'Y') then
  (Sender as TEdit)
    .Text := '';
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, num, n1: Integer;
  j: Integer;
  mi: TMenuItem;
begin
  num := 0;
  for i := 1 to CountOfVertex do
    if sqrt(sqr(X - ArrayOfVertex[i].X) + sqr(Y - ArrayOfVertex[i].Y))
      <= RadiusOfVertex then
      num := i;
  if (num = 0) then
  begin
    num := 0;
    for i := 1 to CountOfVertex do
      if sqrt(sqr(X - ArrayOfVertex[i].X) + sqr(Y - ArrayOfVertex[i].Y))
        <= 4 * RadiusOfVertex then
        num := i;
    if (num = 0) and (X > RadiusOfVertex) and (Y > RadiusOfVertex) and
      (X < Image1.Width - RadiusOfVertex) and
      (Y < Image1.Height - RadiusOfVertex) then
    begin
      if CountOfVertex = 100 then
        ShowMessage('Too many vertexes...')
      else
      begin
        inc(CountOfVertex);
        ArrayOfVertex[CountOfVertex].X := X;
        ArrayOfVertex[CountOfVertex].Y := Y;
        ArrayOfVertex[CountOfVertex].active := false;
      end;
    end;
  end
  else
  begin
    if (Actived = -1) then
    begin
      if SpeedButton3.Flat then
      begin
        SpeedButton6Click(Sender);
        dec(CountOfVertex);
        for i := num to CountOfVertex do
          ArrayOfVertex[i] := ArrayOfVertex[i + 1];

        for i := 1 to CountOfVertex + 1 do
          for j := num to CountOfVertex do
            matrix[i][j] := matrix[i][j + 1];

        for i := 1 to CountOfVertex do
          for j := num to CountOfVertex do
            matrix[j][i] := matrix[j + 1][i];

        for i := 1 to CountOfVertex + 1 do
        begin
          matrix[i][CountOfVertex + 1].cou := 0;
          matrix[CountOfVertex + 1][i].cou := 0;
        end;
      end
      else
      begin
        ArrayOfVertex[num].active := true;
        Actived := num;
      end;
    end
    else
    begin
      if Actived = num then
      begin
        Actived := -1;
        ArrayOfVertex[num].active := false;
      end
      else
      begin
        if (SpeedButton4.Flat) or (SpeedButton5.Flat) then
        begin
          for i := 1 to matrix[Actived][num].cou do
          begin
            mi := TMenuItem.Create(self);
            mi.OnClick := PopupMenuClick;
            mi.Caption := IntToStr(matrix[Actived][num].edges[i]);
            mi.Tag := i;
            PopupMenu1.Items.Insert(0, mi);
          end;
          PopupMenu1.Popup(X, Y);
          Last := num;
        end
        else if SpeedButton7.Flat then
        begin
          if EdgeWeight <> 0 then
          begin
            AddEdge(Actived, num, EdgeWeight);
            if not Oriented then
              AddEdge(num, Actived, EdgeWeight);
            ArrayOfVertex[Actived].active := false;
            Actived := -1;
          end;
        end
        else
        begin
          ArrayOfVertex[Actived].active := false;
          ArrayOfVertex[num].active := true;
          Actived := num;
        end;
      end;
    end;
  end;
  DrawPole;
  Clicked := true;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  i, num: Integer;
begin
  if (Clicked) and (Actived <> -1) then
  begin
    num := 0;
    for i := 1 to CountOfVertex do
      if (sqrt(sqr(X - ArrayOfVertex[i].X) + sqr(Y - ArrayOfVertex[i].Y))
          <= 4 * RadiusOfVertex) and (i <> Actived) then
        num := i;
    if (num = 0) and (X <= Image1.Width - RadiusOfVertex) and
      (Y <= Image1.Height - RadiusOfVertex) and (X >= RadiusOfVertex) and
      (Y >= RadiusOfVertex) then
    begin
      ArrayOfVertex[Actived].X := X;
      ArrayOfVertex[Actived].Y := Y;
      Moved := true;
      DrawPole;
    end;
  end;
  Label1.Caption := 'X : ' + IntToStr(X);
  Label2.Caption := 'Y : ' + IntToStr(Y);
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Moved then
  begin
    ArrayOfVertex[Actived].active := false;
    Actived := -1;
    DrawPole;
  end;
  Clicked := false;
  Moved := false;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Image1.Height := ClientHeight;
  Image1.Width := ClientWidth - Panel1.Width;
end;

end.
