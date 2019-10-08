pacman -S ibus-table
ibus-table-createdb -s liu_ibus_table.txt -n liu.db
cp liu.db /usr/share/ibus-table/tables/
cp liu.png /usr/share/ibus-table/icons/
ibus restart
