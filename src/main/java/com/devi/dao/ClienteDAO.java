package com.devi.dao;

import com.devi.model.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public boolean registrarCliente(Cliente cliente) {
        // CORRECCIÓN: Tabla 'citas' en lugar de 'clientes'
        String sql = "INSERT INTO citas (nombre, correo, telefono, fecha_cita, id_agente, documento) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getCorreo());
            ps.setString(3, cliente.getTelefono());
            ps.setString(4, cliente.getFechaCita());
            ps.setInt(5, cliente.getIdAgente());
            ps.setString(6, cliente.getDocumento());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Cliente> listarClientesPorAgente(int idAgente) {
        List<Cliente> lista = new ArrayList<>();
        // CORRECCIÓN: Tabla 'citas'
        String sql = "SELECT c.*, u.nombre as nombre_agente FROM citas c LEFT JOIN usuarios u ON c.id_agente = u.id_usuario WHERE c.id_agente = ? ORDER BY c.id_cliente DESC";
        try (Connection conn = Conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idAgente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setNombre(rs.getString("nombre"));
                    c.setCorreo(rs.getString("correo"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setFechaCita(rs.getString("fecha_cita"));
                    c.setIdAgente(rs.getInt("id_agente"));
                    c.setNombreAgente(rs.getString("nombre_agente"));
                    c.setDocumento(rs.getString("documento"));
                    lista.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Cliente> listarTodosLosClientes() {
        List<Cliente> lista = new ArrayList<>();
        // CORRECCIÓN: Tabla 'citas'
        String sql = "SELECT c.*, u.nombre as nombre_agente FROM citas c LEFT JOIN usuarios u ON c.id_agente = u.id_usuario ORDER BY c.id_cliente DESC";
        try (Connection conn = Conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("nombre"));
                c.setCorreo(rs.getString("correo"));
                c.setTelefono(rs.getString("telefono"));
                c.setFechaCita(rs.getString("fecha_cita"));
                c.setIdAgente(rs.getInt("id_agente"));
                c.setNombreAgente(rs.getString("nombre_agente"));
                c.setDocumento(rs.getString("documento"));
                lista.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean eliminarCliente(int idCliente) {
        // CORRECCIÓN: Tabla 'citas'
        String sql = "DELETE FROM citas WHERE id_cliente = ?";
        try (Connection conn = Conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCliente);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarCliente(Cliente cliente) {
        // CORRECCIÓN: Tabla 'citas'
        String sql = "UPDATE citas SET nombre = ?, correo = ?, telefono = ?, fecha_cita = ?, documento = ? WHERE id_cliente = ?";
        try (Connection conn = Conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getCorreo());
            ps.setString(3, cliente.getTelefono());
            ps.setString(4, cliente.getFechaCita());
            ps.setString(5, cliente.getDocumento());
            ps.setInt(6, cliente.getIdCliente());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Cliente buscarPorDocumento(String documento) {
        Cliente cliente = null;
        // CORRECCIÓN: Tabla 'citas'
        String sql = "SELECT * FROM citas WHERE documento = ?"; 
        try (Connection conn = Conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, documento);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cliente = new Cliente();
                    cliente.setIdCliente(rs.getInt("id_cliente"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setCorreo(rs.getString("correo"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setFechaCita(rs.getString("fecha_cita"));
                    cliente.setDocumento(rs.getString("documento"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cliente;
    }
}