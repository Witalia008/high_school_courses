unit time;

interface

type
  Tdt = record
    year: integer;
    month: integer;
    day: integer;
    hour: integer;
    min: integer;
    sec: integer;
  end;

const
  month_days: array [0 .. 11, 0 .. 1] of integer = ((31, 31), (28, 29),
    (31, 31), (30, 30), (31, 31), (30, 30), (31, 31), (31, 31), (30, 30),
    (31, 31), (30, 30), (31, 31));

implementation

end.
