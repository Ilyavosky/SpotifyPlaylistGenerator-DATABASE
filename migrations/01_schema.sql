CREATE TYPE track_status AS ENUM ('pending', 'accepted', 'rejected');

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  slug VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE generation_sessions (
  id SERIAL PRIMARY KEY,
  session_uuid VARCHAR(36) NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  target_valence FLOAT,
  target_energy FLOAT,
  target_danceability FLOAT,
  is_exported BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE session_seed_genres (
  session_id INTEGER NOT NULL REFERENCES generation_sessions(id) ON DELETE CASCADE,
  genre_id INTEGER NOT NULL REFERENCES genres(id),
  PRIMARY KEY (session_id, genre_id)
);

CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  spotify_id VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  image_url TEXT
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  spotify_id VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  release_date DATE,
  cover_url TEXT
);

CREATE TABLE tracks (
  id SERIAL PRIMARY KEY,
  spotify_id VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  duration_ms INTEGER,
  url VARCHAR(255) NOT NULL,
  album_id INTEGER REFERENCES albums(id),
  valence FLOAT,
  energy FLOAT,
  danceability FLOAT
);

CREATE TABLE track_artists (
  track_id INTEGER NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
  artist_id INTEGER NOT NULL REFERENCES artists(id),
  is_main_artist BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (track_id, artist_id)
);

CREATE TABLE session_tracks (
  id SERIAL PRIMARY KEY,
  session_id INTEGER NOT NULL REFERENCES generation_sessions(id) ON DELETE CASCADE,
  track_id INTEGER NOT NULL REFERENCES tracks(id),
  status track_status NOT NULL DEFAULT 'pending',
  added_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (session_id, track_id)
);