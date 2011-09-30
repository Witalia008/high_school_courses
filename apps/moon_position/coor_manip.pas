unit coor_manip;

interface

uses math, math_ext;

procedure elliptic_to_equator(lambda, beta: real; var alpha, delta: real);
procedure degree_decomp(d: real; var dd, mm, ss: integer);

implementation

procedure elliptic_to_equator(lambda, beta: real; var alpha, delta: real);
var
  epsilon, x, y: real;
begin
  lambda := Pi * lambda / 180;
  beta := Pi * beta / 180;
  epsilon := Pi * 23.441884 / 180;
  delta := ArcSin(sin(beta) * cos(epsilon) + cos(beta) * sin(epsilon) * sin
      (lambda));
  y := sin(lambda) * cos(epsilon) - tan(beta) * sin(epsilon);
  x := cos(lambda);
  alpha := my_atan(y, x) / 15.0;
  alpha := 180 * (alpha) / Pi;
  delta := 180 * (delta) / Pi;
end;

procedure degree_decomp(d: real; var dd, mm, ss: integer);
var
  fl: boolean;
begin
  fl := false;
  if (d < 0) then
  begin
    d := -d;
    fl := true;
  end;
  dd := trunc(d);
  d := d - trunc(d);
  d := d * 60;
  mm := trunc(d);
  d := d - trunc(d);
  d := d * 60;
  ss := trunc(d);
  if (fl) then
    dd := -dd;
end;

end.
