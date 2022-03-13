package com.sinensia.dao;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.sinensia.contracts.IDao;
import com.sinensia.model.Tramite;

public class TramiteDaoIntegrationTest {

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

	
	private static int idtramite = 1;
	private static int categoriaId = 1;
	@Test
	public void testAdd() throws SQLException {
		
		Tramite tramite = new Tramite();
		
		IDao<Tramite> listaITramiteDao = new TramiteDao();
		
		tramite.setTramiteId(idtramite);
		tramite.setValor(22.2);
		tramite.setCategoriaId(categoriaId);
		tramite.setConcepto("nomina");
		tramite.setFecha(LocalDate.parse("2020-04-05"));
		
		
		idtramite =  listaITramiteDao.add(tramite);
		categoriaId = listaITramiteDao.add(tramite);
		assertTrue(idtramite>0);
		assertTrue(categoriaId>0);
		
	}

	@Test
	public void testGet() throws SQLException {
		IDao<Tramite> tramiteDao = new TramiteDao();
		List<Tramite> tramites = tramiteDao.get();
		
		assertTrue(tramites != null);
	}

	@Test
	public void testGetById() throws SQLException {
		
		IDao<Tramite> TramiteDao = new TramiteDao();
		Tramite tramite = TramiteDao.getById(idtramite);
		
		assertTrue(tramite != null);
		
	}
}