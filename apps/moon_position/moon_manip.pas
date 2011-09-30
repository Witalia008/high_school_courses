unit moon_manip;

interface

uses time, time_manip, sun_manip, math_ext, math, coor_manip;

procedure moons_pos(ut: Tdt; var alpham, deltam: real);

implementation

procedure moons_pos(ut: Tdt; var alpham, deltam: real);
var
  et: Tdt;
  D, M0, lambda0, l, Mm, N, C, Ev, Ae, A3, Mms, Ec, A4, ls, V, lss, Ns, y, x,
    lambdam, betam: real;
begin
  UT_ET(ut, et);
  D := days_from_Jan00(et);
  sun_long_anom(D, M0, lambda0);
  l := 13.176396 * D + 64.975464;
  l := to360(l);
  Mm := l - 0.1114041 * D - 349.383063;
  Mm := to360(Mm);
  N := 151.950429 - 0.0529539 * D;
  N := to360(N);
  C := l - lambda0;
  Ev := 1.2739 * sin(Pi * (2 * C - Mm) / 180.0);
  Ae := 0.1858 * sin(Pi * M0 / 180.0);
  A3 := 0.37 * sin(Pi * M0 / 180.0);
  Mms := Mm + Ev - Ae - A3;
  Ec := 6.2886 * sin(Pi * Mms / 180.0);
  A4 := 0.214 * sin(Pi * 2 * Mm / 180.0);
  ls := l + Ev + Ec - Ae + A4;
  V := 0.6583 * sin(Pi * 2 * (ls - lambda0) / 180.0);
  lss := ls + V;
  Ns := N - 0.16 * sin(Pi * M0 / 180.0);
  y := sin(Pi * (lss - Ns) / 180.0) * cos(Pi * 5.145396 / 180.0);
  x := cos(Pi * (lss - Ns) / 180.0);
  lambdam := 180.0 * my_atan(y, x) / Pi;
  lambdam := lambdam + Ns;
  betam := 180.0 * (ArcSin(sin(Pi * (lss - Ns) / 180.0) * sin(Pi * 5.145396 / 180.0))) / Pi;
  elliptic_to_equator(lambdam, betam, alpham, deltam);
end;

end.
