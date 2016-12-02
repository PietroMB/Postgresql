--estrai tutto nella tua home directory

DROP SCHEMA IF EXISTS scacchi CASCADE;

CREATE SCHEMA scacchi;
CREATE DOMAIN scacchi.dom_eco AS CHAR(3);
CREATE DOMAIN scacchi.dom_risultato AS CHAR(3)  CHECK (VALUE='0-1' OR VALUE='1-0'  OR  VALUE='1/2' OR VALUE IS NULL);
CREATE DOMAIN scacchi.dom_nome_giocatore  AS VARCHAR(20);

CREATE TABLE scacchi.giocatore(
  nome scacchi.dom_nome_giocatore  PRIMARY KEY,
  nazionalita  VARCHAR(20)
);

CREATE TABLE scacchi.apertura(
  eco scacchi.dom_eco  PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  variante  VARCHAR(256)
);

CREATE TABLE scacchi.partita(
  bianco scacchi.dom_nome_giocatore REFERENCES scacchi.giocatore ON UPDATE CASCADE ON DELETE RESTRICT,
  nero scacchi.dom_nome_giocatore  REFERENCES scacchi.giocatore ON UPDATE CASCADE ON DELETE RESTRICT,
  luogo VARCHAR(30),
  anno  INTEGER CHECK (anno > 1600),
  round INTEGER CHECK (round > 0),
  eco scacchi.dom_eco  REFERENCES scacchi.apertura ON UPDATE CASCADE ON DELETE RESTRICT,
  risultato scacchi.dom_risultato,
  num_mosse INTEGER CHECK (num_mosse >= 0 OR num_mosse IS NULL), 
  PRIMARY KEY (bianco,nero,luogo,anno,round)
);

--Popolazione Tabelle

set search_path to scacchi;
\copy giocatore from giocatore.txt;
\copy apertura from apertura.txt;
\copy partita from partita.txt;

--Query

select partita.num_mosse from partita, apertura where partita.eco=apertura.eco and apertura.nome = 'Difesa Francese';
select nazionalita from giocatore, partita where anno = '1996' and (bianco=nome or nero=nome) group by (nome);
select a.nome, variante, risultato from apertura as a, giocatore as g, partita as p where p.eco=a.eco and (bianco=g.nome or nero=g.nome) and g.nome='Kasparov' and risultato='1/2';
select nome from giocatore where nazionalita=(select nazionalita from giocatore where nome='Kramnik');
select nome, variante from apertura where nome>(select nome from apertura where eco='E86');
select p.eco, anno, luogo from partita as p, apertura as a where a.variante like '%2 c3' and p.eco=a.eco;
select eco, bianco from partita where eco not in (select eco from partita where bianco='Kasparov'and eco is not null);
select eco from partita where round<(select min(round) from partita where bianco='Deep Blue' or nero='Deep Blue');
select nazionalita from giocatore, partita where nome in (select bianco from partita where risultato='1-0');
--Prof Version
select nero from partita where nero not in (select nero from partita where risultato <> '0-1' or risultato is null);
--My Version
select nero from partita where nero not in (select nero from partita where risultato <> '0-1') and risultato is not null;
select a.nome from apertura as a, giocatore as g, partita as p where g.nazionalita='Null' and (g.nome = p.bianco or g.nome = p.nero) and p.eco = a.eco;  
select nero,count(nero) from partita where risultato='0-1' group by nero;
