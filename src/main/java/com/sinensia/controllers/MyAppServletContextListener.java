package com.sinensia.controllers;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.sinensia.contracts.IDao;
import com.sinensia.dao.CategoriaDao;
import com.sinensia.model.Categoria;

public class MyAppServletContextListener implements ServletContextListener{
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("ServletContextListener destroyed");
	}

        //Run this before web application is started
	@Override
	public void contextInitialized(ServletContextEvent arg0){
		System.out.println("ServletContextListener started");
		IDao<Categoria> categoriaDao = new CategoriaDao();
		
		try {
			List<Categoria> categorias = categoriaDao.get();
			
			Categoria categoria1 = new Categoria();
			Categoria categoria2 = new Categoria();
			Categoria categoria3 = new Categoria();
			Categoria categoria4 = new Categoria();
			Categoria categoria5 = new Categoria();
			
			if(categorias.size() == 0) {
				System.out.println("Las categorías no existen");
				categoria1.setCategoriaId(1);
				categoria1.setNombre("Salario");
				categoria1.setEsIngreso(true);
				
				categoria2.setCategoriaId(2);
				categoria2.setNombre("Comida");
				categoria2.setEsIngreso(false);
				
				categoria3.setCategoriaId(3);
				categoria3.setNombre("Transporte");
				categoria3.setEsIngreso(true);
				
				categoria4.setCategoriaId(4);
				categoria4.setNombre("Hogar");
				categoria4.setEsIngreso(false);
				
				categoria5.setCategoriaId(5);
				categoria5.setNombre("Ocio");
				categoria5.setEsIngreso(false);
				
				categoriaDao.add(categoria1);
				categoriaDao.add(categoria2);
				categoriaDao.add(categoria3);
				categoriaDao.add(categoria4);
				categoriaDao.add(categoria5);	
			}
			else {
				System.out.println("Las categorías ya existen");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}