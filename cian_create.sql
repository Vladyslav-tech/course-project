DROP DATABASE IF EXISTS cian;
CREATE DATABASE cian;
USE cian;


-- пользователи

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(50)NOT NULL,
	lastname VARCHAR(50)NOT NULL,
	email VARCHAR(50) UNIQUE,
	phone BIGINT UNIQUE ,
	
	INDEX user_phone(phone),
	INDEX user_firstname_lastname(firstname,lastname)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
	rieltor BIT DEFAULT 0,
	gender CHAR(1),
    birthday DATE,
    hometown VARCHAR(50),
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (user_id) REFERENCES users(id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    
    FOREIGN KEY (from_user_id) REFERENCES users(id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT,
    FOREIGN KEY (to_user_id) REFERENCES users(id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT
);



DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums (
	id SERIAL PRIMARY KEY,
	name varchar(100) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT
    
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
	id SERIAL PRIMARY KEY,
	album_id BIGINT UNSIGNED NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT
);

	


-- недвижимость 

DROP TABLE IF EXISTS adress;
CREATE TABLE adress(
	id SERIAL PRIMARY KEY,
	city VARCHAR(20),
	district VARCHAR(20),
	street VARCHAR(20),
	house_number INT,
	
	INDEX indx_city(city),
	INDEX indx_district(district)
);

DROP TABLE IF EXISTS estate_types;
CREATE TABLE estate_types(
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	created_at DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS developers;
CREATE TABLE developers(
	id SERIAL PRIMARY KEY,
	name VARCHAR (50),
	founded_at DATE,
	
	INDEX indx_developers_id(id)
);	

DROP TABLE IF EXISTS estate;
CREATE TABLE estate(
	id SERIAL PRIMARY KEY,
	estate_types_id BIGINT UNSIGNED NOT NULL,
	quantity_of_rooms ENUM ('0','1','2','3','4','5') NOT NULL,
	`floor` TINYINT UNSIGNED NOT NULL,
	adress_id BIGINT UNSIGNED NOT NULL,
	description TEXT(250),
	price BIGINT UNSIGNED NOT NULL,
	houses_built_at DATE,
	photo_id BIGINT UNSIGNED NOT NULL,
	developers_id BIGINT UNSIGNED DEFAULT NULL,
	
	FOREIGN KEY (photo_id) REFERENCES  photos(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT,
	FOREIGN KEY (estate_types_id) REFERENCES  estate_types(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT,
    FOREIGN KEY (adress_id) REFERENCES  adress(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT,
    FOREIGN KEY (developers_id) REFERENCES  developers(id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT,
	
	INDEX flat_price(price),
	INDEX flats_idx_quantity_of_rooms(quantity_of_rooms)
);
	
	
-- объявления

DROP TABLE IF EXISTS advertisement_type;
CREATE TABLE advertisement_type(
	id SERIAL PRIMARY KEY,
	name VARCHAR (50),
	created_at DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS advertisement;
CREATE TABLE advertisement(
	id SERIAL PRIMARY KEY,
	advertisement_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	estate_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (estate_id) REFERENCES estate(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT,
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT,
	FOREIGN KEY (advertisement_type_id) REFERENCES advertisement_type(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT
	
);

DROP TABLE IF EXISTS favourite;
CREATE TABLE favourite(
	id SERIAL PRIMARY KEY,	
	user_id BIGINT UNSIGNED NOT NULL,
	advertisement_id BIGINT UNSIGNED NOT NULL,
	add_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT,
	FOREIGN KEY (advertisement_id) REFERENCES advertisement(id)
		ON UPDATE CASCADE
    	ON DELETE RESTRICT
);
	
	
	
	