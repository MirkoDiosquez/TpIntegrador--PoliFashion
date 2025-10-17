package com.example.DHT.DTO;
import java.time.LocalDate;

public class Compra
{
    private int idCompra ;
    private Cliente cliente ;
    private LocalDate fehaHoraCompra ;
    private int idMetodo ;

    public Compra(int idCompra, Cliente cliente, LocalDate fehaHoraCompra, int idMetodo) {
        this.idCompra = idCompra;
        this.cliente = cliente;
        this.fehaHoraCompra = fehaHoraCompra;
        this.idMetodo = idMetodo;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public LocalDate getFehaHoraCompra() {
        return fehaHoraCompra;
    }

    public void setFehaHoraCompra(LocalDate fehaHoraCompra) {
        this.fehaHoraCompra = fehaHoraCompra;
    }

    public int getIdMetodo() {
        return idMetodo;
    }

    public void setIdMetodo(int idMetodo) {
        this.idMetodo = idMetodo;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
}
