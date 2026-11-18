#!/opt/homebrew/bin/fish

cd (dirname (status filename))

mysql -u root -e "SET GLOBAL local_infile = 1;"

mysql --local-infile=1 -u root -e "DROP DATABASE IF EXISTS airlines;"

mysql --local-infile=1 -u root < "airlines.sql"

mysql --local-infile=1 -u root -D airlines