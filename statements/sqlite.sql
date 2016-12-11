#1
sqlite3 shop.db

#2
N/A

#3
N/A

#4
CREATE TABLE "category" (
	"category_id" integer,
	"category_title" varchar(100) NOT NULL,
	"category_created" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"category_updated" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("category_id"),
	UNIQUE ("category_title")
);

#5
INSERT INTO "category" (category_title) VALUES
	("Women\'s Clothing"),
	("Girls\' Clothig"),
	("Man\'s Clothing");

#6
CREATE TABLE "article" (
	"article_id" integer,
	"article_title" varchar(100) NOT NULL,
	"category_id" integer NOT NULL,
	"article_price" decimal NOT NULL,
	"article_created" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"article_updated" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("article_id"),
	UNIQUE ("article_title"),
	FOREIGN KEY("category_id") REFERENCES "category" ("category_id")
);

#7
INSERT INTO "article" ("article_title", "category_id", "article_price") VALUES
	('Pants', 2, 1.00),
	('Sweatshirt', 2, 1.00),
	('Jeans', 2, 1.00);

#8
UPDATE "article"
SET "article_price" = 3.5, "article_updated" = CURRENT_TIMESTAMP
WHERE "article_title" = 'Pants';

#9
UPDATE "article" SET "article_price" = "article_price" * 1.1, "article_updated" = CURRENT_TIMESTAMP;

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
SELECT "article_title" FROM (SELECT "article_title", MAX("article_price") FROM "article");

#17
SELECT "article_title" FROM (SELECT "article_title", MIN("article_price") FROM "article");

#18
SELECT COUNT(*) FROM "article";

#19
SELECT AVG("article_price") FROM "article";

#20
CREATE VIEW "theMostExpensive" AS
SELECT * FROM "article" ORDER BY "article_price" DESC LIMIT 3;