create function nome() returns trigger as
$BODY$
	declare

	variabile [tipo];

	begin
		query
		--new riferito a variabile locale
	end
$BODY$
LANGUAGE PLPGSQL;

create trigger nome after [delete or update or insert] on tablellaupdatata
	for each row execute procedure nome();
