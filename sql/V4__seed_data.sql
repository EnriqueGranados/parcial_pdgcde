-- V4: Inserciones para las tablas (Verificación de triggers y restricciones).
-- 1. Insertar rangos.
INSERT INTO rango (nombre_rango) VALUES 
('Junior'),    
('Senior'),    
('Director');  

-- 2. Insertar investigadores.
INSERT INTO investigador (id_rango, nombre) VALUES 
(3, 'Dra. Ana López'),    
(2, 'Dr. Carlos Ruiz'),   
(1, 'Lic. Maria Gomez'),   
(3, 'Dr. Jorge Perez'),   
(2, 'Lic. Elena Torres');   

-- 3. Insertar Laboratorios.
INSERT INTO laboratorio (nombre, nivel_bioseguridad, capacidad) VALUES 
('Lab Genética A', 2, 10),
('Lab Patógenos B', 4, 5),     
('Lab Microscopía C', 1, 20),
('Lab Virología D', 3, 8),
('Lab Alta Seguridad E', 4, 3); 

-- 4. Insertar Equipos (Incluyen la columna ultima_revision).
INSERT INTO equipo (id_laboratorio, nombre, estado, ultima_revision) VALUES 
(1, 'Microscopio Electrónico', 'Disponible', '2025-10-01'),
(2, 'Centrífuga Alta Velocidad', 'Disponible', '2026-01-15'),
(2, 'Secuenciador ADN', 'Mantenimiento', '2026-04-10'),
(3, 'Incubadora', 'Disponible', '2025-12-20'),
(4, 'Campana Extractora', 'Fuera de Servicio', '2026-02-28');

-- 5. Insertar Reservas (Pruebas exitosas).
INSERT INTO reserva (id_investigador, id_laboratorio, id_equipo, fecha_inicio, fecha_fin) VALUES 
-- Investigador 1 (Director) en Lab 2 (Nivel 4) con Equipo 2 (Disponible). Funciona perfecto.
(1, 2, 2, '2026-05-01 08:00:00', '2026-05-01 12:00:00'), 

-- Investigador 2 (Senior) en Lab 1 (Nivel 2) con Equipo 1 (Disponible).
(2, 1, 1, '2026-05-02 09:00:00', '2026-05-02 11:00:00'),

-- Investigador 3 (Junior) en Lab 3 (Nivel 1) con Equipo 4 (Disponible).
(3, 3, 4, '2026-05-03 10:00:00', '2026-05-03 14:00:00'),

-- Investigador 4 (Director) en Lab 5 (Nivel 4). Equipo prestado temporalmente del lab 2.
(4, 5, 2, '2026-05-04 13:00:00', '2026-05-04 15:00:00'), 

-- Investigador 1 (Director) hace otra reserva en diferente horario.
(1, 1, 1, '2026-05-05 08:00:00', '2026-05-05 10:00:00');

/* -- =========================================================================
-- Pruebas que fallan (Descomentar para probar).
-- =========================================================================
-- Prueba 1 - Falla porque el equipo 3 está en 'Mantenimiento':
-- INSERT INTO reserva (id_investigador, id_laboratorio, id_equipo, fecha_inicio, fecha_fin) 
-- VALUES (1, 2, 3, '2026-06-01 10:00:00', '2026-06-01 12:00:00');

-- Prueba 2 - Falla porque el investigador 3 es 'Junior' y el Lab 2 es 'Nivel 4':
-- INSERT INTO reserva (id_investigador, id_laboratorio, id_equipo, fecha_inicio, fecha_fin) 
-- VALUES (3, 2, 2, '2026-06-02 10:00:00', '2026-06-02 12:00:00');

-- Prueba 3 - Falla porque el investigador 2 ya tiene una reserva el 2026-05-02 de 9 a 11:
-- INSERT INTO reserva (id_investigador, id_laboratorio, id_equipo, fecha_inicio, fecha_fin) 
-- VALUES (2, 3, 4, '2026-05-02 10:30:00', '2026-05-02 13:00:00');
*/