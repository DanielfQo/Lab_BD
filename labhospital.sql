DROP DATABASE IF EXISTS labhospital;
CREATE SCHEMA labhospital;

USE labhospital;
DROP TABLE IF EXISTS persona;
CREATE TABLE persona(
	persona_ID int PRIMARY KEY,
    nombre varchar(30),
    prim_apellido varchar(30),
    seg_apellido varchar(30),
    edad int
);

DROP TABLE IF EXISTS personal_medico;
CREATE TABLE personal_medico(
	persona_ID int PRIMARY KEY,
    turno enum('dia','tarde','noche'),
    experiencia int
);

DROP TABLE IF EXISTS enfermera;
CREATE TABLE enfermera(
	persona_ID int PRIMARY KEY
);

DROP TABLE IF EXISTS medico;
CREATE TABLE medico(
	persona_ID int PRIMARY KEY,
    especialidad varchar(30),
    salario int
);

DROP TABLE IF EXISTS paciente;
CREATE TABLE paciente(
	persona_ID int,
    genero enum('hombre','mujer'),
    fecha_nacimiento DATE,
    ciudad varchar(30),
    calle varchar(30),
    numero int,
    telefono int,
    historia_ID_historia_clinica int,
    PRiMARY KEY(persona_ID)
);

DROP TABLE IF EXISTS historia_clinica;
CREATE TABLE historia_clinica(
	historia_ID int AUTO_INCREMENT,
    fecha_creacion DATE,
    persona_ID_paciente int,
	PRIMARY KEY(historia_ID,persona_ID_paciente)
);

DROP TABLE IF EXISTS fecha_atencion;
CREATE TABLE fecha_atencion(
	historia_ID int,
	fecha DATE,
    PRIMARY KEY(historia_ID,fecha)
);

DROP TABLE IF EXISTS historia_medico;
CREATE TABLE historia_medico(
	historia_ID int,
    persona_ID_medico int,
    PRIMARY KEY(historia_ID, persona_ID_medico)
);

DROP TABLE IF EXISTS historia_diagnostico;
CREATE TABLE historia_diagnostico(
	historia_ID int,
    diagnostico varchar(30),
    PRIMARY KEY(historia_ID, diagnostico)
);

DROP TABLE IF EXISTS historia_enfermedad;
CREATE TABLE historia_enfermedad(
	historia_ID int,
    enfermedad_ID int,
    PRIMARY KEY(historia_ID, enfermedad_ID)
);

DROP TABLE IF EXISTS paciente_atencion;
CREATE TABLE paciente_atencion(
	persona_ID_paciente int,
    persona_ID_personal_medico int,
    PRIMARY KEY(persona_ID_paciente, persona_ID_personal_medico)
);

DROP TABLE IF EXISTS paciente_alergia;
CREATE TABLE paciente_alergia(
	persona_ID int,
    alergia varchar(30),
    PRIMARY KEY(persona_ID, alergia)
);

DROP TABLE IF EXISTS enfermedad;
CREATE TABLE enfermedad(
	enfermedad_ID int AUTO_INCREMENT,
    nombre varchar(30),
    tasa_mortalidad int,
    PRIMARY KEY(enfermedad_ID,nombre)
);

DROP TABLE IF EXISTS enfermedad_medicamento;
CREATE TABLE enfermedad_medicamento(
	enfermedad_ID int,
    medicamento varchar(30),
    PRIMARY KEY(enfermedad_ID, medicamento)
);

DROP TABLE IF EXISTS enfermedad_sintoma;
CREATE TABLE enfermedad_sintoma(
	enfermedad_ID int,
    sintoma varchar(30),
    PRIMARY KEY(enfermedad_ID, sintoma)
);

