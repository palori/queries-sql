# Mostrar totes les taules mentre codifiquem (despres comentar)
#select * from usairlineflights2.flights;
#select * from usairlineflights2.carriers;
#select * from usairlineflights2.usairports;

#########
# Notes:
# al importar dades de 'flights' no importar totes les columnes, deixa de carregar-ne algunes,
# per tant millor escollir tan sols les que necessitem pels exercicis.
#########

#############
# EXERCICIS #
#############

# 1: Quantitat de registres taula vols.
select count(*) 'total' from usairlineflights2.flights;

# 2: Retard promig de sortida i arribada segons l’aeroport origen.
select
	Origin,
	avg(ArrDelay) 'prom_arribades',
    avg(DepDelay) 'prom_sortides'
from usairlineflights2.flights
group by Origin;

# 3: Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen.
select
	Origin,
	colYear 'Any',
    colMonth 'Mes',
    avg(ArrDelay) 'prom_arribades'
from usairlineflights2.flights
group by colMonth, colYear, Origin
order by Origin, colYear, colMOnth;

# 4: (mateixa consulta que abans i amb el mateix ordre). Però ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat.
select
	City,
	colYear 'Any',
    colMonth 'Mes',
    avg(ArrDelay) 'prom_arribades'
from usairlineflights2.flights
left join usairlineflights2.usairports
	on usairlineflights2.flights.Origin = usairlineflights2.usairports.IATA
group by colMonth, colYear, City
order by City, colYear, colMOnth;

# 5: Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar ordenades
#    de forma que les companyies amb més cancel·lacions apareguin les primeres.
select
	UniqueCarrier,
    colYear,
    colMonth,
    sum(Cancelled) 'total_cancelled'
from usairlineflights2.flights
left join usairlineflights2.carriers
	on usairlineflights2.flights.UniqueCarrier = usairlineflights2.carriers.CarrierCode
group by colMonth, colYear
order by total_cancelled desc, colYear, colMOnth;

# 6: L’identificador dels 10 avions que més distància han recorregut fent vols.
select
    TailNum,
    sum(Distance) 'totalDistance'
from usairlineflights2.flights
where TailNum != ""
group by TailNum
order by totalDistance desc
limit 10;

# 7: Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben
#    al seu destí amb un retràs promig major de 10 minuts.
select
	UniqueCarrier,
    avg(ArrDelay) 'avgDelay'
from usairlineflights2.flights
group by UniqueCarrier
having avgDelay >= 10.0
order by avgDelay desc;
