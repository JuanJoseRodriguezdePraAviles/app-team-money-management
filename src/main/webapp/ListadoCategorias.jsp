<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.sinensia.model.Categoria" %>
<%@ page import="com.sinensia.controllers.CategoriaController" %>
<%@ page import="com.sinensia.dao.CategoriaDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link href="css/ListadoCategorias.css" rel="stylesheet" type="text/css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Listado Categorías</title>
</head>
<body>
	<%@ include file="Cabecera.jsp"%>
	<h1>Categorías</h1>
	<%CategoriaDao categoriaDao = new CategoriaDao();%>
	<%List<Categoria> categorias = categoriaDao.get();%>
	<div class="row">
		<%for(Categoria categoria : categorias){%>
		<div class="col-sm-3 margen">
			<div class="card cuadrado">
				<div class="card-body">
					<h5 class="card-title centrado d-flex justify-content-center"><%=categoria.getNombre() %></h5>
				</div>
			</div>
		</div>
		<%}%>
	</div>
</body>
</html>