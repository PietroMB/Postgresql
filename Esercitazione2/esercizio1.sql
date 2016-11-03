drop schema if exists cinema cascade;

create schema cinema;

set search_path to cinema;

create table persona(
	id_persona int primary key,
	nome char(50) not null,
	cognome char(50) not null
);

create table film(
	id_film int primary key,
	id_regista int references persona(id_persona) on delete set null,
	titolo char(50),
	genere char(50),
	anno int default NULL check (anno > 0 or anno = NULL)
);

create table partecipazione(
	id_attore int references persona(id_persona) on delete cascade,
	id_film int references film(id_film) on delete cascade,
	ruolo char(50),
	primary key(id_attore, id_film)
);

create table cinema(
	id_cinema int primary key,      
	nome char(50) not null,
	indirizzo char(50)
);

create table proiezione(
	id_cinema int references cinema(id_cinema) on delete cascade,  
	id_film int references film(id_film) on delete cascade,
	giorno date,
	primary key(id_cinema,id_film,giorno)
);

insert into cinema values (02, 'S. Angelo', 'Via Lucida 6 Perugia');
insert into cinema values (01, 'Zenith', 'Via Bonfigli 11 Perugia');
insert into cinema values (03, 'Multisala Clarici', 'Corso Cavour 84 Foligno');
insert into cinema values (04, 'Multiplex Giometti', 'Strada Centova Perugia');

-- wget http://www.dmi.unipg.it/raffaella.gentilini/cinema/persona.txt
-- wget http://www.dmi.unipg.it/raffaella.gentilini/cinema/film.txt
-- wget http://www.dmi.unipg.it/raffaella.gentilini/cinema/partecipazione.txt
-- wget http://www.dmi.unipg.it/raffaella.gentilini/cinema/proiezione.txt

\copy persona (id_persona, cognome, nome)  from persona.txt;
\copy film from film.txt;
\copy partecipazione from partecipazione.txt;
\copy proiezione from proiezione.txt;

-- NB il wget dovrà essere fatto sulla home dell'utente da cui lanciate il comando psql

delete from persona where nome= 'John' and cognome = 'Travolta';
