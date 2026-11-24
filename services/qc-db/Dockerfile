FROM mariadb:10.11

# --- Weakness: trivial root password, bind to all interfaces ---
ENV MARIADB_ROOT_PASSWORD=QualityControl1
ENV MARIADB_DATABASE=qc_traceability

COPY init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306
