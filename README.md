# meajudafi-stack

Scripts, docker compose and caddy configuration to setup the stack of [meajudafi](meajudafi.com.br) web site.

Technology and Requirements
----

This project uses the following stack:

- [PostgreSQL](https://www.postgresql.org/) as the database;
- [React](https://reactjs.org/) as the front-end framework;
- [Postgrest](http://postgrest.org) as the back-end;
- [PGAdmin](https://www.pgadmin.org/) as the database UI;
- [Caddy](https://caddyserver.com/) as the proxy.
- [Node.js](https://nodejs.org) for the background worker;
- [Docker Container Crontab](https://github.com/conradoqg/meajudafi-docker-container-crontab) as worker scheduler.

## Related repositories

- [meajudafi-front-end](https://github.com/conradoqg/meajudafi-front-end)
- [meajudafi-workers](https://github.com/conradoqg/meajudafi-workers)
- [meajudafi-docker-container-crontab](https://github.com/conradoqg/meajudafi-docker-container-crontab)

License
----
This project is licensed under the [MIT](LICENSE.md) License.