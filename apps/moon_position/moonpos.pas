unit moonpos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, time_manip, time, moon_manip,
  coor_manip, jpeg, timespan, dateutils;

type
  TForm1 = class(TForm)
    EditYear: TEdit;
    EditMonth: TEdit;
    EditDay: TEdit;
    EditHour: TEdit;
    EditMinute: TEdit;
    EditSecond: TEdit;
    Button1: TButton;
    LabelDate: TLabel;
    LabelTime: TLabel;
    LabelAlpha: TLabel;
    LabelDelta: TLabel;
    LabelAlpha1: TLabel;
    LabelDelta1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    DateTimePicker1: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  year, month, day, hour, min, sec, h, m, s: integer;
  alpha, delta: real;
  tc: Tdt;
begin
  year := StrToInt(EditYear.Text);
  month := StrToInt(EditMonth.Text);
  day := StrToInt(EditDay.Text);
  hour := StrToInt(EditHour.Text);
  min := StrToInt(EditMinute.Text);
  sec := StrToInt(EditSecond.Text);
  if (year < -1999) or (year > 3000) or (month < 1) or (month > 12) or
    (day < 0) or (day > month_days[month - 1][is_leap_year(year)]) or
    (hour < 0) or (hour > 23) or (min < 0) or (min > 59) or (sec < 0) or
    (sec > 59) then
  begin
    ShowMessage('Некоректо введено дату чи час');
    exit;
  end;

  tc.sec := sec;
  tc.min := min;
  tc.hour := hour;
  tc.year := year - 1900;
  tc.month := month - 1;
  tc.day := day;
  moons_pos(tc, alpha, delta);
  hour_decomp(alpha, h, m, s);
  LabelAlpha1.Caption := IntToStr(h) + ' год ' + IntToStr(m) + ' хв ' + IntToStr
    (s) + ' с ';
  degree_decomp(delta, h, m, s);
  LabelDelta1.Caption := IntToStr(h) + ' ° ' + IntToStr(m) + ' '' ' + IntToStr
    (s) + ' '''' ';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EditYear.Text := IntToStr (YearOf(now));
  EditMonth.Text := IntToStr (MonthOf(now));
  EditDay.Text := IntToStr (DayOf(now));
  EditHour.Text := IntToStr (HourOf(now));
  EditMinute.Text := IntToStr (MinuteOf(now));
  EditSecond.Text := IntToStr (SecondOf(now));
  Button1Click(Sender);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  ct: Tdt;
  alpha, delta: real;
  h, m, s: integer;
  t : TDateTime;
begin
  Timer1.Interval := 1000;
  ct.year := YearOf(now) - 1900;
  ct.month := MonthOf(now) - 1;
  ct.day := DayOf(now);
  ct.hour := HourOf(now);
  ct.min := MinuteOf(now);
  ct.sec := SecondOf(now);
  LabelDate.Caption := '';
  if (ct.day < 10) then
    LabelDate.Caption := '0';
  LabelDate.Caption := LabelDate.Caption + IntToStr(ct.day) + ':';
  if (ct.month + 1 < 10) then
    LabelDate.Caption := LabelDate.Caption + '0';
  LabelDate.Caption := LabelDate.Caption + IntToStr(ct.month + 1) + ':';
  LabelDate.Caption := LabelDate.Caption + IntToStr(ct.year + 1900);

  LabelTime.Caption := '';
  if (ct.hour < 10) then
    LabelTime.Caption := '0';
  LabelTime.Caption := LabelTime.Caption + IntToStr(ct.hour) + ':';
  if (ct.min < 10) then
    LabelTime.Caption := LabelTime.Caption + '0';
  LabelTime.Caption := LabelTime.Caption + IntToStr(ct.min) + ':';
  if ct.sec < 10 then
    LabelTime.Caption := LabelTime.Caption + '0';
  LabelTime.Caption := LabelTime.Caption + IntToStr(ct.sec);

  moons_pos(ct, alpha, delta);
  hour_decomp(alpha, h, m, s);
  LabelAlpha.Caption := IntToStr(h) + ' год ' + IntToStr(m) + ' хв ' + IntToStr
    (s) + ' с';
  degree_decomp(delta, h, m, s);
  LabelDelta.Caption := IntToStr(h) + '° ' + IntToStr(m) + ''' ' + IntToStr(s)
    + ' ''''';
end;

end.
