#include <stdlib.h>

extern int __VERIFIER_nondet_int(void);
struct node {
    int value;
    struct node *next;
};
struct list {
    struct node *slist;
    struct list *next;
};
struct iterator {
    struct list *list;
    struct node *node;
};
int main()
{
    struct list *data = ((void *)0);
    {
      while (__VERIFIER_nondet_int())
        {
          struct node *node = malloc(sizeof *node);
          if (!node)
              abort();
          node->next = ((void *)0);
          node->value = __VERIFIER_nondet_int();
          struct list *item = malloc(sizeof *item);
          if (!item)
              abort();
          item->slist = node;
          item->next = data;
          data = item;
        }
    }
    {
      struct iterator iter;
      {
        struct list *list = data;
        if ((iter.list = list))
          iter.node = list->slist;
      }
      struct node *node;
      {
        if (!iter.list)
          node = ((void *)0);
        else {
          struct node *current = iter.node;
          if ((iter.node = current->next))
            node = current;
          else {
            if ((iter.list = iter.list->next))
              iter.node = iter.list->slist;
            node = current;
          }
        }
      }
      while ((node))
      {
        {
          if (!iter.list)
            node = ((void *)0);
          else {
            struct node *current = iter.node;
            if ((iter.node = current->next))
              node = current;
            else {
              if ((iter.list = iter.list->next))
                iter.node = iter.list->slist;
              node = current;
            }
          }
        }
      }
    }
    {
      struct list *list = data;
      while (list && list->next) {
        struct list *dst = ((void *)0);
        while (list) {
          struct list *next = list->next;
          if (!next) {
            list->next = dst;
            dst = list;
            break;
          }
          { struct node **dst = &list->slist;
            struct node *sub1 = list->slist;
            struct node *sub2 = next->slist;
            while (sub1 || sub2) {
              struct node ***pdst = &dst;
              struct node **pdata;
              if (!sub2 || (sub1 && __VERIFIER_nondet_int()))
                pdata = &sub1;
              else
                pdata = &sub2;
              struct node *node = *pdata;
              *pdata = node->next;
              node->next = ((void *)0);
              **pdst = node;
              *pdst = &node->next;
            }
          }
          list->next = dst;
          dst = list;
          list = next->next;
          free(next);
        }
        list = dst;
      }
      data = list;
    }
    {
      struct iterator iter;
      {
        struct list *list = data;
        if ((iter.list = list))
          iter.node = list->slist;
      }
      struct node *node;
      {
        if (!iter.list)
          node = ((void *)0);
        else {
          struct node *current = iter.node;
          if ((iter.node = current->next))
            node = current;
          else {
            if ((iter.list = iter.list->next))
              iter.node = iter.list->slist;
            node = current;
          }
        }
      }
      while ((node))
      {
        {
          if (!iter.list)
            node = ((void *)0);
          else {
            struct node *current = iter.node;
            if ((iter.node = current->next))
              node = current;
            else {
              if ((iter.list = iter.list->next))
                iter.node = iter.list->slist;
              node = current;
            }
          }
        }
      }
    }
    {
      while (data) {
        struct list *next = data->next;
        struct node *node = data->slist;
        while (node) {
            struct node *snext = node->next;
            free(node);
            node = snext;
        }
        free(data);
        data = next;
      }
    }
    return 0;
}
