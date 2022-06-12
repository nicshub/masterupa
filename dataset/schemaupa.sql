
-- drop table Ad;
-- drop table News;
-- drop table User;
-- drop table Item;
-- drop table Page;
-- drop table Writer;

-- drop table contain_a;
-- drop table contain_n;
-- drop table contain_i;
-- drop table open;
-- drop table write;
-- drop table read;
-- drop table click;
-- drop table interact;



-- Entities definition. Please note entity names are capitalized
-- Also we tried to define entities starting with different letter, this
-- simplifies the id definition

create table User(
       cookieId text NOT NULL PRIMARY KEY,
       uId integer UNIQUE, -- This is null if the user is not registered
       name text
);
-- https://www.cognomix.it/cognomi-piu-diffusi-in-italia.php
-- https://www.nomix.it/nomi-piu-diffusi-in-italia.php
insert into User(cookieId, uid, name)  values ('a001','mario.rossi@upa.it',"Mario Rossi");
insert into User(cookieId, uid, name)  values ('a002','maria.russo@upa.it',"Maria Russo");
insert into User(cookieId, uid, name)  values ('a003','giuseppe.ferrari@upa.it',"Giuseppe Ferrari");
insert into User(cookieId, uid, name)  values ('a004','antonio.bianchi@upa.it',"Antonio Bianchi");
insert into User(cookieId, uid, name)  values ('a005','giuseppina.romano@upa.it',"Giuseppina Romano");
insert into User(cookieId, uid, name)  values ('a006','rosa.colombo@upa.it',"Rosa Colombo");
insert into User(cookieId, uid, name)  values ('a007','luigi.ricci@upa.it',"Luigi Ricci");
insert into User(cookieId, uid, name)  values ('a008','angela.marino@upa.it',"Angela Marino");
insert into User(cookieId, uid, name)  values ('a009',null,null);
insert into User(cookieId, uid, name)  values ('a010',null,null);

create table Writer(
       wId integer NOT NULL PRIMARY KEY AUTOINCREMENT,
       name text
);

insert into Writer(name) values 
('Cicerone'),
('Luigi Sailer'),
('Dante Alighieri'),
('Kranz Kafka'),
('Conte Mascetti');

create table News(
       nId integer NOT NULL PRIMARY KEY AUTOINCREMENT,
       title text,
       body text,
       author integer,
       pubOn timestamp DEFAULT CURRENT_TIMESTAMP, -- date/time of publishing 
       FOREIGN KEY(author) REFERENCES Writer(wId)
);

-- https://www.neting.it/tools/generatore-lorem-ipsum-online.html
insert into News(title, body, author) values 
('lorem ipsum', 'Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua',1),
('la vispa teresa', 'La vispa Teresa avea tra l''erbetta, a volo sorpresa gentil farfalletta. E tutta giuliva stringendola viva gridava a distesa',2),
('nel mezzo del cammin','Nel mezzo del cammin di nostra vita mi ritrovai per una selva oscura, ché la diritta via era smarrita.',3),
('One morning','One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin',4),
('Non si intrometta!','Non si intrometta! No, aspetti, mi porga l''indice; ecco lo alzi così... guardi, guardi, guardi; lo vede il dito?',5);


create table Ad(
       aId integer NOT NULL PRIMARY KEY AUTOINCREMENT,
       type char(1), -- Banner/Video/etc
       campaign text,
       brand text
);

-- https://udine.unicusano.it/studiare-a-udine/campagne-pubblicitarie-famose/
insert into Ad(type, campaign,brand) values
('v','i''d like to buy the world a coke','Coca Cola'),
('b','Just do it','Nike'),
('v','Think different','Apple'),
('b','I Want You','US Army'),
('c','Dove c''è Barilla c''è casa','Barilla');

-- https://www.ninjamarketing.it/2012/07/12/i-10-prodotti-piu-venduti-della-storia/
create table Item(
       iId integer NOT NULL PRIMARY KEY AUTOINCREMENT,
       description text,
       type char(10), -- Book,Toy,etc
       price real,
       producer text
);

-- https://www.ninjamarketing.it/2012/07/12/i-10-prodotti-piu-venduti-della-storia/
insert into Item(description, type, price, producer ) values
('Play Station','console',1000,'Sony'),
('Lipitor','pharmacy',30,'Pfizer'),
('Toyota Corolla','car',30000,'Toyota'),
('Star Wars','cinema',10,'Lucasfilm'),
('iPad','tablet',500,'Apple'),
('Mario Bros','videogames',50,'Nintendo'),
('Thriller','album',30,'CBS'),
('Harry Potter','book',20,'J. K. Rowling'),
('iPhone','smartphone',1000,'Apple'),
('Rubik''s Cube','toy',5,' Ideal Toy Corp');


