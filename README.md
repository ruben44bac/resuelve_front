# Resuelve_front

Esta aplicación esta construida con Elixir y Phoenix live_view como framework, además se hizo uso de tailwindcss.
El proyecto publicado se puede encontrar en el siguiente enlace:

[resuelvef](https://resuelvef.gigalixirapp.com/)


## Instalación

Clona el repositorio

```bash
git clone https://github.com/ruben44bac/resuelve_front.git
```

Instala las dependencias por parte de elixir

```bash
cd resuelve_front && mix deps.get
```

Instala las dependencias de node

```bash
cd assets && npm install
```
Finalmente corre la aplicación

```bash
mix phx.server
```

ó si prefieres usa el modo interactivo 

```bash
PORT=4444 iex -S mix phx.server
```


## Uso

La aplicación cuenta con 2 ejercicios, uno de Ghibli y otro sobre Harvard Art Museums, para ingresar basta con entrar a tu localhost y navegar un rato.

```bash
http://localhost:4444/
```

Recuerda que puedes generar la documentación local de la aplicación con

```bash
mix docs
```

Pruebas

```bash
mix test
```
