#include <windows.h>    
#include <stdio.h>
#include <time.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <vector>
#include <set>
#include <gl\gl.h>            
#include <gl\glu.h>            
#include <gl\glaux.h>

using namespace std;


typedef enum { RED, BLACK, NO } crispColor;

struct crisp
{
    crispColor color;
    double xtr, ytr, ztr;
    double xrot, yrot, zrot;
    int position;
    bool tacken;
};

struct pole
{
    int howMany;
    crispColor color;
};

struct TCube
{
    int what;
    double x1, y1, x2, y2;
};

HGLRC hRC;        
HDC hDC;
HWND        hWnd=NULL;        
HINSTANCE    hInstance;    

pole Pole[2][13];
crisp Crisps[2][15];
int CurrentPlayer = 1;
multiset<int> Step;

GLfloat xpos;
GLfloat ypos;
GLfloat xrot = 20;
GLuint yrot;
GLuint xPos;
GLuint yPos;
int isRotY = false;
double isRotX = false;
GLfloat zoom = -16;
GLuint one;
GLUquadricObj *quadric;
TCube cube[2];
        
GLuint texture[1];

GLfloat LightAmbient [] = { 0.5, 0.5, 0.5, 1 };
GLfloat LightDiffuse [] = { 1, 1, 1, 1 };
GLfloat LightPosition [] = { 0, 1, 3, 1 };

static GLfloat boxColor[3][3] = {
    {0.4, 0.3, 0}, {1, 1, 1}, {0.4, 0.3, 0}
};        

bool    keys[256];            
bool    active=TRUE;        
bool    fullscreen=TRUE;    

LRESULT    CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);    

AUX_RGBImageRec *LoadBMP (char *fileName)
{
    FILE *File = NULL;
    if (!fileName)
        return NULL;
    File = fopen(fileName, "r");
    if (File)
    {
        fclose(File);
        return auxDIBImageLoad(fileName);
    }
    return NULL;
}

int LoadGLTextures()
{
    int Status = FALSE;
    AUX_RGBImageRec *TextureImage[1];
    memset (TextureImage, 0,sizeof(void *)*1);
    
    if (TextureImage[0] = LoadBMP("Mud.bmp"))
    {
        Status = TRUE;
        glGenTextures(1, &texture[0]);
        
        glBindTexture(GL_TEXTURE_2D, texture[0]);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
        gluBuild2DMipmaps(GL_TEXTURE_2D, 3, TextureImage[0]->sizeX, TextureImage[0]->sizeY, GL_RGB, GL_UNSIGNED_BYTE, TextureImage[0]->data);
    }

    if (TextureImage[0])
    {
        if (TextureImage[0]->data)
        {
            free (TextureImage[0]->data);
        }
        free (TextureImage[0]);
    }

    return Status;
}

GLvoid BuildLists ()
{
    one = glGenLists(1);
    glNewList(one, GL_COMPILE);
        glRotatef(-90, 1, 0, 0);
        gluDisk(quadric, 0, 0.5, 32, 32);
        gluCylinder(quadric, 0.5, 0.5, 0.2, 32, 32);
        glTranslatef(0, 0, 0.2);
        gluDisk(quadric, 0, 0.5, 32, 32);
        glTranslatef(0, 0, -0.2);
        glRotatef(90, 1, 0, 0);
    glEndList();

}

GLvoid InitObjects ( GLvoid )
{

    cube[0].x1 = 0.52;
    cube[0].x2 = 0.58;
    cube[0].y1 = 0.32;
    cube[0].y2 = 0.38;

    cube[1].x1 = 0.59;
    cube[1].x2 = 0.65;
    cube[1].y1 = 0.32;
    cube[1].y2 = 0.38;

    for (int i = 0; i < 15; i++)
    {
        Crisps[0][i].color = BLACK;
        Crisps[0][i].position = -(i+1);
        Crisps[0][i].xrot = -90;
        Crisps[0][i].yrot = 0;
        Crisps[0][i].zrot = 0;
        Crisps[0][i].xtr = -3.6;
        Crisps[0][i].ytr = -5.7+i*0.3;
        Crisps[0][i].ztr = 0.5;
        Crisps[0][i].tacken = false;

        Crisps[1][i].color = RED;
        Crisps[1][i].position = -(i+1);
        Crisps[1][i].xrot = -90;
        Crisps[1][i].yrot = 0;
        Crisps[1][i].zrot = 0;
        Crisps[1][i].xtr = -3.6;
        Crisps[1][i].ytr = -5.7+i*0.3;
        Crisps[1][i].ztr = 0.5;
        Crisps[1][i].tacken = false;
    }

    for (int i = 0; i <= 12; i++)
    {
        Pole[0][i].howMany = 0;
        Pole[0][i].color = NO;

        Pole[1][i].howMany = 0;
        Pole[1][i].color = NO;
    }
}

