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

import com.sinensia.contracts.IDao;
import com.sinensia.dao.CategoriaDao;
import com.sinensia.dao.TramiteDao;
import com.sinensia.model.Categoria;
import com.sinensia.model.Tramite;

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
	
	public static List<Categoria> getListaCategoriaIngresos(int mes, int anyo) throws SQLException {
		List<Categoria> lista = new ArrayList<Categoria>();
		IDao<Categoria> categoriaDao = new CategoriaDao();
		List<Categoria> categorias = categoriaDao.get();
		
		int i = 0;
		for(Categoria c : categorias) {
			if(c.isEsIngreso() && mes == c.getListaTramites().get(i).getFecha().getMonthValue() &&
					anyo == c.getListaTramites().get(i).getFecha().getYear()) {
				c = insertaTramites(c);
				lista.add(c);
			}
			i++;
		}
		return lista;
	}
	
	public static List<Categoria> getListaCategoriaOrdenada(List<Categoria> lista, int mes, int anyo) throws SQLException {
		List<Double> valoresTotalesCategoria = new ArrayList<Double>();
		int i = 0;
		for(Categoria c: lista) {
			valoresTotalesCategoria.set(i, getValorImportesCategoriaMes(c, mes, anyo));
			i++;
		}
		valoresTotalesCategoria = valoresTotalesCategoria.stream().sorted(Comparator.reverseOrder()).collect(Collectors.toList());
		
		List<Categoria> listaResultado = new ArrayList<Categoria>();
		for(Categoria c : lista) {
			for(int j=0; i<valoresTotalesCategoria.size(); j++) {
				if(getValorImportesCategoriaMes(c, mes, anyo)==valoresTotalesCategoria.get(j)) {
					listaResultado.add(c);
				}
			}
		}
		
		return listaResultado;
	}
	
	public static Categoria insertaTramites(Categoria categoria) throws SQLException {
		IDao<Tramite> tramiteDao = new TramiteDao();
		List<Tramite> listaTramites = tramiteDao.get();
		List<Tramite> tramitesInsertar = new ArrayList<Tramite>();
		
		for(Tramite t : listaTramites) {
			if(categoria.getCategoriaId()==t.getCategoriaId())
				tramitesInsertar.add(t);
		}
		categoria.setListaTramites(tramitesInsertar);
		
		return categoria;
	}
	
	public static double getValorImportesCategoriaMes(Categoria c, int mes, int anyo) {
		List<Tramite> listaTramites = c.getListaTramites();
		double total = 0;
		for(Tramite t: listaTramites) {
			if(t.getFecha().getMonthValue()==mes && t.getFecha().getYear()==anyo) {
				total = t.getValor();
			}
		}
		total = Math.abs(total);
		
		return total;
	}

}
