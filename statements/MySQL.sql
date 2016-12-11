#1
CREATE DATABASE shopdb;

#2
CREATE USER 'shop'@'localhost' IDENTIFIED BY '12345';
GRANT ALL PRIVILEGES ON `shopdb`.* TO 'shop'@'localhost' WITH GRANT OPTION;

#3
CREATE USER 'viewer'@'localhost' IDENTIFIED BY '12345';
GRANT SELECT ON `shopdb`.* TO 'viewer'@'localhost';

#4
CREATE TABLE category (
	category_id int AUTO_INCREMENT,
	category_title varchar(100) NOT NULL,
	category_created timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
	category_updated timestamp NOT NULL DEFAULT now() on update now(),
	PRIMARY KEY (category_id),
	UNIQUE (category_title)
);

#5
INSERT INTO category (category_title, category_created) VALUES
	("Women's Clothing1", now()),
	("Girls' Clothig1", now()),
	("Man's Clothing1", now());

#6
CREATE TABLE article (
	article_id int AUTO_INCREMENT,
	article_title varchar(100) NOT NULL,
	category_id int NOT NULL,
	article_price decimal(10,2) NOT NULL,
	article_created timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
	article_updated timestamp NOT NULL DEFAULT now() on update now(),
	PRIMARY KEY (article_id),
	UNIQUE (article_title),
	FOREIGN KEY(category_id) REFERENCES category (category_id)
);

#7
INSERT INTO article (article_title, category_id, article_price, article_created) VALUES
	('Pants', 2, 1.00, now()),
	('Sweatshirt', 2, 1.00, now()),
	('Jeans', 2, 1.00, now());

#8
UPDATE article SET article_price = 3.5 WHERE article_id = 1;

#9
UPDATE article SET article_price = article_price * 1.1;

#10
DELETE FROM article WHERE article_title = 'Sweatshirt';

#11
SELECT article_title FROM article ORDER BY article_title ASC;

#12
SELECT article_title FROM article ORDER BY article_price DESC;

#13
SELECT article_title FROM article ORDER BY article_price DESC LIMIT 3;

#14
SELECT article_title FROM article ORDER BY article_price ASC LIMIT 3;

#15
SELECT max.article_title FROM (SELECT * FROM article ORDER BY article_price DESC LIMIT 6) as max ORDER BY max.article_price ASC LIMIT 3;

#16
SELECT article_title FROM article ORDER BY article_price DESC LIMIT 1;

#17
SELECT article_title FROM article ORDER BY article_price ASC LIMIT 1;

#18
SELECT COUNT(*) FROM article;

#19
SELECT AVG(article_price) FROM article;

#20
CREATE VIEW theMostExpensive AS
SELECT * FROM article ORDER BY article_price DESC LIMIT 3;