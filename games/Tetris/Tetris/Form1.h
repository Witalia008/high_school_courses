
#include <list>
#include <time.h>

using namespace std;

typedef enum { line, square, rightL, leftL, pyramide, leftZ, rightZ } ShapeType;

#pragma once

namespace Tetris {

    using namespace System;
    using namespace System::ComponentModel;
    using namespace System::Collections;
    using namespace System::Windows::Forms;
    using namespace System::Data;
    using namespace System::Drawing;

    /// <summary>
    /// Summary for Form1
    ///
    /// WARNING: If you change the name of this class, you will need to change the
    ///          'Resource File Name' property for the managed resource compiler tool
    ///          associated with all .resx files this class depends on.  Otherwise,
    ///          the designers will not be able to interact properly with localized
    ///          resources associated with this form.
    /// </summary>
    public ref class Form1 : public System::Windows::Forms::Form
    {
    public:
        Form1(void)
        {
            InitializeComponent();
            //
            //TODO: Add the constructor code here
            //
        }

    protected:
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        ~Form1()
        {
            if (components)
            {
                delete components;
            }
        }

    private: System::Windows::Forms::Button^  button1;
    private: System::Windows::Forms::PictureBox^  pictureBox1;
    private: System::Windows::Forms::GroupBox^  groupBox1;
    private: System::Windows::Forms::Button^  button6;
    private: System::Windows::Forms::Button^  button5;
    private: System::Windows::Forms::Button^  button4;
    private: System::Windows::Forms::Button^  button3;
    private: System::Windows::Forms::Button^  button2;
    private: System::Windows::Forms::Timer^  timer1;
    private: System::Windows::Forms::GroupBox^  groupBox2;
    private: System::Windows::Forms::Label^  label2;
    private: System::Windows::Forms::Label^  label1;
    private: System::Windows::Forms::GroupBox^  groupBox3;
    private: System::Windows::Forms::PictureBox^  pictureBox2;
    private: System::ComponentModel::IContainer^  components;
    private: Pole^ a;




    protected: 

    private:
        /// <summary>
        /// Required designer variable.
        /// </summary>


#pragma region Windows Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        void InitializeComponent(void)
        {
            this->components = (gcnew System::ComponentModel::Container());
            System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(Form1::typeid));
            this->button1 = (gcnew System::Windows::Forms::Button());
            this->pictureBox1 = (gcnew System::Windows::Forms::PictureBox());
            this->groupBox1 = (gcnew System::Windows::Forms::GroupBox());
            this->button6 = (gcnew System::Windows::Forms::Button());
            this->button5 = (gcnew System::Windows::Forms::Button());
            this->button4 = (gcnew System::Windows::Forms::Button());
            this->button3 = (gcnew System::Windows::Forms::Button());
            this->button2 = (gcnew System::Windows::Forms::Button());
            this->timer1 = (gcnew System::Windows::Forms::Timer(this->components));
            this->groupBox2 = (gcnew System::Windows::Forms::GroupBox());
            this->label2 = (gcnew System::Windows::Forms::Label());
            this->label1 = (gcnew System::Windows::Forms::Label());
            this->groupBox3 = (gcnew System::Windows::Forms::GroupBox());
            this->pictureBox2 = (gcnew System::Windows::Forms::PictureBox());
            (cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->pictureBox1))->BeginInit();
            this->groupBox1->SuspendLayout();
            this->groupBox2->SuspendLayout();
            this->groupBox3->SuspendLayout();
            (cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->pictureBox2))->BeginInit();
            this->SuspendLayout();
            // 
            // button1
            // 
            this->button1->Font = (gcnew System::Drawing::Font(L"Monotype Corsiva", 20.25F, System::Drawing::FontStyle::Italic, System::Drawing::GraphicsUnit::Point, 
                static_cast<System::Byte>(204)));
            this->button1->Location = System::Drawing::Point(306, 12);
            this->button1->Name = L"button1";
            this->button1->Size = System::Drawing::Size(167, 44);
            this->button1->TabIndex = 1;
            this->button1->Text = L"���� ���";
            this->button1->UseVisualStyleBackColor = true;
            this->button1->Click += gcnew System::EventHandler(this, &Form1::button1_Click);
            // 
            // pictureBox1
            // 
            this->pictureBox1->Location = System::Drawing::Point(0, 0);
            this->pictureBox1->Name = L"pictureBox1";
            this->pictureBox1->Size = System::Drawing::Size(300, 600);
            this->pictureBox1->TabIndex = 2;
            this->pictureBox1->TabStop = false;
            // 
            // groupBox1
            // 
            this->groupBox1->Controls->Add(this->button6);
            this->groupBox1->Controls->Add(this->button5);
            this->groupBox1->Controls->Add(this->button4);
            this->groupBox1->Controls->Add(this->button3);
            this->groupBox1->Controls->Add(this->button2);
            this->groupBox1->Font = (gcnew System::Drawing::Font(L"Monotype Corsiva", 15.75F, System::Drawing::FontStyle::Italic, System::Drawing::GraphicsUnit::Point, 
                static_cast<System::Byte>(204)));
            this->groupBox1->Location = System::Drawing::Point(306, 75);
            this->groupBox1->Name = L"groupBox1";
            this->groupBox1->Size = System::Drawing::Size(167, 220);
            this->groupBox1->TabIndex = 3;
            this->groupBox1->TabStop = false;
            this->groupBox1->Text = L"��������";
            // 
            // button6
            // 
            this->button6->Location = System::Drawing::Point(6, 182);
            this->button6->Name = L"button6";
            this->button6->Size = System::Drawing::Size(155, 31);
            this->button6->TabIndex = 4;
            this->button6->Text = L"������";
            this->button6->UseVisualStyleBackColor = true;
            this->button6->Click += gcnew System::EventHandler(this, &Form1::button6_Click);
            // 
            // button5
            // 
            this->button5->Location = System::Drawing::Point(6, 142);
            this->button5->Name = L"button5";
            this->button5->Size = System::Drawing::Size(155, 31);
            this->button5->TabIndex = 3;
            this->button5->Text = L"�������";
            this->button5->UseVisualStyleBackColor = true;
            this->button5->Click += gcnew System::EventHandler(this, &Form1::button5_Click);
            // 
            // button4
            // 
            this->button4->Location = System::Drawing::Point(6, 105);
            this->button4->Name = L"button4";
            this->button4->Size = System::Drawing::Size(155, 31);
            this->button4->TabIndex = 2;
            this->button4->Text = L"����������";
            this->button4->UseVisualStyleBackColor = true;
            this->button4->Click += gcnew System::EventHandler(this, &Form1::button4_Click);
            // 
            // button3
            // 
            this->button3->Location = System::Drawing::Point(6, 67);
            this->button3->Name = L"button3";
            this->button3->Size = System::Drawing::Size(155, 31);
            this->button3->TabIndex = 1;
            this->button3->Text = L"��������";
            this->button3->UseVisualStyleBackColor = true;
            this->button3->Click += gcnew System::EventHandler(this, &Form1::button3_Click);
            // 
            // button2
            // 
            this->button2->Font = (gcnew System::Drawing::Font(L"Monotype Corsiva", 15.75F, System::Drawing::FontStyle::Italic, System::Drawing::GraphicsUnit::Point, 
                static_cast<System::Byte>(204)));
            this->button2->ForeColor = System::Drawing::SystemColors::ControlText;
            this->button2->Location = System::Drawing::Point(6, 30);
            this->button2->Name = L"button2";
            this->button2->Size = System::Drawing::Size(155, 31);
            this->button2->TabIndex = 0;
            this->button2->Text = L"����������";
            this->button2->UseVisualStyleBackColor = true;
            this->button2->Click += gcnew System::EventHandler(this, &Form1::button2_Click);
            // 
            // timer1
            // 
            this->timer1->Tick += gcnew System::EventHandler(this, &Form1::timer1_Tick);
            // 
            // groupBox2
            // 
            this->groupBox2->Controls->Add(this->label2);
            this->groupBox2->Controls->Add(this->label1);
            this->groupBox2->Font = (gcnew System::Drawing::Font(L"Monotype Corsiva", 15.75F, System::Drawing::FontStyle::Italic, System::Drawing::GraphicsUnit::Point, 
                static_cast<System::Byte>(204)));
            this->groupBox2->Location = System::Drawing::Point(306, 312);
            this->groupBox2->Name = L"groupBox2";
            this->groupBox2->Size = System::Drawing::Size(167, 100);
            this->groupBox2->TabIndex = 5;
            this->groupBox2->TabStop = false;
            this->groupBox2->Text = L"�������";
            // 
            // label2
            // 
            this->label2->AutoSize = true;
            this->label2->Location = System::Drawing::Point(6, 63);
            this->label2->Name = L"label2";
            this->label2->Size = System::Drawing::Size(84, 25);
            this->label2->TabIndex = 1;
            this->label2->Text = L"������: 0";
            // 
            // label1
            // 
            this->label1->AutoSize = true;
            this->label1->Location = System::Drawing::Point(6, 27);
            this->label1->Name = L"label1";
            this->label1->Size = System::Drawing::Size(113, 25);
            this->label1->TabIndex = 0;
            this->label1->Text = L"��������: 0";
            // 
            // groupBox3
            // 
            this->groupBox3->Controls->Add(this->pictureBox2);
            this->groupBox3->Font = (gcnew System::Drawing::Font(L"Monotype Corsiva", 15.75F, System::Drawing::FontStyle::Italic, System::Drawing::GraphicsUnit::Point, 
                static_cast<System::Byte>(204)));
            this->groupBox3->Location = System::Drawing::Point(306, 418);
            this->groupBox3->Name = L"groupBox3";
            this->groupBox3->Size = System::Drawing::Size(167, 182);
            this->groupBox3->TabIndex = 6;
            this->groupBox3->TabStop = false;
            this->groupBox3->Text = L"�������� ������";
            // 
            // pictureBox2
            // 
            this->pictureBox2->Location = System::Drawing::Point(23, 34);
            this->pictureBox2->Name = L"pictureBox2";
            this->pictureBox2->Size = System::Drawing::Size(120, 120);
            this->pictureBox2->TabIndex = 0;
            this->pictureBox2->TabStop = false;
            // 
            // Form1
            // 
            this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(475, 600);
            this->Controls->Add(this->groupBox3);
            this->Controls->Add(this->groupBox2);
            this->Controls->Add(this->groupBox1);
            this->Controls->Add(this->pictureBox1);
            this->Controls->Add(this->button1);
            this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::Fixed3D;
            this->Icon = (cli::safe_cast<System::Drawing::Icon^  >(resources->GetObject(L"$this.Icon")));
            this->Name = L"Form1";
            this->Text = L"�����";
            (cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->pictureBox1))->EndInit();
            this->groupBox1->ResumeLayout(false);
            this->groupBox2->ResumeLayout(false);
            this->groupBox2->PerformLayout();
            this->groupBox3->ResumeLayout(false);
            (cli::safe_cast<System::ComponentModel::ISupportInitialize^  >(this->pictureBox2))->EndInit();
            this->ResumeLayout(false);

        }
