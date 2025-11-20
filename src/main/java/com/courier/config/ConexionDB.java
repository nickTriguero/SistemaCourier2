/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.courier.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {

    // Configuración de la base de datos
    private static final String URL = "jdbc:postgresql://localhost:5432/courier_db";
    private static final String USER = "postgres"; 
    private static final String PASS = "1234"; 

    // Método para obtener la conexión
    public static Connection getConexion() {
        Connection con = null;
        try {
            // Cargar el driver (asegúrate de haber agregado la librería .jar)
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            System.out.println("Error: No se encontró el Driver de PostgreSQL.");
        } catch (SQLException e) {
            System.out.println("Error de SQL: " + e.getMessage());
        }
        return con;
    }

    // Método Main SOLO para probar que la conexión funciona ahora mismo
    public static void main(String[] args) {
        Connection prueba = getConexion();
        if (prueba != null) {
            System.out.println("¡CONEXIÓN EXITOSA! La base de datos está lista.");
        } else {
            System.out.println("FALLÓ la conexión. Revisa el usuario y contraseña.");
        }
    }
}