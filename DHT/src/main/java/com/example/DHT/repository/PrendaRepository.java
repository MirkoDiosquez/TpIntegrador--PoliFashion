package com.example.DHT.repository;
import com.example.DHT.model.Prenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import org.springframework.data.domain.Pageable;
import java.util.List;

public interface PrendaRepository extends JpaRepository<Prenda, Integer> {
    // agrego query pq no esta funcionando bien sin ella
    @Query("SELECT p FROM Prenda p WHERE SIZE(p.variantes) > 0 ORDER BY p.idPrenda DESC")
    List<Prenda> findTop3ByOrderByIdPrendaDesc(Pageable pageable);
}