ALTER TABLE historia_clinica ADD FOREIGN KEY (persona_ID_paciente) REFERENCES paciente (persona_ID);
ALTER TABLE personal_medico ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE paciente ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE enfermera ADD FOREIGN KEY (persona_ID) REFERENCES personal_medico (persona_ID);
ALTER TABLE medico ADD FOREIGN KEY (persona_ID) REFERENCES personal_medico (persona_ID);
ALTER TABLE paciente_atencion ADD FOREIGN KEY (persona_ID_personal_medico) REFERENCES personal_medico (persona_ID);
ALTER TABLE paciente_atencion ADD FOREIGN KEY (persona_ID_paciente) REFERENCES paciente (persona_ID);
ALTER TABLE paciente_alergia ADD FOREIGN KEY (persona_ID) REFERENCES paciente (persona_ID);
ALTER TABLE historia_medico ADD FOREIGN KEY (historia_ID) REFERENCES historia_clinica (historia_ID);
ALTER TABLE historia_medico ADD FOREIGN KEY (persona_ID_medico) REFERENCES medico (persona_ID);
ALTER TABLE fecha_atencion ADD FOREIGN KEY (historia_ID) REFERENCES historia_clinica (historia_ID);
ALTER TABLE historia_diagnostico ADD FOREIGN KEY (historia_ID) REFERENCES historia_clinica (historia_ID);
ALTER TABLE historia_enfermedad ADD FOREIGN KEY (historia_ID) REFERENCES historia_clinica (historia_ID);
ALTER TABLE historia_enfermedad ADD FOREIGN KEY (enfermedad_ID) REFERENCES enfermedad (enfermedad_ID);
ALTER TABLE enfermedad_medicamento ADD FOREIGN KEY (enfermedad_ID) REFERENCES enfermedad (enfermedad_ID);
ALTER TABLE enfermedad_sintoma ADD FOREIGN KEY (enfermedad_ID) REFERENCES enfermedad (enfermedad_ID);

INSERT INTO persona VALUES
(1, 'Juan', 'Gómez', 'Martínez', 30),
(2, 'María', 'Hernández', 'López', 25),
(3, 'Carlos', 'Luna', 'Díaz', 40),
(4, 'Ana', 'Torres', 'Castillo', 22),
(5, 'Javier', 'Rodríguez', 'Sánchez', 35),
(6, 'Michael', 'Gomez', 'Gomez', 30),
(7, 'Maria', 'Huaman', 'López', 25),
(8, 'Javier', 'Luna', 'Torres', 40),
(9, 'Camila', 'Torres', 'Obando', 22),
(10, 'Cesar', 'Usnayo', 'Ruelas', 35),
(101, 'Juan', 'Martínez', 'Gómez', 30),
(102, 'María', 'Alópez', 'Hernández', 25),
(103, 'Carlos', 'Adíaz', 'Luna', 40),
(104, 'Ana', 'Castillo', 'Torres', 22),
(105, 'Javier', 'Asánchez', 'Rodríguez', 35);

INSERT INTO personal_medico VALUES
(1, 'dia', 5),
(2, 'tarde', 8),
(3, 'noche', 10),
(4, 'dia', 3),
(5, 'tarde', 6),
(6, 'dia', 5),
(7, 'tarde', 8),
(8, 'noche', 10),
(9, 'dia', 3),
(10, 'tarde', 6);

INSERT INTO enfermera VALUES
(6),
(7),
(8),
(9),
(10);

INSERT INTO medico VALUES
(1, 'Cardiologo', 90000),
(2, 'Cirujano Ortopédico', 110000),
(3, 'Pediatra', 80000),
(4, 'Cardiologo', 95000),
(5, 'Neurólogo', 120000);

INSERT INTO enfermedad VALUES
(1, 'Enfermedad coronaria', 11),
(2, 'Fractura ósea', 12),
(3, 'Diabetes tipo 2', 13),
(4, 'Eczema', 14),
(5, 'Migraña', 15);

INSERT INTO paciente VALUES
(101, 'hombre', '1992-07-20', 'Buenos Aires', 'Avenida Principal', 123, 5551234, 1),
(102, 'mujer', '1997-03-15', 'Ciudad de México', 'Calle Olivo', 456, 5555678, 2),
(103, 'hombre', '1980-11-05', 'Santiago', 'Calle Maple', 789, 5558765, 3),
(104, 'mujer', '2003-06-10', 'Bogotá', 'Carrera Pino', 101, 5554321, 4),
(105, 'hombre', '1985-09-28', 'Lima', 'Jirón Céfiro', 234, 5557890, 5);

