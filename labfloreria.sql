DROP DATABASE IF EXISTS labfloreria;
CREATE SCHEMA labfloreria;
USE labfloreria;

DROP TABLE IF EXISTS tienda;
CREATE TABLE tienda(
	tienda_ID int,
    stock int,
    ciudad varchar(30),
    calle varchar(30),
    numero int,
    colonia varchar(30),
    codigo_postal int,
    PRIMARY KEY(tienda_ID)
);

DROP TABLE IF EXISTS personal_servicio;
CREATE TABLE personal_servicio(
	personal_ID int,
    nombres varchar(30),
    prim_apellido varchar(30),
    seg_apellido varchar(30),
    fecha_contratacion DATE,
    sueldo int,
    tienda_ID_tienda int,
    PRIMARY KEY (personal_ID, tienda_ID_tienda)
);

DROP TABLE IF EXISTS vendedor;
CREATE TABLE vendedor(
	personal_ID int PRIMARY KEY,
    comision int
);

DROP TABLE IF EXISTS gerente;
CREATE TABLE gerente(
	personal_ID int PRIMARY KEY,
    bono int
);

DROP TABLE IF EXISTS flor;
CREATE TABLE flor(
	flor_ID int PRIMARY KEY,
    especie varchar(30),
    precio int,
    ambiente varchar(30),
    tamaño int,
    tiempo_vida int,
    estacion enum('verano','otoño','invierno','primavera'),
    fecha_germinacion DATE
);

DROP TABLE IF EXISTS venta;
CREATE TABLE venta(
	venta_ID int,
	fecha DATETIME,
    cliente_ID_cliente int,
    tienda_ID_tienda int,
    personal_ID_vendedor int,
    flor_ID_flor int,
    PRIMARY KEY(venta_ID, cliente_ID_cliente,
				tienda_ID_tienda,
                personal_ID_vendedor,
                flor_ID_flor)
);

DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente(
	cliente_ID int,
    nombre varchar(30),
    apellido varchar(30),
    fecha_nacimiento DATE,
    PRIMARY KEY(cliente_ID)
);

DROP TABLE IF EXISTS cliente_telefono;
CREATE TABLE cliente_telefono(
	cliente_ID int,
    telefono int,
    PRIMARY KEY(cliente_ID,telefono)
);

DROP TABLE IF EXISTS tienda_flores;
CREATE TABLE tienda_flores(
	tienda_ID int,
    flor_ID int,
    PRIMARY KEY(tienda_ID,flor_ID)
);

ALTER TABLE personal_servicio ADD FOREIGN KEY (tienda_ID_tienda) REFERENCES tienda (tienda_ID);
ALTER TABLE vendedor ADD FOREIGN KEY (personal_ID) REFERENCES personal_servicio (personal_ID);
ALTER TABLE gerente ADD FOREIGN KEY (personal_ID) REFERENCES personal_servicio (personal_ID);
ALTER TABLE tienda_flores ADD FOREIGN KEY (flor_ID) REFERENCES flor (flor_ID);
ALTER TABLE tienda_flores ADD FOREIGN KEY (tienda_ID) REFERENCES tienda (tienda_ID);
ALTER TABLE cliente_telefono ADD FOREIGN KEY (cliente_ID) REFERENCES cliente (cliente_ID);
ALTER TABLE venta ADD FOREIGN KEY (personal_ID_vendedor) REFERENCES vendedor (personal_ID);
ALTER TABLE venta ADD FOREIGN KEY (tienda_ID_tienda) REFERENCES tienda (tienda_ID);
ALTER TABLE venta ADD FOREIGN KEY (cliente_ID_cliente) REFERENCES cliente (cliente_ID);
ALTER TABLE venta ADD FOREIGN KEY (flor_ID_flor) REFERENCES flor (flor_ID);


INSERT INTO tienda VALUES
(1, 100, 'Arequipa', 'Calle1', 123, 'Coloni1', 12345),
(2, 150, 'Cuzco', 'Calle2', 456, 'Coloni2', 67890),
(3, 120, 'Lima', 'Calle3', 789, 'Coloni3', 23456),
(4, 200, 'Trujillo', 'Calle4', 101, 'Coloni4', 78901),
(5, 180, 'Tacna', 'Calle5', 112, 'Coloni5', 34567);

