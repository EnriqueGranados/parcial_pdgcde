-- R: Creación de triggers, funciones y auditoría.
-- Función para validar antes de insertar una reserva.
CREATE OR REPLACE FUNCTION fn_validar_reserva() RETURNS TRIGGER AS $$
DECLARE
    v_nombre_rango VARCHAR;
    v_nivel_lab INT;
    v_estado_equipo VARCHAR;
    v_conflictos INT;
BEGIN
    -- El equipo debe estar disponible.
    SELECT estado INTO v_estado_equipo FROM equipo WHERE id_equipo = NEW.id_equipo;
    IF v_estado_equipo != 'Disponible' THEN
        RAISE EXCEPTION 'Operación denegada: El equipo seleccionado se encuentra en estado "%"', v_estado_equipo;
    END IF;

    -- Laboratorios de nivel 4 solo pueden ser reservados por un director.
    SELECT nivel_bioseguridad INTO v_nivel_lab FROM laboratorio WHERE id_laboratorio = NEW.id_laboratorio;
    
    SELECT r.nombre_rango INTO v_nombre_rango 
    FROM investigador i
    INNER JOIN rango r ON i.id_rango = r.id_rango
    WHERE i.id_investigador = NEW.id_investigador;

    IF v_nivel_lab = 4 AND v_nombre_rango != 'Director' THEN
        RAISE EXCEPTION 'Acceso denegado: Los laboratorios de Nivel 4 son exclusivos para investigadores con rango de Director.';
    END IF;

    -- Un investigador no puede tener reservas en el mismo horario.
    SELECT COUNT(*) INTO v_conflictos FROM reserva
    WHERE id_investigador = NEW.id_investigador
      AND (NEW.fecha_inicio < fecha_fin AND NEW.fecha_fin > fecha_inicio);
      
    IF v_conflictos > 0 THEN
        RAISE EXCEPTION 'Conflicto de horario: El investigador ya tiene un laboratorio reservado en este intervalo de tiempo.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Creación del Trigger que ejecuta la validación antes de insertar.
CREATE TRIGGER trg_before_insert_reserva
BEFORE INSERT ON reserva
FOR EACH ROW EXECUTE FUNCTION fn_validar_reserva();

-- Auditoría.
CREATE OR REPLACE FUNCTION fn_auditar_reserva() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_auditoria (usuario_db, accion)
    VALUES (
        CURRENT_USER, 
        'Nueva reserva creada. Investigador ID: ' || NEW.id_investigador || ', Lab ID: ' || NEW.id_laboratorio || ', Equipo ID: ' || NEW.id_equipo
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Creación del Trigger que registra la auditoría después de insertar.
CREATE TRIGGER trg_after_insert_reserva
AFTER INSERT ON reserva
FOR EACH ROW EXECUTE FUNCTION fn_auditar_reserva();