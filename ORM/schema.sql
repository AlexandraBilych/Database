CREATE TABLE "article" (
"article_id" SERIAL PRIMARY KEY,
"title" varchar(50),
"text" text,
"article_created" timestamp NOT NULL DEFAULT now(),
"article_updated" timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "category" (
"category_id" SERIAL PRIMARY KEY,
"title" varchar(50),
"category_created" timestamp NOT NULL DEFAULT now(),
"category_updated" timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "tag" (
"tag_id" SERIAL PRIMARY KEY,
"value" varchar(50),
"tag_created" timestamp NOT NULL DEFAULT now(),
"tag_updated" timestamp NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION update_category_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.category_updated = now();
   RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_category_updated" BEFORE UPDATE ON "category" FOR EACH ROW EXECUTE PROCEDURE update_category_timestamp()

CREATE OR REPLACE FUNCTION update_article_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.article_updated = now();
   RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_article_updated" BEFORE UPDATE ON "article" FOR EACH ROW EXECUTE PROCEDURE update_article_timestamp()

CREATE OR REPLACE FUNCTION update_tag_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.tag_updated = now();
   RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_tag_updated" BEFORE UPDATE ON "tag" FOR EACH ROW EXECUTE PROCEDURE update_tag_timestamp()
