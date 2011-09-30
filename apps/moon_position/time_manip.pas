unit time_manip;

interface

uses time;

function is_leap_year(year: integer): integer;
procedure add_secs(var t: tdt; s: integer);
procedure UT_ET(ut: tdt; var et: tdt);
function days_from_Jan00(now: tdt): real;
procedure hour_decomp(h: double; var hh, mm, ss: integer);

implementation

function is_leap_year(year: integer): integer;
begin
  if (year mod 400 = 0) or ((year mod 100 <> 0) and (year mod 4 = 0)) then
    is_leap_year := 1
  else
    is_leap_year := 0;
end;

procedure add_secs(var t: tdt; s: integer);
begin
  t.sec := t.sec + s;
  if t.sec >= 60 then
  begin
    t.min := t.min + t.sec div 60;
    t.sec := t.sec mod 60;
    if t.min >= 60 then
    begin
      t.hour := t.hour + t.min div 60;
      t.min := t.min mod 60;
      if t.hour >= 24 then
      begin
        t.day := t.day + t.hour div 24;
        t.hour := t.hour mod 24;
        if t.day >= month_days[t.month][is_leap_year(t.year + 1900)] then
        begin
          inc(t.month);
          t.day := 1;
          if t.month = 12 then
          begin
            t.month := 0;
            inc(t.year);
          end;
        end;
      end;
    end;
  end;
end;

procedure UT_ET(ut: tdt; var et: tdt);
var
  delta_t, y, u, t: real;
  year: integer;
begin
  year := ut.year + 1900;
  y := year + (ut.month + 1 - 0.5) / 12.0;
  if (y < -500) then
  begin
    u := (y - 1820.0) / 100.0;
    delta_t := -20 + 32 * u * u;
  end
  else if (y < 500) then
  begin
    u := y / 100.0;
    delta_t := 10583.6 - 1014.41 * u + 33.78311 * u * u - 5.952053 * u * u *
      u - 0.1798452 * u * u * u * u + 0.022174192 * u * u * u * u * u +
      0.0090316521 * u * u * u * u * u * u;
  end
  else if (y < 1600) then
  begin
    u := (y - 1000) / 100.0;
    delta_t := 1574.2 - 556.01 * u + 71.23472 * u * u + 0.319781 * u * u * u -
      0.8503463 * u * u * u * u - 0.005050998 * u * u * u * u * u +
      0.0083572073 * u * u * u * u * u * u;
  end
  else if (y < 1700) then
  begin
    t := y - 1600;
    delta_t := 120 - 0.9808 * t - 0.01532 * t * t + t * t * t / 7129;
  end
  else if (y < 1800) then
  begin
    t := y - 1700;
    delta_t := 8.83 + 0.1603 * t - 0.0059285 * t * t + 0.00013336 * t * t * t -
      t * t * t * t / 1174000;
  end
  else if (y < 1860) then
  begin
    t := y - 1800;
    delta_t := 13.72 - 0.332447 * t + 0.0068612 * t * t + 0.0041116 * t * t *
      t - 0.00037436 * t * t * t * t + 0.0000121272 * t * t * t * t * t -
      0.0000001699 * t * t * t * t * t * t + 0.000000000875 * t * t * t * t *
      t * t * t;
  end
  else if (y < 1900) then
  begin
    t := y - 1860;
    delta_t := 7.62 + 0.5737 * t - 0.251754 * t * t + 0.01680668 * t * t * t -
      0.0004473624 * t * t * t * t + t * t * t * t * t / 233174;
  end
  else if (y < 1920) then
  begin
    t := y - 1900;
    delta_t := -2.79 + 1.494119 * t - 0.0598939 * t * t + 0.0061966 * t * t *
      t - 0.000197 * t * t * t * t;
  end
  else if (y < 1941) then
  begin
    t := y - 1920;
    delta_t := 21.20 + 0.84493 * t - 0.076100 * t * t + 0.0020936 * t * t * t;
  end
  else if (y < 1961) then
  begin
    t := y - 1950;
    delta_t := 29.07 + 0.407 * t - t * t / 233 + t * t * t / 2547;
  end
  else if (y < 1986) then
  begin
    t := y - 1975;
    delta_t := 45.45 + 1.067 * t - t * t / 260 - t * t * t / 718;
  end
  else if (y < 2005) then
  begin
    t := y - 2000;
    delta_t := 63.86 + 0.3345 * t - 0.060374 * t * t + 0.0017275 * t * t * t +
      0.000651814 * t * t * t * t + 0.00002373599 * t * t * t * t * t;
  end
  else if (y < 2050) then
  begin
    t := y - 2000;
    delta_t := 62.92 + 0.32217 * t + 0.005589 * t * t;
  end
  else if (y < 2150) then
  begin
    delta_t := -20 + 32 * ((y - 1820) / 100) * ((y - 1820) / 100) - 0.5628 *
      (2150 - y);
  end
  else
  begin
    u := (y - 1820) / 100.0;
    delta_t := -20 + 32 * u * u;
  end;
  if (delta_t - trunc(delta_t) < 0.5) then
    delta_t := trunc(delta_t)
  else
    delta_t := trunc(delta_t) + 1;
  et := ut;
  add_secs(et, trunc(delta_t));
end;

function days_from_Jan00(now: tdt): real;
var
  i, st, year: integer;
  res: real;
begin
  res := 0;
  year := now.year + 1900;
  st := 1980;
  if (year >= st) then
  begin
    for i := st to year - 1 do
      res := res + 365 + is_leap_year(i);
  end
  else
  begin
    for i := year to st - 1 do
      res := res - (365 + is_leap_year(i));
  end;
  for i := 0 to now.month - 1 do
    res := res + month_days[i][is_leap_year(year)];
  res := res + now.day;
  res := res + ((now.sec / 60.0 + now.min) / 60.0 + now.hour) / 24.0;
  days_from_Jan00 := res;
end;

procedure hour_decomp(h: double; var hh, mm, ss: integer);
begin
  hh := trunc(h);
  h := h - int(h);
  h := h * 60;
  mm := trunc(h);
  h := h - int(h);
  h := h * 60;
  ss := trunc(h);
end;

end.
