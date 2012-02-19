CREATE TABLE boards (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    f_id_cat int NOT NULL,
    description varchar(1024) DEFAULT '' NOT NULL,
    primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE categories (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    ind int NOT NULL,
    primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE extaccount (
    id int NOT NULL AUTO_INCREMENT,
    f_id_acc int NOT NULL,
    ava varchar(255),
    primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE replys (
    id int NOT NULL AUTO_INCREMENT,
    f_id_acc int NOT NULL,
    date timestamp default NOW(),
    f_id_them int NOT NULL,
    content text NOT NULL,
    primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE themes (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    type int DEFAULT 4 NOT NULL,
    date timestamp default NOW(),
    f_id_bor int DEFAULT -1 NOT NULL,
    author int NOT NULL,
    status int,
    primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ipfilter (
    id integer NOT NULL,
    ip varchar(16) NOT NULL,
    f_id_acc integer NOT NULL,
    primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