INSERT INTO historia_clinica VALUES
(1, '2023-01-10', 101),
(2, '2023-02-15', 102),
(3, '2023-03-20', 103),
(4, '2023-04-25', 104),
(5, '2023-05-30', 105);

INSERT INTO fecha_atencion VALUES
(1, '2023-07-10'),
(2, '2023-07-15'),
(3, '2023-07-20'),
(4, '2023-07-25'),
(5, '2023-07-30');

INSERT INTO historia_medico VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 3),
(5, 4),
(5, 5);

INSERT INTO historia_diagnostico VALUES
(1, 'Hipertensión'),
(2, 'Fractura de pierna'),
(3, 'Diabetes tipo 2'),
(4, 'Infección cutánea'),
(5, 'Migraña');

INSERT INTO historia_enfermedad VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 4),
(5, 2);

INSERT INTO paciente_atencion VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 5);

INSERT INTO paciente_alergia VALUES
(101, 'Penicilina'),
(102, 'Ninguna'),
(103, 'Látex'),
(104, 'Sulfonamida'),
(105, 'Ninguna');

INSERT INTO enfermedad_medicamento VALUES
(1, 'Aspirina'),
(2, 'Analgésicos'),
(3, 'Insulina'),
(4, 'Corticosteroides tópicos'),
(5, 'Triptanes');

INSERT INTO enfermedad_sintoma VALUES
(1, 'Dolor en el pecho'),
(2, 'Dolor e hinchazón'),
(3, 'Aumento de la sed'),
(4, 'Comezón y enrojecimiento'),
(5, 'Dolor de cabeza intenso');

-- LABORATORIO !2

INSERT INTO persona VALUES
(11, 'Gabriel', 'Fernández', 'Pérez', 28),
(12, 'Sofía', 'Gutiérrez', 'Ramírez', 29),
(13, 'Pablo', 'Soto', 'Moreno', 45),
(14, 'Luisa', 'Martínez', 'Gómez', 28),
(15, 'Isaac', 'Ríos', 'Jiménez', 32),
(16, 'Laura', 'García', 'Pérez', 27),
(17, 'Ricardo', 'López', 'Díaz', 35),
(18, 'Fernanda', 'Ramírez', 'Vargas', 40),
(19, 'Diego', 'Sánchez', 'Mendoza', 22),
(20, 'Valentina', 'Torres', 'Obando', 33),
(106, 'Gabriel', 'Pérez', 'Fernández', 28),
(107, 'Sofía', 'Ramírez', 'Gutiérrez', 29),
(108, 'Pablo', 'Moreno', 'Soto', 45),
(109, 'Luisa', 'Gómez', 'Martínez', 28),
(110, 'Isaac', 'Jiménez', 'Ríos', 32),
(111, 'Daniel', 'Jiménez', 'Ríos', 32),
(112, 'Juan', 'Jiménez', 'Ríos', 32);

INSERT INTO personal_medico VALUES
(11, 'tarde', 7),
(12, 'noche', 9),
(13, 'dia', 4),
(14, 'tarde', 6),
(15, 'noche', 8),
(16, 'dia', 5),
(17, 'tarde', 7),
(18, 'noche', 9),
(19, 'dia', 4),
(20, 'tarde', 6);

INSERT INTO enfermera VALUES
(11),
(12),
(13),
(14),
(15);

INSERT INTO medico VALUES
(6, 'Gastroenterólogo', 100000),
(7, 'Oftalmólogo', 95000),
(8, 'Psiquiatra', 110000),
(9, 'Traumatólogo', 105000),
(10, 'Cardiologo', 98000);

INSERT INTO enfermedad VALUES
(6, 'Colitis ulcerosa', 9),
(7, 'Cataratas', 5),
(8, 'Trastorno bipolar', 8),
(9, 'Luxación de hombro', 10),
(10, 'Hipotiroidismo', 7);

