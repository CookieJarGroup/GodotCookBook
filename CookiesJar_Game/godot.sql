

-- Borrar la base de datos
DROP Godot   IF     EXISTS Godot;
-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS Godot;
USE Godot;

-- Tabla User
CREATE TABLE user(
  username VARCHAR(10) NOT NULL,
  pass VARCHAR(10) NOT NULL
  PRIMARY KEY  (username,pass)
)engine = innodb;

