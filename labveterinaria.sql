DROP DATABASE IF EXISTS labveterinaria;
CREATE SCHEMA labveterinaria;

USE labveterinaria;

DROP TABLE IF EXISTS persona;
CREATE TABLE persona (
  persona_ID int AUTO_INCREMENT ,
  nombres varchar(20),
  prim_apellido varchar(20),
  seg_apellido varchar(20) ,
  edad int,
  nacionalidad varchar(20),
  direccion varchar(20),
  genero enum('masculino','femenino'),
  PRIMARY KEY (persona_ID)
);

DROP TABLE IF EXISTS persona_telefono;
CREATE TABLE persona_telefono (
  persona_ID int,
  telefono int,
  PRIMARY KEY (persona_ID,telefono)
);

DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
	persona_ID int PRIMARY KEY,
    num_mascotas int
);

DROP TABLE IF EXISTS veterinario;
CREATE TABLE veterinario (
	persona_ID int PRIMARY KEY,
    salario int,
    especialidad varchar(30),
    fecha_contratacion date
);

DROP TABLE IF EXISTS mascota;
CREATE TABLE mascota (
	mascota_ID int AUTO_INCREMENT ,
    raza varchar(30),
    edad int,
    PRIMARY KEY(mascota_ID)
);

DROP TABLE IF EXISTS mascota_enfermedad;
CREATE TABLE mascota_enfermedad (
    mascota_ID int,
    enfermedad varchar(30),
    PRIMARY KEY(mascota_ID,enfermedad)
);

DROP TABLE IF EXISTS mascota_alergia;
CREATE TABLE mascota_alergia (
    mascota_ID int,
    alergia varchar(30),
    PRIMARY KEY(mascota_ID,alergia)
);

DROP TABLE IF EXISTS mascota_tratamiento;
CREATE TABLE mascota_tratamiento (
    mascota_ID int,
    tratamiento varchar(30),
    PRIMARY KEY(mascota_ID,tratamiento)
);

DROP TABLE IF EXISTS vacuna;
CREATE TABLE vacuna (
	vacuna_ID int PRIMARY KEY,
    laboratorio varchar(30),
    fecha_fab DATE,
    fecha_venc DATE,
    tiempo_efectivo int,
    cant_dosis int,
    mascota_ID_mascota int
);

DROP TABLE IF EXISTS vacuna_componente;
CREATE TABLE vacuna_componente (
    vacuna_ID int,
    componente varchar(30),
    PRIMARY KEY(vacuna_ID,componente)
);

DROP TABLE IF EXISTS cliente_mascota;
CREATE TABLE cliente_mascota (
	mascota_ID int,
	persona_ID_cliente int,
    PRIMARY KEY(persona_ID_cliente,mascota_ID)
);

DROP TABLE IF EXISTS veterinario_mascota;
CREATE TABLE veterinario_mascota (
	mascota_ID int,
	persona_ID_veterinario int,
    PRIMARY KEY(persona_ID_veterinario,mascota_ID)
);

ALTER TABLE cliente ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE persona_telefono ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE cliente_mascota ADD FOREIGN KEY (persona_ID_cliente) REFERENCES cliente (persona_ID);
ALTER TABLE veterinario ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE veterinario_mascota ADD FOREIGN KEY (persona_ID_veterinario) REFERENCES veterinario (persona_ID);
ALTER TABLE mascota_tratamiento ADD FOREIGN KEY (mascota_ID) REFERENCES mascota (mascota_ID);
ALTER TABLE cliente_mascota ADD FOREIGN KEY (mascota_ID) REFERENCES mascota (mascota_ID);
ALTER TABLE veterinario_mascota ADD FOREIGN KEY (mascota_ID) REFERENCES mascota (mascota_ID);
ALTER TABLE mascota_enfermedad ADD FOREIGN KEY (mascota_ID) REFERENCES mascota (mascota_ID);
ALTER TABLE mascota_alergia ADD FOREIGN KEY (mascota_ID) REFERENCES mascota (mascota_ID);
ALTER TABLE vacuna_componente ADD FOREIGN KEY (vacuna_ID) REFERENCES vacuna (vacuna_ID);
ALTER TABLE vacuna ADD FOREIGN KEY (mascota_ID_mascota) REFERENCES mascota (mascota_ID);

