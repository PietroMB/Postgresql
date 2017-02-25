select x.azienda from treno x, stazione s where x.stazionep=s.codice 
group by x.azienda having count (*) =
(select count(*) from stazione);


select s.nome from socio s where s.id_socio=
(select h.socio from ha_letto h where h.isbn in
	(select l.isbn from libro l where l.genere='poesia') group by h.socio having count(*) =
	(select count(*) from libro l2 where l2.genere='poesia')
);
