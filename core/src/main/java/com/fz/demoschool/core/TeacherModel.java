package com.fz.demoschool.core;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TeacherModel {
    private final String uuid;
    private final String name;
}