GLvoid DrawDesk( GLvoid )
{
    glBegin(GL_QUADS);
        //floor 
        glColor3fv(boxColor[1]);
        glVertex3f(-3, 0, 7);
        glVertex3f(-3, 0, -7);
        glVertex3f(3, 0, -7);
        glVertex3f(3, 0, 7);
        
        glColor3fv(boxColor[0]);
        glVertex3f(-4.2, -0.1, 7.1);
        glVertex3f(-4.2, -0.1, -7.1);
        glVertex3f(3.1, -0.1, -7.1);
        glVertex3f(3.1, -0.1, 7.1);

        //left
        glColor3fv(boxColor[1]);
        glVertex3f(-3, 0, -7);
        glVertex3f(-3, 0.5, -7);
        glVertex3f(-3, 0.5, 7);
        glVertex3f(-3, 0, 7);

        glColor3fv(boxColor[0]);
        glVertex3f(-4.2, -0.1, 7.1);
        glVertex3f(-4.2, 0.5, 7.1);
        glVertex3f(-4.2, 0.5, -7.1);
        glVertex3f(-4.2, -0.1, -7.1);

        glVertex3f(-4.2, 0.5, -7);
        glVertex3f(-4.1, 0.5, -7);
        glVertex3f(-4.1, 0.5, 7);
        glVertex3f(-4.2, 0.5, 7);

        glVertex3f(-3.1, 0.5, -7);
        glVertex3f(-3, 0.5, -7);
        glVertex3f(-3, 0.5, 7);
        glVertex3f(-3.1, 0.5, 7);

        //back
        glColor3fv(boxColor[1]);
        glVertex3f(-3, 0, -7);
        glVertex3f(-3, 0.5, -7);
        glVertex3f(3, 0.5, -7);
        glVertex3f(3, 0, -7);

        glColor3fv(boxColor[0]);
        glVertex3f(-4.2, -0.1, -7.1);
        glVertex3f(-4.2, 0.5, -7.1);
        glVertex3f(3.1, 0.5, -7.1);
        glVertex3f(3.1, -0.1, -7.1);

        glVertex3f(-4.2, 0.5, -7.1);
        glVertex3f(-4.2, 0.5, -7);
        glVertex3f(3.1, 0.5, -7);
        glVertex3f(3.1, 0.5, -7.1);

        //right
        glColor3fv(boxColor[1]);
        glVertex3f(3, 0, -7);
        glVertex3f(3, 0.5, -7);
        glVertex3f(3, 0.5, 7);
        glVertex3f(3, 0, 7);

        glColor3fv(boxColor[0]);
        glVertex3f(3.1, -0.1, -7.1);
        glVertex3f(3.1, 0.5, -7.1);
        glVertex3f(3.1, 0.5, 7.1);
        glVertex3f(3.1, -0.1, 7.1);

        glVertex3f(3.1, 0.5, -7);
        glVertex3f(3, 0.5, -7);
        glVertex3f(3, 0.5, 7);
        glVertex3f(3.1, 0.5, 7);

        //face
        glColor3fv(boxColor[1]);
        glVertex3f(3, 0, 7);
        glVertex3f(3, 0.5, 7);
        glVertex3f(-3, 0.5, 7);
        glVertex3f(-3, 0, 7);

        glColor3fv(boxColor[0]);
        glVertex3f(-4.2, -0.1, 7.1);
        glVertex3f(-4.2, 0.5, 7.1);
        glVertex3f(3.1, 0.5, 7.1);
        glVertex3f(3.1, -0.1, 7.1);

        glVertex3f(-4.2, 0.5, 7.1);
        glVertex3f(-4.2, 0.5, 7);
        glVertex3f(3.1, 0.5, 7);
        glVertex3f(3.1, 0.5, 7.1);

        //places for chips
        glVertex3f(-4.1, 0.5, 7);
        glVertex3f(-4.1, 0.5, 5.7);
        glVertex3f(-3.1, 0.5, 5.7);
        glVertex3f(-3.1, 0.5, 7);

        glVertex3f(-4.1, 0.5, 1.3);
        glVertex3f(-4.1, 0.5, -7);
        glVertex3f(-3.1, 0.5, -7);
        glVertex3f(-3.1, 0.5, 1.3);

        for (int i = 1; i < 15; i++)
        {
            glVertex3f(-4.1, 0.5, 5.7-i*0.2-(i-1)*0.1);
            glVertex3f(-4.1, 0.5, 5.7-i*0.3);
            glVertex3f(-3.1, 0.5, 5.7-i*0.3);
            glVertex3f(-3.1, 0.5, 5.7-i*0.2-(i-1)*0.1);
        }
    glEnd();

    glBegin(GL_TRIANGLES);
        for (int i = 0; i < 6; i++)
        {
            if (i%2)
                glColor3f(0, 0, 0);
            else
                glColor3f(1, 0, 0);
            glVertex3f(-3+i+0.1, 0.01, -7);
            glVertex3f(-3+i+0.5, 0.01, -1);
            glVertex3f(-3+i+0.9, 0.01, -7);

            glVertex3f(3-i-0.1, 0.01, 7);
            glVertex3f(3-i-0.5, 0.01, 1);
            glVertex3f(3-i-0.9, 0.01, 7);
        }
    glEnd();
    for (int i = 0; i < 15; i++)
    {
        for (double ang = 0; ang < 180; ang += 1)
        {
            glColor3fv(boxColor[1]);
            glBegin(GL_TRIANGLES);
                glVertex3f(-3.6, 0.5, 5.7-i*0.3);
                glVertex3f(-3.6+cos(ang*M_PI/180)/2, 0.5-sin(ang*M_PI/180)/2, 5.7-i*0.3);
                glVertex3f(-3.6+cos((ang+1)*M_PI/180)/2, 0.5-sin((ang+1)*M_PI/180)/2, 5.7-i*0.3);

                glVertex3f(-3.6, 0.5, 5.7-i*0.3-0.2);
                glVertex3f(-3.6+cos(ang*M_PI/180)/2, 0.5-sin(ang*M_PI/180)/2, 5.7-i*0.3-0.2);
                glVertex3f(-3.6+cos((ang+1)*M_PI/180)/2, 0.5-sin((ang+1)*M_PI/180)/2, 5.7-i*0.3-0.2);
            glEnd();
            
            glColor3fv(boxColor[0]);
            glBegin(GL_QUADS);
                glVertex3f(-3.6+cos(ang*M_PI/180)/2, 0.5-sin(ang*M_PI/180)/2, 5.7-i*0.3);
                glVertex3f(-3.6+cos((ang+1)*M_PI/180)/2, 0.5-sin((ang+1)*M_PI/180)/2, 5.7-i*0.3);
                glVertex3f(-3.6+cos((ang+1)*M_PI/180)/2, 0.5-sin((ang+1)*M_PI/180)/2, 5.7-i*0.3-0.2);
                glVertex3f(-3.6+cos(ang*M_PI/180)/2, 0.5-sin(ang*M_PI/180)/2, 5.7-i*0.3-0.2);
            glEnd();
        }
    }
    glColor3fv(boxColor[2]);
    gluQuadricTexture(quadric, GL_FALSE);
    glTranslatef(3.1, 0.5, -6);
    gluCylinder(quadric, 0.1, 0.1, 0.99, 32, 32);
    gluDisk(quadric, 0, 0.1, 32, 32);
    glTranslatef(0, 0, 0.99);
    gluDisk(quadric, 0, 0.1, 32, 32);
        
    glTranslatef(0, 0, 9);
    gluCylinder(quadric, 0.1, 0.1, 0.99, 32, 32);
    gluDisk(quadric, 0, 0.1, 32, 32);
    glTranslatef(0, 0, 0.99);
    gluDisk(quadric, 0, 0.1, 32, 32);
    glTranslatef(-3.1, -0.5, -4.98);
}

