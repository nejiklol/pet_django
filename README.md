# Project Setup

## Prerequisites
- Docker & Docker Compose
- Make

## Environment
Create a `.env` file in the project root.

## Build
```sh
make local-build
```
## Up
```sh
make local-up
```
Backend will be available at http://127.0.0.1:BACKEND_PORT_EXTERNAL.
## Stop
```sh
make local-down
```