DROP DATABASE IF EXISTS vk;

CREATE DATABASE IF NOT EXISTS vk;

USE vk;

SHOW tables;


CREATE TABLE IF NOT EXISTS users(
	id bigint UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	firstname varchar(150) NOT NULL,
	lastname varchar(150) NOT NULL,
	email varchar(150) NOT NULL UNIQUE,
	phone char(11) NOT NULL UNIQUE,
	password_hash CHAR(65) DEFAULT NULL,
	created_at datetime NOT NULL DEFAULT current_timestamp
);

INSERT users VALUES (1, 'Petya', 'Petyhov', 'petya@mail.ru', '89119232323', NULL, DEFAULT);

INSERT users VALUES (DEFAULT, 'Vasya', 'Pupkin', 'pup@mail,ru', '89221231212', NULL, DEFAULT);
SELECT * FROM users;


CREATE TABLE profiles(
	user_id bigint UNSIGNED PRIMARY KEY,
	gender enum('f', 'm', 'x') NOT NULL,
	birthday date NOT NULL,
	photo_id BIGINT UNSIGNED,
	city VARCHAR(130),
	country VARCHAR(130),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT profiles VALUES (1, 'm', '1997-12-12', NULL, 'Moscow', 'Russia')

INSERT profiles VALUES (2, 'm', '1996-12-12', NULL, 'Moscow', 'Russia')

SELECT * FROM profiles;

CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	is_delivered BOOLEAN DEFAULT FALSE,
	created_at datetime NOT NULL DEFAULT NOW(),
	updated_at datetime DEFAULT CURRENT_timestamp ON UPDATE CURRENT_timestamp,
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT messages VALUES (DEFAULT, 1, 2, 'Hi', DEFAULT, DEFAULT, DEFAULT);
INSERT messages VALUES (DEFAULT, 2, 1, 'Ololo', DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM messages;

CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOL DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	CONSTRAINT fk_friend_requests_from_user_id FOREIGN KEY (from_user_id) REFERENCES users (id),
	CONSTRAINT fk_friend_requests_to_user_id FOREIGN KEY (to_user_id) REFERENCES users (id)
);


INSERT friend_requests VALUES (1, 2, DEFAULT);

INSERT friend_requests VALUES (2, 1, DEFAULT);

SELECT * FROM friend_requests;

CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description VARCHAR(255),
	admin_id BIGINT UNSIGNED NOT NULL,
	INDEX (name),
	FOREIGN KEY (admin_id) REFERENCES users (id)
);

INSERT communities VALUES (DEFAULT, 'Number 1', 'I am number one', 1);
INSERT communities VALUES (DEFAULT, 'Number 2', 'I am number two', 1);

SELECT * FROM communities;

CREATE TABLE communities_users (
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (community_id, user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT communities_users VALUES (1, 2, DEFAULT);

SELECT * FROM communities_users;

CREATE TABLE media_types (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

CREATE TABLE media (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	file_name VARCHAR(255) NOT NULL COMMENT '/files/folder/img.png',
	file_size BIGINT UNSIGNED,
	media_types_id INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

INSERT media VALUES (DEFAULT, 1, 'test1.jpg', 100, 1, DEFAULT);
INSERT media VALUES (DEFAULT, 1, 'test2.jpg', 120, 1, DEFAULT);
INSERT media VALUES (DEFAULT, 2, 'test.doc', 500, 3, DEFAULT);

SELECT * FROM media;

DESCRIBE users;

ALTER TABLE users ADD COLUMN passport_number VARCHAR(10);

ALTER TABLE users MODIFY COLUMN passport_number VARCHAR(20);

ALTER TABLE users RENAME COLUMN passport_number TO passport;

ALTER TABLE users ADD KEY passport_idx (passport);

ALTER TABLE users DROP KEY passport_idx;

ALTER TABLE users DROP COLUMN passport;

#Homework

CREATE TABLE user_online (
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	online BOOL DEFAULT FALSE,
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT user_online VALUES (1, TRUE);

SELECT * FROM user_online;

CREATE TABLE user_status(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	status varchar(300),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT user_status VALUES (1, 'На учебе');

SELECT * FROM user_status;

CREATE TABLE user_post(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	post_name varchar(130) NOT NULL,
	post_txt TEXT NOT NULL,
	post_img varchar(120) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users (id)
	
);

INSERT user_post VALUES (1, 'Первая запись', 'Текст для первой записи', DEFAULT, DEFAULT);

SELECT * FROM user_post;