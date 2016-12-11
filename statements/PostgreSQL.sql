#1
CREATE DATABASE "shopdb";

#2
CREATE USER "shop" WITH PASSWORD '12345';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to "shop";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO "shop";

#3
CREATE USER "viewer" WITH NOINHERIT PASSWORD '12345';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "viewer";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO "viewer";

#4
CREATE TABLE "category" (
	"category_id" serial,
	"category_title" varchar(100) NOT NULL,
	"category_created" timestamp NOT NULL DEFAULT now(),
	"category_updated" timestamp NOT NULL DEFAULT now(),
	PRIMARY KEY ("category_id"),
	UNIQUE ("category_title")
);
CREATE OR REPLACE FUNCTION update_category_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.category_updated = now();
   RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_category_updated" BEFORE UPDATE ON "category" FOR EACH ROW EXECUTE PROCEDURE update_category_timestamp();

#5
INSERT INTO "category" ("category_title") VALUES 
	('Womens Clothing'), 
	('Girls Clothig'), 
	('Mans Clothing');

#6
CREATE TABLE "article" (
	"article_id" serial,
	"article_title" varchar(100) NOT NULL,
	"category_id" integer NOT NULL,
	"article_price" decimal NOT NULL,
	"article_created" timestamp NOT NULL DEFAULT now(),
	"article_updated" timestamp NOT NULL DEFAULT now(),
	PRIMARY KEY ("article_id"),
	UNIQUE ("article_title"),
	FOREIGN KEY("category_id") REFERENCES "category" ("category_id")
);
CREATE OR REPLACE FUNCTION update_article_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.article_updated = now();
   RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_article_updated" BEFORE UPDATE ON "article" FOR EACH ROW EXECUTE PROCEDURE update_article_timestamp();

#7
INSERT INTO "article" ("article_title", "category_id", "article_price") VALUES
	('Pants', 2, 1.00),
	('Sweatshirt', 2, 1.00),
	('Jeans', 2, 1.00);

#8
UPDATE "article"
SET "article_price" = 3.5
WHERE "article_id" = 1;

#9
UPDATE "article" SET "article_price" = "article_price" * 1.1, "article_updated" = now();

#10
DELETE FROM "article" WHERE "article_title" = 'Sweatshirt';

#11
SELECT "article_title" FROM "article" ORDER BY "article_title" ASC;

#12
SELECT "article_title" FROM "article" ORDER BY "article_price" DESC;

#13
SELECT "article_title" FROM "article" ORDER BY "article_price" DESC LIMIT 3;

#14
SELECT "article_title" FROM "article" ORDER BY "article_price" ASC LIMIT 3;

#15
SELECT "article_title" FROM "article"
WHERE "article_id" NOT IN (SELECT "article_id" FROM "article" ORDER BY "article_price" DESC LIMIT 3)
ORDER BY "article_price" DESC LIMIT 3;

#16
SELECT "article_title" FROM "article" ORDER BY "article_price" DESC LIMIT 1;

#17
SELECT "article_title" FROM "article" ORDER BY "article_price" ASC LIMIT 1;

#18
SELECT COUNT(*) FROM "article";

#19
SELECT AVG("article_price") FROM "article";

#20
CREATE VIEW "theMostExpensive" AS
SELECT * FROM "article" ORDER BY "article_price" DESC LIMIT 3;