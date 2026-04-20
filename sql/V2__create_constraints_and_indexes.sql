-- V2: Reglas de integridad y creación de índices.
-- Restricciones de no duplicados (UNIQUE).
ALTER TABLE rango 
    ADD CONSTRAINT uq_nombre_rango UNIQUE (nombre_rango);

-- Restricciones de dominio (CHECK).
ALTER TABLE laboratorio ADD CONSTRAINT chk_bioseguridad CHECK (nivel_bioseguridad BETWEEN 1 AND 4);
ALTER TABLE equipo ADD CONSTRAINT chk_estado CHECK (estado IN ('Disponible', 'Mantenimiento', 'Fuera de Servicio'));

-- Restricciones de integridad referencial (FK).
ALTER TABLE investigador 
    ADD CONSTRAINT fk_investigador_rango FOREIGN KEY (id_rango) REFERENCES rango(id_rango);

ALTER TABLE equipo 
    ADD CONSTRAINT fk_equipo_lab FOREIGN KEY (id_laboratorio) REFERENCES laboratorio(id_laboratorio) ON DELETE SET NULL;

ALTER TABLE reserva 
    ADD CONSTRAINT fk_reserva_inv FOREIGN KEY (id_investigador) REFERENCES investigador(id_investigador) ON DELETE CASCADE;

ALTER TABLE reserva 
    ADD CONSTRAINT fk_reserva_lab FOREIGN KEY (id_laboratorio) REFERENCES laboratorio(id_laboratorio) ON DELETE CASCADE;

ALTER TABLE reserva 
    ADD CONSTRAINT fk_reserva_eq FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo) ON DELETE CASCADE;

-- Índices optimizados.
CREATE INDEX idx_reserva_fechas ON reserva(fecha_inicio, fecha_fin);