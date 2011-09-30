unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    width1, height1, minecou : shortint;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  if strtoint(Edit1.Text) < 10 then
    Edit1.Text := '10';
  if strtoint(Edit1.Text) > 40 then
    Edit1.Text := '40';
  if strtoint(Edit2.Text) < 10 then
    Edit2.Text := '10';
  if strtoint(Edit2.Text) > 40 then
    Edit2.Text := '40';
  if StrToInt(Edit3.Text) > StrToInt(Edit1.Text)*StrToInt(Edit2.Text) div 4 then
    Edit3.Text := IntToStr(StrToInt(Edit1.Text)*StrToInt(Edit2.Text) div 4);
  minecou := StrToInt(form2.Edit3.Text);
  width1 := strtoint(form2.edit2.text);
  height1 := strtoint(form2.edit1.text);
  form2.Visible := false;
end;

end.