GLvoid DrawCube ( TCube a )
{
    glColor3f(1, 1, 1);
    glBegin(GL_QUADS);
        glVertex3f(a.x1, a.y1, -1);
        glVertex3f(a.x2, a.y1, -1);
        glVertex3f(a.x2, a.y2, -1);
        glVertex3f(a.x1, a.y2, -1);
    glEnd();
    glColor3f(0, 0, 0);
    glTranslatef((a.x1+a.x2)/2-0.003, (a.y1+a.y2)/2-0.003, -0.99);
    if (a.what%2)
        gluDisk(quadric, 0, 0.006, 16, 16);
    if (a.what > 1)
    {
        glTranslatef(0.02, 0.02, 0);
        gluDisk(quadric, 0, 0.006, 16, 16);
        glTranslatef(-0.04, -0.04, 0);
        gluDisk(quadric, 0, 0.006, 16, 16);
        glTranslatef(0.02, 0.02, 0);
    }

    if (a.what > 3)
    {
        glTranslatef(-0.02, 0.02, 0);
        gluDisk(quadric, 0, 0.006, 16, 16);
        glTranslatef(0.04, -0.04, 0);
        gluDisk(quadric, 0, 0.006, 16, 16);
        glTranslatef(-0.02, 0.02, 0);
    }
    if (a.what == 6)
    {
        glTranslatef(0.02, 0, 0);
        gluDisk(quadric, 0, 0.006, 16, 16);
        glTranslatef(-0.04, 0, 0);
        gluDisk(quadric, 0, 0.006, 16, 16);
        glTranslatef(0.02, 0, 0);
    }
    glTranslatef(-(a.x1+a.x2)/2+0.003, -(a.y1+a.y2)/2+0.003, 0.99);
}

