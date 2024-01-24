DROP DATABASE IF EXISTS labcine;
CREATE SCHEMA labcine;
USE labcine;

DROP TABLE IF EXISTS persona;
CREATE TABLE persona (
  persona_ID int,
  nombres varchar(20),
  prim_apellido varchar(20),
  seg_apellido varchar(20) ,
  genero enum('mujer','hombre') ,
  nacionalidad varchar(20),
  fecha_nacimiento date ,
  PRIMARY KEY (persona_ID)
);

DROP TABLE IF EXISTS responsable;
CREATE TABLE responsable(
	persona_ID int NOT NULL,
	fecha_contrat date,
	correo varchar(50),
	telefono INTEGER,
	sala_ID_sala_cine INTEGER,
	PRIMARY KEY (persona_ID)
);

DROP TABLE IF EXISTS director;
CREATE TABLE director(
  persona_ID int PRIMARY KEY
);

DROP TABLE IF EXISTS actor;
CREATE TABLE actor(
  persona_ID int PRIMARY KEY
);

DROP TABLE IF EXISTS sala_cine;
CREATE TABLE sala_cine(
    sala_ID int PRIMARY KEY,
    nombre varchar(20),
    tipo varchar(20),
    tipo_asiento enum('cama','normal'),
    tipo_pantalla enum('plano','curvo'),
    ubicacion varchar(1),
    capacidad int,
    persona_ID_responsable int,
    pelicula_ID_pelicula int,  
    horario_ID_horario int  
);

DROP TABLE IF EXISTS sala_cine_tecnologia;
CREATE TABLE sala_cine_tecnologia(
    sala_ID int,
    tecnologia VARCHAR(10),
    PRIMARY KEY(sala_ID,tecnologia)
);

DROP TABLE IF EXISTS horario;
CREATE TABLE horario(
    horario_ID int PRIMARY KEY,
    fecha_hora DATETIME
);

DROP TABLE IF EXISTS pelicula;
CREATE TABLE pelicula(
    pelicula_ID int PRIMARY KEY,
    titulo varchar(30),
    estudio varchar(30),
    clasificacion enum('G','PG','PG-13','R','NC-17'),
    sinopsis varchar(200)
);

DROP TABLE IF EXISTS pelicula_idioma;
CREATE TABLE pelicula_idioma(
    pelicula_ID int,
    idioma varchar(30),
    PRIMARY KEY(pelicula_ID,idioma)
);

DROP TABLE IF EXISTS director_pelicula;
CREATE TABLE director_pelicula(
    persona_ID_director int,
    pelicula_ID_pelicula int,
    PRIMARY KEY(persona_ID_director,pelicula_ID_pelicula)
);

DROP TABLE IF EXISTS actor_pelicula;
CREATE TABLE actor_pelicula(
    persona_ID_actor int,
    pelicula_ID_pelicula int,
    PRIMARY KEY(persona_ID_actor,pelicula_ID_pelicula)
);

ALTER TABLE responsable ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE responsable ADD FOREIGN KEY (sala_ID_sala_cine) REFERENCES sala_cine (sala_ID);
ALTER TABLE director ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE director ADD FOREIGN KEY (persona_ID) REFERENCES director_pelicula (persona_ID_director);
ALTER TABLE actor ADD FOREIGN KEY (persona_ID) REFERENCES persona (persona_ID);
ALTER TABLE sala_cine ADD FOREIGN KEY (sala_ID) REFERENCES sala_cine_tecnologia (sala_ID);
ALTER TABLE sala_cine ADD FOREIGN KEY (persona_ID_responsable) REFERENCES responsable (persona_ID);
ALTER TABLE sala_cine ADD FOREIGN KEY (pelicula_ID_pelicula) REFERENCES pelicula (pelicula_ID);
ALTER TABLE sala_cine ADD FOREIGN KEY (horario_ID_horario) REFERENCES horario (horario_ID);
ALTER TABLE director_pelicula ADD FOREIGN KEY (pelicula_ID_pelicula) REFERENCES pelicula (pelicula_ID);
ALTER TABLE actor_pelicula ADD FOREIGN KEY (persona_ID_actor) REFERENCES actor (persona_ID);
ALTER TABLE actor_pelicula ADD FOREIGN KEY (pelicula_ID_pelicula) REFERENCES pelicula (pelicula_ID);
ALTER TABLE pelicula_idioma ADD FOREIGN KEY (pelicula_ID) REFERENCES pelicula (pelicula_ID);

INSERT INTO sala_cine_tecnologia (sala_ID, tecnologia) VALUES
  (1, '2D'),
  (2, '3D'),
  (3, '4D'),
  (4, '2D'),
  (5, '3D');

