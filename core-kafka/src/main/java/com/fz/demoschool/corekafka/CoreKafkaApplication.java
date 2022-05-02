package com.fz.demoschool.corekafka;

import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class CoreKafkaApplication {

	public static void main(String[] args) {
		SpringApplication.run(CoreKafkaApplication.class, args);
	}

	@Bean
	public NewTopic newTopic() {
		return new NewTopic("mytesttopic02", 1, (short)1);
	}
}
