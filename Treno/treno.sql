drop schema if exists fs cascade;

create schema fs;

set search_path to fs;

create table citta(
	nome varchar(50) primary key,
	numeroabitanti int,
	nazione varchar(50)
);

create table stazione(
	codice varchar(50) primary key,
	nome varchar(50),
	categoria varchar(50),
	citta varchar(50) references citta(nome)
);

create table treno(
	codice varchar(50) primary key,
	orariop timestamp(0),
	stazionep varchar(50) references stazione(codice),
	orarioa timestamp(0),
	stazionea varchar(50) references stazione(codice),
	azienda varchar(50)
);

create table percorso(
	treno varchar(50) references treno(codice),
	citta varchar(50) references citta(nome)
);

insert into citta values('Perugia', 200000, 'Italia');
insert into citta values('Bologna', 600000, 'Italia');
insert into citta values('Roma', 6500000, 'Italia');
insert into citta values('Milano', 3000000, 'Italia');
insert into citta values('Parigi', 8000000, 'Francia');
insert into citta values('Basilea', 300000, 'Svizzera');

insert into stazione values('00001','Milano Centrale', 'A', 'Milano');
insert into stazione values('00002','Roma Centrale', 'A', 'Roma');
insert into stazione values('00003','Bologna Centrale', 'A', 'Bologna');
insert into stazione values('00004','Perugia Fontivegge', 'B', 'Perugia');
insert into stazione values('00005','Paris', 'A', 'Parigi');
insert into stazione values('00006','Basel', 'C', 'Basilea');

insert into treno values('a1', current_timestamp, '00001', current_timestamp + (60*interval '1 minute'), '00002', 'fs');
insert into treno values('a2', current_timestamp, '00003', current_timestamp + (160*interval '1 minute'), '00005', 'fs');
insert into treno values('a3', current_timestamp, '00002', current_timestamp + (260*interval '1 minute'), '00004', 'fs');
insert into treno values('b1', current_timestamp, '00006', current_timestamp + (900*interval '1 minute'), '00002', 'fs');
