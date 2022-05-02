package com.fz.demoschool.core.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TeacherModel {
    private final String uuid;
    private final String name;
}