#pragma endregion
            
private:void ClearShape(int a[])
        {
            for (int i = 0; i < 4; i++)
                for (int j = 0; j < 4; j++)
                    a[i][j] = false;
        }
private:void NewShape(int a[], ShapeType & cur)
        {
            cur = rand()%7;
            ClearShape(a);
            switch (cur)
            {
            case line:
                    a[0][0] = true; a[0][1] = true; 
                    a[0][2] = true; a[0][3] = true;
                    break;
            case square:
                    a[0][0] = true; a[0][1] = true; 
                    a[1][0] = true; a[1][1] = true;
                    break;
            case pyramide:
                    a[1][0] = true; a[1][1] = true;
                    a[1][2] = true; a[0][1] = true;
                    break;
            case leftL:
                    a[0][0] = true; a[1][0] = true;
                    a[1][1] = true; a[1][2] = true;
                    break;
            case rightL:
                    a[0][2] = true; a[1][0] = true;
                    a[1][1] = true; a[1][2] = true;
                    break;
            case leftZ:
                    a[0][0] = true; a[0][1] = true;
                    a[1][1] = true; a[1][2] = true;
                    break;
            case rightZ:
                    a[1][0] = true; a[1][1] = true;
                    a[0][1] = true; a[0][2] = true;
                    break;
                }
        }

