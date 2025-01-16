FROM ahmettoguz/postgresql-client

WORKDIR /app

COPY ./bank.sql .
COPY ./staucktion.sql .

CMD /bin/sh -c "\
  /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/bank.sql && \
  /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/staucktion.sql"