INSERT INTO sala_cine (sala_ID, nombre, tipo, tipo_asiento, tipo_pantalla, ubicacion, capacidad, persona_ID_responsable, pelicula_ID_pelicula, horario_ID_horario)
VALUES
  (1, 'Sala 1', 'VIP', 'cama', 'plano', 'A', 50, NULL, NULL, NULL),
  (2, 'Sala 2', 'Normal', 'normal', 'curvo', 'B', 100, NULL, NULL, NULL),
  (3, 'Sala 3', 'Premium', 'cama', 'plano', 'C', 80, NULL, NULL, NULL),
  (4, 'Sala 4', 'VIP', 'normal', 'curvo', 'D', 120, NULL, NULL, NULL),
  (5, 'Sala 5', 'Normal', 'cama', 'plano', 'E', 70, NULL, NULL, NULL);

INSERT INTO horario (horario_ID, fecha_hora)
VALUES
  (1, '2023-01-10 10:00:00'),
  (2, '2023-01-10 15:30:00'),
  (3, '2023-01-11 18:45:00'),
  (4, '2023-01-11 21:15:00'),
  (5, '2023-01-12 12:00:00');
  
INSERT INTO pelicula (pelicula_ID, titulo, estudio, clasificacion, sinopsis)
VALUES
  (1, 'Titanic', 'Paramount', 'PG-13', 'Historia de amor en un barco'),
  (2, 'La La Land', 'Lionsgate', 'PG-13', 'Musical en Los Ángeles'),
  (3, 'Avatar', '20th Century Fox', 'PG-13', 'Aventura en Pandora'),
  (4, 'El Padrino', 'Paramount', 'R', 'Drama y crimen en la mafia'),
  (5, 'Jurassic Park', 'Universal', 'PG-13', 'Parque de dinosaurios');
  
INSERT INTO pelicula_idioma (pelicula_ID, idioma)
VALUES
  (1, 'Español'),
  (1, 'Inglés'),
  (2, 'Español'),
  (2, 'Inglés'),
  (3, 'Español'),
  (4, 'Español'),
  (5, 'Inglés');

INSERT INTO persona (persona_ID, nombres, prim_apellido, seg_apellido, genero, nacionalidad, fecha_nacimiento)
VALUES
  (1, 'Juan', 'Pérez', 'Gomez', 'hombre', 'Mexicana', '1990-05-15'),
  (2, 'Ana', 'López', 'Martínez', 'mujer', 'Española', '1985-08-22'),
  (3, 'Carlos', 'García', 'Ramírez', 'hombre', 'Colombiana', '1988-03-10'),
  (4, 'Laura', 'Hernández', 'Sánchez', 'mujer', 'Argentina', '1995-12-03'),
  (5, 'Pedro', 'Martínez', 'González', 'hombre', 'Chilena', '1993-07-18'),
  (6, 'Pedro', 'Pérez', 'Gomez', 'hombre', 'Mexicana', '1990-05-15'),
  (7, 'Camila', 'López', 'Martínez', 'mujer', 'Española', '1985-08-22'),
  (8, 'Pedro', 'García', 'Ramírez', 'hombre', 'Colombiana', '1988-03-10'),
  (9, 'Gloria', 'Hernández', 'Sánchez', 'mujer', 'Argentina', '1995-12-03'),
  (10, 'Bruno', 'Martínez', 'González', 'hombre', 'Chilena', '1993-07-18');
  
INSERT INTO responsable (persona_ID, fecha_contrat, correo, telefono, sala_ID_sala_cine)
VALUES
  (6, '2022-01-01', 'juan.perez@email.com', 123456789, null),
  (7, '2021-11-15', 'ana.lopez@email.com', 987654321, null),
  (8, '2023-03-05', 'carlos.garcia@email.com', 555555555, null),
  (9, '2020-08-20', 'laura.hernandez@email.com', 111111111, null),
  (10, '2022-06-10', 'pedro.martinez@email.com', 999999999, null);
  

INSERT INTO director_pelicula (persona_ID_director, pelicula_ID_pelicula)
VALUES
  (1, 1),
  (3, 3),
  (5, 5);

INSERT INTO director (persona_ID)
VALUES (1), (3), (5);

INSERT INTO actor (persona_ID)
VALUES (2), (4);

INSERT INTO actor_pelicula (persona_ID_actor, pelicula_ID_pelicula)
VALUES
  (2, 1),
  (4, 3);
  
  INSERT INTO sala_cine_tecnologia (sala_ID, tecnologia) VALUES
  (6, '2D'),
  (7, '3D'),
  (8, '4D'),
  (9, '2D'),
  (10, '3D'),
  (11, '2D'),
  (12, '3D'),
  (13, '4D');
  