INSERT INTO personal_servicio VALUES
(1, 'Michael', 'Ticona', 'Larico', '2022-01-01', 50000, 1),
(2, 'Piero', 'Villa', 'Borja', '2022-02-15', 55000, 2),
(3, 'Rocío', 'Chávez', 'Gonzales', '2022-03-20', 60000, 3),
(4, 'Carlos', 'Hernández', 'Vargas', '2022-04-10', 52000, 4),
(5, 'Ana', 'García', 'Mendoza', '2022-05-05', 58000, 5),
(6, 'Juan', 'Gómez', 'Pérez', '2022-06-10', 52000, 1),
(7, 'María', 'Torres', 'Castillo', '2022-07-15', 54000, 2),
(8, 'Luis', 'Ríos', 'Vargas', '2022-08-20', 59000, 3),
(9, 'Mónica', 'López', 'Díaz', '2022-09-25', 51000, 4),
(10, 'Carlos', 'Fernández', 'Rojas', '2022-10-30', 56000, 5);

INSERT INTO vendedor VALUES
(1, 10),
(2, 8),
(3, 12),
(4, 9),
(5, 11);

INSERT INTO gerente VALUES
(6, 5000),
(7, 4500),
(8, 6000),
(9, 4800),
(10, 5500);

INSERT INTO flor VALUES
(1, 'Rosa', 20, 'sol', 30, 15, 'primavera', '2022-01-01'),
(2, 'Lila', 15, 'sombra', 25, 20, 'verano', '2022-02-15'),
(3, 'Tulipan', 18, 'sol', 28, 18, 'primavera', '2022-03-20'),
(4, 'Geranio', 12, 'sombra', 22, 14, 'verano', '2022-04-10'),
(5, 'Girasol', 25, 'sol', 35, 22, 'verano', '2022-05-05');

INSERT INTO cliente VALUES
(101, 'Piero', 'Cardenas', '1990-05-15'),
(102, 'Michael', 'Richetti', '1985-08-20'),
(103, 'Leo', 'Ponze', '1980-10-25'),
(104, 'Carmen', 'Lara', '1975-03-10'),
(105, 'Julio', 'Jara', '1970-06-05');

INSERT INTO cliente_telefono VALUES
(101, 956456236),
(102, 954562361),
(103, 956452362),
(104, 956789236),
(105, 956223777);

INSERT INTO venta VALUES
(1, '2022-01-05 08:30:00', 101, 1, 1,1),
(2, '2022-02-20 12:45:00', 102, 2, 2,1),
(3, '2022-03-25 15:00:00', 103, 3, 3,2),
(4, '2022-04-15 10:00:00', 104, 4, 2,3),
(5, '2022-05-10 11:30:00', 105, 5, 5,5);

INSERT INTO tienda_flores VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Laboratorio 12

INSERT INTO tienda VALUES
(6, 130, 'Arequipa', 'Calle1', 133, 'Coloni1', 16345),
(7, 150, 'Cuzco', 'Calle2', 556, 'Coloni2', 67560),
(8, 120, 'Lima', 'Calle3', 777, 'Coloni3', 33356);

INSERT INTO personal_servicio VALUES
(11, 'Alejandro', 'Gómez', 'López', '2022-01-01', 70000, 6),
(12, 'María', 'Santos', 'Castillo', '2022-02-15', 55000, 7),
(13, 'Javier', 'Torres', 'Rojas', '2022-03-20', 60000, 8),
(14, 'Camila', 'Martínez', 'Pérez', '2022-04-10', 52000, 6),
(15, 'Gabriel', 'Díaz', 'Hernández', '2022-05-05', 58000, 7),
(16, 'Isabella', 'Fernández', 'Vega', '2022-06-10', 52000, 8);

INSERT INTO vendedor VALUES
(11, 10),
(12, 8),
(13, 12);

INSERT INTO gerente VALUES
(14, 5000),
(15, 4500),
(16, 6000);

INSERT INTO flor VALUES
(6, 'Jazmin', 20, 'sol', 30, 15, 'primavera', '2022-11-01'),
(7, 'Amapola', 15, 'sombra', 25, 20, 'verano', '2022-12-15'),
(8, 'Margarita', 18, 'sol', 28, 18, 'primavera', '2022-10-20');

