-- Script SQL para el sistema DEV-I (Agendamiento CallCenter)

CREATE DATABASE IF NOT EXISTS devi_db;
USE devi_db;

-- Tabla de Usuarios (Agentes de CallCenter)
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(50) DEFAULT 'agente'
);

-- Tabla de Clientes (Agendados y asignados a un agente)
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(20) NOT NULL,
    fecha_cita VARCHAR(50), -- String simple por la brevedad del codigo
    id_agente INT,
    FOREIGN KEY (id_agente) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

-- Insertar un administrador por defecto para poder ingresar la primera vez
INSERT INTO usuarios (nombre, correo, telefono, contrasena, rol) 
VALUES ('Administrador', 'admin@devi.com', '0000000000', 'admin123', 'Administrador');
