package com.fz.demoschool.corekafka.config;

import org.apache.kafka.clients.admin.NewTopic;
import org.apache.kafka.common.config.TopicConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.TopicBuilder;

import java.util.Map;

@Configuration
public class AppKafkaConfig {

    @Bean
    public NewTopic newTopic() {
        return TopicBuilder.name(Constants.TOPIC_SCHOOL_GENERAL_EVENT)
                .partitions(1)
                .replicas(1)
                .config(TopicConfig.RETENTION_MS_CONFIG, "1")
                .build();
    }
}