GLvoid DrawCrisp ( crisp a )
{
    if (a.color == RED)
        glColor3f(1, 0, 0);
    if (a.color == BLACK)
        glColor3f(0, 0, 0);
    if (a.tacken)
    {
        glEnable(GL_BLEND);
        glCallList(one);
        glDisable(GL_BLEND);
    }
    else
    {
        glRotatef(a.xrot, 1, 0, 0);
        glRotatef(a.yrot, 0, 1, 0);
        glRotatef(a.zrot, 0, 0, 1);
        glTranslatef(a.xtr, a.ytr, a.ztr);

        glCallList(one);

        glTranslatef(-a.xtr, -a.ytr, -a.ztr);
        glRotatef(-a.xrot, 1, 0, 0);
        glRotatef(-a.yrot, 0, 1, 0);
        glRotatef(-a.zrot, 0, 0, 1);
    }
}

bool PutCrisp(int i, int j, bool isShift)
{
    int wh = (CurrentPlayer + isShift)%2;
    if (CurrentPlayer)
    {    
        if (Pole[wh][i].color == Crisps[CurrentPlayer][j].color || Pole[wh][i].color == NO && Step.find(i+(isShift ? 12 : 0) - Crisps[CurrentPlayer][j].position) != Step.end())
        {
            Step.erase(Step.find(i+(isShift ? 12 : 0) - Crisps[CurrentPlayer][j].position));
            if (isShift)
            {
                Crisps[CurrentPlayer][j].xtr = 9.7 - i;
                if (i > 6)
                    Crisps[CurrentPlayer][j].xtr -= 0.2;
                Crisps[CurrentPlayer][j].ztr = -6.5+Pole[wh][i].howMany;
                Crisps[CurrentPlayer][j].position = i+12;
            }
            else
            {
                Crisps[CurrentPlayer][j].xtr = -3.5+i;
                if (i > 6)
                    Crisps[CurrentPlayer][j].xtr += 0.2;
                Crisps[CurrentPlayer][j].ztr = 6.5-Pole[wh][i].howMany;
                Crisps[CurrentPlayer][j].position = i;
            }
            Crisps[CurrentPlayer][j].tacken = false;
            Crisps[CurrentPlayer][j].xrot = 0;
            Crisps[CurrentPlayer][j].yrot = 0;
            Crisps[CurrentPlayer][j].zrot = 0;
            Crisps[CurrentPlayer][j].ytr = 0;
            Pole[wh][i].howMany++;
            Pole[wh][i].color = Crisps[CurrentPlayer][j].color;
            return true;
        }
    }
    else
    {
        if (Pole[wh][13-i].color == Crisps[CurrentPlayer][j].color || Pole[wh][13-i].color == NO && Step.find(i+(isShift ? 12 : 0) - Crisps[CurrentPlayer][j].position) != Step.end())
        {
            Step.erase(Step.find(i+(isShift ? 12 : 0) - Crisps[CurrentPlayer][j].position));
            if (isShift)
            {
                Crisps[CurrentPlayer][j].xtr = -3.5+i;
                if (i > 6)
                    Crisps[CurrentPlayer][j].xtr += 0.2;    
                Crisps[CurrentPlayer][j].ztr = -6.5+Pole[wh][13-i].howMany;
                Crisps[CurrentPlayer][j].position = i+12;
            }
            else
            {
                Crisps[CurrentPlayer][j].xtr = 9.7 - i;
                if (i > 6)
                    Crisps[CurrentPlayer][j].xtr -= 0.2;
                Crisps[CurrentPlayer][j].ztr = 6.5-Pole[wh][13-i].howMany;
                Crisps[CurrentPlayer][j].position = i;
            }
            Crisps[CurrentPlayer][j].tacken = false;
            Crisps[CurrentPlayer][j].xrot = 0;
            Crisps[CurrentPlayer][j].yrot = 0;
            Crisps[CurrentPlayer][j].zrot = 0;
            Crisps[CurrentPlayer][j].ytr = 0;
            Pole[wh][13-i].howMany++;
            Pole[wh][13-i].color = Crisps[CurrentPlayer][j].color;
            return true;
        }
    }
    return false;
}

bool GetCrisp (int i, bool isShift)
{
    int wh = (CurrentPlayer + isShift)%2;
    int ii = i;
    if (!CurrentPlayer)
        ii = 13 - i;
    if (Pole[wh][ii].color == (CurrentPlayer ? RED : BLACK))
    {
        Pole[wh][ii].howMany--;
        if (Pole[wh][ii].howMany == 0)
            Pole[wh][ii].color = NO;
        int j = -1;
        for (int k = 0; k < 15; k++)
            if (Crisps[CurrentPlayer][k].position == (i + (isShift ? 12 : 0)))
            {
                if (j == -1) j = k;
                else
                {
                    if (isShift && Crisps[CurrentPlayer][k].ztr > Crisps[CurrentPlayer][j].ztr)
                        j = k;
                    if (!isShift && Crisps[CurrentPlayer][k].ztr <  Crisps[CurrentPlayer][j].ztr)
                        j = k;
                }
            }
        Crisps[CurrentPlayer][j].tacken = true;
        return true;
    }
    return false;
}

