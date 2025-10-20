FROM nocodb/nocodb:latest

ENV NC_DB="postgres://blogdb_wa32_user:CIGGSSBf8qGb7Y1Ej5kKoVlelMnRm8rZ@dpg-d3r1qemmcj7s73bipki0-a.oregon-postgres.render.com:5432/blogdb_wa32?ssl=true"
ENV NC_AUTH_JWT_SECRET="569a1821-0a93-45e8-87ab-eb857f20a010"

EXPOSE 8080
