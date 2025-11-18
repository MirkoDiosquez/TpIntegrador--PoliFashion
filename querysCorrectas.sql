
SHOW COLUMNS FROM devolucion;
SHOW COLUMNS FROM compra_detalle;
SHOW COLUMNS FROM prenda;


select * from prenda_has_talleycolor;


SHOW COLUMNS FROM marca;

select * from resenia;

select * from compra;

select * from devolucion;

select * from devolucion_detalle;

insert into devolucion values (1,14,12345678,now(),14999);

select * from devolucion_detalle;

select * from devolucion;

select * from compra_detalle;

select * from prenda_has_talleycolor;


drop trigger aumComision_y_AjusteStock;

delete from devolucion;
delete from devolucion_detalle;
drop function corroborarAntiguedad;
drop procedure devolucionPrenda;

select * from prenda_has_talleycolor;

select * from alerta_stock;

select * from prenda;

select * from compra;

delimiter //

/* EJERCICIO 1 */
create trigger aumComision_y_AjusteStock after insert on compra_detalle for each row
begin 	
	declare idMarc int default 0;
    declare stockMin int default 0;
    declare porcentajeDeMarca float default 0;
    declare stockUltimaPrendaComprada int default 0;
    
    
    
    select idMarca into idMarc from prenda join prenda_has_talleycolor ptc on prenda.idPrenda = ptc.p_idPrenda
    where ptc.p_idPrenda = NEW.idVariantePrenda;
    
    select porcentajeComision into porcentajeDeMarca from marca join prenda on marca.idMarca = prenda.idMarca
	join prenda_has_talleycolor ptc on prenda.idPrenda = ptc.p_idPrenda
	where ptc.id = NEW.idVariantePrenda;
    
    
    if ( porcentajeDeMarca < 15 ) then
		update marca set porcentajeComision = porcentajeComision + 0.05 where idMarca = idMarc;
	end if;
    
    -- El stock se actualiza igualmente. El if es para que no aumente su comision por cada venta-
    update prenda_has_talleycolor set stock = stock - NEW.cantidad where id = NEW.idVariantePrenda;
    
    update marca set cantidadVentasTotales = cantidadVentasTotales + NEW.cantidad where idMarca = idMarc;
    
    -- Obtengo el stock de la ultima prenda comprada y el stock mínimo
    select stock, stockMinimo into stockUltimaPrendaComprada, stockMin from prenda_has_talleycolor 
    where id = NEW.idVariantePrenda;


    if  ( stockMin > stockUltimaPrendaComprada) then
        insert into alertas_stock values (NEW.idVariantePrenda, now(), 'El stock de esta prenda está por debajo del mínimo');
    end if;

    
    
end//


delimiter ;

/* Ejercicio 2 */ 

delimiter //
create trigger chequeo_ventasMinimas before insert on devolucion_detalle for each row
begin
	declare idMarc int default 0;
	declare cantMinimasVentas int default 0;
    declare cantVentasTotales int default 0;
    
    -- Agarramos la marca de la prenda que está asociada en la devolucion --
	select m.idMarca into idMarc from compra_detalle cd join prenda_has_talleycolor ptc on cd.idVariantePrenda = ptc.id
    join prenda p on ptc.p_idPrenda = p.idPrenda
    join marca m on p.idMarca = m.idMarca
    where cd.id = NEW.idCompraDetalle;



	select ventasMinimasParaDevolucion into cantMinimasVentas from marca where idMarca = idMarc;
    select cantidadVentasTotales into cantVentasTotales from marca where idMarca = idMarc;
	
    if ( cantVentasTotales < cantMinimasVentas ) then
		signal SQLSTATE '45000' set message_text = "no se pudo realizar el cambio";
	end if;
    
    end//
    
    delimiter ; 




