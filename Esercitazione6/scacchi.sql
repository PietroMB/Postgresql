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
