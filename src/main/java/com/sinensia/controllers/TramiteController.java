package com.sinensia.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sinensia.contracts.IDao;
import com.sinensia.dao.TramiteDao;
import com.sinensia.model.Tramite;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;


/**
 * Servlet implementation class TramiteController
 */
@WebServlet("/tramite")
public class TramiteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TramiteController() {
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
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		double valor = Double.parseDouble(request.getParameter("importe"));
		String concepto = request.getParameter("concepto");
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		LocalDate fecha = null;
		try {
			String fechaTexto = request.getParameter("fechaTramite");
			fecha = format.parse(request.getParameter("fechaTramite")).toInstant()
		      .atZone(ZoneId.systemDefault())
		      .toLocalDate();
		}catch(ParseException e) {
			e.printStackTrace();
		}
		int idCategoria = Integer.parseInt(request.getParameter("categoriaEscogida"));
		
		Tramite tramite = new Tramite();
		tramite.setTramiteId(0);
		tramite.setValor(valor);
		tramite.setConcepto(concepto);
		tramite.setFecha(fecha);
		tramite.setCategoriaId(idCategoria);
		
		IDao<Tramite> listaITramiteDao = new TramiteDao();
		try {
			listaITramiteDao.add(tramite);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("index.jsp");
	}

}
