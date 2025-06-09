--COMANDOS PROYECTO BASE DE DATOS MAYO


CREATE database proyecto_mayo;

USE proyecto_mayo;

CREATE table regiones(
      id_region INT PRIMARY KEY AUTO_INCREMENT,
      rnombre VARCHAR(40) NOT NULL
      );

CREATE TABLE pueblos(
      id_pueblo INT PRIMARY KEY AUTO_INCREMENT,
      pnombre VARCHAR(100) NOT NULL,
      num_habitantes INT NOT NULL,
      id_region INT NOT NULL,
      FOREIGN KEY (id_region) REFERENCES regiones(id_region)
      );

CREATE TABLE atracciones(
      id_atraccion INT PRIMARY KEY AUTO_INCREMENT,
      anombre VARCHAR(60) NOT NULL,
      turistas_anio INT NOT NULL,
      id_pueblo INT,
      FOREIGN KEY (id_pueblo) REFERENCES pueblos(id_pueblo)
      );



INSERT INTO regiones (rnombre) VALUES
      ('Valles Centrales'),
      ('Sierra Norte'),
      ('Sierra Sur'),
      ('Costa'),
      ('Istmo'),
      ('Mixteca'),
      ('Papaloapan'),
      ('Cañada');


INSERT INTO pueblos (pnombre, num_habitantes, id_region) VALUES
('San Pablo Villa de Mitla', 10000, 1),   
('Capulálpam de Méndez', 2000, 2),       
('San Pedro y San Pablo Teposcolula', 5000, 6),
('Huautla de Jiménez', 35000, 8), 
('Mazunte', 1500, 4); 

INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Zona Arqueológica de Mitla', 350000, 1),
('Iglesia de San Pablo Apóstol', 180000, 1),
('Fábricas de Mezcal de Mitla', 120000, 1),
('Mercado de Artesanías de Mitla', 150000, 1);

INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Templo de San Mateo', 50000, 2),
('Mirador de la Cruz', 40000, 2),
('Centro de Medicina Tradicional', 25000, 2),
('Senderos Ecoturísticos', 30000, 2);


INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Ex Convento de San Pedro y San Pablo', 70000, 3),
('Capilla Abierta', 60000, 3),
('Casa de la Cacica', 30000, 3),
('Ruinas del Cerro del Pueblo Viejo', 20000, 3);


INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Casa de María Sabina', 90000, 4),
('Cerro de la Adoración', 50000, 4),
('Grutas de San Agustín', 60000, 4),
('Mercado Tradicional de Huautla', 75000, 4);

INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Playa Mazunte', 200000, 5),
('Punta Cometa', 180000, 5),
('Centro Mexicano de la Tortuga', 150000, 5),
('Playa Mermejita', 100000, 5);

USE proyecto_mayo;

-- Consultas Simples

-- Ver todas las regiones
SELECT * FROM regiones;

-- Ver todos los pueblos
SELECT * FROM pueblos;

-- Ver todas las atracciones
SELECT * FROM atracciones;

-- Contar el número total de regiones
SELECT COUNT(id_region) AS total_regiones FROM regiones;

-- Contar el número total de pueblos
SELECT COUNT(id_pueblo) AS total_pueblos FROM pueblos;

-- Contar el número total de atracciones
SELECT COUNT(id_atraccion) AS total_atracciones FROM atracciones;

-- Obtener el nombre de la región con el nombre más largo (alfabéticamente el último)
SELECT MAX(rnombre) AS ultima_region_alfabeticamente FROM regiones;

-- Obtener el nombre de la región con el nombre más corto (alfabéticamente el primero)
SELECT MIN(rnombre) AS primera_region_alfabeticamente FROM regiones;

-- Obtener el pueblo con el mayor número de habitantes
SELECT MAX(num_habitantes) AS max_habitantes_pueblo FROM pueblos;

-- Obtener el pueblo con el menor número de habitantes
SELECT MIN(num_habitantes) AS min_habitantes_pueblo FROM pueblos;

-- Suma total de habitantes de todos los pueblos
SELECT SUM(num_habitantes) AS total_habitantes_pueblos FROM pueblos;

-- Promedio de habitantes por pueblo
SELECT AVG(num_habitantes) AS promedio_habitantes_pueblo FROM pueblos;

-- Suma total de turistas al año de todas las atracciones
SELECT SUM(turistas_anio) AS total_turistas_anual FROM atracciones;

-- Promedio de turistas al año por atracción
SELECT AVG(turistas_anio) AS promedio_turistas_atraccion FROM atracciones;

-- Consultas con Filtrado (WHERE)

-- Pueblos con más de 10000 habitantes
SELECT pnombre, num_habitantes FROM pueblos WHERE num_habitantes > 10000;

-- Atracciones con más de 100000 turistas al año
SELECT anombre, turistas_anio FROM atracciones WHERE turistas_anio > 100000;

-- Pueblos que pertenecen a la región de 'Valles Centrales' (asumiendo id_region = 1)
SELECT pnombre FROM pueblos WHERE id_region = 1;

