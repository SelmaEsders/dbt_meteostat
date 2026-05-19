
WITH 	fl_from			AS (
							SELECT	origin AS faa
									,count(DISTINCT DEST) AS uniq_con_dep
									,count(SCHED_DEP_TIME) AS planned_dep
									,sum(CANCELLED) AS sum_cancelled_dep
									,sum(DIVERTED ) AS sum_diverted_dep
									,count(arr_time) AS flights_occured_dep
									,count(DISTINCT TAIL_NUMBER ) AS unique_airplanes_dep
									,count(DISTINCT AIRLINE) AS unique_airline_dep
							FROM {{ref('prep_flights')}}
							GROUP BY ORIGIN
							),
		fl_to			AS (
							SELECT	dest AS faa
									,count(DISTINCT origin) AS uniq_con_arr
									,count(SCHED_DEP_TIME) AS planned_arr
									,sum(CANCELLED) AS sum_cancelled_arr
									,sum(DIVERTED ) AS sum_diverted_arr
									,count(arr_time) AS flights_occured_arr
									,count(DISTINCT TAIL_NUMBER ) AS unique_airplanes_arr
									,count(DISTINCT AIRLINE) AS unique_airline_arr
							FROM {{ref('prep_flights')}}
							GROUP BY dest
							),
		j_fl_from_to	AS (
							SELECT	ff.FAA 
									,uniq_con_dep
									,uniq_con_arr
									,planned_dep + planned_arr AS total_planned
									,sum_cancelled_dep + sum_cancelled_arr AS total_cancelled
									,sum_diverted_dep + sum_diverted_arr AS total_diverted
									,flights_occured_dep + flights_occured_arr AS total_occ_flights
									,((unique_airplanes_dep + unique_airplanes_arr)::NUMERIC)/2 AS avg_unq_airpl
									,((unique_airline_dep + unique_airline_arr)::NUMERIC)/2 AS avg_unq_airline
							FROM fl_from AS ff
							JOIN fl_to	AS ft
							USING (faa)
							)
SELECT	name
		,CITY 
		,COUNTRY 
		,fft.*
FROM j_fl_from_to AS fft
JOIN {{ref('prep_airports')}}
using (faa)
ORDER BY name