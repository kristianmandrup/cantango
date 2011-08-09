Cantango comes with the concept of Categories of models. This is useful
when a group of models logically belong to gether and can be grouped as
one named category. You can then reference these category from your
permissions.

Example categories Yaml file:

```yaml
another_articles:
  [Post, Article]
articles:
  [Article, Post, Comment]
user_models:
  [Admin, Guest, User]
``

The categories can be referenced using the special '^' (pointer) as a prefix.

Note: In the near future you will also be able to reference categories from
Permit classes.

Example of Using Cateogry pointers in permissions file:

```yaml
roles:
  user:
    can:
      read:
      - ^articles
      - Post
```

The "^articles" point to the articles Category from the Categories file ;)
