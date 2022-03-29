<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>Cabecera del proyecto</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="js/funciones.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-primary shadow">
	  <div class="container">
	    <a class="navbar-brand" id="colorDeTextoATM" href="index.jsp">AppTeamMoney</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarResponsive">
	      <ul class="navbar-nav ms-auto">
	        <li class="nav-item active">
	          <a class="nav-link" id="colorDeTextoLC" href="ListadoCategorias.jsp">Categorías</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" id="colorDeTextoRM" href="ResumenMes.jsp">Resumen del mes</a>
	        </li>
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            Configuración
	          </a>
	          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
	            <li><a class="dropdown-item" href="#" onclick="createCookie('configuracion', 'true', 1)">Consultas</a></li>
	            <li><a class="dropdown-item" href="#" onclick="createCookie('configuracion', 'false', 1)">Procedimientos almacenados</a></li>
	          </ul>
	        </li>
	      </ul>
	    </div>
	  </div>
	</nav>
</body>
</html>

