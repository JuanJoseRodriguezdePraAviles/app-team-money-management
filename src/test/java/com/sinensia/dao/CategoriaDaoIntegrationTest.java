package com.sinensia.dao;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

import com.sinensia.contracts.IDao;
import com.sinensia.model.Categoria;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
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
	public void test1GetById() throws SQLException {
		IDao<Categoria> categoriaDao = new CategoriaDao();
		Categoria categoria = categoriaDao.getById(idCategoria);
		assertTrue(categoria != null);
	}
	
	@Test
	public void test2Get() throws SQLException {
		IDao<Categoria> categoriaDao = new CategoriaDao();
		List<Categoria> categorias = categoriaDao.get();
		assertTrue(categorias.size() > 0);
	}
	
}
