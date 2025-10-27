
-- Ejercicio 3 --

delimiter //
create procedure prendasMasVendidas (in fechaInicio date, in fechaFin date)
begin
	select prenda.idPrenda, prenda.nombre, sum(compra_detalle.cantidad * compra_detalle.precioUnitario) as ingresosGenerados, sum(compra_detalle.cantidad) as cantidadVendida from prenda 
    join prenda_has_talleycolor p on prenda.idPrenda = p.p_idPrenda
    join compra_detalle on prenda.idPrenda = compra_detalle.idVariantePrenda  
    join compra on compra_detalle.idCompra = compra.idCompra 
    where date(datetimeCompra) between fechaInicio and fechaFin group by prenda.idPrenda, prenda.nombre order by cantidadVendida desc limit 10;
end//
delimiter ; 
call prendasMasVendidas ('2025-10-10','2025-10-12');


delimiter //
-- Ejercicio 4  Falta terminar--
create procedure devolucionPrenda (in idVenta int, in dniClient varchar())
begin	
	if ( select idCompra from compra where idCompra = idVenta ) then
    end;
    
    
    end;
//


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


delimiter //
create event bonusClienteSemanal on schedule every 1 week starts now() do
begin 
	 call bonusClientes();
end//
delimiter ;
     

-- Ejercicio 6 --
delimiter //
create procedure eliminarMarcas_Stock()
BEGIN 
    delete from marca where idMarca IN ( SELECT idMarca from ( select prenda.idMarca, SUM(prenda_has_talleycolor.stock) AS total_stock from  prenda 
     join prenda_has_talleycolor ON prenda.idPrenda = prenda_has_talleycolor.idPrenda group by  prenda.idMarca ) 
	 where total_stock <= 0 OR total_stock is null
    )
    and idMarca not in (
        select prenda.idMarca from prenda 
        join prenda_has_talleycolor p ON prenda.idPrenda = p.idPrenda 
        join compra_detalle on compra_detalle.idVariantePrenda = p.p_idPrenda
        join compra on compra.idCompra = compra_detalle.idCompra
        where compra.datetimeCompra >= DATE_SUB(CURDATE(), interval 6 month)
    );
END//
delimiter ;

delimiter //
create event eliminarStockEvento on schedule every 15 day starts now() do
begin
	call eliminarMarcas_Stock();
end//
delimiter ;
