INITIALIZED_DB=$(psql -qX -U postgres $POSTGRES_DB -c 'select username, password from usr;' | grep admin)

if [[ -z "$INITIALIZED_DB" ]] ; then
#    su postgres -c /usr/share/davical/dba/create-database.sh
    psql -qX -U postgres -c 'CREATE ROLE $POSTGRES_DB;'
    psql -qX -U postgres -c "ALTER USER davical WITH PASSWORD '$PGPASS';"
    psql -qX -U postgres -c 'GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $PGUSER;'
    psql -qXAt -U $PGUSER $POSTGRES_DB < /usr/share/awl/dba/awl-tables.sql
    psql -qXAt -U $PGUSER $POSTGRES_DB < /usr/share/awl/dba/schema-management.sql
    psql -qXAt -U $PGUSER $POSTGRES_DB < /usr/share/davical/dba/davical.sql
    psql -qXAt -U $PGUSER $POSTGRES_DB < /usr/share/davical/dba/base-data.sql
    psql -qX -U $PGUSER $POSTGRES_DB -c "UPDATE usr SET user_no = 1, password = '**$ADMINPW' WHERE username = 'admin';"
else
    psql -qX -U $PGUSER -c "ALTER USER $PGUSER WITH PASSWORD '$PGPASS';"
    psql -qX -U $PGUSER -c 'GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $PGUSER;'
    psql -qX -U $PGUSER $POSTGRES_DB -c "UPDATE usr SET user_no = 1, password = '**$ADMINPW' WHERE username = 'admin';"
fi

#UPDATE ALWAYS THE DATABASE
sleep 3
/usr/share/davical/dba/update-davical-database --dbname $POSTGRES_DB --dbuser $PGUSER --dbpass $PGPASS --appuser $PGUSER --nopatch --owner $PGUSER
