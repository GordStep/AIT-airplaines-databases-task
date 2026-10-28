#!/opt/homebrew/bin/fish

mysql -u root -e "SET GLOBAL local_infile = 1;"

mysql --local-infile=1 -u root -e "DROP DATABASE IF EXISTS airlines;"

mysql --local-infile=1 -u root < "/Users/gordstep/Documents/database/airplaines/airlines.sql"

mysql --local-infile=1 -u root -D airlines