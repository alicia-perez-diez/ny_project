USE ny_project;
-
CREATE TEMPORARY TABLE resumen_crimenes
SELECT 
	a.barrio AS barrios, ROUND(AVG(a.precio)) AS precio_medio, ROUND(AVG(a.numero_de_reviews)) AS num_medio_reviews,
	ROUND(AVG(c.numero_de_delitos)) AS numero_de_delitos, ROUND(AVG(c.numero_de_faltas)) AS numero_de_faltas, ROUND(AVG(c.numero_de_violaciones)) AS numero_de_violaciones, ROUND(AVG(c.diferencia_2017)) AS diferencia_crimenes_2016_2017, ROUND(AVG(c.diferencia_2018)) AS diferencia_crimenes_2017_2018
FROM ny_project.airbnb as a
JOIN ny_project.crimenes as c
ON a.barrio = c.barrio
GROUP BY a.barrio;
-
CREATE TEMPORARY TABLE resumen_crimenes_totales
SELECT *, numero_de_delitos + numero_de_faltas + numero_de_violaciones AS total_crimenes
FROM resumen_crimenes;
-
CREATE TEMPORARY TABLE precios_medios_totales
SELECT SUM(precio_medio) AS precio_medio_total
FROM resumen_crimenes;
-
SELECT barrios, (rc.precio_medio/pm.precio_medio_total) * 100 AS promedio_de_precio
FROM resumen_crimenes_totales AS rc
JOIN precios_medios_totales AS pm;