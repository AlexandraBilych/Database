from entity import *

class Article(Entity):
   _columns = ['title', 'text']

class Category(Entity):
    _columns  = ['title']

class Tag(Entity):
    _columns  = ['value']


if __name__ == "__main__":
    article = Article()
    article.title = "apulaz"
    article.save()

    for article in Article.all():
        print(article.title)


# import psycopg2
# import psycopg2.extras

# conn = psycopg2.connect("dbname=%s user=%s password=%s host=%s" % ("shopdb", "shop", "12345", "127.0.0.1"))
# print(conn)
# cur = conn.cursor(cursor_factory = psycopg2.extras.DictCursor)
# print(cur)
# # cur.execute("CREATE TABLE test (id serial PRIMARY KEY, num integer, data varchar);")
# # cur.execute("INSERT INTO test (num, data) VALUES (%s, %s)", (100, "abc'def"))
# cur.execute("SELECT * from article")
# print(cur.fetchone())
# conn.commit()
# cur.close()
# conn.close()



