package com.example.DHT.repository;

import com.example.DHT.model.VariantePrenda;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VariantePrendaRepository extends JpaRepository<VariantePrenda, Integer> {
    List<VariantePrenda> findByPrenda_IdPrenda(Integer idPrenda);
}