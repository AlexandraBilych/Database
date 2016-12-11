import psycopg2
from entity import *

class Article(Entity):
   _columns = ['title', 'text']

class Category(Entity):
    _columns  = ['title']

class Tag(Entity):
    _columns  = ['value']


if __name__ == "__main__":
    Entity.db = psycopg2.connect("dbname=%s user=%s password=%s host=%s" % ("shopdb", "shop", "12345", "127.0.0.1"))

    article = Article()
    article.title = "apulaz"
    article.save()

    for article in Article.all():
        print(article.title)

    Entity.db.close()
