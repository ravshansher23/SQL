USE vk;


INSERT INTO users (firstname, lastname, email, phone)
VALUES ('Igor', 'Petrov','igor@mail.com', '89213549560'),
('Oksana', 'Petrova','oksana@mail.com', '89213549561'),
('Dasha', 'Metrova','dashaa@mail.com', '88213559561'),
('Oksana4', 'Petrova1','oksana1@mail.com', '88213549561'),
('Oksana1', 'Petrova2','oksana2@mail.com', '87213519561'),
('Oksana2', 'Petrova3','oksana3@mail.com', '86213549561'),
('Oksana3', 'Petrova4','oksana4@mail.com', '85212549561'),
('Oksana5', 'Petrova5','oksana5@mail.com', '84213549551');

SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;

ALTER TABLE profiles ADD COLUMN is_active bool DEFAULT TRUE;


SELECT * FROM profiles;
SELECT * FROM users;

INSERT INTO profiles (user_id, gender, birthday, city, country)
VALUES (3, 'x', '2010-12-12', 'SPB', 'Russia'),
(4, 'm', '2015-12-12', 'SPB', 'Russia'),
(5, 'm', '2010-12-12', 'SPB', 'Russia'),
(6, 'f', '2000-12-12', 'SPB', 'Russia'),
(7, 'f', '2001-12-12', 'SPB', 'Russia'),
(8, 'x', '2002-12-12', 'SPB', 'Russia'),
(9, 'x', '2003-12-12', 'SPB', 'Russia'),
(10, 'x', '2004-12-12', 'SPB', 'Russia');

UPDATE profiles SET is_active = FALSE WHERE datediff(date(now()), birthday) < 6570;

SELECT * FROM messages;

INSERT INTO messages(from_user_id, to_user_id, txt, updated_at)
VALUES (2,4, 'Привет!', '2022-08-31 22:11:11'),
(4,2, 'Привет!', '2022-08-31 22:12:11'),
(2,4, 'Как дела?', '2022-08-31 22:15:11'),
(4,2, 'Хорошо', '2022-08-31 22:17:11'),
(2,4, 'Письмо из будущего', '2023-08-31 22:11:11'),
(2,4, 'Еще одно письмо из будущего', '2023-08-31 22:11:11');

DELETE FROM messages WHERE datediff(now(), updated_at) < 0;