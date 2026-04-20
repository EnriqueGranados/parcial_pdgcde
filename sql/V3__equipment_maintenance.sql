-- V3: Modificación de la tabla equipo para rastrear la última revisión.
-- Agregamos la columna para rastrear la última revisión del equipo.
ALTER TABLE equipo 
ADD COLUMN ultima_revision DATE;