INSERT INTO persona VALUES
(1, 'John', 'Doe', 'Smith', 25, 'American', '123 Main St','masculino'),
(2, 'Jane', 'Smith', 'Doe', 30, 'Canadian', '456 Oak St','femenino'),
(3, 'Alice', 'Johnson', 'White', 22, 'British', '789 Pine St','femenino'),
(4, 'Bob', 'Miller', 'Jones', 35, 'Australian', '101 Elm St','masculino'),
(5, 'Eva', 'Brown', 'Davis', 28, 'German', '202 Maple St','femenino');

INSERT INTO persona_telefono VALUES
(1, 123456789),
(2, 987654321),
(3, 555111222),
(4, 333444555),
(5, 999888777);

INSERT INTO cliente VALUES
(1, 2),
(2, 1),
(3, 3),
(4, 0),
(5, 4);

INSERT INTO veterinario VALUES
(1, 50000, 'Dermatology', '2023-01-15'),
(2, 60000, 'Surgery', '2022-05-20'),
(3, 55000, 'Oncology', '2023-03-10'),
(4, 70000, 'Cardiology', '2022-08-05'),
(5, 48000, 'Internal Medicine', '2023-02-28');

INSERT INTO mascota VALUES
(1, 'Labrador', 3),
(2, 'Siamese', 2),
(3, 'Persian', 5),
(4, 'Golden Retriever', 1),
(5, 'Beagle', 4);

INSERT INTO mascota_enfermedad VALUES
(1, 'Fleas'),
(2, 'Respiratory Infection'),
(3, 'Kidney Disease'),
(4, 'Heartworm'),
(5, 'Arthritis');

INSERT INTO mascota_alergia VALUES
(1, 'Pollen'),
(2, 'Seafood'),
(3, 'Dust'),
(4, 'Grass'),
(5, 'Peanuts');

INSERT INTO mascota_tratamiento VALUES
(1, 'Vitamin Supplement'),
(2, 'Antibiotics'),
(3, 'Chemotherapy'),
(4, 'Heartworm Preventive'),
(5, 'Pain Medication');

INSERT INTO cliente_mascota VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(4, 5),
(5, 5);

INSERT INTO vacuna VALUES
(1, 'Pfizer', '2022-01-01', '2023-01-01', 365, 2, 4),
(2, 'Moderna', '2022-02-01', '2023-02-01', 365, 3, 1),
(3, 'Johnson & Johnson', '2022-03-01', '2023-03-01', 365, 1, 3),
(4, 'AstraZeneca', '2022-04-01', '2023-04-01', 365, 2, 2),
(5, 'Sinovac', '2022-05-01', '2023-05-01', 365, 2, 5);

INSERT INTO vacuna_componente VALUES
(1, 'Component A'),
(1, 'Component B'),
(2, 'Component X'),
(3, 'Component Y'),
(4, 'Component P'),
(5, 'Component Q');

INSERT INTO veterinario_mascota VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Laboratorio 11

INSERT INTO persona VALUES
(6, 'Michael', 'Williams', 'Johnson', 40, 'Canadian', '303 Pine St','masculino'),
(7, 'Sophia', 'Brown', 'Clark', 27, 'American', '404 Oak St','femenino'),
(8, 'Daniel', 'Garcia', 'Rodriguez', 33, 'Mexican', '505 Maple St','masculino'),
(9, 'Olivia', 'Davis', 'Miller', 29, 'Australian', '606 Elm St','femenino'),
(10, 'Liam', 'Anderson', 'Hall', 22, 'British', '707 Main St','masculino');

INSERT INTO persona_telefono VALUES
(6, 111222333),
(6, 111442333),
(7, 444555666),
(8, 777888999),
(8, 123128999),
(8, 772347989),
(9, 888777666),
(10, 333222111);

INSERT INTO cliente VALUES
(6, 2),
(7, 1),
(8, 3),
(9, 1),
(10, 4);

INSERT INTO veterinario VALUES
(6, 55000, 'Dentistry', '2022-12-10'),
(7, 62000, 'Orthopedics', '2023-05-15'),
(8, 57000, 'Neurology', '2022-10-20'),
(9, 72000, 'Ophthalmology', '2023-01-05'),
(10, 49000, 'Dermatology', '2023-04-30');

INSERT INTO mascota VALUES
(6, 'Dachshund', 2),
(7, 'Bengal', 4),
(8, 'Maine Coon', 3),
(9, 'Poodle', 1),
(10, 'Boxer', 5);

INSERT INTO mascota_enfermedad VALUES
(6, 'Allergies'),
(7, 'Diabetes'),
(8, 'Gastrointestinal Issues'),
(9, 'Obesity'),
(10, 'Ear Infection');

INSERT INTO mascota_alergia VALUES
(6, 'Mold'),
(7, 'Chicken'),
(8, 'Fish'),
(9, 'Soy'),
(10, 'Wheat');

