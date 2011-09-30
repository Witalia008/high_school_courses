unit math_ext;

interface

uses math;

function to360(a: real): real;
function my_atan(y, x: real): real;

implementation

function to360(a: real): real;
begin
  result := a;
  if (result > 360) then
    result := result - trunc(result / 360) * 360;
  if (result < 0) then
    result := result + trunc(- result / 360) * 360 + 360;
end;

function my_atan(y, x: real): real;
var
  res, rez: real;
begin
  res := ArcTan(y / x);
  if (y > 0) and (x > 0) and (not(res >= 0) and (res <= Pi / 2)) then
  begin
    rez := res + Pi;
    if (not(rez >= 0) and (rez <= Pi / 2)) then
    begin
      rez := rez + Pi;
      if (not(rez >= 0) and (rez <= Pi / 2)) then
      begin
        rez := res - Pi;
        if (not(rez >= 0) and (rez <= Pi / 2)) then
          rez := rez - Pi;
      end;
    end;
    res := rez;
  end;
  if (y > 0) and (x < 0) and (not(res >= Pi / 2) and (res <= Pi)) then
  begin
    rez := res + Pi;
    if (not(rez >= Pi / 2) and (rez <= Pi)) then
    begin
      rez := rez + Pi;
      if (not(rez >= Pi / 2) and (rez <= Pi)) then
      begin
        rez := res - Pi;
        if (not(rez >= Pi / 2) and (rez <= Pi)) then
          rez := rez - Pi;
      end;
    end;
    res := rez;
  end;
  if (y < 0) and (x < 0) and (not(res >= Pi) and (res <= Pi + Pi / 2)) then
  begin
    rez := res + Pi;
    if (not(rez >= Pi) and (rez <= Pi + Pi / 2)) then
    begin
      rez := rez + Pi;
      if (not(rez >= Pi) and (rez <= Pi + Pi / 2)) then
      begin
        rez := res - Pi;
        if (not(rez >= Pi) and (rez <= Pi + Pi / 2)) then
          rez := rez - Pi;
      end;
    end;
    res := rez;
  end;
  if (y < 0) and (x > 0) and (not(res >= Pi + Pi / 2) and (res <= 2 * Pi)) then
  begin
    rez := res + Pi;
    if (not(rez >= Pi + Pi / 2.0) and (rez <= 2 * Pi)) then
    begin
      rez := rez + Pi;
      if (not(rez >= Pi + Pi / 2.0) and (rez <= 2 * Pi)) then
      begin
        rez := res - Pi;
        if (not(rez >= Pi + Pi / 2.0) and (rez <= 2 * Pi)) then
          rez := rez - Pi;
      end;
    end;
    res := rez;
  end;
  result := res;
end;

end.
