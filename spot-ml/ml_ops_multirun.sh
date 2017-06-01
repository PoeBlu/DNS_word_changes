#!/bin/bash
#running ml_ops with different groups having different values of topic number, multiple replicates for each
for j in {1..10}
	do
		echo "Running ML"
		./ml_ops_test.sh 20170509 dns 1 100
		echo "Replicate: $j"
		echo "Saving csv file"
		mkdir /home/duxbury/brandon_results/multirun_results/dir_dns_spark_${j}
		hive -e "INSERT OVERWRITE LOCAL DIRECTORY '/home/duxbury/brandon_results/multirun_results/dir_dns_spark_${j}' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' SELECT * FROM brandon_dns_spark;"
		echo "csv file saved"
		echo "now merging csv files into one"
		cat /home/duxbury/brandon_results/multirun_results/dir_dns_spark_${j}/* > /home/duxbury/brandon_results/multirun_results/dns_spark_${j}.csv
	done
