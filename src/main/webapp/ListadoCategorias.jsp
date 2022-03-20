<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sinensia.model.Categoria"%>
<%@ page import="com.sinensia.model.Tramite"%>
<%@ page import="com.sinensia.controllers.CategoriaController"%>
<%@ page import="com.sinensia.dao.CategoriaDao"%>
<%@ page import="com.sinensia.dao.TramiteDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="css/ListadoCategorias.css" rel="stylesheet" type="text/css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Listado Categorías</title>
</head>
<body>
	<%@ include file="Cabecera.jsp"%>
	<%CategoriaDao categoriaDao = new CategoriaDao();%>
	<%List<Categoria> categorias = categoriaDao.get();%>
	<%TramiteDao tramiteDao = new TramiteDao();%>
	<%List<Tramite> tramites = tramiteDao.get();%>
	<div class="d-flex justify-content-around">
	<div class="container">
	<h1 style="text-align: center; margin-bottom: 2%; margin-top: 2%;">Gastos</h1>
	  <div class="row row-cols-2">
	  <%for(Categoria categoria : categorias){%>
		<%categoria = CategoriaController.insertaTramites(categoria);%>
		<%if(!categoria.isEsIngreso()){ %>
	  	<div class="col-sm-6">
		    <div class="card rounded border border-danger" style="margin-bottom: 5%; width: 18rem; text-align: center; margin-left: 15%;">
		      <div class="card-body">
		        <h5 class="card-title"><%=categoria.getNombre() %></h5>
		        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#<%=categoria.getNombre() %>">
				  Movimientos
				</button>
		        <div class="modal fade" id="<%=categoria.getNombre() %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel"><%=categoria.getNombre() %></h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<%if (categoria.getListaTramites().size() == 0){%>
					      		<p>No hay trámites relacionados por el momento para esta categoría</p>
					      	<%} else { %>   	
					        <table class="table">
							  <thead>
							    <tr>
							      <th scope="col">ID</th>
							      <th scope="col">Fecha</th>
							      <th scope="col">Concepto</th>
							      <th scope="col">Valor</th>
							    </tr>
							  </thead>
							  <tbody>
							  <%for(Tramite tramite : tramites){%>
									<%if (tramite.getCategoriaId() == categoria.getCategoriaId()){%>
										<tr>
											<td><%= tramite.getTramiteId()%></td>
											<td><%= tramite.getFecha()%></td>
											<td><%=tramite.getConcepto()%></td>
											<td><%= tramite.getValor() %></td>
										</tr>
									<%} %>
								<%} %>
							  </tbody>
							</table>
					      	<%} %>
					      </div>
					    </div>
					  </div>
					</div>
		      </div>
		    </div>
	  	</div>
	  	<%}%>
		<%}%>
	  </div>
	</div>
	
	<div class="container">
	<h1 style="text-align: center; margin-bottom: 2%; margin-top: 2%;">Ingresos</h1>
	  <div class="row row-cols-2">
	  <%for(Categoria categoria : categorias){%>
		<%categoria = CategoriaController.insertaTramites(categoria);%>
		<%if(categoria.isEsIngreso()){ %>
	  	<div class="col-sm-6">
		    <div class="card rounded border border-success" style="margin-bottom: 5%; width: 18rem; text-align: center; margin-left: 15%;">
		      <div class="card-body">
		        <h5 class="card-title"><%=categoria.getNombre() %></h5>
		        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#<%=categoria.getNombre() %>">
				  Movimientos
				</button>
		        <div class="modal fade" id="<%=categoria.getNombre() %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel"><%=categoria.getNombre() %></h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<%if (categoria.getListaTramites().size() == 0){%>
					      		<p>No hay trámites relacionados por el momento para esta categoría</p>
					      	<%} else { %>   	
					        <table class="table">
							  <thead>
							    <tr>
							      <th scope="col">ID</th>
							      <th scope="col">Fecha</th>
							      <th scope="col">Concepto</th>
							      <th scope="col">Valor</th>
							    </tr>
							  </thead>
							  <tbody>
							  <%for(Tramite tramite : tramites){%>
									<%if (tramite.getCategoriaId() == categoria.getCategoriaId()){%>
										<tr>
											<td><%= tramite.getTramiteId()%></td>
											<td><%= tramite.getFecha()%></td>
											<td><%=tramite.getConcepto()%></td>
											<td><%= tramite.getValor() %></td>
										</tr>
									<%} %>
								<%} %>
							  </tbody>
							</table>
					      	<%} %>
					      </div>
					    </div>
					  </div>
					</div>
		      </div>
		    </div>
	  	</div>
	  	<%}%>
		<%}%>
	  </div>
	</div>
	</div>
</body>
</html>