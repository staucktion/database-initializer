FROM ahmettoguz/postgresql-client

WORKDIR /app

COPY ./bank.sql .
COPY ./staucktion.sql .

CMD /bin/sh -c "\
  echo '##################################################################### bank.sql running' && \
  echo '' && \
  /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/bank.sql && \
  echo 'bank.sql finished' && \
  echo '##################################################################### bank.sql finished' && \
  echo '' && \
  echo '##################################################################### staucktion.sql running' && \
  /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/staucktion.sql && \
  echo '##################################################################### staucktion.sql finished'"
