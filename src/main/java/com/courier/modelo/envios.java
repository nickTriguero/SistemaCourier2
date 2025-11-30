package com.courier.modelo;

import java.util.Date;

/**
 *
 * @author RinRi
 */
public class envios {
    
    private int id_envio;
    private int cliente_id;
    private String n_guia;
    private String descripcion;
    private double peso_kg;
    private String servicio;
    private String destino;
    private String estado;
    private Date fecha_creacion;
    private Date fecha_entregado;
    private int curier_id;
    private double costo;
    private String inicio;

    public int getId_envio() { return id_envio; }
    public void setId_envio(int id_envio) { this.id_envio = id_envio; }

    public int getCliente_id() { return cliente_id; }
    public void setCliente_id(int cliente_id) { this.cliente_id = cliente_id; }

    public String getN_guia() { return n_guia; }
    public void setN_guia(String n_guia) { this.n_guia = n_guia; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) {  this.descripcion = descripcion; }

    public double getPeso_kg() { return peso_kg; }
    public void setPeso_kg(double peso_kg) { this.peso_kg = peso_kg; }

    public String getServicio() { return servicio; }
    public void setServicio(String servicio) { this.servicio = servicio; }

    public String getDestino() { return destino; }
    public void setDestino(String destino) { this.destino = destino; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public Date getFecha_creacion() { return fecha_creacion; }
    public void setFecha_creacion(Date fecha_creacion) { this.fecha_creacion = fecha_creacion; }

    public Date getFecha_entregado() { return fecha_entregado; }
    public void setFecha_entregado(Date fecha_entregado) {  this.fecha_entregado = fecha_entregado; }

    public int getCurier_id() { return curier_id; }
    public void setCurier_id(int curier_id) { this.curier_id = curier_id; }

    public double getCosto() { return costo; }
    public void setCosto(double costo) { this.costo = costo; }

    public String getInicio() { return inicio; }
    public void setInicio(String inicio) { this.inicio = inicio; }
}
