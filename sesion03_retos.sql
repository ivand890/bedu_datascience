USE tienda; 

-- Reto 1 --
SELECT nombre, apellido_paterno, apellido_materno
  FROM empleado
 WHERE id_puesto 
    IN
      (SELECT id_puesto
         FROM puesto
        WHERE salario < 11000);

SELECT id_empleado, MIN(total), MAX(total)
  FROM
      (SELECT clave, id_empleado, COUNT(*) AS total
         FROM venta
        GROUP BY clave, id_empleado) AS subquerry
 GROUP BY id_empleado;

SELECT clave, id_articulo 
  FROM venta
 WHERE id_articulo 
    IN 
      (SELECT id_articulo 
         FROM articulo 
        WHERE precio > 5000);

-- Reto 2 --
SELECT clave, nombre, apellido_paterno, apellido_materno
  FROM empleado
  JOIN venta
    ON empleado.id_empleado = venta.id_empleado
 ORDER BY clave;

SELECT clave, nombre
  FROM venta
  JOIN articulo
    ON venta.id_articulo = articulo.id_articulo
 ORDER BY clave;

SELECT clave, SUM(precio) AS Total_Venta
  FROM venta
  JOIN articulo
    ON venta.id_articulo = articulo.id_articulo
 GROUP BY clave
 ORDER BY Total_Venta DESC;

-- Reto 3 --
CREATE VIEW puestos AS
SELECT empleado.nombre, empleado.apellido_paterno, puesto.nombre AS puesto
  FROM empleado
  JOIN puesto
    ON empleado.id_puesto = puesto.id_puesto;

--SELECT *
--  FROM puestos;


CREATE VIEW empleado_articulo AS
SELECT venta.clave, 
       CONCAT(empleado.nombre, ' ', empleado.apellido_paterno) AS nombre, 
       articulo.nombre AS articulo
  FROM venta
  JOIN empleado
    ON venta.id_empleado = empleado.id_empleado
  JOIN articulo
    ON venta.id_articulo = articulo.id_articulo
 ORDER BY venta.clave;

--SELECT *
--  FROM empleado_articulo;


CREATE VIEW puesto_ventas AS
SELECT puesto.nombre, count(venta.clave) AS total
  FROM venta
  JOIN empleado
    ON venta.id_empleado = empleado.id_empleado
  JOIN puesto
    ON empleado.id_puesto = puesto.id_puesto
 GROUP BY puesto.nombre;

--SELECT *
--  FROM puesto_ventas
-- ORDER BY total DESC
-- LIMIT 1;