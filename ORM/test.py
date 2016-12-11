class A(object):
    a = 1;

    def __init__(self, value):
        self.__s = value;

class B(A):
    c = 2;
    _d = "lol";



if __name__ == "__main__":
    o = A(4)
    print(o.__dict__)
    print(o.a)
    print(o._A__s)

    o1 = B(5)
    print(o1.__dict__)
    print(o1.a)
    print(B.c)
    print(o1._A__s)
    print(B._d)


# # db = None
#     db = psycopg2.connect("dbname=%s user=%s password=%s host=%s" % ("shopdb", "shop", "12345", "127.0.0.1"))


#             if ( self.__loaded or self.__modified ):
#             self.__class__.db.commit()
#             print("COMMIT")

#         #when close connection?
#         self.__cursor.close()
#         self.__class__.db.close()
