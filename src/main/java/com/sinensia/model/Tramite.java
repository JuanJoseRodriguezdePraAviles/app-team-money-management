package com.sinensia.model;

public class Tramite {
	private int tramiteId;
	private double valor;
	private int categoriaId;
	private String concepto;
	
	public int getTramiteId() {
		return tramiteId;
	}

	public void setTramiteId(int tramiteId) {
		this.tramiteId = tramiteId;
	}

	public double getValor() {
		return valor;
	}

	public void setValor(double valor) {
		this.valor = valor;
	}

	public int getCategoriaId() {
		return categoriaId;
	}

	public void setCategoriaId(int categoriaId) {
		this.categoriaId = categoriaId;
	}
	public String getConcepto() {
		return concepto;
	}

	public void setConcepto(String concepto) {
		this.concepto = concepto;
	}

	public Tramite() {
		
	}
	
	public Tramite(int tramiteId, double valor, int categoriaId, String concepto) {
		this.tramiteId = tramiteId;
		this.valor = valor;
		this.categoriaId = categoriaId;
		this.concepto = concepto;
	}
	
}
