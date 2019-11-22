drop database if exists bioraznolikost;
create database bioraznolikost;
use bioraznolikost;

create table istrazivac(
    sifra       int not null primary key auto_increment,
    ime         varchar(50),
    prezime     varchar(50)
);

create table ugrozenost(
    sifra       int not null primary key auto_increment,
    naziv       char(2)
);

create table vrsta(
    sifra       int not null primary key auto_increment,
    ime         varchar(100),
    istrazivac  int not null,
    ugrozenost  int not null
);

alter table vrsta add foreign key (istrazivac) references istrazivac(sifra);
alter table vrsta add foreign key (ugrozenost) references ugrozenost(sifra);

describe istrazivac;
select * from istrazivac;

insert into istrazivac (sifra,ime,prezime) values
(null,'Carl','Linnaeus'),
(null,'Carl','Hermann'),
(null,'Alexandr','Fischer'),
(null,'Charles Lucien','Bonaparte'),
(null,'Heinrich','Kuhl');

describe ugrozenost;
select * from ugrozenost;

insert into ugrozenost (sifra,naziv) values
(null,'EX'),
(null,'EW'),
(null,'RE'),
(null,'CR'),
(null,'EN'),
(null,'VU'),
(null,'NT'),
(null,'LC'),
(null,'DD');

describe vrsta;
select * from vrsta;

insert into vrsta (sifra,ime,istrazivac,ugrozenost) values
(null,'Spermophilus citelus',1,3),
(null,'Mustela lutreola',1,3),
(null,'Monachus monachus',2,3),
(null,'Castor fiber',1,3),
(null,'Lynx lynx',1,3),
(null,'Rupicapra rupicapra',1,3),
(null,'Talpa cf. europea',1,5),
(null,'Plecotus austriacus',3,5),
(null,'Myotis capaccinii',4,5),
(null,'Miniopterus schreibersii',5,5);