program moonspos;

uses
  Forms,
  moonpos in 'moonpos.pas' {Form1},
  time_manip in 'time_manip.pas',
  sun_manip in 'sun_manip.pas',
  coor_manip in 'coor_manip.pas',
  math_ext in 'math_ext.pas',
  time in 'time.pas',
  moon_manip in 'moon_manip.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
