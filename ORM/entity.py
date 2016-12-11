import psycopg2
import psycopg2.extras


class DatabaseError(Exception):
    pass
class NotFoundError(Exception):
    pass

class Entity(object):
    db = None

    # ORM part 1
    __delete_query    = 'DELETE FROM "{table}" WHERE {table}_id=%s'
    __insert_query    = 'INSERT INTO "{table}" ({columns}) VALUES ({placeholders}) RETURNING "{table}_id"'
    __list_query      = 'SELECT * FROM "{table}"'
    __select_query    = 'SELECT * FROM "{table}" WHERE {table}_id=%s'
    __update_query    = 'UPDATE "{table}" SET {columns} WHERE {table}_id=%s'

    def __init__(self, id=None):
        if self.__class__.db is None:
            raise DatabaseError()

        self.__cursor   = self.__class__.db.cursor(
            cursor_factory=psycopg2.extras.DictCursor
        )
        self.__fields   = {}
        self.__id       = id
        self.__loaded   = False
        self.__modified = False
        self.__table    = self.__class__.__name__.lower()

    # def __getattr__(self, name):
    #     # check, if instance is modified and throw an exception

    #     # get corresponding data from database if needed

    #     # check, if requested property name is in current class
    #     #    getter with name as an argument
    #     # throw an exception, if attribute is unrecognized
    #     # name = "text"
    #     # if name in self.__class__._columns:
    #     #     print("__getattr__ no attr - %s", self.__class__._columns.index(name))
    #     #     return self.__class__._columns[0]
    #     print("__getattr__ - %s", name)
    #     pass

    # def __setattr__(self, name, value):
    #     # check, if requested property name is in current class
    #     #    columns, parents, children or siblings and call corresponding
    #     #    setter with name and value as arguments or use default implementation
    #     print("__setattr__ - %s", name)
    #     pass

    def __execute_query(self, query, args):
        # execute an sql statement and handle exceptions together with transactions
        pass

    def __insert(self):
        # generate an insert query string from fields keys and values and execute it
        # use prepared statements
        # save an insert id
        pass

    def __load(self):
        # if current instance is not loaded yet execute select statement and store it's result as an associative array (fields), where column names used as keys
        pass

    def __update(self):
        # generate an update query string from fields keys and values and execute it
        # use prepared statements
        pass

    def _get_children(self, name):
        # return an array of child entity instances
        # each child instance must have an id and be filled with data
        pass

    def _get_column(self, name):
        # return value from fields array by <table>_<name> as a key
        self.__cursor.execute("select %s from %s" % (name, self.__class__))
        res = self.__cursor.fetchall()

        print(res)
        return res

    def _get_parent(self, name):
        # ORM part 2
        # get parent id from fields with <name>_id as a key
        # return an instance of parent entity class with an appropriate id
        pass

    def _get_siblings(self, name):
        # ORM part 2
        # get parent id from fields with <name>_id as a key
        # return an array of sibling entity instances
        # each sibling instance must have an id and be filled with data
        pass

    def _set_column(self, name, value):
        # put new value into fields array with <table>_<name> as a key
        pass

    def _set_parent(self, name, value):
        # ORM part 2
        # put new value into fields array with <name>_id as a key
        # value can be a number or an instance of Entity subclass
        pass

    @classmethod
    def all(cls):
        istances = []

        # get ALL rows with ALL columns from corrensponding table
        cursor = cls.db.cursor(
            cursor_factory=psycopg2.extras.DictCursor
        )

        table_name = cls.__name__.lower()
        cursor.execute(cls.__list_query.format(table=table_name))
        rows = cursor.fetchall()

        print(rows)

        # for each row create an instance of appropriate class
        # each instance must be filled with column data, a correct id and MUST NOT query a database for own fields any more
        for row in rows:
            print(row[0])
            istance = cls(row[0])
            instance.__fields = dict(row)
            istances.append(istance)

        # return an array of istances
        return istances

    def delete(self):
        # execute delete query with appropriate id
        pass

    @property
    def id(self):
        # try to guess yourself
        pass

    @property
    def created(self):
        # try to guess yourself
        pass

    @property
    def updated(self):
        # try to guess yourself
        pass

    def save(self):
        # execute either insert or update query, depending on instance id
        self.__cursor.execute("select * from article");
        print(self.__cursor.fetchall())
        if ( not self.__loaded or self.__modified ):
            self.__class__.db.commit()
            print("COMMIT")
        pass