/* EJERCICIO 3 */
delimiter //
create procedure prendasMasVendidas (in fechaInicio date, in fechaFin date)
begin
	declare cantVentas int default 0;
    select count(*) into cantVentas from compra_detalle;
	select prenda.idPrenda, sum(compra_detalle.cantidad * compra_detalle.precioUnitario) as ingresosGenerados,
    sum(compra_detalle.cantidad) as cantidadVendida from prenda 
    join compra_detalle on prenda.idPrenda = compra_detalle.idVariantePrenda 
    join compra on compra_detalle.idCompra=compra.idCompra 
    where datetimeCompra between fechaInicio and fechaFin group by prenda.idPrenda order by cantidadVendida desc
	limit 10;
end //
delimiter ;
call prendasMasVendidas ('2025-10-10','2025-10-12');
drop procedure prendasMasVendidas;



/* EJERCICIO 4 terminado */
/* Aca estamos devolviendo directamente toda la compra*/
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
    
    
	if existeCompra and noSeDevolvioAntes(idVenta) then
		 start transaction;
         select costoTotal into costoCompra from compra where idCompra = idVenta;
            insert into devolucion (idCompra, dniCliente, fechaHora, montoTotalReembolsado)
            values (idVenta, dniClient, now(), costoCompra);
            
            set idDev = last_insert_id();
		open cursorC;
			cloop:loop
				fetch cursorC into idP, idM, cant;
				if hayFilas=0 and corroborarAntiguedad(idVenta) then
					leave cloop;
				end if;
               
		if (chequearVentasMinimasMarca(idM)) then

            select id into idCD from compra_detalle where idCompra = idVenta and idVariantePrenda = idP;
            
            insert into devolucion_detalle (idDevolucion, idCompraDetalle, cantidadDevuelta)
            values (idDev, idCD, cant);
            
            update prenda_has_talleycolor set stock = stock + cant where id = idP;
		else
			rollback;
			signal sqlstate '45000' set message_text = 'No se puede devolver todos los productos';
        end if; 
        end loop;
        close cursorC;
			commit;
	else 
		signal sqlstate '45000' set message_text = 'No existe esa compra o Ya se devolvio esa compra';
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
    if ( fecha > date_sub(now(), interval 30 DAY) ) then
		set puedeDevolver = true;
	end if;
    return puedeDevolver;
end //
delimiter ;


/* Ejercicio 5 */
delimiter //
create procedure bonusClientes () 
begin
	declare fechaFin date;
	declare fechaInicio date;
    set fechaInicio = date_sub(curdate(), interval 7 day);
    set fechaFin = curdate();
    
	update cliente set puntos = (puntos + (puntos * 0.05) ) where cliente.dni in ( select compra.clienteDni from compra where datetimeCompra between fechaInicio and fechaFin );
end //
delimiter ;


call bonusClientes();

delimiter //
create event bonusClienteSemanal on schedule every 1 week starts now() do
begin 
	 call bonusClientes();
     end //

delimiter ;  
   

/* Ejercicio 6 */


delimiter //
create procedure eliminarMarcas_Stock()
begin 
    delete from marca where idMarca in ( select idMarca from ( select prenda.idMarca, SUM(prenda_has_talleycolor.stock) AS total_stock from  prenda 
     join prenda_has_talleycolor on prenda.idPrenda = prenda_has_talleycolor.p_idPrenda 
		group by  prenda.idMarca ) as t 
        where total_stock <= 0 or total_stock is null
    ) 
    and idMarca not in (
        select prenda.idMarca
        from compra_detalle cd
        join prenda_has_talleycolor ptc 
            on cd.idVariantePrenda = ptc.id
        join prenda 
            on ptc.p_idPrenda = prenda.idPrenda
        join compra 
            on cd.idCompra = compra.idCompra
        where compra.datetimeCompra >= date_sub(curdate(), interval 6 month)
    );
end;
//

create event eliminarStockEvento on schedule every 15 day starts now() do
begin
	call eliminarMarcas_Stock();
end;