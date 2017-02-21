drop schema if exists biblioteca cascade;
create schema biblioteca;
set search_path to biblioteca;
create table scrittore(
	nome varchar(50) primary key,
	sesso char check(sesso='M' or sesso='F'),
	nazione varchar(50)
);

create table generi(
	nome varchar(50) primary key,
	sala varchar(50)
);
	
create table libro(
	ISBN varchar(20) primary key,
	titolo varchar(50),
	autore varchar(50) references scrittore(nome) on delete restrict,
	genere varchar(30) references generi(nome) on delete cascade
);

create table socio(
	id_socio varchar(50) primary key,
	nome varchar(50),
	sesso char check(sesso='M' or sesso='F'),
	eta int
);

create table ha_letto(
	ISBN varchar(20) references libro(ISBN) on delete cascade on update cascade,
	socio varchar(50) references socio(id_socio) on delete cascade on update cascade,
	primary key(ISBN, socio)
);


\copy scrittore from Scrittore.txt;
\copy generi from Genere.txt;
\copy libro from Libro.txt;
\copy socio from Socio.txt;
\copy ha_letto (socio, ISBN) from Ha_letto.txt;

select s.nome from socio as s, ha_letto as h where h.socio=s.id_socio and s.sesso='F' group by(s.nome); 

select l.titolo from libro as l, generi as g where l.genere=g.nome and g.sala='A';

select l.titolo, g.sala from libro as l, generi as g where l.genere=g.nome;


