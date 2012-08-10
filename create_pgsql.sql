CREATE TABLE categories (
    id SERIAL UNIQUE NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(1024) NOT NULL,
    pos int NOT NULL,
    primary key(id)
);


CREATE TABLE boards (
    id SERIAL UNIQUE NOT NULL,
    name varchar(255) NOT NULL,
    f_id_cat int NOT NULL,
    FOREIGN KEY (f_id_cat) REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE,
    description varchar(1024) DEFAULT '' NOT NULL,
    type int NOT NULL default 1,
    primary key(id)
);


CREATE TABLE account (
    id SERIAL UNIQUE NOT NULL,
    username varchar(50) NOT NULL,
    psw varchar(255) NOT NULL,
    ava varchar(255),
    status int NOT NULL,
    primary key(id)
);

CREATE TABLE moders (
    f_id_b int NOT NULL,
    f_id_acc int NOT NULL,
    FOREIGN KEY(f_id_b) REFERENCES boards(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(f_id_acc) REFERENCES account(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE themes (
    id SERIAL UNIQUE NOT NULL,
    name varchar(255) NOT NULL,
    type int DEFAULT 4 NOT NULL,
    date timestamp default NOW(),
    f_id_bor int NOT NULL,
    f_id_acc int NOT NULL,
    FOREIGN KEY(f_id_bor) REFERENCES boards(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(f_id_acc) REFERENCES account(id) ON DELETE CASCADE ON UPDATE CASCADE,
    status int,
    primary key(id)
);

CREATE TABLE replys (
    id SERIAL UNIQUE NOT NULL,
    f_id_acc int NOT NULL,
    FOREIGN KEY(f_id_acc) REFERENCES account(id) ON DELETE CASCADE ON UPDATE CASCADE,
    date timestamp default NOW(),
    f_id_them int NOT NULL,
    FOREIGN KEY(f_id_them) REFERENCES themes(id) ON DELETE CASCADE ON UPDATE CASCADE,
    content text NOT NULL,
    primary key(id)
);

