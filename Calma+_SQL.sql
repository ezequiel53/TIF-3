-- Proyecto: EDUCONNECTA-TIF

-- 1. Tabla PERSONA
-- Base para Usuario, Alumno y Profesor (Relación 1 a 1)
CREATE TABLE persona (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    fechaNacimiento DATE
);

-- 2. Tabla USUARIO (Relación 1 a 1 con Persona)
CREATE TABLE usuario (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    passwordHash VARCHAR(255) NOT NULL,
    rol VARCHAR(20),
    persona_id BIGINT UNIQUE, -- Clave Foránea a Persona (1:1)
    FOREIGN KEY (persona_id) REFERENCES persona(id)
);

-- 3. Tabla ALUMNO (Relación 1 a 1 con Persona)
CREATE TABLE alumno (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    legajo VARCHAR(50) UNIQUE NOT NULL,
    persona_id BIGINT UNIQUE, -- Clave Foránea a Persona (1:1)
    FOREIGN KEY (persona_id) REFERENCES persona(id)
);

-- 4. Tabla PROFESOR (Relación 1 a 1 con Persona)
CREATE TABLE profesor (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    persona_id BIGINT UNIQUE, -- Clave Foránea a Persona (1:1)
    FOREIGN KEY (persona_id) REFERENCES persona(id)
);

-- 5. Tabla CURSO (Relación 1 a Muchos con Profesor)
-- La FK 'profesor_id' está en la tabla N (Curso)
CREATE TABLE curso (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(255) NOT NULL,
    cupo INT NOT NULL,
    profesor_id BIGINT, -- Clave Foránea a Profesor (N:1)
    FOREIGN KEY (profesor_id) REFERENCES profesor(id)
);

-- 6. Tabla INSCRIPCION (Relación 1 a Muchos con Alumno y Curso)
-- Contiene las FKs de las tablas relacionadas (Alumno y Curso)
CREATE TABLE inscripcion (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    alumno_id BIGINT, -- Clave Foránea a Alumno (N:1)
    curso_id BIGINT, -- Clave Foránea a Curso (N:1)
    fechaInscripcion DATE NOT NULL,
    estado VARCHAR(20),
    FOREIGN KEY (alumno_id) REFERENCES alumno(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);
