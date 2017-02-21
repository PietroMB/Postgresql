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

/*a*/select s.nome from socio as s, ha_letto as h where h.socio=s.id_socio and s.sesso='F' group by(s.nome); 

/*b*/select l.titolo from libro as l, generi as g where l.genere=g.nome and g.sala='A';

/*c*/select l.titolo, g.sala from libro as l, generi as g where l.genere=g.nome;

/*e*/select s.id_socio from socio as s, generi as g, libro as l, ha_letto as h where s.id_socio=h.socio and l.ISBN=h.ISBN and l.genere=g.nome and g.sala='A';

/*g*/select s.nome from socio as s, generi as g, libro as l, ha_letto as h where s.id_socio=h.socio and l.ISBN=h.ISBN and l.genere=g.nome and g.sala='A' group by (s.nome);

/*h*/select s.nome from scrittore as s, ha_letto as h, libro as l, socio as so where s.nome=l.autore and l.ISBN=h.ISBN and so.id_socio=h.socio and so.sesso='F';

/*i*/select s.id_socio from socio as s, generi as g, libro as l, ha_letto as h where s.id_socio=h.socio and l.ISBN=h.ISBN and l.genere=g.nome and g.sala != 'B' group by(s.id_socio);

/*j*/select s.id_socio from socio as s, generi as g, libro as l, ha_letto as h where s.id_socio=h.socio and l.genere=g.nome and g.sala != 'B' group by(s.id_socio);

/*k*/select l.titolo from libro as l, generi as g where l.genere=g.nome and g.sala=(select ge.sala from generi as ge, libro as li where li.genere=ge.nome and li.titolo='Ossi di seppia');

/*l*/select autore from libro where titolo<(select titolo from libro where ISBN='88-55-55555-5') order by titolo;

/*m*/select l.autore from libro as l, ha_letto as h where h.ISBN=l.ISBN and l.titolo<(select titolo from libro where ISBN='88-55-55555-5') order by (l.titolo);

/*n*/select s.id_socio from socio as s, ha_letto as h where h.socio=s.Id_socio and h.ISBN<(select MIN(li.ISBN) from libro as li, generi as ge where ge.nome=li.genere and ge.sala='B') group by s.id_socio;


/*d,f da fare*/
