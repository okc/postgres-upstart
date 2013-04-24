#description "PostgreSQL 9.2 Server"
#author "PostgreSQL"
 
# disable during testing --- manual operation only
#
#start on runlevel [2345]
#stop on runlevel [!2345]

#respawn

## EDIT FROM HERE

# Installation prefix
#env prefix=/usr/local/pgsql

# Data directory
#env PGDATA="/usr/local/pgsql/data"

# Who to run the postmaster as, usually "postgres".  (NOT "root")
#env PGUSER=postgres

# Where to keep a log file
#env PGLOG="/usr/local/pgsql/data/serverlog"

## STOP EDITING HERE

# What to use to start up the PostgresQL database cluster.  (If you want the script to wait
# until the server has started, you could use "pg_ctl start -w" here.
# But without -w, pg_ctl adds no value.)
#env DAEMON="/usr/local/pgsql/bin/postgres"

# What to use to shut down the PostgresQL database cluster.
#env PGCTL="/usr/local/pgsql/bin/pg_ctl"

#pre-start script
#if [ -d /var/run/postgresql ]; then
#chmod 2775 /var/run/postgresql
#else
#install -d -m 2775 -o postgres -g postgres /var/run/postgresql
#fi
#end script

#setuid postgres
#setgid postgres

# Parse command line parameters.
#script

  case $1 in
    start)
	#echo -n "Starting PostgreSQL: "
	#test x"$OOM_SCORE_ADJ" != x && echo "$OOM_SCORE_ADJ" > /proc/self/oom_score_adj
	#test x"$OOM_ADJ" != x && echo "$OOM_ADJ" > /proc/self/oom_adj
	#exec "/usr/local/pgsql/bin/postgres -D '/usr/local/pgsql/data' &" >>/usr/local/pgsql/data/serverlog 2>&1
	exec - postgres -c "/usr/local/pgsql/bin/postgres -D '/usr/local/pgsql/data'"
	#echo "ok"
	;;
    stop)
	#echo -n "Stopping PostgreSQL: "
	exec - postgres -c "/usr/local/pgsql/bin/pg_ctl stop -D '/usr/local/pgsql/data' -s -m fast"
	#echo "ok"
	;;
    restart)
	#echo -n "Restarting PostgreSQL: "
	exec - postgres -c "/usr/local/pgsql/bin/pg_ctl stop -D '/usr/local/pgsql/data' -s -m fast -w"
	#test x"$OOM_SCORE_ADJ" != x && echo "$OOM_SCORE_ADJ" > /proc/self/oom_score_adj
	#test x"$OOM_ADJ" != x && echo "$OOM_ADJ" > /proc/self/oom_adj
	exec - postgres -c "/usr/local/pgsql/bin/postgres -D '/usr/local/pgsql/data'"
	#echo "ok"
	;;
    reload)
        #echo -n "Reload PostgreSQL: "
        exec - postgres -c "/usr/local/pgsql/bin/pg_ctl reload -D '/usr/local/pgsql/data' -s"
        #echo "ok"
        ;;
    status)
	exec - postgres -c "/usr/local/pgsql/bin/pg_ctl status -D '/usr/local/pgsql/data'"
	;;
  *)
	# Print help
	echo "Usage: $0 {start|stop|restart|reload|status}"
	exit 1
	;;
esac

#end script

#exec "/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data"
