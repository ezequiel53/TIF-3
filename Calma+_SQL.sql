CREATE TABLE persona (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20),
    fecha_nac DATE
);

CREATE TABLE usuario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    persona_id BIGINT NOT NULL,
    CONSTRAINT fk_usuario_persona
        FOREIGN KEY (persona_id) REFERENCES persona(id)
        ON DELETE CASCADE
);

CREATE TABLE alumno (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    legajo VARCHAR(50) NOT NULL UNIQUE,
    persona_id BIGINT NOT NULL,
    CONSTRAINT fk_alumno_persona
        FOREIGN KEY (persona_id) REFERENCES persona(id)
        ON DELETE CASCADE
);

CREATE TABLE profesor (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    persona_id BIGINT NOT NULL,
    CONSTRAINT fk_profesor_persona
        FOREIGN KEY (persona_id) REFERENCES persona(id)
        ON DELETE CASCADE
);

CREATE TABLE curso (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(500),
    cupo INT DEFAULT 30,
    profesor_id BIGINT,
    CONSTRAINT fk_curso_profesor
        FOREIGN KEY (profesor_id) REFERENCES profesor(id)
        ON DELETE SET NULL
);

CREATE TABLE inscripcion (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    alumno_id BIGINT NOT NULL,
    curso_id BIGINT NOT NULL,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE),
    estado VARCHAR(20) DEFAULT 'INSCRITO',
    CONSTRAINT fk_inscripcion_alumno
        FOREIGN KEY (alumno_id) REFERENCES alumno(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_inscripcion_curso
        FOREIGN KEY (curso_id) REFERENCES curso(id)
        ON DELETE CASCADE,
    CONSTRAINT uq_alumno_curso UNIQUE (alumno_id, curso_id)
);


CREATE INDEX idx_persona_dni ON persona(dni);
CREATE INDEX idx_curso_profesor ON curso(profesor_id);

