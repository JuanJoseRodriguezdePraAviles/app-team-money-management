<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.sinensia.model.Categoria" %>
<%@ page import="com.sinensia.controllers.CategoriaController" %>
<%@ page import="com.sinensia.dao.CategoriaDao" %>
<%@ page import="com.sinensia.model.Tramite" %>
<%@ page import="com.sinensia.dao.TramiteDao" %>
<%@ page import="com.sinensia.controllers.TramiteController" %>
<%@ page import="java.time.Period" %>
<!DOCTYPE html>
<html>
<head>
	<title>AppTeamMoney</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="css/ListaCategorias.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<link href="css/Listado.css" rel="stylesheet" type="text/css">
	<script src="js/EleccionCheckbox.js"></script>
</head>
<body>
	<%double totalCategoriasGastos = 0;%>
	<%double totalCategoriasIngresos = 0;%>
	<%double totalCategoria = 0;%>
	
	<%LocalDate fechaActual = LocalDate.now();%>
	<%Locale fechaEs = new Locale("es", "ES");%>
	<%String fechaCompleta = fechaActual.format(DateTimeFormatter.ofPattern("MMMM yyyy", fechaEs)); %>
	
	<%CategoriaDao categoriaDao = new CategoriaDao();%>
	<%List<Categoria> categorias = categoriaDao.get();%>
	
	<%for(Categoria categoria : categorias){%>
		<%categoria = CategoriaController.insertaTramites(categoria);%>
	<%}%>
	
	<%int mes = LocalDate.now().getMonthValue();%>
	<%int anyo = LocalDate.now().getYear();%>
	
	<%List<Categoria> categoriasGastos = CategoriaController.getListaCategoriaGastos(categorias, mes, anyo);%>
	<%List<Categoria> categoriasIngresos = CategoriaController.getListaCategoriaIngresos(categorias, mes, anyo);%>
	
	<%for (Categoria categoria : categoriasGastos) {%>
		<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
	  	<%totalCategoriasGastos += totalCategoria; %>
	<%}%>
	
	<%for (Categoria categoria : categoriasIngresos) {%>
		<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
	  	<%totalCategoriasIngresos += totalCategoria; %>
	<%}%>
	
	<%@ include file="Cabecera.jsp"%>
	<div id="carouselExampleIndicators" class="carousel slide" onload="(#carouselExampleIndicators).carousel('pause')">
	  <div class="carousel-inner" onload=".carousel('pause')">
	  	<%TramiteDao tramiteDao = new TramiteDao();%>
		<%List<Tramite> tramites = tramiteDao.get();%>
		<% tramites = TramiteController.getListaTramiteOrdenada(tramites); %>
		<% int mesesTotales = 1;%>
		<%LocalDate primeraFecha = LocalDate.now(); %>
		<%if(tramites.size()>1){ %>
			<% primeraFecha = tramites.get(0).getFecha();  %>
			<% primeraFecha = primeraFecha.withDayOfMonth(1);  %>
			<% LocalDate ultimaFecha = tramites.get(tramites.size()-1).getFecha(); %>
			<% ultimaFecha = ultimaFecha.withDayOfMonth(1);  %>
			<% mesesTotales = Period.between(primeraFecha, ultimaFecha).getMonths(); %>
			
		<%} %>
	  	<%for(int i=0; i<=mesesTotales; i++) {%>
	  	
		  	<%if(i==0) {%>
		    	<div onload="(#carouselExampleIndicators).carousel('pause')" class="carousel-item active">
		    <%}else{ %>
	    		<div onload="(#carouselExampleIndicators).carousel('pause')" class="carousel-item">
	    	<%} %>
	    	<%fechaCompleta = primeraFecha.format(DateTimeFormatter.ofPattern("MMMM yyyy", fechaEs)); %>
	        <h1 class="fechaCompleta"><%=fechaCompleta %></h1>
	        <%categoriasGastos = CategoriaController.getListaCategoriaGastos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
	        <%totalCategoriasGastos=0; %>
			<%categoriasIngresos = CategoriaController.getListaCategoriaIngresos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
			<%totalCategoriasIngresos=0; %>
			<div class="d-flex justify-content-around">
				<div class="rounded border border-danger listaCategorias">
					<h3>Gastos</h3>
					<ul class="list-group">
						<%for (Categoria categoria : categoriasGastos) {%>
							<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
						  	<%totalCategoriasGastos += totalCategoria; %>
						<%}%>
						<%for (Categoria categoria : categoriasGastos) {%>
							<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
						  	<%double porcentajeGastos = totalCategoria / totalCategoriasGastos * 100; %>
							<li class="list-group-item d-flex justify-content-between align-items-center">
							    <%=categoria.getNombre()%>
							    <span class="badge bg-primary rounded-pill"><%=porcentajeGastos%>%</span>
						  	</li>
						<%}%>
					</ul>
					<p>Los gastos en este mes son: <%=totalCategoriasGastos%>&#8364;</p>
				</div>
				<div class="rounded border border-success listaCategorias">
					<h3>Ingresos</h3>
					<ul class="list-group">
						<%for (Categoria categoria : categoriasIngresos) {%>
							<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
						  	<%totalCategoriasIngresos += totalCategoria; %>
						<%}%>
					  	<%for (Categoria categoria : categoriasIngresos) {%>
							<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
						  	<%double porcentajeGastos = totalCategoria / totalCategoriasIngresos * 100; %>
							<li class="list-group-item d-flex justify-content-between align-items-center">
							    <%=categoria.getNombre()%>
							    <span class="badge bg-primary rounded-pill"><%=porcentajeGastos%>%</span>
						  	</li>
						<%}%>
					</ul>
					<p>Los ingresos en este mes son: <%=totalCategoriasIngresos%>&#8364;</p>
				</div>
			</div>
	    </div>
	    <%primeraFecha = primeraFecha.plusMonths(1); %>
	    <%} %>
	    
	  </div>
	  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true" onload="(#carouselExampleIndicators).carousel('pause')"></span>
	    <span class="sr-only">Anterior</span>
	  </a>
	  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next" onload=".carousel(<%=mesesTotales-1%>)">
	    <span class="carousel-control-next-icon" onclick="(#carouselExampleIndicators).carousel('pause')" aria-hidden="true"></span>
	    <span class="sr-only">Siguiente</span>
	  </a>
	</div>
	<div class="d-flex justify-content-around botones" onload="(#carouselExampleIndicators).carousel('pause')">
		<div class="boton">
			<a class="btn btn-danger" href="NuevoTramiteGasto.jsp" role="button" onclick="esGasto()">Gastos</a>
		</div>
		<div class="boton">
			<a class="btn btn-success" href="NuevoTramiteIngreso.jsp" role="button" onclick="esIngreso()">Ingresos</a>
		</div>
		
	</div>
	
	
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
</body>
</html>