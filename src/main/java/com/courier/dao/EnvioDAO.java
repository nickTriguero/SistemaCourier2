/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.courier.dao;
import com.courier.config.ConexionDB;
import com.courier.modelo.envios;
import com.courier.modelo.usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EnvioDAO {

    // 1. LISTAR TODOS LOS ENVÍOS (Para que el Admin los vea)
    public List<envios> listar() {
        List<envios> lista = new ArrayList<>();
        // Unimos tablas para ver el nombre del cliente y no solo su ID
        String sql = "SELECT * FROM envios ORDER BY id_envio DESC"; 
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                envios e = new envios();
                e.setId_envio(rs.getInt("id_envio"));
                e.setN_guia(rs.getString("n_guia"));
                e.setDescripcion(rs.getString("descripcion"));
                e.setEstado(rs.getString("estado"));
                e.setCliente_id(rs.getInt("cliente_id"));
                e.setCurier_id(rs.getInt("curier_id")); // OJO: Así está en tu base de datos
                lista.add(e);
            }
        } catch (Exception e) {
            System.err.println("Error al listar envios: " + e);
        }
        return lista;
    }

    // 2. LISTAR SOLO COURIERS (Para llenar el dropdown de asignar)
    public List<usuarios> listarCouriers() {
        List<usuarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE rol = 'courier' AND activo = true";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                usuarios u = new usuarios();
                u.setId(rs.getInt("id"));
                u.setNombre_completo(rs.getString("nombre_completo"));
                lista.add(u);
            }
        } catch (Exception e) {
            System.err.println("Error al listar couriers: " + e);
        }
        return lista;
    }

    // 3. ACTUALIZAR ESTADO Y ASIGNAR COURIER
    public boolean actualizarEnvio(int idEnvio, String estado, int idCourier) {
        String sql = "UPDATE envios SET estado = ?, curier_id = ? WHERE id_envio = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, idCourier);
            ps.setInt(3, idEnvio);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Error actualizando envio: " + e);
            return false;
        }
    }
    // 4. LISTAR SOLO LOS PAQUETES DE UN COURIER ESPECÍFICO
    public List<envios> listarPorCourier(int idCourier) {
        List<envios> lista = new ArrayList<>();
        // Buscamos solo donde curier_id coincida
        String sql = "SELECT * FROM envios WHERE curier_id = ? ORDER BY id_envio DESC"; 
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCourier);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                envios e = new envios();
                e.setId_envio(rs.getInt("id_envio"));
                e.setN_guia(rs.getString("n_guia"));
                e.setDescripcion(rs.getString("descripcion"));
                e.setEstado(rs.getString("estado"));
                e.setDestino(rs.getString("destino")); // Agregamos destino para que sepa dónde ir
                e.setCliente_id(rs.getInt("cliente_id"));
                lista.add(e);
            }
        } catch (Exception e) {
            System.err.println("Error listar mis envios: " + e);
        }
        return lista;
    }

    // 5. MARCAR COMO ENTREGADO (Método rápido)
    public boolean marcarEntregado(int idEnvio) {
        // Actualizamos estado y ponemos la fecha de hoy (NOW())
        String sql = "UPDATE envios SET estado = 'Entregado', fecha_entregado = CURRENT_DATE WHERE id_envio = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idEnvio);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Error al entregar: " + e);
            return false;
        }
    }
   // 6. CLIENTE: SOLICITAR ENVÍO (CON GUÍA SECUENCIAL "CI")
    public boolean solicitarEnvio(envios e) {
        
        // 1. Primero calculamos el siguiente número
        int siguienteNumero = 1;
        String sqlMax = "SELECT MAX(id_envio) FROM envios";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement psMax = con.prepareStatement(sqlMax);
             ResultSet rsMax = psMax.executeQuery()) {
            
            if (rsMax.next()) {
                // Si el último es 6, el siguiente será 7
                siguienteNumero = rsMax.getInt(1) + 1;
            }
        } catch (Exception ex) {
            System.out.println("Error al calcular id: " + ex);
        }

        // 2. Creamos la guía con el formato que pediste "CI" + número
        String guiaGenerada = "CI" + siguienteNumero; 
        
        // 3. Calculamos el costo simulado
        double costoCalc = 3.0 + (e.getPeso_kg() * 2.0);
        String costoFinal = String.format("$%.2f", costoCalc);

        // 4. Guardamos el pedido en la base de datos
        String sql = "INSERT INTO envios (cliente_id, n_guia, descripcion, peso_kg, servicio, inicio, destino, estado, costo, fecha_creacion) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, 'Pendiente', ?, CURRENT_TIMESTAMP)";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, e.getCliente_id());
            ps.setString(2, guiaGenerada); // Aquí va la CI7, CI8, etc.
            ps.setString(3, e.getDescripcion());
            ps.setDouble(4, e.getPeso_kg());
            ps.setString(5, e.getServicio());
            ps.setString(6, e.getInicio());
            ps.setString(7, e.getDestino());
            ps.setString(8, costoFinal);
            
            ps.executeUpdate();
            return true;
        } catch (Exception ex) {
            System.err.println("Error al solicitar envio: " + ex);
            return false ;
        }
    }
}