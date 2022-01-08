# meajudafi-stack

Scripts and templates to setup the stack of [meajudafi](https://meajudafi.com.br/) web site.

Technology and Requirements
----

This project uses the following stack:

- [PostgreSQL](https://www.postgresql.org/) as the database;
- [React](https://reactjs.org/) as the front-end framework;
- [Postgrest](http://postgrest.org) as the back-end;
- [PGAdmin](https://www.pgadmin.org/) as the database UI;
- [Node.js](https://nodejs.org) for the background worker;
- [MicroK8s](https://microk8s.io/) as a kubernetes.

It requires the following tool to be installed:

- [MicroK8s](https://microk8s.io/) as a kubernetes, with DNS, ingress and a default storage class;
- [Make](https://www.gnu.org/software/make/) as build tool;
- [Kubetpl](https://github.com/shyiko/kubetpl) as k8s template rendering.

To install do:

```sh
$ make
$ sudo make install
```

## Related repositories

- [meajudafi-front-end](https://github.com/conradoqg/meajudafi-front-end)
- [meajudafi-workers](https://github.com/conradoqg/meajudafi-workers)

License
----
This project is licensed under the [MIT](LICENSE.md) License.