-- Atracciones del pueblo 'Mazunte' (asumiendo id_pueblo = 5)
SELECT anombre FROM atracciones WHERE id_pueblo = 5;

-- Consultas con Agrupación (GROUP BY) y Agregación

-- Suma de habitantes por región
SELECT r.rnombre, SUM(p.num_habitantes) AS total_habitantes_region
FROM regiones r
INNER JOIN pueblos p ON r.id_region = p.id_region
GROUP BY r.rnombre;

-- Número de pueblos por región, ordenado por el nombre de la región
 

-- Promedio de turistas por pueblo
SELECT p.pnombre, AVG(a.turistas_anio) AS promedio_turistas_por_pueblo
FROM pueblos p
INNER JOIN atracciones a ON p.id_pueblo = a.id_pueblo
GROUP BY p.pnombre;

-- Contar el número de atracciones por pueblo
SELECT p.pnombre, COUNT(a.id_atraccion) AS total_atracciones_por_pueblo
FROM pueblos p
LEFT JOIN atracciones a ON p.id_pueblo = a.id_pueblo
GROUP BY p.pnombre
ORDER BY total_atracciones_por_pueblo DESC;

-- Consultas con Filtrado de Grupos (HAVING)

-- Regiones con un total de habitantes mayor a 10000
SELECT r.rnombre, SUM(p.num_habitantes) AS total_habitantes
FROM regiones r
INNER JOIN pueblos p ON r.id_region = p.id_region
GROUP BY r.rnombre
HAVING total_habitantes > 10000;

-- Pueblos que tienen más de 3 atracciones
SELECT p.pnombre, COUNT(a.id_atraccion) AS numero_atracciones
FROM pueblos p
INNER JOIN atracciones a ON p.id_pueblo = a.id_pueblo
GROUP BY p.pnombre
HAVING numero_atracciones > 3;

-- Consultas con Subconsultas

-- Pueblos que están en la región 'Valles Centrales' (usando subconsulta)
SELECT pnombre, num_habitantes
FROM pueblos
WHERE id_region IN (SELECT id_region FROM regiones WHERE rnombre = 'Valles Centrales');

-- Atracciones que pertenecen a pueblos con más de 10000 habitantes (usando subconsulta)
SELECT anombre, turistas_anio
FROM atracciones
WHERE id_pueblo IN (SELECT id_pueblo FROM pueblos WHERE num_habitantes > 10000);

-- Regiones que tienen al menos un pueblo con más de 20000 habitantes
SELECT rnombre
FROM regiones
WHERE id_region IN (SELECT id_region FROM pueblos WHERE num_habitantes > 20000);

-- Consultas con Joins (INNER JOIN, LEFT JOIN)

-- Listar todos los pueblos junto con el nombre de su región
SELECT p.pnombre, p.num_habitantes, r.rnombre AS nombre_region
FROM pueblos p
INNER JOIN regiones r ON p.id_region = r.id_region;

-- Listar todas las atracciones junto con el nombre del pueblo y su región
SELECT a.anombre, a.turistas_anio, p.pnombre AS nombre_pueblo, r.rnombre AS nombre_region
FROM atracciones a
INNER JOIN pueblos p ON a.id_pueblo = p.id_pueblo
INNER JOIN regiones r ON p.id_region = r.id_region;

-- Encontrar regiones que no tienen pueblos asignados (si hubiera alguna)
SELECT r.rnombre
FROM regiones r
LEFT JOIN pueblos p ON r.id_region = p.id_region
WHERE p.id_pueblo IS NULL;

-- Encontrar pueblos que no tienen atracciones asignadas (si hubiera alguno)
SELECT p.pnombre
FROM pueblos p
LEFT JOIN atracciones a ON p.id_pueblo = a.id_pueblo
WHERE a.id_atraccion IS NULL;

-- Consulta Compleja: Total de turistas por región, incluyendo el nombre de la región
SELECT r.rnombre AS nombre_region, SUM(a.turistas_anio) AS total_turistas_region
FROM regiones r
INNER JOIN pueblos p ON r.id_region = p.id_region
INNER JOIN atracciones a ON p.id_pueblo = a.id_pueblo
GROUP BY r.rnombre
ORDER BY total_turistas_region DESC;

-- Consulta Compleja: Pueblo con la atracción más visitada y su región
SELECT p.pnombre AS pueblo, r.rnombre AS region, a.anombre AS atraccion_mas_visitada, a.turistas_anio
FROM atracciones a
INNER JOIN pueblos p ON a.id_pueblo = p.id_pueblo
INNER JOIN regiones r ON p.id_region = r.id_region
ORDER BY a.turistas_anio DESC
LIMIT 1;

-- Consulta Compleja: Región con el mayor número de habitantes en sus pueblos mágicos
SELECT r.rnombre AS region_mas_habitada_en_pueblos_magicos, SUM(p.num_habitantes) AS total_habitantes
FROM regiones r
INNER JOIN pueblos p ON r.id_region = p.id_region
GROUP BY r.rnombre
ORDER BY total_habitantes DESC
LIMIT 1;

