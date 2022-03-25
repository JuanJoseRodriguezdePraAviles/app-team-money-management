<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.sinensia.model.Categoria" %>
<%@ page import="com.sinensia.controllers.CategoriaController" %>
<%@ page import="com.sinensia.dao.CategoriaDao" %>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.math.RoundingMode"%>
<!DOCTYPE html>
<html>
<head>
	<title>AppTeamMoney</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<link href="css/ResumenIndexCSS.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%double totalCategoriasGastos = 0;%>
	<%double totalCategoriasIngresos = 0;%>
	<%double totalCategoria = 0;%>
	<%double porcentajeGastos = 0;%>
	<%double porcentajeIngresos = 0;%>
	
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
	<div class="container shadow" style="background-color: #e6e6e6;">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Gastos</th>
					<th scope="col">Ingresos</th>
					<th scope="col">Total</th>
				</tr>
			</thead>
				<tbody>
					<tr>
						<td style="color: red;"><%=totalCategoriasGastos%>&#8364;</td>
						<td style="color: green;"><%=totalCategoriasIngresos%>&#8364;</td>
						<td><%=totalCategoriasIngresos-totalCategoriasGastos%>&#8364;</td>
					</tr>
			</tbody>
		</table>
	</div>
	<div class="d-flex justify-content-around">
		<div class="rounded border border-danger listaCategorias" style="background: linear-gradient(#ff0000, #ff3300, #ff6600, #ff5050);">
			<h3 style="color: white;">Gastos</h3>
			<ul class="list-group">
				<%for (Categoria categoria : categoriasGastos) {%>
					<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
				  	<%porcentajeGastos = totalCategoria / totalCategoriasGastos * 100; %>
					<li class="list-group-item d-flex justify-content-between align-items-center" style="background-color: red; color: white;">
					    <%=categoria.getNombre()%>
					    <%BigDecimal porcentaje = BigDecimal.valueOf(porcentajeGastos);%>
    					<%porcentaje = porcentaje.setScale(2, RoundingMode.HALF_UP);%>
					    <span class="badge rounded-pill" style="background-color: #e6e6e6; color: red;"><%=porcentaje.doubleValue()%>%</span>
				  	</li>
				<%}%>
			</ul>
		</div>
		<div class="rounded border border-success listaCategorias" style="background: linear-gradient(#009900, #336600, #009933, #33cc33);">
			<h3 style="color: white;">Ingresos</h3>
			<ul class="list-group">
			  	<%for (Categoria categoria : categoriasIngresos) {%>
					<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
				  	<%porcentajeIngresos = totalCategoria / totalCategoriasIngresos * 100; %>
					<li class="list-group-item d-flex justify-content-between align-items-center" style="background-color: green; color: white;">
					    <%=categoria.getNombre()%>
					    <%BigDecimal porcentaje = BigDecimal.valueOf(porcentajeIngresos);%>
    					<%porcentaje = porcentaje.setScale(2, RoundingMode.HALF_UP);%>
					    <span class="badge rounded-pill" style="background-color: #e6e6e6; color: green;"><%=porcentaje.doubleValue()%>%</span>
				  	</li>
				<%}%>
			</ul>
		</div>
	</div>
	<div class="d-flex justify-content-around botones">
		<div class="boton">
			<a class="btn fw-bold" style="background: linear-gradient(#ff0000, #ff3300, #ff6600, #ff5050); color: white;" href="NuevoTramiteGasto.jsp" role="button" onclick="esGasto()">Gastos</a>
		</div>
		<div class="boton">
			<a class="btn fw-bold" style="background: linear-gradient(#009900, #336600, #009933, #33cc33); color: white;" href="NuevoTramiteIngreso.jsp" role="button" onclick="esIngreso()">Ingresos</a>
		</div>
	</div>
	<%@ include file="PieDePagina.jsp"%>
</body>
</html>