INSERT INTO cliente VALUES
(106, 'Piero', 'Cardenas', '1990-05-15'),
(107, 'Michael', 'Apaza', '1985-08-20'),
(108, 'Manuel', 'Flores', '1980-10-25');

INSERT INTO cliente_telefono VALUES
(106, 911456236),
(107, 953331111),
(108, 953333361),
(108, 977772362),
(108, 956669236);

INSERT INTO venta VALUES
(6, '2022-01-05 08:30:00', 106, 6, 11,6),
(7, '2022-02-20 12:45:00', 107, 7, 12,8),
(8, '2022-02-20 12:45:00', 107, 7, 12,6),
(9, '2022-03-25 15:00:00', 108, 8, 13,7),
(10, '2022-03-25 15:00:00', 108, 8, 13,8),
(11, '2022-03-25 15:00:00', 108, 8, 13,6);

INSERT INTO tienda_flores VALUES
(6, 6),
(7, 7),
(8, 8);

-- Laboratorio 12
-- a) Mostrar los nombres, apellidos, y fecha de nacimiento de todos los clientes que compraron flores de luz
SELECT c.nombre, c.apellido, c.fecha_nacimiento
FROM  cliente c
JOIN  venta v ON c.cliente_ID = v.cliente_ID_cliente
JOIN flor f ON v.flor_ID_flor = f.flor_ID
WHERE f.ambiente = 'sol';
-- b) Muestre el código, especie y tamaño de todas las flores con fecha de germinación en octubre, noviembre o diciembre
SELECT f.flor_ID, f.especie, f.tamaño
FROM  flor f
WHERE MONTH(f.fecha_germinacion) = 10  
OR MONTH(f.fecha_germinacion) = 11 
OR MONTH(f.fecha_germinacion) = 12; 
-- c) Muestre todos el personal de servicio ordenado por el local en que trabajan
SELECT * FROM personal_servicio ps
ORDER BY tienda_ID_tienda ASC;
-- d) Defina una consulta que involucre por lo menos dos tablas y una condición.
SELECT ps.personal_ID, ps.nombres, ps.prim_apellido, t.tienda_ID, t.ciudad
FROM personal_servicio ps
JOIN tienda t ON ps.tienda_ID_tienda = t.tienda_ID
WHERE t.ciudad = 'Arequipa' OR t.ciudad = 'Lima';
-- e) Defina una consulta que involucre por lo menos dos tablas y dos condiciones
SELECT t.tienda_ID, t.ciudad, f.especie
FROM tienda t
JOIN tienda_flores tf ON t.tienda_ID = tf.tienda_ID
JOIN flor f ON tf.flor_ID = f.flor_ID
WHERE f.estacion = 'verano' AND f.tiempo_vida >= 20;

-- Laboratorio 14
-- a) Mostrar la cantidad de flores disponibles por cada estación
SELECT estacion, COUNT(*) AS cantidad_flores
FROM flor
GROUP BY estacion;
-- b) Muestre las ventas que registraron la compra de dos tipos de flores o más.
SELECT c.cliente_ID, c.nombre, COUNT(v.venta_ID) AS total_compras, v.fecha
FROM venta v
JOIN cliente c ON c.cliente_ID = v.cliente_ID_cliente
GROUP BY c.cliente_ID, c.nombre, v.fecha
HAVING COUNT(v.cliente_ID_cliente) >= 2;
-- c) Defina una consulta que involucre por lo menos dos tablas y un una función que involucre Fechas.
SELECT v.fecha, c.nombre AS nombre_cliente, t.ciudad, f.especie
FROM venta v
JOIN cliente c ON v.cliente_ID_cliente = c.cliente_ID
JOIN tienda t ON v.tienda_ID_tienda = t.tienda_ID
JOIN flor f ON v.flor_ID_flor = f.flor_ID
WHERE MONTH(v.fecha) = 1; 
-- d) Defina una consulta que involucre por lo menos dos tablas y una función de manipulación de textos.
SELECT c.nombre AS nombre_cliente, CONCAT(p.nombres, ' ', p.prim_apellido) AS nombre_vendedor
FROM venta v
JOIN cliente c ON v.cliente_ID_cliente = c.cliente_ID
JOIN personal_servicio p ON v.personal_ID_vendedor = p.personal_ID;

