DROP SCHEMA IF EXISTS mondiali2010 CASCADE;

CREATE SCHEMA mondiali2010;

CREATE TABLE mondiali2010.stadio (
nome VARCHAR PRIMARY KEY,
citta VARCHAR,
capienza INTEGER);
CREATE TABLE mondiali2010.squadra (
nazione VARCHAR PRIMARY KEY,
confederazione VARCHAR,
data_qualifica DATE,
sponsor VARCHAR);
CREATE TABLE mondiali2010.partita ( 
stadio VARCHAR REFERENCES mondiali2010.stadio ON DELETE RESTRICT ON UPDATE CASCADE,
data DATE,
squadra1 VARCHAR  REFERENCES mondiali2010.squadra ON DELETE RESTRICT ON UPDATE CASCADE,
squadra2 VARCHAR  REFERENCES mondiali2010.squadra ON DELETE RESTRICT ON UPDATE CASCADE,
goal1 INTEGER,
goal2 INTEGER,
spettatori INTEGER,
PRIMARY KEY(stadio,data));

INSERT INTO mondiali2010.stadio VALUES('FNB Stadium', 'Johannesburg', 94700);
INSERT INTO mondiali2010.stadio VALUES('Green Point Stadium', 'Citta del Capo', 70000);
INSERT INTO mondiali2010.stadio VALUES('Nelson Mandela', 'Nelson Mandela Bay', 48000);
INSERT INTO mondiali2010.stadio VALUES('Ellis Park Stadium', 'Johannesburg', 61000);
INSERT INTO mondiali2010.squadra VALUES('Sudafrica', 'CAF', '15/06/2004','adidas');
INSERT INTO mondiali2010.squadra VALUES('Messico', 'CONCACAF', '10/10/2009','adidas');
INSERT INTO mondiali2010.squadra VALUES('Uruguay', 'CONMEBOL', '18/11/2009','puma');
INSERT INTO mondiali2010.squadra VALUES('Francia', 'UEFA', '18/11/2009','adidas');
INSERT INTO mondiali2010.squadra VALUES('Corea del Sud', 'AFC', '06/06/2009','nike');
INSERT INTO mondiali2010.squadra VALUES('Grecia', 'UEFA', '18/11/2009','adidas');
INSERT INTO mondiali2010.squadra VALUES('Argentina', 'CONMEBOL', '14/10/2009','adidas');
INSERT INTO mondiali2010.squadra VALUES('Nigeria', 'CAF', '14/11/2009','adidas');
INSERT INTO mondiali2010.partita VALUES('FNB Stadium', '06/11/2010', 'Sudafrica','Messico', 1,1,84490);
INSERT INTO mondiali2010.partita VALUES('Green Point Stadium', '11/06/2010', 'Uruguay','Francia', 0,0,64100);
INSERT INTO mondiali2010.partita VALUES('Nelson Mandela', '12/06/2010', 'Corea del Sud','Grecia', 2,0,31513);
INSERT INTO mondiali2010.partita VALUES('Ellis Park Stadium', '12/06/2010', 'Argentina','Nigeria', 1,0,55686);
