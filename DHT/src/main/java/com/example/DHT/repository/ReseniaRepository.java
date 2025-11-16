package com.example.DHT.repository;
import com.example.DHT.model.Resenia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReseniaRepository extends JpaRepository<Resenia, Integer> {
    List<Resenia> findAllByClienteDni(String clienteDni);
}