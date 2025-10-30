package com.example.DHT.extras.excepcion;

public class StockInsuficiente extends RuntimeException {
  public StockInsuficiente(String message) {
    super(message);
  }
}