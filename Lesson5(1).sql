USE vk;
DROP TABLE user_s;
CREATE TABLE IF NOT EXISTS user_s(
	id bigint UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	firstname varchar(150) NOT NULL,
	lastname varchar(150) NOT NULL,
	email varchar(150) NOT NULL UNIQUE,
	phone char(11) NOT NULL UNIQUE,
	password_hash CHAR(65) DEFAULT NULL,
	created_at varchar(50) NOT NULL DEFAULT '12.09.2022 16:04'
);

INSERT INTO user_s (firstname, lastname, email, phone)
VALUES ('Igor', 'Petrov','igor@mail.com', '89213549560'),
('Oksana', 'Petrova','oksana@mail.com', '89213549561'),
('Dasha', 'Metrova','dashaa@mail.com', '88213559561'),
('Oksana4', 'Petrova1','oksana1@mail.com', '88213549561'),
('Oksana1', 'Petrova2','oksana2@mail.com', '87213519561'),
('Oksana2', 'Petrova3','oksana3@mail.com', '86213549561'),
('Oksana3', 'Petrova4','oksana4@mail.com', '85212549561'),
('Oksana5', 'Petrova5','oksana5@mail.com', '84213549551');


SELECT * FROM user_s;

ALTER TABLE user_s ADD COLUMN updated_at varchar(50) DEFAULT '12.09.2022 16:04';
UPDATE user_s
	SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i')
;

ALTER TABLE user_s ADD COLUMN created_at_dt DATETIME;
ALTER TABLE user_s ADD COLUMN updated_at_dt DATETIME;

UPDATE user_s
SET created_at_dt = STR_TO_DATE(created_at, '%Y-%m-%d %T'),
    updated_at_dt = STR_TO_DATE(updated_at, '%Y-%m-%d %T');
   
   
ALTER TABLE user_s 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;   
## задание 3
   
USE store;

SELECT * FROM storehouses_products;
SELECT * FROM products;
SELECT * FROM storehouses;

INSERT INTO storehouses_products (storehouse_id, product_id, value) 
VALUES (1, 1, 15),
(1, 2, 25),
(2, 3, 5),
(2, 4, 0),
(3, 5, 13),
(3, 6, 0),
(3, 7, 2);

INSERT INTO storehouses (id, name) 
VALUES (1, 'ЮГ'),
(2, 'Север'),
(3, 'Запад');

SELECT product_id, value FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 2147483647 ELSE value END;

# Практическое задание теме “Агрегация данных”
# задание 1 

SELECT * FROM users;
SELECT birthday_at FROM users ;
SELECT round(AVG(TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25) AS age
FROM
users;

#задание 2
SELECT dayname(birthday_at) FROM users ;
SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) AS day FROM users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users GROUP BY day;
SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY day;