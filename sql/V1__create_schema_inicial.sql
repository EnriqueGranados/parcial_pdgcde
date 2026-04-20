-- V1: Creación del esquema inicial.
-- Tabla para el rango.
CREATE TABLE rango (
    id_rango SERIAL PRIMARY KEY,
    nombre_rango VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla los investigadores.
CREATE TABLE investigador (
    id_investigador SERIAL PRIMARY KEY,
    id_rango INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
);

-- Tabla para los laboratorios.
CREATE TABLE laboratorio (
    id_laboratorio SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

-- Tabla para los equipos.
CREATE TABLE equipo (
    id_equipo SERIAL PRIMARY KEY,
    id_laboratorio INT,
    nombre VARCHAR(150) NOT NULL,
    estado VARCHAR(50) NOT NULL
);

-- Tabla de reservas.
CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_investigador INT,
    id_laboratorio INT,
    id_equipo INT,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL
);

-- Tabla de auditoria.
CREATE TABLE log_auditoria (
    id_log SERIAL PRIMARY KEY,
    usuario_db VARCHAR(100),
    accion TEXT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);