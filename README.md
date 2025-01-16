<h1 id="top" align="center">Database Initializer</h1>

<br/>

<h2 id="system-startup">🚀 System Startup</h2>

- Launch database. Check [`postgresql`](https://github.com/staucktion/postgresql) repository.

- Rename `.env.example` as `.env` with proper configurations.

- Place `init.sql` file for database structure and data.

- Launch database initializer. Check [`docker-config`](https://github.com/staucktion/docker-config) repository.

<h2 id="clean-sql">Clean Sql</h2>

replace following regex with empty string

```
^--.*\n{1,}
```
