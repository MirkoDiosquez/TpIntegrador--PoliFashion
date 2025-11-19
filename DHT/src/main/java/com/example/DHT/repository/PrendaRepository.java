package com.example.DHT.repository;
import com.example.DHT.model.Prenda;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PrendaRepository extends JpaRepository<Prenda, Integer> {
    List<Prenda> findTop3ByOrderByIdPrendaDesc();
}