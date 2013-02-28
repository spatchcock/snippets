select this,that,the_other INTO OUTFILE '/tmp/file.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
FROM table_name;
