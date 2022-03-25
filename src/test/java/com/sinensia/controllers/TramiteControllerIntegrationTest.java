package com.sinensia.controllers;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.sinensia.model.Tramite;

public class TramiteControllerIntegrationTest {

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
	public void testGetListaTramiteOrdenada() throws SQLException {
		List<Tramite> lista = new ArrayList<Tramite>();
		Tramite tramite1 = new Tramite();
		Tramite tramite2 = new Tramite();
		tramite1.setFecha(LocalDate.now());
		tramite2.setFecha(LocalDate.now().minusMonths(1));
		lista.add(tramite1);
		lista.add(tramite2);
		lista = TramiteController.getListaTramiteOrdenada(lista);
		LocalDate fecha1 = lista.get(0).getFecha();
		LocalDate fecha2 = lista.get(1).getFecha();
		assertTrue(fecha1.compareTo(fecha2)<0);
	}

}
