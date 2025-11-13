package com.example.DHT.repository;

import com.example.DHT.model.Compra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface CompraRepository extends JpaRepository<Compra, Integer> {
    List<Compra> findAllByClienteDni(String clienteDni);
    List<Compra> findByDatetimeCompraBetween(LocalDate desde, LocalDate hasta);
}