GLvoid ReSizeGLScene(GLsizei width, GLsizei height)        
{
    if (height==0)                                    
    {
        height=1;                                        
    }

    glViewport(0,0,width,height);                        

    glMatrixMode(GL_PROJECTION);                        
    glLoadIdentity();                                    

    gluPerspective(45.0f,(GLfloat)width/(GLfloat)height,0.1f,100.0f);

    glMatrixMode(GL_MODELVIEW);                            
    glLoadIdentity();                                    
}

int InitGL()    
{
    ShowCursor( true );
    if (!LoadGLTextures())
        return FALSE;
    quadric = gluNewQuadric();
    gluQuadricNormals(quadric, GL_SMOOTH);
    gluQuadricTexture(quadric, GL_TRUE);
    BuildLists();
    InitObjects();
    glEnable(GL_TEXTURE_2D);
    glShadeModel(GL_SMOOTH);
    glColor4f(0, 0, 0, 0.5);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    glClearColor(0, 0.3, 0, 0.5);
    glClearDepth(1.0);
    glDepthFunc(GL_LEQUAL);
    glEnable(GL_DEPTH_TEST);
    glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);

    glLightfv(GL_LIGHT1, GL_AMBIENT, LightAmbient);
    glLightfv(GL_LIGHT1, GL_DIFFUSE, LightDiffuse);
    glLightfv(GL_LIGHT1, GL_POSITION, LightPosition);
    glEnable(GL_LIGHT1);
    glEnable(GL_LIGHTING);
    glEnable(GL_COLOR_MATERIAL);
    return TRUE;
}


int DrawGLScene(GLvoid)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();
    DrawCube( cube[0] );
    DrawCube( cube[1] );
    glTranslatef(xpos, ypos, 0);
    glTranslatef(0, 0, zoom);
    glTranslatef(0, -1.5, 0);
    glRotatef(xrot, 1, 0, 0);
    glRotatef(yrot, 0, 1, 0);

    glTranslatef(-3.1, 0, 0);
    DrawDesk();
    for (int i = 0; i < 15; i++)
        DrawCrisp( Crisps[1][i] );
    glTranslatef(6.2, 0, 0);

    glRotatef(-180, 0, 1, 0);
    DrawDesk();
    for (int i = 0; i < 15; i++)
        DrawCrisp( Crisps[0][i] );
    glTranslatef(3.1, 0, 0);
    glRotatef(180, 0, 1, 0);

    glColor3f(1, 0, 0);
    glTranslatef(-3.1, -0.19, 0);
    glCallList(one);
    glTranslatef(6.2, 0, 0);
    glRotatef(180, 0, 1, 0);
    glColor3f(0.1, 0.1, 0.1);
    glCallList(one);

    yrot += 2*isRotY;
    xrot += 2*isRotX;
    ypos += 0.043*isRotX;
    zoom -= 0.04*isRotX;
    if (yrot%180 == 0)
        isRotY = false;
    if (xrot == 90 || xrot == 20)
        isRotX = 0;
    if (yrot%360 == 0)
        yrot = 0;

    return TRUE;
}


GLvoid KillGLWindow(GLvoid)                                
{
    if (fullscreen)                                        
    {
        ChangeDisplaySettings(NULL,0);                    
        ShowCursor(TRUE);                                
    }

    if (hRC)                                        
    {
        if (!wglMakeCurrent(NULL,NULL))                    
        {
            MessageBox(NULL,"Release Of DC And RC Failed.","SHUTDOWN ERROR",MB_OK | MB_ICONINFORMATION);
        }

        if (!wglDeleteContext(hRC))                        
        {
            MessageBox(NULL,"Release Rendering Context Failed.","SHUTDOWN ERROR",MB_OK | MB_ICONINFORMATION);
        }
        hRC=NULL;                                        
    }

    if (hDC && !ReleaseDC(hWnd,hDC))                    
    {
        MessageBox(NULL,"Release Device Context Failed.","SHUTDOWN ERROR",MB_OK | MB_ICONINFORMATION);
        hDC=NULL;                                        
    }

    if (hWnd && !DestroyWindow(hWnd))                    
    {
        MessageBox(NULL,"Could Not Release hWnd.","SHUTDOWN ERROR",MB_OK | MB_ICONINFORMATION);
        hWnd=NULL;                                        
    }

    if (!UnregisterClass("OpenGL",hInstance))            
    {
        MessageBox(NULL,"Could Not Unregister Class.","SHUTDOWN ERROR",MB_OK | MB_ICONINFORMATION);
        hInstance=NULL;                                    
    }
}
 