private:void Rotate(int a[], ShapeType cur)
        {
            switch (cur)
            {
            case line:
                for (int i = 0; i < 4; i++)
                    swap (a[0][i], a[i][0]);
            case square: 
                return;
            }
            int temp[4][4];
            ClearShape(temp);
            for (int i = 0; i < 4; i++)
                for (int j = 0; j < 4; j++)
                    temp[j][3-i] = a[i][j];
            ClearShape(a);
            for (int i = 0; i < 4; i++)
                for (int j = 0; j < 4; j++)
                    a[i][j] = temp[i][j];

            bool fl1 = true, fl2 = true;
            while (fl1 || fl2)
            {
                fl1 = true; fl2 = true;
                for (int i = 0; i < 4; i++)
                {
                    if (a[0][i])
                        fl1 = false;
                    if (a[i][0])
                        fl2 = false;
                }
                if (fl1)
                {
                    for (int i = 0; i < 3; i++)
                        for (int j = 0; j < 4; j++)
                            a[i][j] = a[i+1][j];
                    for (int j = 0; j < 4; j++)
                        a[3][j] = false;
                }
                if (fl2)
                {
                    for (int i = 0; i < 4; i++)
                        for (int j = 0; j < 3; j++)
                            a[i][j] = a[i][j+1];
                    for (int i = 0; i < 4; i++)
                        a[i][3] = false;
                }
            }
        }
        
