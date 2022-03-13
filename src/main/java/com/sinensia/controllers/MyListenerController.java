package com.sinensia.controllers;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class MyListenerController implements ServletContextListener{

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		 
		 
		System.out.print("aplicacion web arrancada");
	}
		 
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		 System.out.print("aplicacion web parada");
	}
}