INSERT INTO paciente VALUES
(106, 'hombre', '1995-04-18', 'Madrid', 'Calle Rosales', 567, 5559876, 6),
(107, 'mujer', '1998-09-22', 'Buenos Aires', 'Avenida del Sol', 890, 5558765, 7),
(108, 'hombre', '1975-12-12', 'Ciudad de México', 'Calle Nogal', 123, 5552345, 8),
(109, 'mujer', '2001-07-05', 'Lima', 'Jirón Libertad', 456, 5555432, 9),
(110, 'hombre', '1988-02-14', 'Santiago', 'Avenida Primavera', 789, 5556543, 10),
(111, 'hombre', '1988-02-14', 'Santiago', 'Avenida Primavera', 789, 5556543, 10),
(112, 'hombre', '1988-02-14', 'Santiago', 'Avenida Primavera', 789, 5556543, 10);

INSERT INTO historia_clinica VALUES
(6, '2023-06-05', 106),
(7, '2023-07-10', 107),
(8, '2023-08-15', 108),
(9, '2023-09-20', 109),
(10, '2023-10-25', 110);

INSERT INTO fecha_atencion VALUES
(6, '2023-04-10'),
(7, '2023-06-15'),
(8, '2023-07-20'),
(9, '2023-04-25'),
(10, '2023-03-30');

INSERT INTO historia_medico VALUES
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO historia_diagnostico VALUES
(6, 'Colitis crónica'),
(7, 'Visión borrosa'),
(8, 'Episodios maníacos'),
(9, 'Lesión en el hombro'),
(10, 'Hipotiroidismo');

INSERT INTO historia_enfermedad VALUES
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO paciente_atencion VALUES
(106, 11),
(107, 11),
(108, 12),
(109, 12),
(110, 11),
(111, 12),
(112, 15);

INSERT INTO paciente_alergia VALUES
(106, 'Ninguna'),
(107, 'Penicilina'),
(108, 'Aspirina'),
(109, 'Látex'),
(110, 'Ninguna');

INSERT INTO enfermedad_medicamento VALUES
(6, 'Antiinflamatorios'),
(7, 'Gotas para los ojos'),
(8, 'Paracetamol'),
(9, 'Fisioterapia'),
(10, 'Levotiroxina');

INSERT INTO enfermedad_sintoma VALUES
(6, 'Dolor abdominal y diarrea'),
(7, 'Visión nublada'),
(8, 'Cambios bruscos de humor'),
(9, 'Dolor al levantar el brazo'),
(10, 'Fatiga y sensibilidad al frío');

-- LABORATORIO !2
-- a) Mostrar los nombres, apellidos,y dirección de todos los pacientes con apellido paterno que comience con letra ’A’
SELECT p.nombre, p.prim_apellido, pe.calle
FROM persona p
JOIN paciente pe ON p.persona_ID = pe.persona_ID
WHERE p.prim_apellido LIKE 'A%';
-- b) Muestre todos los doctores con 5 años de experiencia ordenados por salario
SELECT * 
FROM medico m
JOIN personal_medico pm ON m.persona_ID = pm.persona_ID
WHERE experiencia >= 5
ORDER BY salario;
-- c) Muestre todos los pacientes que fueron atendidos en el mes de Julio
SELECT p.nombre, p.prim_apellido
FROM persona p
JOIN historia_clinica hc ON p.persona_ID = hc.persona_ID_paciente
JOIN fecha_atencion fa ON hc.historia_ID = fa.historia_ID;
-- d) Defina una consulta que involucre por lo menos dos tablas y una condición.
SELECT m.persona_ID, m.especialidad, m.salario, p.nombre, p.prim_apellido
FROM medico m
JOIN persona p ON m.persona_ID = p.persona_ID
WHERE m.especialidad = 'Cardiologo';
-- e) Defina una consulta que involucre por lo menos tres tablas y con o sin condiciones
SELECT p.nombre, p.prim_apellido, h.fecha_creacion, m.especialidad, m.salario
FROM persona p
JOIN historia_clinica h ON p.persona_ID = h.persona_ID_paciente
JOIN historia_medico hm ON h.historia_ID = hm.historia_ID
JOIN medico m ON hm.persona_ID_medico = m.persona_ID;

