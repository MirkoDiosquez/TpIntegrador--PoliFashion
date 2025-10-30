package com.example.DHT.repository;

import com.example.DHT.model.Devolucion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DevolucionRepository extends JpaRepository<Devolucion, Integer> {
}
