package com.devi.model;

public class Cliente {
    private int idCliente;
    private String nombre;
    private String correo;
    private String telefono;
    private String fechaCita;
    private int idAgente;
    private String nombreAgente; // Para visualización
    private String documento;    // NUEVO CAMPO PARA BÚSQUEDA

    public Cliente() {}

    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getFechaCita() { return fechaCita; }
    public void setFechaCita(String fechaCita) { this.fechaCita = fechaCita; }

    public int getIdAgente() { return idAgente; }
    public void setIdAgente(int idAgente) { this.idAgente = idAgente; }

    public String getNombreAgente() { return nombreAgente; }
    public void setNombreAgente(String nombreAgente) { this.nombreAgente = nombreAgente; }

    // Métodos para el nuevo campo documento
    public String getDocumento() { return documento; }
    public void setDocumento(String documento) { this.documento = documento; }
}