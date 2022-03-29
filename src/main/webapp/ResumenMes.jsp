<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.sinensia.model.Tramite"%>
<%@ page import="com.sinensia.model.Categoria"%>
<%@ page import="com.sinensia.controllers.TramiteController"%>
<%@ page import="com.sinensia.controllers.CategoriaController"%>

<%@ page import="com.sinensia.services.CategoriaService"%>
<%@ page import="com.sinensia.services.TramiteService"%>

<!DOCTYPE html>
<html>
<head>
	<title>Resumen del Mes</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
</head>

<body>
	<%Cookie cookie = new Cookie("configuracion", "true");%>
	<%response.addCookie(cookie);%>

	<%Cookie[] configuracion = request.getCookies(); %>
	<%boolean conf=true; %>
	<%if (configuracion != null) {
        for (int i = 0; i < configuracion.length; i++) {
            if (configuracion[i].getName().equals("configuracion")) {
                conf = Boolean.parseBoolean(configuracion[i].getValue());
            }
        }
    } %>

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
	<%List<Categoria> categorias = categoriaService.get(conf);%>

	<%for(Categoria categoria : categorias){%>

	<%categoria = CategoriaController.insertaTramites(categoria, conf);%>
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
	<div class="mx-auto anchoDeLaTabla">
		<table class="table" id="tabla">
			<thead>
				<tr>
					<th scope="col">Día</th>
					<th scope="col">Categoría</th>
					<th scope="col">Concepto</th>
					<th scope="col">Importe</th>
				</tr>
			</thead>
				<tbody>
				<%for(Tramite tramite : tramites) {%>
					<%for(Categoria categoria: categorias) {%>
						<%if(tramite.getCategoriaId() == categoria.getCategoriaId()) {%>
							<tr>
								<td scope="row"><%= tramite.getFecha().getDayOfMonth()%> <%=mesActual%></td>
								<td><%=categoria.getNombre()%></td>
								<td><%=tramite.getConcepto()%></td>
								<%if(categoria.isEsIngreso()) { %>
									<td id="ingresos">+ <%= tramite.getValor()%></td>	
								<%} else { %>
									<td id="gastos">- <%= tramite.getValor()%></td>
								<%}%>
							</tr>
						<%}%>
					<%}%>
				<%}%>
			</tbody>
		</table>
	</div>
	
	<script>
		$(document).ready(function() {
			$('#tabla').DataTable({
				"pageLength":10
			});
		});
	</script>
	
	<div class="d-flex justify-content-around botones">
		<div class="boton">
			<a class="btn fw-bold botonGastos" href="NuevoTramiteGasto.jsp" role="button">Gastos</a>
		</div>
		<h3 class="saldoDisponible">
			Saldo disponible: <%=totalIngresos-totalGastos %>
		</h3>
		<div class="boton">
			<a class="btn fw-bold botonIngresos" href="NuevoTramiteIngreso.jsp" role="button">Ingresos</a>
		</div>
	</div>
	
	<%@ include file="PieDePagina.jsp"%>
</body>
</html>