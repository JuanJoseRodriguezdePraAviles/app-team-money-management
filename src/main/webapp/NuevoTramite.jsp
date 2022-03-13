<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="es">
<head>
<title>Nuevo trámite</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
	.principalDiv {
		text-align: center;
		margin-top: 2%;
	}
	.centerDiv {
		margin-left: 32%;
	}
	.leftColumnConfig {
		width: 25%;
		margin-right: 5%;
		margin-bottom: 2%;
	}
	.gastoColor {
		color: red;
	}
	.ingresoSpace {
		margin-left: 5%;
	}
	.ingresoColor {
		color: green;
	}
	.dateSelectSize {
		width: 23%;
	}
	#fechaTramite {
		margin-bottom: 13%;
	}
	.addTramite {
		width: 36%;
	}
</style>
<body>
	<%LocalDate fechaActual = LocalDate.now(); %>
	<%Locale fechaEs = new Locale("es", "ES"); %>
	<%String fechaCompleta = fechaActual.format(DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy", fechaEs)); %>
	<%@ include file="Cabecera.jsp"%>
	<div class="principalDiv">
		<h1><%=fechaCompleta%></h1>
		<div class="container mt-3">
			<form action="MostrarAlumnoInsertado.jsp">
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
						<select class="form-select"
							aria-label="Default select example">
							<option selected>Tipo de categoría</option>
							<option value="1">Salario</option>
							<option value="2">Comida</option>
							<option value="3">Transporte</option>
							<option value="4">Hogar</option>
							<option value="5">Ocio</option>
						</select>
					</div>
				</div>
				<button type="submit" class="btn btn-primary addTramite">Agregar trámite</button>
			</form>
		</div>
	</div>
</body>
</html>