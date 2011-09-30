#include <stdio.h>
#include <cstdlib>
#include <string>
#include <vector>
#include <math.h>
#include <fstream>

using namespace std;

#define INF 10e+19

bool is_unary (string a)
{
    return (a == "-" || a == "+");
}

bool is_op (string a)
{
    return (a == "+" || a == "-" || a == "/" || a == "*" || a == "%" || a == "!");
}

bool is_func(string a)
{
    return (a == "asin" || a == "acos" || a == "atg"  || a == "actg"
            || a == "tg" || a == "ctg" || a == "sin" || a == "cos"
            || a == "root" || a == "ln" || a == "lg" || a == "exp" || a == "^" || a == "abs");
}

int prior (string op)
{
    if (op[0] < 0)
        return (op[0] == -'+' || op[0] == -'-') ? 4 : -1;
    else
        return (op == "+" || op == "-") ? 1 :
                (op == "/" || op == "*" || op == "%") ? 2 :
                (op == "root" || op == "exp" || op == "lg" || op == "ln" ||
                op == "sin" || op == "cos" || op == "tg" || op == "ctg" ||
                op == "asin" || op == "acos" || op == "atg"  || op == "actg" || op == "!" || op == "abs") ? 3 : -1;
}

bool one_arg (string op)
{
    return (op == "exp" || op == "lg" || op == "ln" ||
            op == "sin" || op == "cos" || op == "tg" || op == "ctg" ||
            op == "asin" || op == "acos" || op == "atg"  || op == "actg" ||
            op == "!" || op == "abs");
}

string process_op (vector<double> & st, string op)
{
    if (st.empty()) {
        return "Not enough parametres!";
    }
    if (op[0] < 0)
    {
        double l = st.back(); st.pop_back();
        switch (-op[0])
        {
            case '+': st.push_back(l); break;
            case '-': st.push_back(-l); break;
        }
    }
    else
    {
        if (!one_arg(op))
        {
            double a = st.back(); st.pop_back();
            if (st.empty()) {
                return "Not enough parametres!";
            }
            double b = st.back(); st.pop_back();
            if (op == "+") st.push_back(a + b);
            if (op == "-") st.push_back(b - a);
            if (op == "*") st.push_back(a * b);
            if (op == "/")
                if (a != 0)
                    st.push_back(b / a);
                else
                    return "Division by zero!";
            if (op == "%") st.push_back(b / 100 * a);
            if (op == "^") st.push_back(pow(b, a));
            if (op == "root")
                if (b != 0)
                {
                    if (int(b)%2 == 0 && a < 0)
                        return "Complex number is result of root!";
                    else
                        st.push_back(pow(a, 1 / b));
                }
                else
                    return "Zero root from number!";
        }
        else
        {
            double a = st.back(); st.pop_back();
            if (op == "abs") st.push_back((a < 0) ? (-a) : (a));
            if (op == "lg") st.push_back(log10(a));
            if (op == "ln") st.push_back(log(a));
            if (op == "exp") st.push_back(exp(a));
            if (op == "sin") st.push_back(sin(a));
            if (op == "cos") st.push_back(cos(a));
            if (op == "tg")
                if (a - 3.1415926535 / 2 > -0.01 && a - M_PI < 0.01)
                    return "Tg is Infinity!";
                else
                    st.push_back(tan(a));
            if (op == "ctg")
                if (tan(a) < 10e-3)
                    st.push_back(1 / tan(a));
                else
                    return "Ctg is Infinity!";
            if (op == "asin") st.push_back(asin(a));
            if (op == "acos") st.push_back(acos(a));
            if (op == "atg") st.push_back(atan(a));
            if (op == "actg")
                if (a != 0)
                    st.push_back(atan(1 / a));
                else
                    return "ArcCtg from Infinity";
            if (op == "!")
            {
                int res = 1;
                if (int(a) > 100)
                    return "Too long number in factorial!";
                for (int i = 2; i <= int(a); i++)
                    res *= i;
                st.push_back(res);
            }
        }
    }
    return "OK";
}

double StrToFloat (string & s)
{
    double a = 0, b = 0;
    size_t i = 0;
    while (i < s.length() && s[i] != '.')
        a = a * 10 + s[i++]-'0';
    if (s[i] == '.')
    {
        size_t j = s.length()-1;
        while (j != i)
            b = (b + s[j--] - '0') / 10;
    }
    return a + b;
}

pair<double, string> calc (string s)
{
    pair<double, string> result;
    result.first = 0;
    result.second = "OK";
    if (s == "")
        return result;
    bool may_unary = true;
    vector<string> op;
    vector<double> st;
    for (size_t i = 0; i < s.size(); i++)
    {
        string operand = "";
        operand.push_back(s[i]);
        if (operand == "(")
        {
            op.push_back(operand);
            may_unary = true;
        } else
            if (operand == ")")
            {
                while (op.back() != "(")
                {
                    result.second = process_op(st, op.back());
                    op.pop_back();
                    if (result.second != "OK")
                        return result;
                }
                op.pop_back();
                may_unary = false;
            } else
            {
                if ((operand[0] < '0' || operand[0] > '9') && !is_op(operand))
                {
                    i++;
                    while (i < s.length() && s[i] >= 'a' && s[i] <= 'z')
                        operand.push_back(s[i++]);
                    i--;
                }
                if (is_op(operand) || is_func(operand))
                {
                    if (may_unary && is_unary(operand)) operand[0] *= -1;
                    while (!op.empty() && op.back() != "(" && prior(op.back()) >= prior(operand))
                    {
                        result.second = process_op(st, op.back());
                        op.pop_back();
                        if (result.second != "OK")
                            return result;
                    }
                    op.push_back(operand);
                    may_unary = true;
                } else
                {
                    i++;
                    while (i < s.length() && (s[i] >= '0' && s[i] <= '9' || s[i] == '.'))
                        operand += s[i++];
                    i--;
                    st.push_back(StrToFloat(operand));
                    may_unary = false;
                }
            }
    }
    while (!op.empty())
    {
        result.second = process_op(st, op.back());
        op.pop_back();
        if (result.second != "OK")
            return result;
    }
    if (!st.empty())
        result.first = st.back();
    return result;
}

