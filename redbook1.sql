drop database if exists redbook1;
create database redbook1 default character set utf8;
# ovu sljedeću liniju copy/paste u command prompt
# PRIPAZITI SAMO NA PUTANJU DATOTEKE
# c:\xampp\mysql\bin\mysql.exe -uedunova -pedunova --default_character_set=utf8 < D:\PP20\redbook.hr\redbook1.sql

# BACKUP
# c:\xampp\mysql\bin\mysqldump.exe -uedunova -pedunova redbook > d:\redbook1.sql

use redbook1;

create table istrazivac(
sifra       		int not null primary key auto_increment,
email       		varchar(50) not null,
lozinka     		char(60) not null,
ime         		varchar(50) not null,
prezime     		varchar(50) not null,
uloga       		varchar(20) not null
);


insert into istrazivac values 
(null,'admin@redbook.hr',
'$2y$10$AzFzPK10Gi3nYBfpVKGYPeiyeQ8JOQOkfGJJ1jKJnQ.2hacJ2iwBi',
'Ivan','Damjanović','admin');


insert into istrazivac values 
(null,'istrazivac@redbook.hr',
'$2y$10$AzFzPK10Gi3nYBfpVKGYPeiyeQ8JOQOkfGJJ1jKJnQ.2hacJ2iwBi',
'Redbook','Istrazivac','istrazivac');

insert into istrazivac values
(null,'vrozac@gmail.com',
'$2y$10$AzFzPK10Gi3nYBfpVKGYPeiyeQ8JOQOkfGJJ1jKJnQ.2hacJ2iwBi',
'Vlatko','Rožac','istrazivac');

create table vrsta(
    sifra               int not null primary key auto_increment,
    ime                 varchar(50),
    kategorija          varchar(50),
    istrazivac          int,
    ugrozenost          int
);

create table projekt(
    sifra               int not null primary key auto_increment,
    naziv               varchar(50) not null,
    vrsta               int not null,
    istrazivac          int not null
);

alter table vrsta add foreign key (istrazivac) references istrazivac(sifra);

alter table projekt add foreign key (vrsta) references vrsta(sifra);
alter table projekt add foreign key (istrazivac) references istrazivac(sifra);


describe vrsta;
select * from vrsta;
insert into vrsta (sifra,ime,ugrozenost) values
    (null,'Spermophilus citelus',3),
    (null,'Mustela lutreola',3),
    (null,'Monachus monachus',3),
    (null,'Castor fiber',3),
    (null,'Lynx lynx',3),
    (null,'Rupicapra rupicapra',3),
    (null,'Talpa cf. europea',5),
    (null,'Plecotus austriacus',5),
    (null,'Myotis capaccinii',5),
    (null,'Myotis bechsteinii',6),
    (null,'Delphinus delphis',9),
    (null,'Lutra lutra',9),
    (null,'Nyctalus leisleri',7),
    (null,'Sciurus vulgaris',7),
    (null,'Cricetus cricetus',7),
    (null,'Canis lupus',7),
    (null,'Ursus arctos',7),
    (null,'Glis glis',8);

insert into vrsta (sifra,ime,ugrozenost) values
(null,'Felis silvestris',8);

update vrsta 
set kategorija = 'Šišmiš' 
where ime = 'Myotis capaccinii';
update vrsta 
set kategorija = 'Šišmiš'
where ime = 'Myotis bechsteinii';
update vrsta 
set kategorija = 'Šišmiš'
where ime = 'Nyctalus leisleri';
update vrsta 
set kategorija = 'Šišmiš'
where ime = 'Plecotus austriacus';
update vrsta 
set kategorija = 'Glodavac' 
where ime = 'Spermophilus citelus';