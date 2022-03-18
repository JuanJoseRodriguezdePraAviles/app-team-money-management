<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.sinensia.model.Categoria" %>
<%@ page import="com.sinensia.controllers.CategoriaController" %>
<%@ page import="com.sinensia.dao.CategoriaDao" %>
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
	<h1 class="fechaCompleta"><%=fechaCompleta%></h1>
	<div class="d-flex justify-content-around">
		<div class="rounded border border-danger listaCategorias">
			<h3>Gastos</h3>
			<ul class="list-group">
				<%for (Categoria categoria : categoriasGastos) {%>
					<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
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
	<div class="d-flex justify-content-around botones">
		<div class="boton">
			<a class="btn btn-danger" href="NuevoTramite.jsp" role="button" onclick="esGasto()">Gastos</a>
		</div>
		<div class="boton">
			<a class="btn btn-success" href="NuevoTramite.jsp" role="button" onclick="esIngreso()">Ingresos</a>
		</div>
	</div>
</body>
</html>