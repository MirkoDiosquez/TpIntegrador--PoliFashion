package com.example.DHT;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableTransactionManagement
public class DhtApplication {

	public static void main(String[] args) {
		SpringApplication.run(DhtApplication.class, args);
	}

}