INSERT INTO mascota_tratamiento VALUES
(6, 'Flea Control'),
(7, 'Insulin Injections'),
(8, 'Digestive Enzymes'),
(9, 'Weight Management Plan'),
(10, 'Ear Drops');

INSERT INTO cliente_mascota VALUES
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO vacuna VALUES
(6, 'Novavax', '2022-06-01', '2023-06-01', 365, 2, 7),
(7, 'Covaxin', '2022-07-01', '2023-07-01', 365, 3, 8),
(8, 'Sputnik V', '2022-08-01', '2023-08-01', 365, 1, 9),
(9, 'Sinopharm', '2022-09-01', '2023-09-01', 365, 2, 10),
(10, 'Bharat Biotech', '2022-10-01', '2023-10-01', 365, 2, 6);

INSERT INTO vacuna_componente VALUES
(6, 'Component C'),
(6, 'Component D'),
(7, 'Component Z'),
(8, 'Component W'),
(9, 'Component K'),
(10, 'Component L');

INSERT INTO veterinario_mascota VALUES
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- a) Mostrar los nombres, apellidos, nacionalidad y edad de todos los clientes:
SELECT nombres, prim_apellido, nacionalidad, edad
FROM persona
JOIN cliente ON persona.persona_ID = cliente.persona_ID;
-- b) Mostrar el salario, dirección y edad de los veterinarios ordenados por apellido paterno:
SELECT salario, direccion, edad
FROM persona
JOIN veterinario ON persona.persona_ID = veterinario.persona_ID
ORDER BY prim_apellido;
-- c) Mostrar todas las vacunas del año 2022 de un laboratorio en específico (por ejemplo, Pfizer):
SELECT *
FROM vacuna
WHERE YEAR (fecha_fab) = 2022;
-- d) Defina una consulta que involucre por lo menos dos tablas y una condición. Por ejemplo, mostrar los nombres y las enfermedades de las mascotas:
SELECT mascota.mascota_ID, raza, enfermedad
FROM mascota
JOIN mascota_enfermedad ON mascota.mascota_ID = mascota_enfermedad.mascota_ID
JOIN cliente_mascota ON mascota.mascota_ID = cliente_mascota.mascota_ID
JOIN persona ON cliente_mascota.persona_ID_cliente = persona.persona_ID;
-- e) Defina una consulta que involucre por lo menos tres tablas y con o sin condiciones. Por ejemplo, mostrar las mascotas, sus tratamientos y los nombres de los veterinarios que las atienden:
SELECT mascota.mascota_ID, raza, tratamiento, persona.nombres AS nombre_veterinario
FROM mascota
JOIN mascota_tratamiento ON mascota.mascota_ID = mascota_tratamiento.mascota_ID
JOIN veterinario_mascota ON mascota.mascota_ID = veterinario_mascota.mascota_ID
JOIN persona ON veterinario_mascota.persona_ID_veterinario = persona.persona_ID;
    
-- LABORATORIO 13

-- a) Mostrar los nombres, apellidos, nacionalidad y edad de todos los Clientes con más de 1 teléfono registrado
SELECT p.*, COUNT(pt.telefono) AS cantidad_telefonos
FROM persona p
LEFT JOIN persona_telefono pt ON p.persona_ID = pt.persona_ID
GROUP BY p.persona_ID
HAVING COUNT(pt.telefono) > 1;
-- b) Muestre el promedio de salario de los veterinarios según el genero
SELECT p.genero, AVG(v.salario) AS promedio_salario
FROM veterinario v
JOIN persona p ON v.persona_ID = p.persona_ID
GROUP BY p.genero;
-- c) Defina una consulta que involucre por lo menos dos tablas y un Group By.
SELECT p.nombres, p.prim_apellido, p.seg_apellido, COUNT(cm.mascota_ID) AS cantidad_mascotas
FROM persona p
JOIN cliente c ON p.persona_ID = c.persona_ID
LEFT JOIN cliente_mascota cm ON c.persona_ID = cm.persona_ID_cliente
GROUP BY p.persona_ID, p.nombres, p.prim_apellido, p.seg_apellido;
-- d) Defina una consulta que involucre por lo menos dos tablas y una función de agregación.
SELECT m.raza, ROUND(AVG(m.edad)) AS promedio_edad
FROM mascota m
LEFT JOIN mascota_enfermedad me ON m.mascota_ID = me.mascota_ID
GROUP BY m.raza;

-- LABORATORIO 15

