DROP SCHEMA IF EXISTS mondiali2010 CASCADE;

CREATE SCHEMA mondiali2010;

set search_path to mondiali2010;

CREATE TABLE stadio (
nome VARCHAR PRIMARY KEY,
citta VARCHAR,
capienza INTEGER);
CREATE TABLE squadra (
nazione VARCHAR PRIMARY KEY,
confederazione VARCHAR,
data_qualifica DATE,
sponsor VARCHAR);
CREATE TABLE partita ( 
stadio VARCHAR REFERENCES stadio ON DELETE RESTRICT ON UPDATE CASCADE,
data DATE,
squadra1 VARCHAR  REFERENCES squadra ON DELETE RESTRICT ON UPDATE CASCADE,
squadra2 VARCHAR  REFERENCES squadra ON DELETE RESTRICT ON UPDATE CASCADE,
goal1 INTEGER,
goal2 INTEGER,
spettatori INTEGER,
PRIMARY KEY(stadio,data));

INSERT INTO stadio VALUES('FNB Stadium', 'Johannesburg', 94700);
INSERT INTO stadio VALUES('Green Point Stadium', 'Citta del Capo', 70000);
INSERT INTO stadio VALUES('Nelson Mandela', 'Nelson Mandela Bay', 48000);
INSERT INTO stadio VALUES('Ellis Park Stadium', 'Johannesburg', 61000);
INSERT INTO squadra VALUES('Sudafrica', 'CAF', '15/06/2004','adidas');
INSERT INTO squadra VALUES('Messico', 'CONCACAF', '10/10/2009','adidas');
INSERT INTO squadra VALUES('Uruguay', 'CONMEBOL', '18/11/2009','puma');
INSERT INTO squadra VALUES('Francia', 'UEFA', '18/11/2009','adidas');
INSERT INTO squadra VALUES('Corea del Sud', 'AFC', '06/06/2009','nike');
INSERT INTO squadra VALUES('Grecia', 'UEFA', '18/11/2009','adidas');
INSERT INTO squadra VALUES('Argentina', 'CONMEBOL', '14/10/2009','adidas');
INSERT INTO squadra VALUES('Nigeria', 'CAF', '14/11/2009','adidas');
INSERT INTO partita VALUES('FNB Stadium', '06/11/2010', 'Sudafrica','Messico', 1,1,84490);
INSERT INTO partita VALUES('Green Point Stadium', '11/06/2010', 'Uruguay','Francia', 0,0,64100);
INSERT INTO partita VALUES('Nelson Mandela', '12/06/2010', 'Corea del Sud','Grecia', 2,0,31513);
INSERT INTO partita VALUES('Ellis Park Stadium', '12/06/2010', 'Argentina','Nigeria', 1,0,55686);


select s.nome from stadio s where s.nome = (select stadio from partita, squadra where (squadra1=nazione or squadra2=nazione) and sponsor='puma');

select s.nome from stadio s, partita p, squadra sq where s.nome=p.stadio and (squadra1=nazione or squadra2=nazione) and sponsor='puma'; 
