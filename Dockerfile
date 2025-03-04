FROM ahmettoguz/postgresql-client

WORKDIR /app

COPY ./bank.sql .
COPY ./staucktion.sql .

CMD /bin/sh -c "\
  echo '🚀🚀🚀' && \
  echo '🚀 Running the bank.sql script' && \
  echo '🚀🚀🚀' && \

  /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/bank.sql && \

  echo '⚓⚓⚓' && \
  echo '⚓ Execution of bank.sql is complete' && \
  echo -e '⚓⚓⚓\n' && \

  echo '🚀🚀🚀' && \
  echo '🚀 Running the staucktion.sql script' && \
  echo '🚀🚀🚀' && \

  /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/staucktion.sql && \

  echo '⚓⚓⚓' && \
  echo '⚓ Execution of staucktion.sql is complete' && \
  echo '⚓⚓⚓'"