-- Laboratorio 11
INSERT INTO sala_cine (sala_ID, nombre, tipo, tipo_asiento, tipo_pantalla, ubicacion, capacidad, persona_ID_responsable, pelicula_ID_pelicula, horario_ID_horario)
VALUES
  (6, 'Sala 6', 'VIP', 'cama', 'plano', 'F', 60, 6, 1, 1),
  (7, 'Sala 7', 'Normal', 'normal', 'curvo', 'G', 90, 7, 2, 2),
  (8, 'Sala 8', 'Premium', 'cama', 'plano', 'H', 75, 8, 3, 3),
  (9, 'Sala 9', 'VIP', 'normal', 'curvo', 'I', 110, 9, 4, 4),
  (10, 'Sala 10', 'Normal', 'cama', 'plano', 'J', 85, 10, 5, 5),
  (11, 'Sala 11', 'VIP', 'cama', 'plano', 'K', 70, NULL, NULL, NULL),
  (12, 'Sala 12', 'Normal', 'normal', 'curvo', 'L', 95, NULL, NULL, NULL),
  (13, 'Sala 13', 'Premium', 'cama', 'plano', 'M', 80, NULL, NULL, NULL);

INSERT INTO horario (horario_ID, fecha_hora)
VALUES
  (6, '2023-01-13 14:30:00'),
  (7, '2023-01-14 17:00:00'),
  (8, '2023-01-15 20:15:00'),
  (9, '2023-01-16 22:45:00'),
  (10, '2023-01-17 11:30:00'),
  (11, '2023-01-18 16:45:00'),
  (12, '2023-01-19 19:00:00'),
  (13, '2023-01-20 21:30:00');

INSERT INTO pelicula (pelicula_ID, titulo, estudio, clasificacion, sinopsis)
VALUES
  (6, 'Inception', 'Warner Bros.', 'PG-13', 'Dream heist'),
  (7, 'The Shawshank Redemption', 'Columbia Pictures', 'R', 'Drama in prison'),
  (8, 'Forrest Gump', 'Paramount Pictures', 'PG-13', 'Life journey'),
  (9, 'The Dark Knight', 'Warner Bros.', 'PG-13', 'Batman saga'),
  (10, 'The Matrix', 'Warner Bros.', 'R', 'Virtual reality');

INSERT INTO pelicula_idioma (pelicula_ID, idioma)
VALUES
  (6, 'Inglés'),
  (6, 'Español'),
  (7, 'Inglés'),
  (8, 'Español'),
  (9, 'Inglés'),
  (9, 'Español'),
  (10, 'Inglés'),
  (10, 'Español');

INSERT INTO persona (persona_ID, nombres, prim_apellido, seg_apellido, genero, nacionalidad, fecha_nacimiento)
VALUES
  (11, 'Miguel', 'Gómez', 'Pérez', 'hombre', 'Mexicana', '1991-09-25'),
  (12, 'Luisa', 'Molina', 'Vargas', 'mujer', 'Colombiana', '1987-04-12'),
  (13, 'Gabriel', 'Fernández', 'López', 'hombre', 'Chilena', '1998-11-05'),
  (14, 'Isabella', 'Rodríguez', 'Santos', 'mujer', 'Dominicana', '1994-02-18'),
  (15, 'Diego', 'Martínez', 'Torres', 'hombre', 'Mexicana', '1992-06-30'),
  (16, 'Sofía', 'Moreno', 'Gómez', 'mujer', 'Peruana', '1993-08-15'),
  (17, 'Alejandro', 'Soto', 'López', 'hombre', 'Venezolana', '1989-03-22'),
  (18, 'Elena', 'Guerrero', 'Vargas', 'mujer', 'Ecuatoriana', '1997-12-08');

INSERT INTO responsable (persona_ID, fecha_contrat, correo, telefono, sala_ID_sala_cine)
VALUES
  (11, '2022-02-05', 'miguel.gomez@email.com', 111111111, 6),
  (12, '2021-10-18', 'luisa.molina@email.com', 222222222, 7),
  (13, '2023-04-02', 'gabriel.fernandez@email.com', 333333333, 8),
  (14, '2020-09-15', 'isabella.rodriguez@email.com', 444444444, 9),
  (15, '2022-07-20', 'diego.martinez@email.com', 555555555, 10),
  (16, '2021-09-10', 'sofia.moreno@email.com', 666666666, 11),
  (17, '2022-12-05', 'alejandro.soto@email.com', 777777777, 12),
  (18, '2020-11-30', 'elena.guerrero@email.com', 888888888, 13);

