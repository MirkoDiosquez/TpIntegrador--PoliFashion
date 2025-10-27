/* EJERCICIO 3 */
delimiter //
create procedure prendasMasVendidas (in fechaInicio date, in fechaFin date)
begin
	declare cantVentas int default 0;
    select count(*) into cantVentas from compra_detalle;
	select prenda.idPrenda, sum(compra_detalle.cantidad * compra_detalle.precioUnitario) as ingresosGenerados, sum(compra_detalle.cantidad) as cantidadVendida from prenda join compra_detalle on prenda.idPrenda = compra_detalle.idPrenda join compra on compra_detalle.idCompra=compra.idCompra where datetimeCompra between fechaInicio and fechaFin group by prenda.idPrenda order by cantidadVendida desc;
end //
delimiter ;
call prendasMasVendidas ('2025-10-10','2025-10-12');

/* EJERCICIO 4 terminado */
/* aca estamos devolviendo directamente toda la compra, no sabemos si hay q especificar una prenda para devolver */
delimiter //
create procedure devolucionPrenda (in idVenta int, in dniClient varchar(45))
begin
	declare hayFilas boolean default 1;
	declare existeCompra boolean default 0;
    declare costoCompra int default 0;
	declare idP int ;
	declare idM int ;
	declare idCD int ;
    declare idDev int ;
	declare cant int ;
	declare cursorC cursor for select idVariantePrenda,prenda.idMarca,cantidad from compra_detalle join prenda_has_talleycolor p
	on p.id = idVariantePrenda join prenda on prenda.idPrenda = p.p_idPrenda where idCompra = idVenta;
     declare continue handler for not found set hayFilas = 0;

    if exists (select 1 from compra_detalle where idCompra = idVenta) then
		set existeCompra = true;
	end if;
    
	if existeCompra then
		open cursorC;
			cloop:loop
				fetch cursorC into idP, idM, cant;
				if hayFilas=0 then
					leave cloop;
				end if;
                
		if ( (chequearVentasMinimasMarca(idM) and corroborarAntiguedad(idVenta)) and noSeDevolvioAntes(idVenta) ) then
			select costoTotal into costoCompra from compra where idCompra = idVenta;
            select id into idCD from compra_detalle where idCompra = idVenta and idVariantePrenda = idP;
			
            insert into devolucion (idCompra, dniCliente, fechaHora, montoTotalReembolsado)
            values (idVenta, dniClient, now(), costoCompra);
            
            set idDev = last_insert_id();
            
            insert into devolucion_detalle (idDevolucion, idCompraDetalle, cantidadDevuelta)
            values (idDev, idCD, cant);
            
            update prenda_has_talleycolor set stock = stock + cant where id = idP;
		else
			signal sqlstate '45000' set message_text = 'No se puede devolver esta compra';
        end if; 
        end loop;
        close cursorC;
	else 
		signal sqlstate '45000' set message_text = 'No existe esa compra';
    end if;
end //
delimiter ;


call devolucionPrenda(1, 12345678);

delimiter //
create function noSeDevolvioAntes(idCompra int) returns boolean deterministic
begin
	declare nodevuelto boolean default true;
    if exists (select 1 from devolucion where devolucion.idCompra = idCompra) then
		set nodevuelto = false;
	end if;
    
    return nodevuelto;
end //
delimiter ;

delimiter //
create function cantVentasPorMarca(idM int) returns int deterministic
begin
declare cantVentas int default 0;
	select count(*) into cantVentas from compra_detalle 
	join prenda_has_talleycolor p on idVariantePrenda = p.id
	join prenda on p.p_idPrenda = prenda.idPrenda
	where idMarca = idM ;
    return cantVentas;
end // 
delimiter ;

delimiter //
create function chequearVentasMinimasMarca(idM int) returns boolean deterministic
begin
	declare puedeDevolver boolean default false;
    declare cantMin int default 0;
    select ventasMinimasParaDevolucion into cantMin from marca where idMarca = idM;
	if ( cantVentasPorMarca(idM) >= cantMin ) then
		set puedeDevolver = true;
	end if;
	return puedeDevolver ;
end //
delimiter ;

delimiter //
create function corroborarAntiguedad ( idCompra int ) returns boolean deterministic 
begin
	declare puedeDevolver boolean default 0;
	declare fecha datetime;
    select datetimeCompra into fecha from compra where compra.idCompra = idCompra;
    if ( fecha < date_sub(now(), interval 30 DAY) ) then
		set puedeDevolver = true;
	end if;
    return puedeDevolver;
end //
delimiter ;


-- Ejercicio 5--
delimiter //
create procedure bonusClientes () 
begin
	declare fechaFin date;
	declare fechaInicio date;
    set fechaInicio = curdate();
    set fechaFin = date_sub(curdate(), interval 7 day);
    
	update cliente set puntos = (puntos + (puntos * 0.05) ) where cliente.dni in ( select compra.clienteDni from compra where datetimeCompra between fechaInicio and fechaFin );
end //
delimiter ;