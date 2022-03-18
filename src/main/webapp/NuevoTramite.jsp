<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.sinensia.model.Categoria" %>
<%@ page import="com.sinensia.model.Tramite" %>
<%@ page import="com.sinensia.controllers.CategoriaController" %>
<%@ page import="com.sinensia.dao.CategoriaDao" %>
<!DOCTYPE html>
<html lang="es">
<head>
<title>Nuevo trámite</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="css/NuevoTramite.css"
	rel="stylesheet">
<link
	href="css/Listado.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        function mensajeImporte() {
			if(document.querySelector('input[id="gasto"]:checked')) {
				document.getElementById("mensajeImporte").style.color = "red";
				document.getElementById("mensajeImporte").innerHTML = "Gasto agregado correctamente";
			}
			else{
				document.getElementById("mensajeImporte").style.color = "green";
				document.getElementById("mensajeImporte").innerHTML = "Ingreso agregado correctamente";
			}
        }
    </script>
</head>
<body>
	<%LocalDate fechaActual = LocalDate.now(); %>
	<%Locale fechaEs = new Locale("es", "ES"); %>
	<%String fechaCompleta = fechaActual.format(DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy", fechaEs)); %>
	<%CategoriaDao categoriaDao = new CategoriaDao();%>
	<%List<Categoria> categorias = categoriaDao.get();%>
	<%@ include file="Cabecera.jsp"%>
	<div class="principalDiv">
		<h1><%=fechaCompleta%></h1>
		<div class="container mt-3">
			<div class="d-flex centerDiv">
				<input type="number" class="form-control leftColumnConfig" id="importe" placeholder="Importe" name="importe">
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="opciones" id="gasto" value="gasto">
					<label class="form-check-label gastoColor" for="gasto">Gasto</label>
				</div>
				<div class="form-check form-check-inline ingresoSpace">
					<input class="form-check-input" type="radio" name="opciones" id="ingreso" value="ingreso">
					<label class="form-check-label ingresoColor" for="ingreso">Ingreso</label>
				</div>
			</div>
			<div class="d-flex centerDiv">
				<textarea class="form-control leftColumnConfig" id="concepto" rows="3" placeholder="Concepto"></textarea>
				<div class="dateSelectSize">
					<input type="date" class="form-control" id="fechaTramite" value="<%=fechaActual%>" name="fechaTramite">
					<select id="categoriaEscogida" class="form-select"
						aria-label="Default select example">
						<option selected>Tipo de categoría</option>
						<%for (Categoria categoria : categorias) {%>
							<option value=<%=categoria.getCategoriaId()%>><%=categoria.getNombre()%></option>
						<%}%>
					</select>
				</div>
			</div>
			<button class="btn btn-primary addTramite" onclick="mensajeImporte()">Agregar trámite</button>
			<p id="mensajeImporte"></p>
		</div>
	</div>
</body>
</html>