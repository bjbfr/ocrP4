
sql_cmd()
{
psql -d olist -a -f ./sql/$1.sql 1>logs/$1.log 2>logs/$1_errors.log
}

count_lines()
{
 echo "$1 $(cat $1 | wc -l)"
}

count_lines_all()
{
for f in `ls olist_*_dataset.csv`
do
  count_lines $f
done
}

rm logs/*
# create, load and fix tables
sql_cmd olist_drop_tables
sql_cmd olist_create_tables
sql_cmd olist_fix_tables
sql_cmd olist_load_tables
sql_cmd olist_load_order_reviews
sql_cmd olist_convert_columns
sql_cmd olist_add_fk
sql_cmd olist_create_indexes
sql_cmd olist_create_view

#check
count_lines_all
cat logs/olist_load_tables.log

