#include <stdio.h>
#include <cstdlib>

using namespace std;

typedef int T;
//bool operator == (const T a, const T b) {   return a == b;   }
//bool operator < (T a, T b)  {   return a < b;    }

typedef enum {RED, BLACK} nodeColor;

typedef struct _Node {
    struct _Node * left;
    struct _Node * right;
    struct _Node * parent;
    nodeColor color;
    T data;
} Node;

#define NIL &sentinel
Node sentinel = { NIL, NIL, 0, BLACK, 0 };

Node * root = NIL; 

void rotateLeft (Node * x)
{
    Node * y = x->right;
    x->right = y->left;
    if (y->left != NIL) 
        y->left->parent = x;
    if (y != NIL) 
        y->parent = x->parent;
    if (x->parent)
    {
        if (x == x->parent->right)
            x->parent->right = y;
        else
            x->parent->left = y;
    }else
        root = y;
    y->left = x;
    if (x != NIL) 
        x->parent = y;
}

void rotateRight (Node * x)
{
    Node * y = x->left;
    x->left = y->right;
    if (y->right != NIL)
        y->right->parent = x;
    if (y != NIL)
        y->parent = x->parent;
    if (x->parent)
    {
        if (x == x->parent->right)
            x->parent->right = y;
        else
            x->parent->left = y;
    }else
        root = y;
    y->right = x;
    if (x != NIL)
        x->parent = y;
}

void insertFixup (Node * x)
{
    while (x != root && x->parent->color == RED)
    {
        if (x->parent == x->parent->parent->left)
        {
            Node * y = x->parent->parent->right;
            if (y->color == RED)
            {
                x->parent->color = BLACK;
                y->color = BLACK;
                x->parent->parent->color = RED;
                x = x->parent->parent;
            }
            else
            {
                if (x == x->parent->right)
                {
                    x = x->parent;
                    rotateLeft (x);
                }
                x->parent->color = BLACK;
                x->parent->parent->color = RED;
                rotateRight (x->parent->parent);
            }
        }
        else
        {
            Node * y = x->parent->parent->left;
            if (y->color == RED)
            {
                x->parent->color = BLACK;
                y->color = BLACK;
                x->parent->parent->color = RED;
                x = x->parent->parent;
            }
            else
            {
                if (x == x->parent->left)
                {
                    x = x->parent;
                    rotateRight (x);
                }
                x->parent->color = BLACK;
                x->parent->parent->color = RED;
                rotateLeft (x->parent->parent);
            }
        }
    }
    root->color = BLACK;
}

Node * insertNode (T data)
{
    Node *current, *parent, *x;
    current = root;
    parent = 0;
    while (current != NIL)
    {
        if (current->data == data) 
            return current;
        parent = current;
        if (data < current->data)
            current = current->left;
        else
            current = current->right;
    }

    x = new struct _Node ();
    /*if ((x = malloc (sizeof(*x))) == 0)
    {
        printf ("Insufficient Memory To Insert The New Node\n");
        exit(1);
    }*/

    x->data = data;
    x->color = BLACK;
    x->parent = parent;
    x->left = NIL;
    x->right = NIL;

    if (parent)
    {
        if (x->data < parent->data)
            parent->left = x;
        else
            parent->right = x;
    }
    else
        root = x;

    insertFixup (x);
    return x;
}

void deleteFixup (Node * x)
{    
    while (x != root && x->color == BLACK)
    {
        if (x == x->parent->left)
        {
            Node *y = x->parent->right;
            if (y->color == RED)
            {
                y->color = BLACK;
                x->parent->color = RED;
                rotateLeft(x->parent);
                y = x->parent->right;
            }
            if (y->left->color == BLACK && y->right->color == BLACK)
            {
                y->color = RED;
                x = x->parent;
            }
            else
            {
                if (y->right->color == BLACK)
                {
                    y->left->color = BLACK;
                    y->color = RED;
                    rotateRight (y);
                    y = x->parent->right;
                }
                y->color = x->parent->color;
                y->right->color = BLACK;
                x->parent->color = BLACK;
                rotateLeft(x->parent);
                x = root;
            }
        }
        else
        {
            Node *y = x->parent->left;
            if (y->color == RED)
            {
                y->color = BLACK;
                x->parent->color = RED;
                rotateRight(x->parent);
                y = x->parent->left;
            }
            if (y->left->color == BLACK && y->right->color == BLACK)
            {
                y->color = RED;
                x = x->parent;
            }
            else
            {
                if (y->left->color == BLACK)
                {
                    y->right->color = BLACK;
                    y->color = RED;
                    rotateLeft(y);
                    y = x->parent->left;
                }
                y->color = x->parent->color;
                x->parent->color = BLACK;
                y->left->color = BLACK;
                rotateRight(x->parent);
                x = root;
            }
        }
    }

    x->color = BLACK;
}

Node * deleteNode (Node * z)
{
    Node *x, *y;
    if (!z || z == NIL)
        return (0);

    if (z->left == NIL || z->right == NIL)
        y = z;
    else
    {
        y = z->right;
        while (y->left != NIL)
            y = y->left;
    }
    if (y->left != NIL)
        x = y->left;
    else
        x = y->right;
    
    x->parent = y->parent;
    if (y->parent)
    {
        if (y == y->parent->right)
            y->parent->right = x;
        else
            y->parent->left = y;
    }else
        root = x;

    if (y != z)
        z->data = y->data;
    if (y->color == BLACK)
        deleteFixup (x);
    return y;
}

Node * findNode (T data)
{
    Node * current = root;
    while (current != NIL)
        if (current->data == data)
            return current;
        else
            current = data < current->data ? current->left : current->right;
    return (0);
}

int main()
{
    freopen ("input.txt", "r", stdin);
    freopen ("output.txt", "w", stdout);
    int n;
    scanf ("%d\n", &n);
    for (int i = 0; i < n; i++)
    {
        char q;
        int x;
        scanf ("%c %d\n", &q, &x);
        if (q == '+')
            insertNode(x);
        if (q == '-')
            deleteNode(findNode(x));
        if (q == '?')
        {
            if (findNode(x))
                printf ("YES\n");
            else
                printf ("NO\n");
        }
    }
    return 0;
}