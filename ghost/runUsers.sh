mysql --defaults-file=mysql.cnf < createUsers.sql

read -p "Data created - Press enter to continue"

touch /tmp/users.postpone.flag

read -p "Flag file created  - Press enter to start the migration"

/Applications/gh-ost \
    --user=gh-ost \
    --password=gh-ost \
    --host=localhost \
    --port=3360 \
    --database=gh-ost \
    --table=users \
    --alter='engine=innodb' \
    --exact-rowcount \
    --switch-to-rbr \
    --initially-drop-old-table \
    --initially-drop-ghost-table \
    --throttle-query='select timestampdiff(second, min(last_update), now()) < 5 from _users_ghc' \
    --serve-socket-file=/tmp/users.test.sock \
    --initially-drop-socket-file \
    --postpone-cut-over-flag-file=/tmp/users.postpone.flag \
    --allow-on-master \
    --default-retries=1 \
    --stack \
    --execute \
    --alter='change column first firstname varchar(255) not null, change column last lastname varchar(255) not null after id' \
    --approve-renamed-columns
