/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.courier.dao;

import com.courier.config.ConexionDB;
import com.courier.modelo.usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    
    // 1. Método para validar si el usuario existe y devolver su rol
    public usuarios validarUsuario(String email, String password) {
        usuarios Usuario = null;
        
        // CORRECCIÓN 1: Cambiamos para seleccionar TODO (*) o agregamos 'id'
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ? AND activo = true";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Usuario = new usuarios();
                // CORRECCIÓN 2: ¡Guardamos el ID! Esto era lo que faltaba
                Usuario.setId(rs.getInt("id")); 
                
                Usuario.setNombre_completo(rs.getString("nombre_completo"));
                Usuario.setEmail(rs.getString("email"));
                Usuario.setRol(rs.getString("rol"));
            }
        } catch (Exception e) {
            System.out.println("Error al validar: " + e.getMessage());
        }
        return Usuario;
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
    
    //3. Método extra: obtener solo el nombre por email (opcional, por si lo necesitas)
    public String obtenerNombrePorEmail(String email) {
        String sql = "SELECT nombre FROM usuarios WHERE email = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("nombre_completo");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return email; // fallback
    }
    // 4. Método NUEVO para listar todos los usuarios (Para el Admin)
    public List<usuarios> listarUsuarios() {
        List<usuarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE activo = true ORDER BY id ASC";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                usuarios u = new usuarios();
                u.setId(rs.getInt("id"));
                u.setNombre_completo(rs.getString("nombre_completo"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password")); // Opcional mostrarlas
                u.setRol(rs.getString("rol"));
                
                lista.add(u);
            }
        } catch (Exception e) {
            System.out.println("Error al listar usuarios: " + e.getMessage());
        }
        return lista;
    }
        // 5. MÉTODO PARA TRAER UN SOLO USUARIO (Para ponerlo en el formulario de edición)
    public usuarios obtenerPorId(int id) {
        usuarios u = new usuarios();
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setId(rs.getInt("id"));
                u.setNombre_completo(rs.getString("nombre_completo"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRol(rs.getString("rol"));
            }
        } catch (Exception e) {
            System.err.println("Error al buscar ID: " + e);
        }
        return u;
    }

    // 6. MÉTODO PARA ACTUALIZAR EN LA BASE DE DATOS
    public boolean actualizar(usuarios u) {
        String sql = "UPDATE usuarios SET nombre_completo=?, email=?, rol=?, password=? WHERE id=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, u.getNombre_completo());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getRol());
            ps.setString(4, u.getPassword()); // Actualizamos también la clave
            ps.setInt(5, u.getId());
            
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Error al actualizar: " + e);
            return false;
        }
    }
    // 7. MÉTODO PARA desactivar- activar USUARIO
    public void eliminar(int id) {
        String sql ="UPDATE usuarios SET activo = false WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error al desactivar usuario: " + e);
        }
    }
    // 8. LISTAR SOLO LOS ELIMINADOS (Para la papelera)
    public List<usuarios> listarInactivos() {
        List<usuarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE activo = false"; // <-- OJO: false
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                usuarios u = new usuarios();
                u.setId(rs.getInt("id"));
                u.setNombre_completo(rs.getString("nombre_completo"));
                u.setEmail(rs.getString("email"));
                u.setRol(rs.getString("rol"));
                lista.add(u);
            }
        } catch (Exception e) {
            System.err.println("Error listar inactivos: " + e);
        }
        return lista;
    }

    // 9. ACTIVAR USUARIO (Restaurar)
    public void activar(int id) {
        String sql = "UPDATE usuarios SET activo = true WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error al activar: " + e);
        }
    }
    // 10. MÉTODO PARA REGISTRAR NUEVO USUARIO
    public boolean registrar(usuarios u) {
        // Al crear uno nuevo, por defecto activo es TRUE
        String sql = "INSERT INTO usuarios (nombre_completo, email, password, rol, activo) VALUES (?, ?, ?, ?, true)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, u.getNombre_completo());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRol());
            
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Error al registrar: " + e);
            return false;
        }
    }
}

