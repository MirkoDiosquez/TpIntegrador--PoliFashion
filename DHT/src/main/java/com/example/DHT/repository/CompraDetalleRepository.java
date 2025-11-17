package com.example.DHT.repository;

import com.example.DHT.model.CompraDetalle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface CompraDetalleRepository extends JpaRepository<CompraDetalle, Integer> {

    List<CompraDetalle> findByCompra_DatetimeCompraBetween(LocalDateTime start, LocalDateTime end);

    List<CompraDetalle> findByCompra_IdCompra(Integer idCompra);
}