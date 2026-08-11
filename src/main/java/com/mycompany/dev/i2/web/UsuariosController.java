package com.mycompany.dev.i2.web;

import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;
import java.io.Serializable;

@Named("usuariosController")
@RequestScoped
public class UsuariosController implements Serializable {

    private String usuario;
    private String password;

    public String validarLogin() {
        // Lógica de validación
        return "citas?faces-redirect=true";
    }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}