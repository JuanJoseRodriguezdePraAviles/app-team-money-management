<%@page import="com.sinensia.services.CategoriaService"%>
<%@page import="com.sinensia.services.TramiteService"%>
<%@page import="com.sinensia.dao.CategoriaDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.sinensia.model.Tramite"%>
<%@ page import="com.sinensia.model.Categoria"%>
<%@ page import="com.sinensia.controllers.TramiteController"%>
<%@ page import="com.sinensia.controllers.CategoriaController"%>
<%@ page import="com.sinensia.dao.TramiteDao"%>
<%@ page import="com.sinensia.dao.CategoriaDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Resumen del Mes</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="css/ListaCategorias.css" rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<%double tramiteMes= 0; %>
	<%double totalGastos = 0;%>
	<%double totalIngresos = 0;%>

	<%LocalDate fechaActual = LocalDate.now();%>
	<%Locale fechaEs = new Locale("es", "ES");%>
	<%String fechaCompleta = fechaActual.format(DateTimeFormatter.ofPattern("MMMM yyyy", fechaEs)); %>
	<%String mesActual = fechaActual.format(DateTimeFormatter.ofPattern("MMM", fechaEs)); %>

	<%TramiteService tramiteService = new TramiteService();%>
	<%List<Tramite> tramites = tramiteService.get();%>

	<%CategoriaService categoriaService = new CategoriaService();%>
	<%List<Categoria> categorias = categoriaService.get();%>

	<%for(Categoria categoria : categorias){%>
	<%categoria = CategoriaController.insertaTramites(categoria);%>
	<%}%>

	<%int mes = LocalDate.now().getMonthValue();%>
	<%int anyo = LocalDate.now().getYear();%>

	<%List<Categoria> categoriasGastos = CategoriaController.getListaCategoriaGastos(categorias, mes, anyo);%>
	<%List<Categoria> categoriasIngresos = CategoriaController.getListaCategoriaIngresos(categorias, mes, anyo);%>

	<%for (Categoria categoria : categoriasGastos) {%>
	<%tramiteMes = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
	<%totalGastos += tramiteMes; %>
	<%}%>

	<%for (Categoria categoria : categoriasIngresos) {%>
	<%tramiteMes = CategoriaController.getValorImportesCategoriaMes(categoria, mes, anyo);%>
	<%totalIngresos += tramiteMes; %>
	<%}%>

	<%@ include file="Cabecera.jsp"%>
	<h1 class="fechaCompleta"><%=fechaCompleta%></h1>
	<div class="mx-auto" style="width: 75%">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Día</th>
					<th scope="col">Categoría</th>
					<th scope="col">Concepto</th>
					<th scope="col">Importe</th>
				</tr>
			</thead>
			<tbody>

				<%for(Tramite tramite : tramites){%>
					<%for(Categoria categoria: categorias){%>
						<%if (tramite.getCategoriaId() == categoria.getCategoriaId()){%>
							<tr>
								<td scope="row"><%= tramite.getFecha().getDayOfMonth()%> <%=mesActual%></td>
								<td><%=categoria.getNombre()%></td>
								<td><%=tramite.getConcepto()%></td>
								<td><%= tramite.getValor() %></td>	
							</tr>
						<%} %>
					<%} %>
				<%} %>

			</tbody>
		</table>

		<h3 style="text-align: center;">
			Saldo disponible:
			<%=totalIngresos-totalGastos %></h3>

	</div>
	<div class="d-flex justify-content-around botones">
		<div class="boton">
			<a class="btn btn-danger" href="NuevoTramiteGasto.jsp" role="button" onclick="esGasto()">Gastos</a>
		</div>
		<div class="boton">
			<a class="btn btn-success" href="NuevoTramiteIngreso.jsp" role="button" onclick="esIngreso()">Ingresos</a>
		</div>
	</div>
</body>
</html>