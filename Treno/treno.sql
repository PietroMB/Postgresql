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
insert into treno values('b2', current_timestamp, '00004', current_timestamp + (900*interval '1 minute'), '00002', 'fs');
insert into treno values('b3', current_timestamp, '00005', current_timestamp + (900*interval '1 minute'), '00002', 'fs');
insert into treno values('b4', current_timestamp, '00005', current_timestamp + (900*interval '1 minute'), '00002', 'italo');

insert into percorso values('a1','Perugia');
insert into percorso values('a2','Bologna');
insert into percorso values('b1','Parigi');

/*query*/

select * from treno where stazionep in (select codice from stazione where citta='Perugia') or stazionea in (select codice from stazione where citta='Roma');

select * from treno where stazionep not in (select codice from stazione where citta='Bologna');

select x.azienda from treno x where x.stazionep in (select s.codice from stazione s) group by x.azienda having count (*) = (select count(*) from stazione);

/*java*/
/*
        String url="jdbc:postgresql://127.0.0.1/postgres";
        String userid="postgres";
        String password="postgres";
	con=DriverManager.getConnection(url,userid,password);
	Statment s = con.createStatment();
	s.executeUpdate("alter table citta add numStazioni int");
	ResultSet rs = s.executeQuery("select nome, count(codice) from fs.stazione group by citta");
	PreparedStatment ps = con.preparedStatment("insert into fs.citta values (?,?)");
	while(rs.next()){
		String citta=rs.getString("citta");
		int numStazioni=(int)rs.getString("count");
		ps.setString(1, citta);
		ps.setString(2, numStazioni);
		ps.execute();
	}
	rs.close();
	ps.close();
	s.close();
	con.close();*/

/*trigger*/

alter table citta add numStazioni int;

create function contac() returns trigger as $BODY$
	declare 
	citta varchar(50);
	begin

		update citta set numstazioni=(select count(s.citta) from stazione s where s.citta=new.citta group by s.citta) where nome=new.citta;
		RETURN NEW;
	end
	$BODY$
LANGUAGE PLPGSQL;

create trigger contac after delete or update or insert on stazione for each row execute procedure contac();

/*
	r record;

		FOR r IN SELECT stazione.citta, COUNT(*) FROM stazione GROUP BY stazione.citta LOOP
			UPDATE citta SET numstazioni = r.count WHERE citta.nome = r.citta;
		END LOOP;
*/
