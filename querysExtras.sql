# querys extras para q sea funcional

# para q no haya q insertar el monto total si no q te lo calcule automaticamente
delimiter //
create function calcularTotalGastado(idC int) returns float deterministic
begin
	declare total float default 0;
	select sum(cantidad * precioUnitario) into total from compra_detalle where idCompra = idC group by idC;
    return total;
end //
delimiter ;


delimiter //
create trigger after_insert_compraDetalle after insert on compra_detalle for each row
begin
    UPDATE compra SET costoTotal = calcularTotalGastado(new.idCompra) WHERE idCompra = new.idCompra;
end //
delimiter ;

delimiter //
create trigger after_update_compraDetalle after update on compra_detalle for each row
begin
    UPDATE compra SET costoTotal = calcularTotalGastado(new.idCompra) WHERE idCompra = new.idCompra;
end //
delimiter ;