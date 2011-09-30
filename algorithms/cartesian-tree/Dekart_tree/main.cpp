#include <stdio.h>
#include <cstdlib> 

using namespace std;

#define MAX 50000

struct item
{
    int key, prior, nom;
    item * l, *r;
    item() {}
    item (int key, int prior, int nom) : key(key), prior(prior), nom(nom), l(NULL), r(NULL) {}
};

typedef item * pitem;

void split (pitem t, int key, pitem & l, pitem & r)
{
    if (!t)
        l = r = NULL;
    else
        if (key < t->key)
            split (t->l, key, l, t->l), r = t;
        else 
            split (t->r, key, t->r, r), l = t;
}

void insert (pitem & t, pitem it)
{
    if (!t)
        t = it;
    else
        if (t->prior > it->prior)
            split (t, it->key, it->l, it->r), t = it;
        else
            insert (it->key < t->key ? t->l : t->r, it);
}

void solve (pitem parent, pitem t, int key)
{
    if (t->key == key)
    {
        if (parent)
            printf ("%d ", parent->nom);
        else
            printf ("0 ");
        if (t->l)
            printf ("%d ", t->l->nom);
        else
            printf ("0 ");
        if (t->r)
            printf ("%d\n", t->r->nom);
        else
            printf ("0\n");
    }
    else
        solve (t, key < t->key ? t->l : t->r, key);
}

pitem tree = NULL;

struct xx
{
    int x, y;
} a[MAX+1];

int main()
{
    freopen ("input.txt", "r", stdin);
    freopen ("output.txt", "w", stdout);
    int n;
    scanf ("%d", &n);
    for (int i = 1; i <= n; i++)
    {
        scanf ("%d%d", &a[i].x, &a[i].y);
        pitem it = new item (a[i].x, a[i].y, i);
        insert (tree, it);
    }
    printf ("YES\n");
    for (int i = 1; i <= n; i++)
        solve (NULL, tree, a[i].x);
    return 0;
}