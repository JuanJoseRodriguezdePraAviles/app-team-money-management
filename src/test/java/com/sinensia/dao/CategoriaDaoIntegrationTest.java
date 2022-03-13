package com.sinensia.dao;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.sinensia.contracts.IDao;
import com.sinensia.model.Categoria;

public class CategoriaDaoIntegrationTest {

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
	
	private static int idCategoria = 1;
	
	@Test
	public void testGet() throws SQLException {
		IDao<Categoria> categoriaDao = new CategoriaDao();
		List<Categoria> categorias = categoriaDao.get();
		assertTrue(categorias.size() > 0);
	}
	
	@Test
	public void testGetById() throws SQLException {
		IDao<Categoria> categoriaDao = new CategoriaDao();
		Categoria categoria = categoriaDao.getById(idCategoria);
		assertTrue(categoria != null);
	}
	
}
