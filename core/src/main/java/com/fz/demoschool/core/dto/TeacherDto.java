package com.fz.demoschool.core.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TeacherDto {
    String uuid;
    String name;
    Integer schoolId;
}
