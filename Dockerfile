FROM postgres:latest

ENV POSTGRES_DB=accounting_and_budgeting
ENV POSTGRES_USER=accounting_and_budgeting
ENV POSTGRES_PASSWORD=accounting_and_budgeting

# Copy all migration files to init directory
# PostgreSQL will execute these in alphabetical order on first run
COPY sql/V_acco*.sql /docker-entrypoint-initdb.d/

# Ensure the container uses UTF-8 encoding
ENV LANG=en_US.utf8
