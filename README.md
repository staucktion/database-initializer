<h1 id="top" align="center">Database Initializer [v1.2.0]</h1>

<br/>

<h2 id="system-startup">🚀 System Startup</h2>

- Launch database. Check [`postgresql`](https://github.com/staucktion/postgresql) repository.

- Rename `.env.example` as `.env` with proper configurations.

- Launch database initializer. Check [`docker-config`](https://github.com/staucktion/docker-config) repository.

<h2 id="clean-sql">Cleaning Sql file</h2>

In vs code replace following regex with empty string

```
^--.*\n{1,}
```
