package com.sinensia.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sinensia.model.Categoria;
import com.sinensia.model.Tramite;
import com.sinensia.services.TramiteService;

/**
 * Servlet implementation class CategoriaController
 */
public class CategoriaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoriaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public static List<Categoria> getListaCategoriaIngresos(List<Categoria> categorias, int mes, int anyo) throws SQLException {
		List<Categoria> listaIngresosOrdenada = new ArrayList<Categoria>();
		for(Categoria c : categorias) {
			//Categorias debe tener su lista tramites de entrada
			if(c.getListaTramites().size()>0) {
				for(int i=0;i<c.getListaTramites().size();i++) {
					if(c.isEsIngreso() && mes == c.getListaTramites().get(i).getFecha().getMonthValue() &&
							anyo == c.getListaTramites().get(i).getFecha().getYear()) {
						listaIngresosOrdenada.add(c);
						i=c.getListaTramites().size();
					}
				}
			}
		}
		return listaIngresosOrdenada;
	}
	
	public static List<Categoria> getListaCategoriaGastos(List<Categoria> categorias, int mes, int anyo) throws SQLException {
		List<Categoria> listaGastosOrdenada = new ArrayList<Categoria>();
		
		for(Categoria c : categorias) {
			//Categorias debe tener su lista tramites de entrada
			if(c.getListaTramites().size()>0) {
				for(int i=0;i<c.getListaTramites().size();i++) {
					if(!c.isEsIngreso() && mes == c.getListaTramites().get(i).getFecha().getMonthValue() &&
							anyo == c.getListaTramites().get(i).getFecha().getYear()) {
						listaGastosOrdenada.add(c);
						i=c.getListaTramites().size();
					}
				}
			}
		}
		return listaGastosOrdenada;
	}
	
	public static List<Categoria> getListaCategoriaOrdenada(List<Categoria> lista, int mes, int anyo) throws SQLException {
		List<Double> valoresTotalesCategoria = new ArrayList<Double>();
		for(Categoria c: lista) {
			valoresTotalesCategoria.add(getValorImportesCategoriaMes(c, mes, anyo));
		}
		valoresTotalesCategoria = valoresTotalesCategoria.stream().sorted(Comparator.reverseOrder()).collect(Collectors.toList());
		
		List<Categoria> listaResultado = new ArrayList<Categoria>();
		for(int j=0; j<valoresTotalesCategoria.size(); j++) {
			for(Categoria c : lista) {
				if(getValorImportesCategoriaMes(c, mes, anyo)==valoresTotalesCategoria.get(j)) {
					listaResultado.add(c);
				}
			}
		}
		
		return listaResultado;
	}
	
	public static Categoria insertaTramites(Categoria categoria, boolean configuracion) throws SQLException {
		TramiteService tramiteService = new TramiteService();
		List<Tramite> listaTramites = tramiteService.get(configuracion);
		List<Tramite> tramitesInsertar = new ArrayList<Tramite>();
		if(listaTramites!=null) {
			for(Tramite t : listaTramites) {
				if(categoria.getCategoriaId()==t.getCategoriaId())
					tramitesInsertar.add(t);
			}
		}
		categoria.setListaTramites(tramitesInsertar);
		
		return categoria;
	}
	
	public static double getValorImportesCategoriaMes(Categoria c, int mes, int anyo) {
		List<Tramite> listaTramites = c.getListaTramites();
		double total = 0;
		for(Tramite t: listaTramites) {
			if(t.getFecha().getMonthValue()==mes && t.getFecha().getYear()==anyo) {
				total += t.getValor();
			}
		}
		total = Math.abs(total);
		
		return total;
	}

}
