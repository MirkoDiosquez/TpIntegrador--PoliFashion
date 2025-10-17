



-- Ejercicio 3 --

delimiter //
create procedure prendasMasVendidas (in fechaInicio date, in fechaFin date)
begin
	declare cantVentas int default 0;
    select count(*) into cantVentas from compra_detalle;
	select prenda.idPrenda, sum(compra_detalle.cantidad * compra_detalle.precioUnitario) as ingresosGenerados, sum(compra_detalle.cantidad) as cantidadVendida from prenda join compra_detalle on prenda.idPrenda = compra_detalle.idPrenda join compra on compra_detalle.idCompra=compra.idCompra where datetimeCompra between fechaInicio and fechaFin group by prenda.idPrenda order by cantidadVendida desc;
	end;
//

call prendasMasVendidas ('2025-10-10','2025-10-12');

-- Ejercicio 4 --
create procedure devolucionPrenda (in idVenta int, in dniClient varchar())
begin	
	if ( select idCompra from compra where idCompra = idVenta ) then
    