INSERT INTO director_pelicula (persona_ID_director, pelicula_ID_pelicula)
VALUES
  (7, 2),
  (7, 6),
  (7, 4),
  (9, 4),
  (9, 6),
  (9, 8),
  (9, 2),
  (11, 6),
  (13, 8);

INSERT INTO director (persona_ID)
VALUES (7), (9), (11), (13);

INSERT INTO actor (persona_ID)
VALUES (8), (10), (12), (14), (16);

INSERT INTO actor_pelicula (persona_ID_actor, pelicula_ID_pelicula)
VALUES
  (2, 2),
  (2, 4),
  (12, 6),
  (14, 8),
  (16, 10);
  
  -- a) Mostrar los nombres, apellidos, nacionalidad y edad de todos los directores:
SELECT p.nombres, p.prim_apellido, p.nacionalidad, YEAR(CURDATE()) - YEAR(p.fecha_nacimiento) AS edad
FROM director_pelicula dp
JOIN persona p ON dp.persona_ID_director = p.persona_ID;

-- b) Mostrar el código y título de las películas:
SELECT pelicula_ID, titulo
FROM pelicula;

-- c) Mostrar todas las películas que se emitieron en el último año:
SELECT s.sala_ID, s.nombre AS nombre_sala, h.fecha_hora, p.titulo AS titulo_pelicula
FROM sala_cine s
JOIN horario h ON s.horario_ID_horario = h.horario_ID
LEFT JOIN pelicula p ON s.pelicula_ID_pelicula = p.pelicula_ID
WHERE YEAR(h.fecha_hora) = 2023;

-- d) Definir una consulta que involucre al menos dos tablas y una condición (como ejemplo, estoy utilizando las tablas pelicula y director_pelicula):
SELECT p.pelicula_ID, p.titulo, dp.persona_ID_director, per.nombres AS nombre_director
FROM pelicula p
JOIN director_pelicula dp ON p.pelicula_ID = dp.pelicula_ID_pelicula
JOIN persona per ON dp.persona_ID_director = per.persona_ID
WHERE p.clasificacion = 'PG-13';

-- e) Definir una consulta que involucre al menos dos tablas y dos condiciones (como ejemplo, estoy utilizando las tablas pelicula, pelicula_idioma e idioma):
SELECT p.pelicula_ID, p.titulo, pi.idioma
FROM pelicula p
JOIN pelicula_idioma pi ON p.pelicula_ID = pi.pelicula_ID
WHERE p.clasificacion = 'PG-13' AND pi.idioma = 'Español';

-- LABORATORIO 13

-- a) Mostrar la cantidad de películas que tienen un idioma similar (Por ejemplo español)
SELECT idioma , COUNT(pelicula_ID) AS cantidad_peliculas
FROM pelicula_idioma
GROUP BY idioma;
-- b) Muestre los directores u actores que aparecen en 3 películas como mínimo
SELECT p.* ,COUNT(dp.persona_ID_director) AS Cantidad_peliculas
FROM director_pelicula dp
JOIN persona p ON p.persona_ID = dp.persona_ID_director
GROUP BY dp.persona_ID_director
HAVING COUNT(dp.persona_ID_director) >= 3;
-- c) Defina una consulta que involucre por lo menos dos tablas y un Group By.
SELECT t.tecnologia, GROUP_CONCAT(sc.nombre ORDER BY sc.sala_ID) AS Nombres_Salas
FROM sala_cine_tecnologia t
JOIN sala_cine sc ON t.sala_ID = sc.sala_ID
GROUP BY t.tecnologia;
-- d) Defina una consulta que involucre por lo menos dos tablas y una función de agregación.
SELECT sc.tipo_asiento, SUM(sc.capacidad) AS Capacidad_Total
FROM sala_cine sc
INNER JOIN sala_cine_tecnologia sct ON sc.sala_ID = sct.sala_ID
GROUP BY sc.tipo_asiento;

-- LABORATORIO 15

-- a) Implemente una función que dado una sala de cine y un idioma, retorne la cantidad de películas proyectadas bajo el idioma indicado

-- b) Implemente una función que reciba como mínimo 2 parámetros de entrada

-- c) Implemente un procedimiento almacenado que por medio del nombre y apellidos de un responsable de sala, se obtenga la información 
-- detallada de las salas, películas, géneros, nombre de directores y horario en la que estuvo a cargo.

-- d) Implemente un procedimiento almacenado que reciba por lo menos 3 parámetros de entrada

-- e) Implemente un procedimiento almacenado que utilice una de las funciones anteriores.
