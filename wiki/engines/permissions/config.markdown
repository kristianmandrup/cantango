Permissions can be defined in a permissions store. A permission store
should store the following sets:

* roles
* role groups
* licenses
* users

A typical permission store is a simple Yaml file, using the following structure:

```yaml
roles:
  admin:
    can:
      manage:
      - all
  user:
    can:
      read:
      - ^articles
      - Post
      write:
      - Comment
    cannot:
      write:
      - Article
role_groups:
  bloggers:
    can:
      read:
      - Article
      - Comment
    cannot:
      write:
      - Article
      - Post
  editors:
    can:
      read:
      - Article
      - Comment
    cannot:
      write:
      - Article
      - Post
licenses:
  editors:
    can:
      manage:
      - all
users:
  stan@theman.com:
    can:
      manage:
      - all
  kris@thewiz.dk:
    cannot:
      read:
        - Book

