package com.fz.demoschool.corekafka;

import com.fz.demoschool.corekafka.config.Constants;
import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class CoreKafkaApplication {

	public static void main(String[] args) {
		SpringApplication.run(CoreKafkaApplication.class, args);
	}

}
