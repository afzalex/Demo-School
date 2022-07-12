package com.fz.demoschool.core.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.UUID;

@Slf4j
@Configuration
public class CoreConfig {

    public CoreConfig(){
        log.info("coreconfig loading...");
    }

    private final String SERVICE_UUID = UUID.randomUUID().toString();

    @Bean
    public String serviceUUID() {
        return SERVICE_UUID;
    }
}
