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

	static IDao<Tramite> listaITramiteDao = new TramiteDao();
	TramiteDao tramiteDao = null;
	
	private static int idtramite = 3;
	private static int categoriaId = 1;
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		
		Tramite tramite = new Tramite();
		tramite.setTramiteId(idtramite);
		tramite.setValor(22.2);
		tramite.setCategoriaId(categoriaId);
		tramite.setConcepto("nomina");
		tramite.setFecha(LocalDate.parse("2020-04-05"));
		
		
		idtramite =  listaITramiteDao.add(tramite);
		assertTrue(idtramite>0);
		
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		TramiteDao tramite = new TramiteDao();
		
		tramite.remove(3);
		tramite.remove(7);
		
	}
	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
		
	}

	@Test
	public void testAdd() throws SQLException {
		
		Tramite tramite = new Tramite();
		
		IDao<Tramite> listaITramiteDao = new TramiteDao();
		
		tramite.setTramiteId(7);
		tramite.setValor(22.2);
		tramite.setCategoriaId(categoriaId);
		tramite.setConcepto("nomina");
		tramite.setFecha(LocalDate.parse("2020-04-05"));
		
		
		idtramite =  listaITramiteDao.add(tramite);
		assertTrue(idtramite>0);
		
		
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