create table Page(
       pId integer NOT NULL PRIMARY KEY AUTOINCREMENT,
       ts integer TIMESTAMP DEFAULT CURRENT_TIMESTAMP-- Timestamp of page being created
       );

-- Inserts
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;
insert into Page DEFAULT VALUES;

-- Relationship definition. Please note relationship names are all small letters.

create table open(
       cookieId integer,
       pId integer,
       ts integer DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the user opens the page
       PRIMARY KEY(cookieId, pId, ts),
       FOREIGN KEY(cookieId) REFERENCES User(cookieId),
       FOREIGN KEY(pId) REFERENCES Page(pId)
);

insert into open(cookieId, pId) 
select cookieId, pId from User, Page order by RANDOM();

create table contain_n(
       pId integer,
       nId integer,
       PRIMARY KEY( pId, nId),
       FOREIGN KEY(pId) REFERENCES Page(pId),
       FOREIGN KEY(nId) REFERENCES News(nId)
);

insert into contain_n(pId, nId) 
select pId, nId from Page, News order by RANDOM();

create table contain_a(
       pId integer,
       aId integer,
       PRIMARY KEY( pId, aId),
       FOREIGN KEY(pId) REFERENCES Page(pId),
       FOREIGN KEY(aId) REFERENCES Ad(aId)
);

insert into contain_a(pId, aId) 
select pId, aId from Page, Ad order by RANDOM();

create table contain_i(
       pId integer,
       iId integer,
       PRIMARY KEY( pId, iId),
       FOREIGN KEY(pId) REFERENCES Page(pId),
       FOREIGN KEY(iId) REFERENCES Item(iId)
);

insert into contain_i(pId, iId) 
select pId, iId from Page, Item order by RANDOM();


create table click(
       cookieId integer,
       aId integer,
       PRIMARY KEY( cookieId, aId),
       FOREIGN KEY(cookieId) REFERENCES User(cookieId),
       FOREIGN KEY(aId) REFERENCES Ad(aId)
);

insert into click(cookieId, aId) 
select cookieId, aId from User, Ad order by RANDOM() limit 10;

create table read(
       cookieId integer,
       nId integer,
       PRIMARY KEY( cookieId, nId),
       FOREIGN KEY(cookieId) REFERENCES User(cookieId),
       FOREIGN KEY(nId) REFERENCES News(nId)
);


insert into read(cookieId, nId) 
select cookieId, nId from User, News order by RANDOM();

create table interact(
       cookieId integer,
       iId integer,
       info timestamp, -- ts when the user collected info 
       basket timestamp, -- ts when the user put the item in the basket 
       buy timestamp, -- ts when the user buys the item
       PRIMARY KEY(cookieId, iId),
       FOREIGN KEY(cookieId) REFERENCES User(cookieId),
       FOREIGN KEY(iId) REFERENCES Item(iId)
);

-- Info
insert into interact(cookieId, iId, info) 
select cookieId, iId,CURRENT_TIMESTAMP from User, Item order by RANDOM() limit 70;

-- Select random 50 basket interation between the previuos one
UPDATE interact 
SET basket = datetime(interact.info,'+1 months')
FROM (SELECT 
            x.cookieId, x.iId, x.info, x.basket, x.buy 
        FROM 
            interact x
        WHERE 
            x.info IS NOT NULL 
        ORDER BY 
            random() 
            LIMIT 50
     ) AS s
WHERE 
interact.iId=s.iId AND interact.cookieId=s.cookieId;

-- Select random 30 buy interation between the previuos one
UPDATE interact 
SET buy = datetime(interact.basket,'+1 months')
FROM (SELECT 
            x.cookieId, x.iId, x.info, x.basket, x.buy 
        FROM 
            interact x
        WHERE 
            x.basket IS NOT NULL 
        ORDER BY 
            random() 
            LIMIT 30
     ) AS s
WHERE 
interact.iId=s.iId AND interact.cookieId=s.cookieId;


create table write(
       wId integer,
       nId integer,
       PRIMARY KEY( wId, nId),
       FOREIGN KEY(wId) REFERENCES Writer(wId),
       FOREIGN KEY(nId) REFERENCES News(nId)
);

insert into write(wId, nId) 
select wId, nId from Writer, News order by RANDOM();





       


       
       




       


       
       
