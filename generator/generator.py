import sys
import os.path
import yaml

class CommandLineArgError(Exception):
    def __str__ (self):
        return "Usage: ./generator.py [file_name]"

class FileNotFoundError(Exception):
    pass

class DataTypeError(Exception):
    def __str__(self):
        return "https://www.postgresql.org/docs/9.1/static/datatype.html"

class Generator:

    def __init__(self, file_name):
        if not os.path.isfile(file_name):
            raise FileNotFoundError()
        self.file_name = file_name

    def __createColumn(self, table_name, column_title, column_type):
        return '"table_name_%s" %s, ' % (column_title, column_type)

    def __addRowId(self, table_name):
        return '"%s_id" SERIAL PRIMARY KEY,' % table_name

    def __addRowCreated(self, table_name):
        return '"%s_created" timestamp NOT NULL DEFAULT now(),' % table_name

    def __addRowIdUpdated(self, table_name):
        return '"%s_updated" timestamp NOT NULL DEFAULT now()' % table_name

    def __addTriggerUpdated(self, table_name):
       return """CREATE OR REPLACE FUNCTION update_%(s)s_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.%(s)s_updated = now();
   RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_%(s)s_updated" BEFORE UPDATE ON "%(s)s" FOR EACH ROW EXECUTE PROCEDURE update_%(s)s_timestamp()\n""" % {'s' : table_name}

    def __outputTable(self, table):
        for i in table:
            print(i)

    def createDDL(self):
        file = open(self.file_name, 'r')
        schemaDB = yaml.load_all(file)

        for doc in schemaDB:
            for table_name, fields in doc.items():
                table_name = table_name.lower()
                table = ['CREATE TABLE "%s" (' % table_name, ]

                table.append(self.__addRowId(table_name))

                columns = fields["fields"]
                for column_title, column_type in columns.items():
                    table.append(self.__createColumn(column_title, column_type))

                table.append(self.__addRowCreated(table_name))
                table.append(self.__addRowIdUpdated(table_name))
                table.append(");\n")
                table.append(self.__addTriggerUpdated(table_name))

                self.__outputTable(table);

        file.close()


if __name__ == "__main__" :
    if ( len(sys.argv) != 2 ):
        raise CommandLineArgError()

    generator = Generator('shopdb.txt')
    generator.createDDL()
