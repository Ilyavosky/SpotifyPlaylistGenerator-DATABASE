# Aplicación MVP para generar playlists en Spotify

**Universidad Politécnica de Chiapas**

**Integrantes:**
- Cortés Ruiz Ilya — 243710
- Hernández Muñoz Brittany Aurora — 243707

Infraestructura de base de datos PostgreSQL para el proyecto Spotify Playlist Generator. Contiene el schema SQL y la configuración Docker para desarrollo local.

## Requisitos

- Docker Desktop

## Instalación

```bash
git clone https://github.com/Ilyavosky/SpotifyPlaylistGenerator-DATABASE.git
cd SpotifyPlaylistGenerator-DATABASE
git checkout develop
```

## Variables de entorno

Crea un archivo `.env` en la raíz del proyecto

## Ejecución

```bash
# Levantar la base de datos
docker compose up -d

# Verificar que está corriendo
docker ps

# Detener
docker compose down

# Detener y eliminar datos
docker compose down -v
```

Las migrations en `migrations/01_schema.sql` se ejecutan automáticamente al primer `docker compose up`.

## Schema

La base de datos modela el flujo completo de generación de playlists:

```
generation_sessions     — Sesión de generación con parámetros de vibra
session_seed_genres     — Géneros semilla usados en cada sesión
genres                  — Catálogo de géneros disponibles
tracks                  — Canciones obtenidas de Spotify
artists                 — Artistas de cada track
albums                  — Álbumes de cada track
track_artists           — Relación track-artista (soporta featuring)
session_tracks          — Estado de cada track en una sesión (pending/accepted/rejected)
```

### Enum track_status

```sql
CREATE TYPE track_status AS ENUM ('pending', 'accepted', 'rejected');
```


## Declaración de uso de IA

Este proyecto fue desarrollado con asistencia de Claude (Anthropic) como herramienta de apoyo para la generación de código en las partes criticas debido a que la API de Spotify sufrió cambios drásticos, y sigue en desarrollo, muchos endpoints cambiaron y se volvió más estricta. Nuestro equipo revisó, validó, adaptó y comprende todo el código que fue diseñado con el uso de IA. Claro que en su mayoria es de autoría propia, pues investigamos la documentación de cada recurso usado.
