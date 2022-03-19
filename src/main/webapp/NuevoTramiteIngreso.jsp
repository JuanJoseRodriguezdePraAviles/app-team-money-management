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
			<form  method="post" action="tramite">
			<div class="d-flex centerDiv">
				<input type="number" class="form-control leftColumnConfig" id="importe" placeholder="Importe" name="importe">
			</div>
			<div class="d-flex centerDiv">
				<textarea class="form-control leftColumnConfig" id="concepto" rows="3" placeholder="Concepto" name="concepto"></textarea>
				<div class="dateSelectSize">
					<input type="date" class="form-control" id="fechaTramite" value="<%=fechaActual%>" name="fechaTramite">
					<select name="categoriaEscogida" class="form-select"
						aria-label="Default select example">
						<option selected>Tipo de categoría</option>
						<%for (Categoria categoria : categorias) {%>
							<%if(categoria.isEsIngreso()){ %>
								<option value=<%=categoria.getCategoriaId()%>><%=categoria.getNombre()%></option>
							<%} %>
						<%}%>
					</select>
				</div>
			</div>
			<input class = "btn btn-primary addTramite" type="submit" name="submit" value="Agregar trámite">
			</form>
			
			<p id="mensajeImporte"></p>
		</div>
	</div>
</body>
</html>