private:void NewShapeA()
        {
            nextShape.ClearShape();
            nextShape.left = 3;
            nextShape.top = -3;
            nextShape.NewShape( ShapeType(rand()%7) );
        }

private:Brush ^GetColor ()
        {
            int col = rand()%7;
            switch (col)
            {
            case 0:return Brushes::Aqua;
            case 1:return Brushes::Blue;
            case 2:return Brushes::Gold; 
            case 3:return Brushes::Green;
            case 4:return Brushes::Yellow;
            case 5:return Brushes::Silver;
            case 6:return Brushes::Red;
            }
        }

private:void DrawScene ()
        {
            Color ^col = gcnew Color();
            Pen ^pen = gcnew Pen(col->Red);
            Graphics ^bigImage = pictureBox1->CreateGraphics();
            Graphics ^smallImage = pictureBox2->CreateGraphics();
            bigImage->Clear(col->Black);
            smallImage->Clear(col->Black);
            pen->Color = col->Gray;
            int i;
            for (i = 1; i < 10; i++)
                bigImage->DrawLine(pen, i*30, 0, i*30, 600); 
            for (i = 1; i < 20; i++)
                bigImage->DrawLine(pen, 0, i*30, 300, i*30);
            for (i = 1; i < 4; i++)
            {
                smallImage->DrawLine(pen, i*30, 0, i*30, 120);
                smallImage->DrawLine(pen, 0, i*30, 120, i*30);
            }

            Brush ^brush = GetColor();
            for (int i = 0; i < 4; i++)
                for (int j = 0; j < 4; j++)
                    if (nextShape.cells[i][j])
                        smallImage->FillRectangle(brush, i*30+2, j*30+2, i*30+27, j*30+27);
        }


private:System::Void button1_Click(System::Object^  sender, System::EventArgs^  e) {
            srand(time(NULL));
            button2->ForeColor = Color::White;
            timer1->Enabled = true;
            NewShapeA();
            DrawScene();
        }
private:System::Void button2_Click(System::Object^  sender, System::EventArgs^  e) {
            timer1->Interval = 100;
            button2->ForeColor = Color::White;
            button3->ForeColor = Color::Black;
            button4->ForeColor = Color::Black;
            button5->ForeColor = Color::Black;
            button6->ForeColor = Color::Black;
        }
private:System::Void button3_Click(System::Object^  sender, System::EventArgs^  e) {
            timer1->Interval = 80;
            button3->ForeColor = Color::White;
            button2->ForeColor = Color::Black;
            button4->ForeColor = Color::Black;
            button5->ForeColor = Color::Black;
            button6->ForeColor = Color::Black;
        }
private:System::Void button4_Click(System::Object^  sender, System::EventArgs^  e) {
            timer1->Interval = 60;
            button4->ForeColor = Color::White;
            button2->ForeColor = Color::Black;
            button3->ForeColor = Color::Black;
            button5->ForeColor = Color::Black;
            button6->ForeColor = Color::Black;
        }
private:System::Void button5_Click(System::Object^  sender, System::EventArgs^  e) {
            timer1->Interval = 40;
            button5->ForeColor = Color::White;
            button2->ForeColor = Color::Black;
            button3->ForeColor = Color::Black;
            button4->ForeColor = Color::Black;
            button6->ForeColor = Color::Black;
        }
private:System::Void button6_Click(System::Object^  sender, System::EventArgs^  e) {
            timer1->Interval = 20;
            button6->ForeColor = Color::White;
            button2->ForeColor = Color::Black;
            button3->ForeColor = Color::Black;
            button4->ForeColor = Color::Black;
            button5->ForeColor = Color::Black;
        }
private:System::Void timer1_Tick(System::Object^  sender, System::EventArgs^  e) {
            /*list<Shape>::iterator it = shapes.end(), I = shapes.begin();
            it--;
            bool fl = true;
            for (int i = 0; i < 4; i++)
                for (int j = 0; j < 4; j++)
                    if (it->cells[i][j])
                    {
                        
                    }*/
        }
};
public ref class Pole{
    int x;
};
}

