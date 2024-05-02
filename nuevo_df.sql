use ny_project;

-- comprobamos que los datos se han importado correctamente
SELECT * FROM airbnb;
SELECT * FROM crimenes;

-- seleccionamos las columnas que queremos que se muestren
-- aplicamos función AVG a todas las columnas de crimenes porque es requisito para hacer el GROUP BY, aunque no repercute en el resultado final
-- hacemos join entre las tablas tomando el barrio como punto de referencia

SELECT 
	a.barrio AS barrios, ROUND(AVG(a.precio)) AS precio_medio, ROUND(AVG(a.numero_de_reviews)) AS num_medio_reviews,
	ROUND(AVG(c.numero_de_delitos)) AS numero_de_delitos, ROUND(AVG(c.numero_de_faltas)) AS numero_de_faltas, ROUND(AVG(c.numero_de_violaciones)) AS numero_de_violaciones, ROUND(AVG(c.diferencia_2017)) AS diferencia_crimenes_2016_2017, ROUND(AVG(c.diferencia_2018)) AS diferencia_crimenes_2017_2018
FROM ny_project.airbnb as a
JOIN ny_project.crimenes as c
ON a.barrio = c.barrio
GROUP BY a.barrio;

