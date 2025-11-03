package com.example.DHT.repository;

import com.example.DHT.model.Devolucion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DevolucionRepository extends JpaRepository<Devolucion, Integer> {
    boolean existsByCompraIdCompra(Integer idCompra);

    List<Devolucion> findAllByClienteDni(String clienteDni);
}
