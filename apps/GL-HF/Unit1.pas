unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ShellApi, pngimage, registry;

const
  SC_UDF = $EFF0;
  LLKHF_ALTDOWN = KF_ALTDOWN shr 8;
  WH_KEYBOARD_LL = 13;

var
  HookHandle: hHook = 0;

type
  KBDLLHOOKSTRUCT = record
    vkCode: DWORD;
    scanCode: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: Pointer;
  end;

  PKBDLLHOOKSTRUCT = ^KBDLLHOOKSTRUCT;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Image1: TImage;
    Timer1: TTimer;
    Image2: TImage;
    Image3: TImage;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure WMSysCommand(var Message: TMessage); message WM_SYSCOMMAND;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function KeyboardProc(nCode: integer; wParam: longint;
  lParam: longint): integer; stdcall;
var
  KeyStroke: boolean;
  p: PKBDLLHOOKSTRUCT;
begin
  KeyStroke := false;
  if (nCode = HC_ACTION) then
  begin
    case wParam of
      WM_KEYDOWN, WM_SYSKEYDOWN, WM_KEYUP, WM_SYSKEYUP:
        begin
          p := PKBDLLHOOKSTRUCT(lParam);
          KeyStroke := ((p^.vkCode = VK_LWIN) or (p^.vkCode = VK_RWIN)) or
            ((p^.vkCode = VK_TAB) and ((p^.flags and LLKHF_ALTDOWN) <> 0)) or
            ((p^.vkCode = VK_ESCAPE) and ((p^.flags and LLKHF_ALTDOWN) <> 0))
            or ((p^.vkCode = VK_ESCAPE) and
              ((GetKeyState(VK_CONTROL) and $8000) <> 0)) or
            ((p^.vkCode = VK_F4) and ((p^.flags and LLKHF_ALTDOWN) <> 0));
          // ( (p^.vkCode = VK_DELETE) and ( (p^.flags and LLKHF_ALTDOWN) <> 0 ) and
          // ( (GetKeyState(VK_CONTROL) and $8000) <> 0));
        end;
    end;
  end;
  if KeyStroke then
    result := 1
  else
    result := CallNextHookEx(0, nCode, wParam, lParam);
end;

procedure Hook(lRun: boolean); export; stdcall;
begin
  if lRun then
    HookHandle := SetWindowsHookEx(WH_KEYBOARD_LL, @KeyboardProc, HInstance, 0)
  else
  begin
    UnhookWindowsHookEx(HookHandle);
    HookHandle := 0;
  end;
end;

procedure TForm1.WMSysCommand(var Message: TMessage);
begin
  if Message.wParam <> SC_CLOSE then
  begin
    inherited;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  MessageBox(0, ' ,   !'#10#13'  !=)',
    'Info', MB_ICONINFORMATION);
  close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  MessageBox(0, 'ͳ,     ...   .', 'Info',
    MB_ICONINFORMATION);
end;

procedure TForm1.FormActivate(Sender: TObject);
var
  hTaskBar: THandle;
begin
  ShowWindow(Application.handle, SW_HIDE);
  Form1.Height := screen.Height;
  Form1.Width := screen.Width;
  // SystemParametersInfo(SPI_SCREENSAVERRUNNING, 1, 0, 0);
  hTaskBar := FindWindow('Shell_TrayWnd', Nil);
  ShowWindow(hTaskBar, SW_HIDE);
  hTaskBar := FindWindowEx(hTaskBar, HWND(0), 'Button', nil);
  ShowWindow(hTaskBar, SW_HIDE);
  hTaskBar := FindWindow('Button', nil);
  ShowWindow(hTaskBar, SW_HIDE);
  ShowWindow(FindWindow(nil, 'Program Manager'), SW_HIDE);
  { hTaskBar := FindWindow(nil, '  Windows');
    if hTaskBar = 0 then
    ShellExecute(0, 'open', 'taskmgr.exe', nil, nil, SW_HIDE)
    else
    ShowWindow(hTaskBar, SW_HIDE); }
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  hTaskBar: THandle;
begin
  ShowWindow(Application.handle, SW_SHOW);
  // SystemParametersInfo(SPI_SCREENSAVERRUNNING, 0, 0, 0);
  hTaskBar := FindWindow('Shell_TrayWnd', Nil);
  ShowWindow(hTaskBar, SW_SHOW);
  hTaskBar := FindWindowEx(hTaskBar, HWND(0), 'Button', nil);
  ShowWindow(hTaskBar, SW_SHOW);
  hTaskBar := FindWindow('Button', nil);
  ShowWindow(hTaskBar, SW_SHOW);
  ShowWindow(FindWindow(nil, 'Program Manager'), SW_SHOW);
  { hTaskBar := FindWindow(nil, '  Windows');
    ShellExecute(0, 'open', 'taskmgr.exe', nil, nil, SW_SHOW);
    ShowWindow(hTaskBar, SW_SHOWNORMAL); }
  Hook(false);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ClientWidth := screen.Width;
  ClientHeight := screen.Height;
  Image1.Left := screen.Width div 2 - 300;
  Image1.Top := screen.Height div 2 - 100;
  Image2.Left := 0;
  Image2.Top := 0;
  Image2.Width := ClientWidth;
  Image2.Height := ClientHeight;
  Image3.Left := 0;
  Image3.Top := 0;
  Image3.Width := ClientWidth;
  Image3.Height := ClientHeight;
  if (screen.Width > 1200) then
    Image2.Visible := true
  else
    Image3.Visible := true;
  Label2.Left := ClientWidth - 10 - Label2.Width;
  Label2.Top := ClientHeight - 10 - Label2.Height;
  Label1.Left := screen.Width div 2 - 150;
  Label1.Top := screen.Height div 2 - 100;
  Button1.Left := screen.Width div 2 - 300;
  Button1.Top := screen.Height div 2 + 50;
  Button2.Left := screen.Width div 2;
  Button2.Top := screen.Height div 2 + 50;
  Hook(true);
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  h: HWND;
  curs: TRect;
begin
  // Form1.FormStyle := fsStayOnTop;
  h := FindWindow('Progman', nil);
  ShowWindow(h, SW_HIDE);
  h := FindWindow('Shell_TrayWnd', nil);
  ShowWindow(h, SW_HIDE);
  h := FindWindow(nil, ' ');
  ShowWindow(h, SW_HIDE);
  h := FindWindow(nil, ' ');
  ShowWindow(h, SW_HIDE);
  h := FindWindow(nil, '  Windows');
  ShowWindow(h, SW_HIDE);
  { SetWindowPos(handle, HWND_TOPMOST, Left, Top, Width, Height,
    SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOSIZE);
    curs := Rect(Form1.Left + 0, Form1.Top + 0, Form1.Left + Form1.Width - 0,
    Form1.Top + Form1.Height - 0);
    ClipCursor(@curs); }
end;

end.
