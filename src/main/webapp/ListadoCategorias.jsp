<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sinensia.model.Categoria"%>
<%@ page import="com.sinensia.model.Tramite"%>
<%@ page import="com.sinensia.controllers.CategoriaController"%>
<%@ page import="com.sinensia.dao.CategoriaDao"%>
<%@ page import="com.sinensia.dao.TramiteDao"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="com.sinensia.services.CategoriaService"%>
<%@ page import="com.sinensia.services.TramiteService"%>
<!DOCTYPE html>
<html>
<head>
	<title>Listado de categorías</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
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

	<%TramiteService tramiteService = new TramiteService();%>
	<%List<Tramite> tramites = tramiteService.get(conf);%>
	
	<%@ include file="Cabecera.jsp"%>
	<div class="d-flex justify-content-around">
		<div class="container">
			<h1 class="titulos">Gastos</h1>
			<div class="row row-cols-2">
			<%CategoriaService categoriaService = new CategoriaService();%>
			<%List<Categoria> categorias = categoriaService.get(conf);%>
				<%for (Categoria categoria : categorias) {%>
					<%categoria = CategoriaController.insertaTramites(categoria, conf);%>
					<%if(!categoria.isEsIngreso()) {%>
					<div class="col-sm-6">
						<div class="card rounded border border-danger cardsStyle fondoGastos">
							<div class="card-body">
								<h5 class="card-title"><%=categoria.getNombre()%></h5>
								<button type="button" class="btn botonMovimientoGastos" data-bs-toggle="modal" data-bs-target="#<%=categoria.getNombre()%>">
									Movimientos</button>
								<div class="modal fade" id="<%=categoria.getNombre()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title colorTituloModal" id="exampleModalLabel"><%=categoria.getNombre()%></h5>
												<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<%if(categoria.getListaTramites().size() == 0) {%>
													<p class="colorTituloModal">No hay trámites relacionados por el momento para esta categoría</p>
												<%} else {%>
												<table class="table fondoTabla">
													<thead>
														<tr>
															<th scope="col">ID</th>
															<th scope="col">Fecha</th>
															<th scope="col">Concepto</th>
															<th scope="col">Valor</th>
														</tr>
													</thead>
													<tbody>
														<%for(Tramite tramite : tramites) {%>
															<%if(tramite.getCategoriaId() == categoria.getCategoriaId()) {%>
															<tr>
																<td><%=tramite.getTramiteId()%></td>
																<td><%=tramite.getFecha()%></td>
																<td><%=tramite.getConcepto()%></td>
																<td><%=tramite.getValor()%></td>
															</tr>
															<%}%>
														<%}%>
													</tbody>
												</table>
												<%}%>
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
			<h1 class="titulos">Ingresos</h1>
			<div class="row row-cols-2">
				<%for (Categoria categoria : categorias) {%>
					<%categoria = CategoriaController.insertaTramites(categoria, conf);%>
					<%if(categoria.isEsIngreso()) {%>
					<div class="col-sm-6">
						<div class="card rounded border border-success cardsStyle fondoIngresos">
							<div class="card-body">
								<h5 class="card-title"><%=categoria.getNombre()%></h5>
								<button type="button" class="btn botonMovimientoIngresos" data-bs-toggle="modal" data-bs-target="#<%=categoria.getNombre()%>">
									Movimientos</button>
								<div class="modal fade" id="<%=categoria.getNombre()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title colorTituloModal" id="exampleModalLabel"><%=categoria.getNombre()%></h5>
												<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<%if(categoria.getListaTramites().size() == 0) {%>
													<p class="colorTituloModal">No hay trámites relacionados por el momento para esta categoría</p>
												<%} else {%>
												<table class="table fondoTabla">
													<thead>
														<tr>
															<th scope="col">ID</th>
															<th scope="col">Fecha</th>
															<th scope="col">Concepto</th>
															<th scope="col">Valor</th>
														</tr>
													</thead>
													<tbody>
														<%for(Tramite tramite : tramites) {%>
															<%if(tramite.getCategoriaId() == categoria.getCategoriaId()) {%>
															<tr>
																<td><%=tramite.getTramiteId()%></td>
																<td><%=tramite.getFecha()%></td>
																<td><%=tramite.getConcepto()%></td>
																<td><%=tramite.getValor()%></td>
															</tr>
															<%}%>
														<%}%>
													</tbody>
												</table>
												<%}%>
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
	
	<%@ include file="PieDePagina.jsp"%>
</body>
</html>