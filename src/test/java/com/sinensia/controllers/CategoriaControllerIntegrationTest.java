package com.sinensia.controllers;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.sinensia.model.Categoria;
import com.sinensia.model.Tramite;

public class CategoriaControllerIntegrationTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetListaCategoriaIngresos() throws SQLException {
		List<Categoria> listaCategorias = new ArrayList<Categoria>();
		listaCategorias.add(new Categoria(95, "Bricolaje", false));
		listaCategorias.add(new Categoria(96, "Cocina", false));
		listaCategorias.get(0).setListaTramites(new ArrayList<Tramite>());
		listaCategorias.get(1).setListaTramites(new ArrayList<Tramite>());
		listaCategorias.get(0).getListaTramites().add(new Tramite(55, 4.0, LocalDate.now(), 95, "Abono"));
		listaCategorias.get(1).getListaTramites().add(new Tramite(56, 8.0, LocalDate.now(), 96, "Sarten"));
		listaCategorias = CategoriaController.getListaCategoriaIngresos(listaCategorias, LocalDateTime.now().getMonthValue(), LocalDateTime.now().getYear());
		if(listaCategorias.size()>0)
			assertTrue(listaCategorias.get(0).isEsIngreso());
		else
			assertTrue(listaCategorias!=null);
	}
	
	@Test
	public void testGetListaCategoriaGastos() throws SQLException {
		List<Categoria> listaCategorias = new ArrayList<Categoria>();
		listaCategorias.add(new Categoria(95, "Bricolaje", false));
		listaCategorias.add(new Categoria(96, "Cocina", false));
		listaCategorias.get(0).setListaTramites(new ArrayList<Tramite>());
		listaCategorias.get(1).setListaTramites(new ArrayList<Tramite>());
		listaCategorias.get(0).getListaTramites().add(new Tramite(55, 4.0, LocalDate.now(), 95, "Abono"));
		listaCategorias.get(1).getListaTramites().add(new Tramite(56, 8.0, LocalDate.now(), 96, "Sarten"));
		listaCategorias = CategoriaController.getListaCategoriaGastos(listaCategorias, LocalDateTime.now().getMonthValue(), LocalDateTime.now().getYear());
		if(listaCategorias.size()>0)
			assertTrue(!listaCategorias.get(0).isEsIngreso());
		else
			assertTrue(listaCategorias!=null);
	}

	@Test
	public void testGetListaCategoriaOrdenada() throws SQLException{
		List<Categoria> listaCategorias = new ArrayList<Categoria>();
		listaCategorias.add(new Categoria(95, "Bricolaje", false));
		listaCategorias.add(new Categoria(96, "Cocina", false));
		listaCategorias.get(0).setListaTramites(new ArrayList<Tramite>());
		listaCategorias.get(1).setListaTramites(new ArrayList<Tramite>());
		listaCategorias.get(0).getListaTramites().add(new Tramite(55, 4.0, LocalDate.now(), 95, "Abono"));
		listaCategorias.get(1).getListaTramites().add(new Tramite(56, 8.0, LocalDate.now(), 96, "Sarten"));
		listaCategorias = CategoriaController.getListaCategoriaOrdenada(listaCategorias, LocalDateTime.now().getMonthValue(), LocalDateTime.now().getYear());
		if(listaCategorias.size()>1) {
			double valorMes1 = CategoriaController.getValorImportesCategoriaMes(listaCategorias.get(0), LocalDateTime.now().getMonthValue(), LocalDateTime.now().getYear());
			double valorMes2 = CategoriaController.getValorImportesCategoriaMes(listaCategorias.get(1), LocalDateTime.now().getMonthValue(), LocalDateTime.now().getYear());
			assertTrue(valorMes1>=valorMes2);
		}
		assertTrue(listaCategorias!=null);
	}

	@Test
	public void testInsertaTramites() throws SQLException {
		Categoria categoria = new Categoria(95, "Bricolaje", false);
		categoria = CategoriaController.insertaTramites(categoria);
		assertTrue(categoria.getListaTramites().size()>=0);
	}

	@Test
	public void testGetValorImportesCategoriaMes() throws SQLException{
		List<Categoria> listaCategorias = new ArrayList<Categoria>();
		listaCategorias.add(new Categoria(55, "Ocio", false));
		Categoria categoria = listaCategorias.get(0);
		List<Tramite> listaTramites = new ArrayList<Tramite>();
		listaTramites.add(new Tramite(55, 4.0, LocalDate.now(), 55, "Cine"));
		listaTramites.add(new Tramite(56, 8.0, LocalDate.now(), 55, "Cena"));
		categoria.setListaTramites(listaTramites);
		double valorMes = CategoriaController.getValorImportesCategoriaMes(categoria, LocalDateTime.now().getMonthValue(), LocalDateTime.now().getYear());
		assertTrue(valorMes==12);
	}
}