BOOL CreateGLWindow(char* title, int width, int height, int bits, bool fullscreenflag)
{
    GLuint        PixelFormat;            
    WNDCLASS    wc;                        
    DWORD        dwExStyle;                
    DWORD        dwStyle;                
    RECT        WindowRect;                
    WindowRect.left=(long)0;            
    WindowRect.right=(long)width;        
    WindowRect.top=(long)0;                
    WindowRect.bottom=(long)height;        

    fullscreen=fullscreenflag;            

    hInstance            = GetModuleHandle(NULL);                
    wc.style            = CS_HREDRAW | CS_VREDRAW | CS_OWNDC;    
    wc.lpfnWndProc        = (WNDPROC) WndProc;                    
    wc.cbClsExtra        = 0;                                    
    wc.cbWndExtra        = 0;                                    
    wc.hInstance        = hInstance;                            
    wc.hIcon            = LoadIcon(NULL, IDI_WINLOGO);            
    wc.hCursor            = LoadCursor(NULL, IDC_ARROW);            
    wc.hbrBackground    = NULL;                                    
    wc.lpszMenuName        = NULL;                                    
    wc.lpszClassName    = "OpenGL";                                

    if (!RegisterClass(&wc))                                    
    {
        MessageBox(NULL,"Failed To Register The Window Class.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                            
    }
    
    if (fullscreen)                                                
    {
        DEVMODE dmScreenSettings;                                
        memset(&dmScreenSettings,0,sizeof(dmScreenSettings));    
        dmScreenSettings.dmSize=sizeof(dmScreenSettings);        
        dmScreenSettings.dmPelsWidth    = width;                
        dmScreenSettings.dmPelsHeight    = height;                
        dmScreenSettings.dmBitsPerPel    = bits;                    
        dmScreenSettings.dmFields=DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT;

        if (ChangeDisplaySettings(&dmScreenSettings,CDS_FULLSCREEN)!=DISP_CHANGE_SUCCESSFUL)
        {
            if (MessageBox(NULL,"The Requested Fullscreen Mode Is Not Supported By\nYour Video Card. Use Windowed Mode Instead?","NeHe GL",MB_YESNO|MB_ICONEXCLAMATION)==IDYES)
            {
                fullscreen=FALSE;        
            }
            else
            {
                MessageBox(NULL,"Program Will Now Close.","ERROR",MB_OK|MB_ICONSTOP);
                return FALSE;                                    
            }
        }
    }

    if (fullscreen)                                            
    {
        dwExStyle=WS_EX_APPWINDOW;                                
        dwStyle=WS_POPUP;                                        
        ShowCursor(FALSE);                                        
    }
    else
    {
        dwExStyle=WS_EX_APPWINDOW | WS_EX_WINDOWEDGE;            
        dwStyle=WS_OVERLAPPEDWINDOW;                        
    }

    AdjustWindowRectEx(&WindowRect, dwStyle, FALSE, dwExStyle);        

    if (!(hWnd=CreateWindowEx(    dwExStyle,                            
                                "OpenGL",                            
                                title,                                
                                dwStyle |                            
                                WS_CLIPSIBLINGS |                    
                                WS_CLIPCHILDREN,                    
                                0, 0,                                
                                WindowRect.right-WindowRect.left,    
                                WindowRect.bottom-WindowRect.top,    
                                NULL,                                
                                NULL,                                
                                hInstance,                            
                                NULL)))                                
    {
        KillGLWindow();                                
        MessageBox(NULL,"Window Creation Error.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                
    }

    static    PIXELFORMATDESCRIPTOR pfd=                
    {
        sizeof(PIXELFORMATDESCRIPTOR),                
        1,                                            
        PFD_DRAW_TO_WINDOW |                        
        PFD_SUPPORT_OPENGL |                        
        PFD_DOUBLEBUFFER,                            
        PFD_TYPE_RGBA,                                
        bits,                                        
        0, 0, 0, 0, 0, 0,                            
        0,                                            
        0,                                            
        0,                                            
        0, 0, 0, 0,                                    
        16,                                              
        0,                                            
        0,                                            
        PFD_MAIN_PLANE,                                
        0,                                            
        0, 0, 0                                        
    };
    
    if (!(hDC=GetDC(hWnd)))                            
    {
        KillGLWindow();                                
        MessageBox(NULL,"Can't Create A GL Device Context.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                
    }

    if (!(PixelFormat=ChoosePixelFormat(hDC,&pfd)))    
    {
        KillGLWindow();                                
        MessageBox(NULL,"Can't Find A Suitable PixelFormat.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                
    }

    if(!SetPixelFormat(hDC,PixelFormat,&pfd))        
    {
        KillGLWindow();                                
        MessageBox(NULL,"Can't Set The PixelFormat.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                
    }

    if (!(hRC=wglCreateContext(hDC)))                
    {
        KillGLWindow();                                
        MessageBox(NULL,"Can't Create A GL Rendering Context.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                
    }

    if(!wglMakeCurrent(hDC,hRC))                    
    {
        KillGLWindow();                                
        MessageBox(NULL,"Can't Activate The GL Rendering Context.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                
    }

    ShowWindow(hWnd,SW_SHOW);                        
    SetForegroundWindow(hWnd);                        
    SetFocus(hWnd);                                    
    ReSizeGLScene(width, height);                    

    if (!InitGL())                                    
    {
        KillGLWindow();                                
        MessageBox(NULL,"Initialization Failed.","ERROR",MB_OK|MB_ICONEXCLAMATION);
        return FALSE;                                
    }

    return TRUE;                                    
}

LRESULT CALLBACK WndProc(    HWND    hWnd,            
                            UINT    uMsg,            
                            WPARAM    wParam,            
                            LPARAM    lParam)            
{
    switch (uMsg)                                    
    {
        case WM_ACTIVATE:                            
        {
            if (!HIWORD(wParam))                    
            {
                active=TRUE;                        
            }
            else
            {
                active=FALSE;                        
            }

            return 0;                                
        }

        case WM_SYSCOMMAND:                            
        {
            switch (wParam)                            
            {
                case SC_SCREENSAVE:                    
                case SC_MONITORPOWER:                
                return 0;                            
            }
            break;                                    
        }

        case WM_CLOSE:                                
        {
            PostQuitMessage(0);                        
            return 0;                                
        }

        case WM_KEYDOWN:                            
        {
            keys[wParam] = TRUE;                    
            return 0;                                
        }

        case WM_KEYUP:                                
        {
            keys[wParam] = FALSE;                    
            return 0;                                
        }

        case WM_SIZE:                                
        {
            ReSizeGLScene(LOWORD(lParam),HIWORD(lParam));  
            return 0;                                
        }
    }

    return DefWindowProc(hWnd,uMsg,wParam,lParam);
}

int WINAPI WinMain(    HINSTANCE    hInstance,            
                    HINSTANCE    hPrevInstance,        
                    LPSTR        lpCmdLine,            
                    int            nCmdShow)            
{
    MSG        msg;                                    
    BOOL    done=FALSE;                            

    if (MessageBox(NULL,"Would You Like To Run In Fullscreen Mode?", "Start FullScreen?",MB_YESNO|MB_ICONQUESTION)==IDNO)
    {
        fullscreen=FALSE;                            
    }

    if (!CreateGLWindow("NeHe's OpenGL Framework",1366,768,16,fullscreen))
    {
        return 0;                                    
    }

    while(!done)                                    
    {
        if (PeekMessage(&msg,NULL,0,0,PM_REMOVE))    
        {
            if (msg.message==WM_QUIT)                
            {
                done=TRUE;                            
            }
            else                                    
            {
                TranslateMessage(&msg);                
                DispatchMessage(&msg);                
            }
        }
        else                                        
        {
            if (active)                                
            {
                if (keys[VK_ESCAPE])                
                {
                    done=TRUE;                        
                }
                else                                
                {
                    DrawGLScene();                    
                    SwapBuffers(hDC);                
                }
            }

            if (keys[VK_PRIOR])                        
            {
                keys[VK_PRIOR]=FALSE;                    
                KillGLWindow();                        
                fullscreen=!fullscreen;
                if (!CreateGLWindow("NeHe's OpenGL Framework",1366,768,16,fullscreen))
                    return 0;                        
            }
            if (keys['N'] && Step.size() != 0)
            {
                int i = 14;
                while (i >= 0 && Crisps[CurrentPlayer][i].position > 0) i--;
                if (i >= 0)
                {
                    Crisps[CurrentPlayer][i].position = 0;
                    Crisps[CurrentPlayer][i].tacken = true;
                }
            }
            if (keys['G'])
            {
                if (cube[0].what == 0 && cube[1].what == 0 && !isRotY && !isRotX)
                    {
                        cube[0].what = rand() % 6 + 1;
                        cube[1].what = rand() % 6 + 1;
                        Step.clear();
                        Step.insert(cube[0].what);
                        Step.insert(cube[1].what);
                        if (cube[0].what == cube[1].what)
                        {
                            Step.insert(cube[0].what);
                            Step.insert(cube[1].what);
                        }
                        isRotX = 1;
                    }
            }
            if (cube[0].what && cube[1].what)
            {
                bool fl;
                if (keys[VK_SHIFT])
                    fl = true;
                else
                    fl = false;
                int j = 14;
                while (j >= 0 && !Crisps[CurrentPlayer][j].tacken) j--;
                if (j >= 0 &&  Step.size() != 0)
                {
                    if (keys[VK_F1])
                        if (PutCrisp(1, j, fl)) keys[VK_F1] = false;
                    if (keys[VK_F2])
                        if (PutCrisp(2, j, fl)) keys[VK_F2] = false;
                    if (keys[VK_F3])
                        if (PutCrisp(3, j, fl)) keys[VK_F3] = false;
                    if (keys[VK_F4])
                        if (PutCrisp(4, j, fl)) keys[VK_F4] = false;
                    if (keys[VK_F5])
                        if (PutCrisp(5, j, fl)) keys[VK_F5] = false;
                    if (keys[VK_F6])
                        if (PutCrisp(6, j, fl)) keys[VK_F6] = false;
                    if (keys[VK_F7])
                        if (PutCrisp(7, j, fl)) keys[VK_F7] = false;
                    if (keys[VK_F8])
                        if (PutCrisp(8, j, fl)) keys[VK_F8] = false;
                    if (keys[VK_F9])
                        if (PutCrisp(9, j, fl)) keys[VK_F9] = false;
                    if (keys[VK_F10])
                        if (PutCrisp(10, j, fl)) keys[VK_F10] = false;
                    if (keys[VK_F11])
                        if (PutCrisp(11, j, fl)) keys[VK_F11] = false;
                    if (keys[VK_F12])
                        if (PutCrisp(12, j, fl)) keys[VK_F12] = false;
                }
                if (j < 0)
                {
                    if (keys[VK_F1])
                        if (GetCrisp(1, fl)) keys[VK_F1] = false;
                    if (keys[VK_F2])
                        if (GetCrisp(2, fl)) keys[VK_F2] = false;
                    if (keys[VK_F3])
                        if (GetCrisp(3, fl)) keys[VK_F3] = false;
                    if (keys[VK_F4])
                        if (GetCrisp(4, fl)) keys[VK_F4] = false;
                    if (keys[VK_F5])
                        if (GetCrisp(5, fl)) keys[VK_F5] = false;
                    if (keys[VK_F6])
                        if (GetCrisp(6, fl)) keys[VK_F6] = false;
                    if (keys[VK_F7])
                        if (GetCrisp(7, fl)) keys[VK_F7] = false;
                    if (keys[VK_F8])
                        if (GetCrisp(8, fl)) keys[VK_F8] = false;
                    if (keys[VK_F9])
                        if (GetCrisp(9, fl)) keys[VK_F9] = false;
                    if (keys[VK_F10])
                        if (GetCrisp(10, fl)) keys[VK_F10] = false;
                    if (keys[VK_F11])
                        if (GetCrisp(11, fl)) keys[VK_F11] = false;
                    if (keys[VK_F12])
                        if (GetCrisp(12, fl)) keys[VK_F12] = false;
                }
            }
            if (Step.size() == 0 && xrot == 90)
            {
                isRotY = true;
                cube[0].what = cube[1].what = 0;
                CurrentPlayer ^= 1;
                isRotX = -0.5;
            }
            if (keys[VK_BACK])
            {
                for (int i = 0; i < 15; i++)
                    if (Crisps[CurrentPlayer][i].tacken)
                    {
                        Crisps[CurrentPlayer][i].tacken = false;
                        if (Crisps[CurrentPlayer][i].position == 0)
                            Crisps[CurrentPlayer][i].position = -(i+1);
                        else
                        {
                            int pos = Crisps[CurrentPlayer][i].position;
                            if (CurrentPlayer)
                            {
                                Pole[(CurrentPlayer+pos / 13)][pos%13+pos/13].howMany++;
                                Pole[(CurrentPlayer+pos / 13)][pos%13+pos/13].color = Crisps[CurrentPlayer][i].color;
                            }
                            else
                            {
                                Pole[(CurrentPlayer+pos / 13)][13-(pos%13+pos/13)].howMany++;
                                Pole[(CurrentPlayer+pos / 13)][13-(pos%13+pos/13)].color = Crisps[CurrentPlayer][i].color;
                            }
                        }
                    }
            }
            bool P1win = true, P2win = true;
            for (int i = 0; i < 15; i++)
            {
                if (Crisps[0][i].position != 24)
                    P2win = false;
                if (Crisps[1][i].position != 24)
                    P1win = false;
            }
            if (P1win)
                MessageBox(NULL, "End!", "Player 1 won!", MB_ICONINFORMATION | MB_OK);
            
            if (P2win)
                MessageBox(NULL, "End!", "Player 2 won!", MB_ICONINFORMATION | MB_OK);
        }
    }

    KillGLWindow();                                    
    return (msg.wParam);                            
}