-- a) Implemente una función que permita conocer la cantidad de mascotas atendidas por un veterinario, dando como datos
-- de entrada su nombre y mes en el que trabajo.
DELIMITER //
DROP FUNCTION IF EXISTS obtenerCantidadMascotasAtendidas //
CREATE FUNCTION obtenerCantidadMascotasAtendidas(veterinario_nombre VARCHAR(20),mes_trabajo INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE cantidad_mascotas INT;
    SELECT COUNT(*) INTO cantidad_mascotas
    FROM veterinario_mascota vm
    JOIN veterinario v ON vm.persona_ID_veterinario = v.persona_ID
    JOIN persona p ON v.persona_ID = p.persona_ID
    WHERE p.nombres = veterinario_nombre AND MONTH(v.fecha_contratacion) = mes_trabajo;
    RETURN cantidad_mascotas;
END //
DELIMITER ;
SELECT obtenerCantidadMascotasAtendidas('Michael', 12);
-- b) Implemente una función que reciba como mínimo 2 parámetros de entrada
DELIMITER //
DROP PROCEDURE IF EXISTS actualizarDireccionPersona //
CREATE PROCEDURE actualizarDireccionPersona(IN personaID INT, IN nuevaDireccion VARCHAR(50))
BEGIN
    UPDATE persona
    SET direccion = nuevaDireccion
    WHERE persona_ID = personaID;
    SELECT CONCAT('Dirección actualizada a: ', nuevaDireccion) AS 'Resultado';
END //
DELIMITER ;
CALL actualizarDireccionPersona(1,'124 Calle');
-- c) Implemente un procedimiento almacenado que dado el nombre y apellido de un cliente, le permita obtener la
-- información detallada de sus mascotas, vacunas, fechas de su aplicación y las observaciones echas por su veterinario.
DELIMITER //
DROP PROCEDURE IF EXISTS obtenerInformacionCliente //
CREATE PROCEDURE obtenerInformacionCliente(IN nombre_cliente VARCHAR(20), IN apellido_cliente VARCHAR(20))
BEGIN
    SELECT *
    FROM cliente_mascota cm
    JOIN mascota m ON cm.mascota_ID = m.mascota_ID
    JOIN vacuna v ON m.mascota_ID = v.mascota_ID_mascota
    JOIN veterinario_mascota vm ON m.mascota_ID = vm.mascota_ID
    WHERE cm.persona_ID_cliente = (SELECT persona_ID FROM persona WHERE nombres = nombre_cliente AND prim_apellido = apellido_cliente);
END //
DELIMITER ;
CALL obtenerInformacionCliente('John','Doe');
-- d) Implemente un procedimiento almacenado que reciba por lo menos 3 parámetros de entrada
DELIMITER //
DROP PROCEDURE IF EXISTS insertarNuevaMascota //
CREATE PROCEDURE insertarNuevaMascota(IN clienteID INT, IN edadMascota INT, IN razaMascota VARCHAR(30))
BEGIN
    DECLARE nuevaMascotaID INT;
    INSERT INTO mascota (raza, edad)
    VALUES (razaMascota, edadMascota);
    SET nuevaMascotaID = LAST_INSERT_ID();
    INSERT INTO cliente_mascota (persona_ID_cliente, mascota_ID)
    VALUES (clienteID, nuevaMascotaID);
    SELECT CONCAT('Nueva mascota insertada para el cliente con ID ', clienteID) AS 'Resultado';
END //
DELIMITER ;
CALL insertarNuevaMascota(1, 3, 'Chihuahua');
-- e) Implemente un procedimiento almacenado que utilice una de las funciones anteriores.
DELIMITER //
DROP PROCEDURE IF EXISTS actualizarSalarioVeterinario //
CREATE PROCEDURE actualizarSalarioVeterinario(IN veterinario_nombre VARCHAR(20), IN mes_trabajo INT)
BEGIN
    DECLARE cantidad_mascotas INT;
    DECLARE salario INT;
    SET cantidad_mascotas = obtenerCantidadMascotasAtendidas(veterinario_nombre, mes_trabajo);
    UPDATE veterinario v
    SET v.salario = v.salario + (1000 * cantidad_mascotas)
    WHERE v.persona_ID = (SELECT persona_ID FROM persona WHERE nombres = veterinario_nombre);
    SELECT CONCAT('Salario actualizado para el veterinario ', veterinario_nombre, ' en el mes ', mes_trabajo) AS 'Resultado';
END //
DELIMITER ;
CALL actualizarSalarioVeterinario('Michael', 12);