-- LABORATORIO 14
-- a) Mostrar todos los datos personales de las enfermeras (para el caso de nombre, apellido paterno y apellido materno en
-- una cola columna) con más de 2 pacientes a cargo
SELECT CONCAT(p.nombre,' ', p.prim_apellido,' ', p.seg_apellido) AS Nombre_Completo
FROM persona p
JOIN personal_medico pm ON p.persona_ID = pm.persona_ID
JOIN enfermera e ON pm.persona_ID = e.persona_ID
JOIN paciente_atencion pa ON e.persona_ID = pa.persona_ID_personal_medico
GROUP BY e.persona_ID
HAVING COUNT(pa.persona_ID_paciente) > 2;
-- b) Muestre el promedio de pacientes asignados a los doctores y mostrando el valor obtenido con dos decimales
SELECT ROUND(AVG(cantidad_pacientes),2) AS promedio_pacientes
FROM (
    SELECT COUNT(hm.historia_ID) AS cantidad_pacientes
    FROM historia_medico hm
    GROUP BY hm.persona_ID_medico
) AS promedio;
-- c) Defina una consulta que involucre por lo menos dos tablas y una función que involucre Fechas.
SELECT pe.nombre AS nombre_paciente, fa.fecha,
       DATEDIFF(CURDATE(), fa.fecha) AS dias_desde_ultima_atencion
FROM paciente p
JOIN persona pe ON p.persona_ID = pe.persona_ID
JOIN fecha_atencion fa ON fa.historia_ID = p.historia_ID_historia_clinica;
-- d) Defina una consulta que involucre por lo menos dos tablas y una función de manipulación de textos.
SELECT CONCAT(persona.nombre, ' ', persona.prim_apellido, ' ', persona.seg_apellido) AS nombre_completo
FROM paciente
JOIN persona ON paciente.persona_ID = persona.persona_ID
WHERE CONCAT(persona.nombre, ' ', persona.prim_apellido, ' ', persona.seg_apellido) LIKE '%C%';

-- LABORATORIO 16

-- a) Implemente una función que dado el nombre y apellido de un doctor o enfermera, muestre la cantidad de pacientes que tiene a cargo.
DELIMITER //
DROP FUNCTION IF EXISTS mostrarPacientes //
CREATE FUNCTION mostrarPacientes(
    p_nombreDoctor VARCHAR(30),
    p_apellidoDoctor VARCHAR(30)
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE totalPacientes INT;
    SELECT COUNT(DISTINCT pa.persona_ID_paciente) INTO totalPacientes
    FROM persona p
    JOIN personal_medico pm ON p.persona_ID = pm.persona_ID
    JOIN enfermera e ON pm.persona_ID = e.persona_ID
    LEFT JOIN paciente_atencion pa ON e.persona_ID = pa.persona_ID_personal_medico
    WHERE p.nombre = p_nombreDoctor AND (p.prim_apellido = p_apellidoDoctor OR p.seg_apellido = p_apellidoDoctor)
    GROUP BY e.persona_ID;
    RETURN totalPacientes;
END //
DELIMITER ;
SELECT mostrarPacientes('Sofía', 'Gutiérrez') AS Cantidad_Pacientes;
-- b) Implemente una función que reciba como mínimo 2 parámetros de entrada
DELIMITER //
DROP FUNCTION IF EXISTS ObtenerPersonasPorEdadYCuidad //
CREATE FUNCTION ObtenerPersonasPorEdadYCuidad(p_edad INT, p_ciudad VARCHAR(30))
RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(200);
    SELECT GROUP_CONCAT(CONCAT(nombre, ' ', prim_apellido, ' ', seg_apellido) SEPARATOR ', ')
    INTO resultado
    FROM persona
    JOIN paciente ON persona.persona_ID = paciente.persona_ID
    WHERE ciudad = p_ciudad AND edad >= p_edad;
    RETURN resultado;
