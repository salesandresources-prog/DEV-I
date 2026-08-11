package com.devi.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    // Apuntando a la base de datos 'citas' correctamente
    private static final String URL = "jdbc:mysql://localhost:3306/citas?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = ""; 

    public static Connection obtenerConexion() {
        Connection conectar = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conectar = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("====== [DEV-I] ¡Conexión Exitosa con base 'citas'! ======");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("[Error DEV-I] Falla de conexión: " + e.getMessage());
        }
        return conectar;
    }
}