//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include <string>
#define finally
#ifdef finally
    #include "poland.cpp"
    #include "longnums.cpp"
#endif
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
bool isRes = false, isResL = false;
UnicodeString memory = "0", memoryL;
UnicodeString argA = "0", whatToDo = "";
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------

string UStrToStr (UnicodeString A)
{
    wchar_t * a = A.c_str();
    string res = "";
    for (int i = 0; i < A.Length(); i++)
        res.push_back(a[i]);
    return res;
}

//---------------------------------------------------------------------------

UnicodeString StrToUStr (string a)
{
    UnicodeString res = "";
    for (int i = 0; i < a.length(); i++)
        res += a[i];
    return res;
}

//---------------------------------------------------------------------------

string reverse (string s)
{
    string res = "";
    for (int i = s.length()-1; i >= 0; i--)
        res += s[i];
    return res;
}

//---------------------------------------------------------------------------

void __fastcall TForm1::N4Click(TObject *Sender)
{
    N4->Checked = true;
    N3->Checked = false;
    Panel1->Visible = false;
    Panel2->Visible = true;
    ClientWidth = 345;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N3Click(TObject *Sender)
{
    N3->Checked = true;
    N4->Checked = false;
    Panel1->Visible = true;
    Panel2->Visible = false;
    ClientWidth = 514;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
    if (Edit1->Text == "ArcCtg from Infinity" ||
        Edit1->Text == "Ctg is Infinity!" ||
        Edit1->Text == "Zero root from number!" ||
        Edit1->Text == "Division by zero!"||
        Edit1->Text == "Not enough parametres!"||
        Edit1->Text == "Complex number is result of root!"||
        Edit1->Text == "Tg is Infinity!")
        {
            Edit1->Text = "0";
            Edit8->Text = "";
        }
    Edit6->Text = "Result will appear here!";
    UnicodeString name = ((TButton *) Sender)->Caption;
    string edit1 = UStrToStr(Edit1->Text);
    if (isRes) {
        isRes = false;
        if ((is_func(UStrToStr(name)) && name != "root" && name != "^")
            || name == "(" || name == ")")
                Edit1->Text = "0";
    }
    bool canEdit = true;
    string last = "";
    if (Edit1->Text != "0")
        last += Edit1->Text.c_str()[Edit1->Text.Length()-1];
    if (last != "") {
        if (is_op(UStrToStr(name)) || name == "root" || name == "^")
            if (!((last[0] >= '0' && last[0] <= '9') || (last == ")")
                || (is_unary(UStrToStr(name)) && last == "(") || last == "!"))
                    canEdit = false;
        if (is_func(UStrToStr(name)) && name != "root" && name != "^")
            if (last == "." || (last[0] >= '0' && last[0] <= '9') || last == "!" || last == ")" || (last[0] >= 'a' && last[0] <= 'z'))
                canEdit = false;
        if (name == ".")
        {
            int l = Edit1->Text.Length() - 1, couComas = 0;
            while (l >= 0 && ((edit1[l] >= '0' && edit1[l] <= '9') || edit1[l] == '.'))
            {
                l--;
                if (edit1[l] == '.')
                    couComas++;
            }
            if (couComas == 1)
                canEdit = false;
            if (!(last[0] >= '0' && last[0] <= '9'))
                canEdit = false;
        }
        if (name == "(")
            if ((last[0] >= '0' && last[0] <= '9') || last == ")" || last == "!" || last == ".")
                canEdit = false;
        if (name.c_str()[0] >= '0' && name.c_str()[0] <= '9')
            if (last == "!" || last == ")" || (last[0] >= 'a' && last[0] <= 'z'))
                canEdit = false;
        if (name == ")")
            if (!(last == ")" || last == "!" || (last[0] >= '0' && last[0] <= '9') || last == "("))
                canEdit = false;
    }
    else
        if (is_op(UStrToStr(name)) && !is_unary(UStrToStr(name)) || name == "root" || name == "^")
            canEdit = false;
    if (canEdit) {
        if (name == "(") {
            if (Button30->Caption == ""){
                Button30->Caption = "(=1";
            }
            else
            {
                int n = 0;
                wchar_t * a = Button30->Caption.c_str();
                for (int i = 2; i < Button30->Caption.Length(); i++) {
                    n = n * 10 + a[i] - '0';
                }
                Button30->Caption = "(=" + IntToStr(n+1);
            }
        }
        if (name == ")") {
            if (Button30->Caption != "") {
                int n = 0;
                wchar_t * a = Button30->Caption.c_str();
                for (int i = 2; i < Button30->Caption.Length(); i++) {
                    n = n * 10 + a[i] - '0';
                }
                n--;
                if (n == 0) {
                    Button30->Caption = "";
                }
                else
                    Button30->Caption = "(=" + IntToStr(n);
            }
            else
                canEdit = false;
        }
        if (canEdit) {
            if (name == ")" && last == "(")
                Edit1->Text = Edit1->Text + "0";
            if (Edit1->Text == "0")
                Edit1->Text = "";
            Edit1->Text = Edit1->Text + name;
        }
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button20Click(TObject *Sender)
{
    Edit1->Text = "0";
    Edit8->Text = "";
    Edit6->Text = "Result will appear here!";
    Button30->Caption = "";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button21Click(TObject *Sender)
{
    Edit1->Text = "0";
    Edit6->Text = "Result will appear here!";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button22Click(TObject *Sender)
{
    memory = Edit1->Text;
    Edit1->Text = "0";
    Edit2->Text = "M";
    Edit6->Text = "Result will appear here!";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button23Click(TObject *Sender)
{
    if (Edit2->Text == "M")
    {
        if (Edit1->Text == "0")
            Edit1->Text = "";
        Edit1->Text = Edit1->Text + memory;
        Edit6->Text = "Result will appear here!";
    }
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button16Click(TObject *Sender)
{
    isRes = true;
    Button30->Caption = "";
    pair<double, string> Res = calc(UStrToStr(Edit1->Text));
    if (Res.first < 10e-10)
        Res.first = 0;
    if (Res.second != "OK") {
        Edit1->Text = StrToUStr(Res.second);
        Edit8->Text = "E";
        return;
    }
    UnicodeString res = FloatToStr(Res.first);
    string a = "";
    for (int i = 0; i < res.Length(); i++)
        if (res.c_str()[i] == ',')
            a += ".";
        else
            a += res.c_str()[i];
    Edit6->Text = Edit1->Text + "=";
    Edit1->Text = StrToUStr(a);
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button19Click(TObject *Sender)
{
    string s = "";
    Edit6->Text = "Result will appear here!";
    s += Edit1->Text.c_str()[Edit1->Text.Length() - 1];
    Edit1->Text = Edit1->Text.Delete(Edit1->Text.Length(), 1);
    if (s[0] >= 'a' && s[0] <= 'z') {
        while (!is_func(reverse(s)) && Edit1->Text != "")
        {
            s += Edit1->Text.c_str()[Edit1->Text.Length() - 1];
            Edit1->Text = Edit1->Text.Delete(Edit1->Text.Length(), 1);
        }
    }
    if (s == ")") {
        if (Button30->Caption == "")
            Button30->Caption = "(=1";
        else
        {
            int n = 0;
            wchar_t * a = Button30->Caption.c_str();
            for (int i = 2; i < Button30->Caption.Length(); i++)
                n = n * 10 + a[i] - '0';
            Button30->Caption = "(=" + IntToStr(n+1);
        }
    }
    if (s == "(")
    {
        int n = 0;
        wchar_t * a = Button30->Caption.c_str();
        for (int i = 2; i < Button30->Caption.Length(); i++)
            n = n * 10 + a[i] - '0';
        n--;
        if (n == 0) {
            Button30->Caption = "";
        }
        else
            Button30->Caption = "(=" + IntToStr(n);
    }
    if (Edit1->Text == "")
        Edit1->Text = "0";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button40Click(TObject *Sender)
{
    if (Edit3->Text == "Division by zero!" ||
        Edit3->Text == "Can't raise into float power!" ||
        Edit3->Text == "Power is too big!" ||
        Edit3->Text == "Complex number is result of root!"||
        Edit3->Text == "Too long factorial!")
        {
            Edit3->Text = "0";
            Edit8->Text = "";
            Edit7->Text = "";
        }
    if (Edit5->Text.c_str()[Edit5->Text.Length() - 1] == '=')
        Edit5->Text = "Result will appear here!";
    UnicodeString name = ((TButton *) Sender)->Caption;
    string edit1 = UStrToStr(Edit1->Text);
    if (isResL) {
        isResL = false;
    }
    if (name != ".")
    {
        if (Edit3->Text == "0")
            Edit3->Text = "";
        Edit3->Text = Edit3->Text + name;
    }
    else
    {
        bool isPoint = false;
        for (int i = 0; i < Edit3->Text.Length(); i++)
            if (Edit3->Text.c_str()[i] == '.')
                isPoint = true;
        if (!isPoint)
            Edit3->Text = Edit3->Text + name;
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button58Click(TObject *Sender)
{
    Edit3->Text = "0";
    Edit7->Text = "";
    if (Edit5->Text.c_str()[Edit5->Text.Length()-1] == '=')
        Edit5->Text = "Result will appear here!";
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button59Click(TObject *Sender)
{
    Edit3->Text = "0";
    Edit5->Text = "Result will appear here!";
    argA = "0";
    whatToDo = "";
    Edit7->Text = "";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button56Click(TObject *Sender)
{
    memoryL = Edit3->Text;
    Edit3->Text = "0";
    Edit4->Text = "M";
    Edit6->Text = "Result will appear here!";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button57Click(TObject *Sender)
{
    if (Edit4->Text == "M")
        Edit3->Text = memoryL;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button50Click(TObject *Sender)
{
    UnicodeString name = ((TButton *) Sender)->Caption;
    if (is_unary(UStrToStr(name)) && Edit3->Text == "0") {
        Edit3->Text = name;
        return;
    }
    if (Edit5->Text == "Result will appear here!")
    {
        Edit5->Text = "(" + Edit3->Text + ")" + name;
    }
    else
    {
        if (Edit5->Text.c_str()[Edit5->Text.Length() - 1] == '=')
        {
            Edit5->Text = Edit3->Text;
            Edit5->Text = "(" + Edit3->Text + ")" + name;
        }
        else
        {
            if (Edit3->Text == "0")
            {
                Edit5->Text = Edit5->Text.Delete(Edit5->Text.Length(), 1);
                Edit5->Text = "(" + Edit3->Text + ")" + name;
            }
            else
            {
                Button60Click(Sender);
                Edit5->Text = "(" + Edit3->Text + ")" + name;
            }
        }
    }
    argA = Edit3->Text;
    whatToDo = name;
    Edit3->Text = "0";
    isResL = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button60Click(TObject *Sender)
{
    if (whatToDo != "")
    {
        Edit5->Text = Edit5->Text + "(" + Edit3->Text + ")" + "=";
        TLong A, B, res;
        A.Input(UStrToStr(argA));
        B.Input(UStrToStr(Edit3->Text));
        if (whatToDo == "+") {
            res = A + B;
            Edit3->Text = StrToUStr(res.Output());
        }
        if (whatToDo == "-") {
            res = A - B;
            Edit3->Text = StrToUStr(res.Output());
        }
        if (whatToDo == "*") {
            res = res.Multi(A, B);
            Edit3->Text = StrToUStr(res.Output());
        }
        if (whatToDo == "/") {
            if (B.Comp_0()) {
                Edit3->Text = "Division by zero!";
                Edit5->Text = "Result will be here!";
                Edit7->Text = "E";
                return;
            }
            else
            {
                res = A / B;
                Edit3->Text = StrToUStr(res.Output());
            }
        }
        if (whatToDo == "^") {
            bool isPoint = false;
            for (int i = 0; i < Edit3->Text.Length(); i++)
                if (Edit3->Text.c_str()[i] == '.')
                    isPoint = true;
            if (isPoint) {
                Edit3->Text = "Can't raise into float power!";
                Edit5->Text = "Result will be here!";
                Edit7->Text = "E";
                return;
            }
            else
            {
                if (Edit3->Text.Length() > 9)
                {
                    Edit3->Text = "Power is too big!";
                    Edit7->Text = "E";
                    Edit5->Text = "Result will be here!";
                    return;
                }
                else
                {
                    int b = StrToInt(Edit3->Text);
                    res = A ^ b;
                    res.point = A.point * b;
                    Edit3->Text = StrToUStr(res.Output());
                    if (Edit3->Text.c_str()[Edit3->Text.Length() - 1] == '.')
                        Edit3->Text = Edit3->Text.Delete(Edit3->Text.Length(), 1);
                }
            }
        }
        isResL = true;
        argA = Edit3->Text;
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button54Click(TObject *Sender)
{
    if (Edit3->Text.c_str()[0] == '-') {
        Edit3->Text = "Complex number is result of root!";
        return;
    }
    if (Edit3->Text != "0") {
        TLong A;
        A.Input(UStrToStr(Edit3->Text));
        TLong res = A.Root(A, 50);
        Edit5->Text = "sqrt(" + Edit3->Text + ")=";
        string Res = res.Output();
        int cou = 0;
        while (Res[Res.length() - cou - 1] == '0')
            cou++;
        if (Res[Res.length() - cou - 1] == '.')
            cou++;
        string rres = "";
        for (int i = 0; i < Res.length() - cou; i++)
            rres.push_back(Res[i]);
        Edit3->Text = StrToUStr(rres);
        isResL = true;
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N5Click(TObject *Sender)
{
    ShowMessage("It's an easy calculator!");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N6Click(TObject *Sender)
{
    ShowMessage("Made by Kojuhivskij Vitalij\n18.09.2011\nAll rights reserved.");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::NumberPI1Click(TObject *Sender)
{
    if (N4->Checked) {
        Edit3->Text = "3.1415926535897932384626433832795";
    }
    else
    {
        char last;
        if (Edit1->Text != "0")
            last = Edit1->Text.c_str()[Edit1->Text.Length()-1];
        else
            last = ' ';
        if (last != '!' && last != ')' && !(last >= '0' && last <= '9') && !(last >= 'a' && last <= 'z'))
        {
            if (Edit1->Text == "0")
                Edit1->Text = "";
            Edit1->Text = Edit1->Text + "3.1415926535";
        }
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Numbere1Click(TObject *Sender)
{
    if (N4->Checked) {
        Edit3->Text = "2.71828182845905";
    }
    else
    {
        char last;
        if (Edit1->Text != "0")
            last = Edit1->Text.c_str()[Edit1->Text.Length()-1];
        else
            last = ' ';
        if (last != '!' && last != ')' && !(last >= '0' && last <= '9') && !(last >= 'a' && last <= 'z'))
        {
            if (Edit1->Text == "0")
                Edit1->Text = "";
            Edit1->Text = Edit1->Text + "2.71828182845905";
        }
    }
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button62Click(TObject *Sender)
{
    Edit2->Text = "";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button63Click(TObject *Sender)
{
    Edit2->Text = "M";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button64Click(TObject *Sender)
{
    memory = "0";
    Edit2->Text = "";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button66Click(TObject *Sender)
{
    Edit4->Text = "M";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button67Click(TObject *Sender)
{
    Edit4->Text = "";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button68Click(TObject *Sender)
{
    memoryL = "0";
    Edit4->Text = "";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button69Click(TObject *Sender)
{
    int b = int(StrToFloat(Edit3->Text));
    if (b > 100)
    {
        Edit3->Text = "Too long factorial!";
        return;
    }
    string a = "1";
    TLong A;
    A.Input(a);
    for (int i = 1; i <= b; i++)
        A.HalfLongMulti(i);
    Edit5->Text = Edit3->Text + "!=";
    Edit3->Text = StrToUStr(A.Output());
    isResL = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button70Click(TObject *Sender)
{
    Edit3->Text = Edit3->Text.Delete(Edit3->Text.Length(), 1);
    if (Edit3->Text == "")
        Edit3->Text = "0";
}
//---------------------------------------------------------------------------

