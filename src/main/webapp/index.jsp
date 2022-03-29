<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.sinensia.model.Categoria"%>
<%@ page import="com.sinensia.controllers.CategoriaController"%>
<%@ page import="com.sinensia.dao.CategoriaDao"%>
<%@ page import="com.sinensia.model.Tramite"%>
<%@ page import="com.sinensia.services.TramiteService"%>
<%@ page import="com.sinensia.controllers.TramiteController"%>
<%@ page import="java.time.Period"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.math.RoundingMode"%>
<%@ page import="javax.servlet.http.Cookie"%>
<!DOCTYPE html>
<html>
<head>
<title>AppTeamMoney</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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

	<%Cookie[] configuracion = request.getCookies(); %>
	<%boolean conf=true; %>
	<%if (configuracion != null) {
        for (int i = 0; i < configuracion.length; i++) {
            if (configuracion[i].getName().equals("configuracion")) {
                conf = Boolean.parseBoolean(configuracion[i].getValue());
            }
        }
    } %>
	<%for(Categoria categoria : categorias){%>
	<%categoria = CategoriaController.insertaTramites(categoria, conf);%>
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
	<div id="carouselExampleIndicators" class="carousel slide"
		onload="(#carouselExampleIndicators).carousel('pause')">
		<div class="carousel-inner" onload=".carousel('pause')">
			<%TramiteService tramiteService = new TramiteService();%>
			<%List<Tramite> tramites = tramiteService.get(conf);%>
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
			<div onload="(#carouselExampleIndicators).carousel('pause')"
				class="carousel-item active">
				<%}else{ %>
				<div onload="(#carouselExampleIndicators).carousel('pause')"
					class="carousel-item">
					<%} %>
					<%fechaCompleta = primeraFecha.format(DateTimeFormatter.ofPattern("MMMM yyyy", fechaEs)); %>
					<h1 class="fechaCompleta"><%=fechaCompleta %></h1>
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
									<% categoriasGastos = CategoriaController.getListaCategoriaGastos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
									<% categoriasIngresos = CategoriaController.getListaCategoriaIngresos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
									<%totalCategoriasGastos=0; %>
									<%totalCategoriasIngresos=0; %>
									<%for (Categoria categoria : categoriasGastos) {%>
									<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
									<%totalCategoriasGastos += totalCategoria; %>
									<%}%>
								
									<%for (Categoria categoria : categoriasIngresos) {%>
									<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
									<%totalCategoriasIngresos += totalCategoria; %>
									<%}%>
									<%categoriasGastos = CategoriaController.getListaCategoriaGastos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
									<%categoriasIngresos = CategoriaController.getListaCategoriaIngresos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
									<td style="color: red;"><%=totalCategoriasGastos%>&#8364;</td>
									<td style="color: green;"><%=totalCategoriasIngresos%>&#8364;</td>
									<td><%=totalCategoriasIngresos-totalCategoriasGastos%>&#8364;</td>
									<%totalCategoriasGastos=0; %>
									<%totalCategoriasIngresos=0; %>
								</tr>
							</tbody>
						</table>
					</div>
					<%categoriasGastos = CategoriaController.getListaCategoriaGastos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
					<%totalCategoriasGastos=0; %>
					<%categoriasIngresos = CategoriaController.getListaCategoriaIngresos(categorias, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
					<%totalCategoriasIngresos=0; %>
					<div class="d-flex justify-content-around">
						<div class="rounded border border-danger listaCategorias"
							style="background: linear-gradient(#ff0000, #ff3300, #ff6600, #ff5050);">
							<h3 style="color: white;">Gastos</h3>
							<ul class="list-group">
								<%for (Categoria categoria : categoriasGastos) {%>
								<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
								<%totalCategoriasGastos += totalCategoria; %>
								<%}%>
								<%for (Categoria categoria : categoriasGastos) {%>
								<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
								<%porcentajeGastos = totalCategoria / totalCategoriasGastos * 100; %>
								<li
									class="list-group-item d-flex justify-content-between align-items-center">
									<%=categoria.getNombre()%> <%BigDecimal porcentaje = BigDecimal.valueOf(porcentajeGastos);%>
									<%porcentaje = porcentaje.setScale(2, RoundingMode.HALF_UP);%> <span
									class="badge rounded-pill"
									style="background-color: #e6e6e6; color: red;"><%=porcentaje.doubleValue()%>%</span>
								</li>
								<%}%>
							</ul>
						</div>
						<div class="rounded border border-success listaCategorias"
							style="background: linear-gradient(#009900, #336600, #009933, #33cc33);">
							<h3 style="color: white;">Ingresos</h3>
							<ul class="list-group">
								<%for (Categoria categoria : categoriasIngresos) {%>
								<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
								<%totalCategoriasIngresos += totalCategoria; %>
								<%}%>
								<%for (Categoria categoria : categoriasIngresos) {%>
								<%totalCategoria = CategoriaController.getValorImportesCategoriaMes(categoria, primeraFecha.getMonthValue(), primeraFecha.getYear());%>
								<%porcentajeIngresos = totalCategoria / totalCategoriasIngresos * 100; %>
								<li
									class="list-group-item d-flex justify-content-between align-items-center">
									<%=categoria.getNombre()%> <%BigDecimal porcentaje = BigDecimal.valueOf(porcentajeIngresos);%>
									<%porcentaje = porcentaje.setScale(2, RoundingMode.HALF_UP);%> <span
									class="badge rounded-pill"
									style="background-color: #e6e6e6; color: green;"><%=porcentaje.doubleValue()%>%</span>
								</li>
								<%}%>
							</ul>
						</div>
					</div>
				</div>
				<%primeraFecha = primeraFecha.plusMonths(1); %>
				<%} %>

			</div>
			<a class="carousel-control-prev" href="#carouselExampleIndicators"
				role="button" data-slide="prev"> <span
				class="carousel-control-prev-icon" aria-hidden="true"
				onload="(#carouselExampleIndicators).carousel('pause')"></span> <span
				class="sr-only">Anterior</span>
			</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
				role="button" data-slide="next"
				onload=".carousel(<%=mesesTotales-1%>)"> <span
				class="carousel-control-next-icon"
				onclick="(#carouselExampleIndicators).carousel('pause')"
				aria-hidden="true"></span> <span class="sr-only">Siguiente</span>
			</a>
		</div>
		<div class="d-flex justify-content-around botones"
			onload="(#carouselExampleIndicators).carousel('pause')">
			<div class="boton">
				<a class="btn fw-bold"
					style="background: linear-gradient(#ff0000, #ff3300, #ff6600, #ff5050); color: white;"
					href="NuevoTramiteGasto.jsp" role="button" onclick="esGasto()">Gastos</a>
			</div>
			<div class="boton">
				<a class="btn fw-bold"
					style="background: linear-gradient(#009900, #336600, #009933, #33cc33); color: white;"
					href="NuevoTramiteIngreso.jsp" role="button" onclick="esIngreso()">Ingresos</a>
			</div>

		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>

	<%@ include file="PieDePagina.jsp"%>
</body>
</html>