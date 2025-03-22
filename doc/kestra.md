# Kestra and Postgres Containers

## Overview

This document describes the steps to take in order to
- Create Kestra container image locally
- Run Kestra and Postgres containers locally
- Clean up


## Prerequisites
- Docker & Docker Compose

## Building the Kestra Container Image

The following is the command to build the Kestra and postgres image locally. Note that in the [docker compose](../workflow-orchestration/docker-compose.yaml) file we pin the Kestra image version to `latest` which is always a moving target.


```
docker compose up
```


**Output**

```
[+] Running 1/1
 ✔ kestra Pulled                                                                                                   2.8s
[+] Running 3/3
 ✔ Network workflow-orchestration_default       Created                                                            0.0s
 ✔ Container workflow-orchestration-postgres-1  Created                                                            0.1s
 ✔ Container workflow-orchestration-kestra-1    Created                                                            0.1s
Attaching to kestra-1, postgres-1
postgres-1  |
postgres-1  | PostgreSQL Database directory appears to contain a database; Skipping initialization
postgres-1  |
postgres-1  | 2025-03-22 05:18:52.067 UTC [1] LOG:  starting PostgreSQL 17.2 (Debian 17.2-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
postgres-1  | 2025-03-22 05:18:52.068 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
postgres-1  | 2025-03-22 05:18:52.090 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
postgres-1  | 2025-03-22 05:18:52.115 UTC [29] LOG:  database system was shut down at 2025-03-22 05:17:12 UTC
postgres-1  | 2025-03-22 05:18:52.134 UTC [1] LOG:  database system is ready to accept connections
kestra-1    | 2025-03-22 05:18:54,087 INFO  main         org.flywaydb.core.FlywayExecutor Database: jdbc:postgresql://postgres:5432/kestra (PostgreSQL 17.2)
kestra-1    | 2025-03-22 05:18:54,146 INFO  main         o.f.core.internal.command.DbValidate Successfully validated 28 migrations (execution time 00:00.031s)
kestra-1    | 2025-03-22 05:18:54,156 INFO  main         o.f.core.internal.command.DbMigrate Current version of schema "public": 1.29
kestra-1    | 2025-03-22 05:18:54,158 INFO  main         o.f.core.internal.command.DbMigrate Schema "public" is up to date. No migration necessary.
kestra-1    | 2025-03-22 05:18:55,071 INFO  standalone   io.kestra.cli.AbstractCommand Starting Kestra 0.21.7 with environments [cli] [revision 17ed325 / 2025-03-18T15:49]
kestra-1    | 2025-03-22 05:18:55,177 INFO  standalone   i.kestra.core.plugins.PluginScanner Registered 91 core plugins (scan done in 100ms)
kestra-1    | 2025-03-22 05:18:55,500 INFO  standalone   i.kestra.core.plugins.PluginScanner Registered 542 plugins from 101 groups (scan done in 321ms)
kestra-1    | 2025-03-22 05:18:56,101 INFO  standalone   io.kestra.cli.AbstractCommand Server Running: http://b9dfadee4554:8080, Management server on port http://b9dfadee4554:8081/health
kestra-1    | 

```

```
## docker ps output

CONTAINER ID   IMAGE                  COMMAND                  CREATED              STATUS                        PORTS                              NAMES
b9dfadee4554   kestra/kestra:latest   "docker-entrypoint.s…"   About a minute ago   Up About a minute             0.0.0.0:8080-8081->8080-8081/tcp   workflow-orchestration-kestra-1
9c4af60d4b99   postgres               "docker-entrypoint.s…"   About a minute ago   Up About a minute (healthy)   0.0.0.0:5432->5432/tcp             workflow-orchestration-postgres-1
```

<br>

The following is the command to spin down everything.


```
docker-compose down
```


**Output**

```
 [+] Running 3/3
 ✔ Container workflow-orchestration-kestra-1    Removed                                                            2.2s
 ✔ Container workflow-orchestration-postgres-1  Removed                                                            0.7s
 ✔ Network workflow-orchestration_default       Removed                                                            0.7s
```

