package com.sinensia.model;

import java.util.List;

public class Categoria {
	private int categoriaId;
	private String nombre;
	private List<Tramite> listaTramites;
	private boolean esIngreso;
	
	public int getCategoriaId() {
		return categoriaId;
	}
	public void setCategoriaId(int categoriaId) {
		this.categoriaId = categoriaId;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public List<Tramite> getListaTramites() {
		return listaTramites;
	}
	public void setListaTramites(List<Tramite> listaTramites) {
		this.listaTramites = listaTramites;
	}
	public boolean isEsIngreso() {
		return esIngreso;
	}
	public void setEsIngreso(boolean esIngreso) {
		this.esIngreso = esIngreso;
	}
	
	public Categoria() {
		
	}
	
	public Categoria(int categoriaId, String nombre, List<Tramite> listaTramites, boolean esIngreso) {
		this.categoriaId = categoriaId;
		this.nombre = nombre;
		this.listaTramites = listaTramites;
		this.esIngreso = esIngreso;
	}
	
}
