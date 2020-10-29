USE tienda; 

-- Reto 1 --
SELECT nombre
FROM articulo
WHERE nombre LIKE "%Pasta%"; 

SELECT nombre
FROM articulo
WHERE nombre LIKE "%Cannelloni%";

SELECT nombre
FROM articulo
WHERE nombre LIKE "% - %";

SELECT * 
FROM puesto
WHERE nombre LIKE "%Designer%";

SELECT * 
FROM puesto
WHERE nombre LIKE "%Developer%";

-- Reto 2
SELECT AVG(salario) AS "Salario Promedio"
FROM puesto;

SELECT COUNT(*) AS "Pasta in Name"
FROM articulo
WHERE nombre LIKE "%Pasta%";

SELECT MIN(salario) AS "Salario mínimo", 
       MAX(salario) AS "Salario máximo"
FROM puesto;

SELECT sum(salario) AS "Suma last 5"
FROM (SELECT salario
      FROM puesto
      ORDER BY id_puesto DESC 
      LIMIT 5) AS last5;

-- Reto 3 --
SELECT nombre, COUNT(*)
FROM puesto
GROUP BY nombre;

SELECT nombre, SUM(salario)
FROM puesto
GROUP BY nombre;

SELECT empleado.nombre, venta.id_empleado, count(clave) AS ventas
FROM venta, empleado
WHERE venta.id_empleado = empleado.id_empleado
GROUP BY venta.id_empleado
ORDER BY venta.id_empleado;

SELECT articulo.nombre, venta.id_articulo, count(clave) AS ventas
FROM venta, articulo
WHERE venta.id_articulo = articulo.id_articulo
GROUP BY venta.id_articulo
ORDER BY venta.id_articulo;