END //
DELIMITER ;
SELECT ObtenerPersonasPorEdadYCuidad(20,'Santiago');
-- c) Implemente un procedimiento almacenado que por medio de una enfermedad, muestre todos los pacientes atendidos
-- (nombre, apellidos, teléfonos) junto a su medico que lo atendió.
DELIMITER //
DROP PROCEDURE IF EXISTS MostrarPacientesPorEnfermedad //
CREATE PROCEDURE MostrarPacientesPorEnfermedad(IN enfermedad_nombre VARCHAR(30))
BEGIN
    DECLARE enfermedad_id INT;
    SELECT e.enfermedad_ID INTO enfermedad_id FROM enfermedad e WHERE LOWER(e.nombre) = LOWER(enfermedad_nombre);
    SELECT 
        p.persona_ID AS IDPaciente,
        p.prim_apellido AS ApellidoPaterno,
        p.seg_apellido AS ApellidoMaterno,
        m.persona_ID AS IDMedico,
        m.turno AS TurnoMedico
    FROM persona p
    JOIN paciente_atencion pa ON p.persona_ID = pa.persona_ID_paciente
    JOIN personal_medico m ON pa.persona_ID_personal_medico = m.persona_ID
    JOIN historia_clinica hc ON p.persona_ID = hc.persona_ID_paciente
    JOIN historia_enfermedad he ON hc.historia_ID = he.historia_ID
    WHERE enfermedad_id = he.enfermedad_ID ;
END //
DELIMITER ;
CALL MostrarPacientesPorEnfermedad('Diabetes tipo 2');
-- d) Implemente un procedimiento almacenado que reciba por lo menos 3 parámetros de entrada
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarAtencion //
CREATE PROCEDURE RegistrarAtencion(
    IN p_personaID_Paciente INT,
    IN p_personaID_Medico INT,
    IN p_fecha DATE,
    IN p_diagnostico VARCHAR(30)
)
BEGIN
    DECLARE historiaID INT;
    INSERT INTO historia_clinica (persona_ID_paciente, fecha_creacion)
    VALUES (p_personaID_Paciente, CURRENT_DATE);
    SELECT historia_ID INTO historiaID
    FROM historia_clinica
    WHERE persona_ID_paciente = p_personaID_Paciente
    ORDER BY fecha_creacion DESC
    LIMIT 1;
    INSERT INTO paciente_atencion (persona_ID_paciente, persona_ID_personal_medico)
    VALUES (p_personaID_Paciente, p_personaID_Medico);
    INSERT INTO fecha_atencion (historia_ID, fecha)
    VALUES (historiaID, p_fecha);
    INSERT INTO historia_medico (historia_ID, persona_ID_medico)
    VALUES (historiaID, p_personaID_Medico);
    INSERT INTO historia_diagnostico (historia_ID, diagnostico)
    VALUES (historiaID, p_diagnostico);
    SELECT CONCAT('Nueva atencion registrada con ID: ', p_personaID_Paciente) AS 'Resultado';
END //
DELIMITER ;
CALL RegistrarAtencion(101, 2, '2024-01-27', 'Fiebre');
-- e) Implemente un procedimiento almacenado que utilice una de las funciones anteriores.
DELIMITER //
DROP PROCEDURE IF EXISTS MostrarCantidadPacientesPorDoctor //
CREATE PROCEDURE MostrarCantidadPacientesPorDoctor(
    IN p_nombreDoctor VARCHAR(30),
    IN p_apellidoDoctor VARCHAR(30)
)
BEGIN
    DECLARE cantidadPacientes INT;
    SET cantidadPacientes = mostrarPacientes(p_nombreDoctor, p_apellidoDoctor);
    IF cantidadPacientes > 5 THEN
        SELECT 'El doctor/enfermera ', p_nombreDoctor, ' ', p_apellidoDoctor, ' tiene ', cantidadPacientes, ' pacientes. Está ocupado.' AS Resultado;
    ELSE
        SELECT 'El doctor/enfermera ', p_nombreDoctor, ' ', p_apellidoDoctor, ' tiene ', cantidadPacientes, ' pacientes. No está tan ocupado.' AS Resultado;
    END IF;
END //
DELIMITER ;
CALL MostrarCantidadPacientesPorDoctor('Sofía', 'Gutiérrez');

