<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<link href="css/Listado.css" rel="stylesheet" type="text/css">
	<script src="js/EleccionCheckbox.js"></script>
</head>
<body>
	<%@ include file="Cabecera.jsp"%>
	<h1>Página inicial</h1>
	<div class="d-flex justify-content-center botones">
		<div class="boton">
			<a class="btn btn-danger" href="NuevoTramite.jsp" role="button" onclick="esGasto()">Gastos</a>
		</div>
		<div class="boton">
			<a class="btn btn-success" href="NuevoTramite.jsp" role="button" onclick="esIngreso()">Ingresos</a>
		</div>
	</div>
</body>
</html>