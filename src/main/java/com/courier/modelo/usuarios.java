package com.courier.modelo;

import java.util.Date;

/**
 *
 * @author RinRi
 */
public class usuarios {
    
    private int id;
    private String nombre_completo;
    private String email;
    private String password;
    private String rol;
    private Date fecha_creacion;
    private String guia;
    private boolean activo;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre_completo() {return nombre_completo; }
    public void setNombre_completo(String nombre_completo) { this.nombre_completo = nombre_completo; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public Date getFecha_creacion() { return fecha_creacion; }
    public void setFecha_creacion(Date fecha_creacion) { this.fecha_creacion = fecha_creacion; }

    public String getGuia() { return guia; }
    public void setGuia(String guia) { this.guia = guia; }
    
    public boolean isActivo() {
        return activo; }

    public void setActivo(boolean activo) {
        this.activo = activo; }
}
