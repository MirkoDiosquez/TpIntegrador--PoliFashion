package com.example.DHT.repository;

import com.example.DHT.model.VariantePrenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VariantePrendaRepository extends JpaRepository<VariantePrenda, Integer> {
}