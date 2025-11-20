/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.courier.dao;

import com.courier.config.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {
    
    // 1. Método para validar si el usuario existe y devolver su rol
    public String validarUsuario(String email, String password) {
        String rol = null;
        String sql = "SELECT rol FROM usuarios WHERE email = ? AND password = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                rol = rs.getString("rol"); // Si lo encuentra, guarda el rol (admin, cliente, etc)
            }
        } catch (Exception e) {
            System.out.println("Error al validar: " + e.getMessage());
        }
        return rol; // Retorna el rol o null si falló
    }

    // 2. Método para cambiar contraseña (Recuperación)
    public boolean cambiarPassword(String email, String nuevaPass) {
        String sql = "UPDATE usuarios SET password = ? WHERE email = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nuevaPass);
            ps.setString(2, email);
            
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0; // Retorna true si se actualizó algo
        } catch (Exception e) {
            System.out.println("Error al cambiar clave: " + e.getMessage());
            return false;
        }
    }
}
