unit sun_manip;

interface

uses math;

procedure sun_long_anom(days: real; var anomaly, longitude: real);

implementation

procedure sun_long_anom(days: real; var anomaly, longitude: real);
var
  n, Ec: real;
begin
  n := 360 / 365.2422 * days;
  if n > 360 then
    n := n - trunc(n / 360) * 360;
  if n < 0 then
    n := n + trunc(- n / 360) * 360 + 360;
  anomaly := n + 278.833540 - 282.596403;
  if anomaly < 0 then
    anomaly := anomaly + 360;
  Ec := 360 / Pi * 0.016718 * sin(Pi * (anomaly) / 180.0);
  longitude := N + Ec + 278.833540;
  if longitude > 360 then
    longitude := longitude - 360;
end;

end.
