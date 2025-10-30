package com.example.DHT.repository;

import com.example.DHT.model.Cliente;
import com.example.DHT.model.CompraDetalle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CompraDetalleRepository extends JpaRepository<CompraDetalle, Integer> {
}
