<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp"%>
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
	<title>Nuevo gasto</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<%LocalDate fechaActual = LocalDate.now();%>
	<%Locale fechaEs = new Locale("es", "ES");%>
	<%String fechaCompleta = fechaActual.format(DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy", fechaEs));%>
	<%CategoriaDao categoriaDao = new CategoriaDao();%>
	<%List<Categoria> categorias = categoriaDao.get();%>
	<%@ include file="Cabecera.jsp"%>
	<div class="principalDiv">
		<h1><%=fechaCompleta%></h1>
		<div class="container contenedorGastos">
			<form method="post" action="tramite">
				<div class="d-flex centerDiv">
					<input type="number" class="form-control leftColumnConfig" id="importe" placeholder="Importe" name="importe">
				</div>
				<div class="d-flex centerDiv">
					<textarea class="form-control leftColumnConfig" id="concepto" rows="3" placeholder="Concepto" name="concepto" maxlength="14"></textarea>
					<div class="dateSelectSize">
						<input type="date" class="form-control" id="fechaTramite" value="<%=fechaActual%>" name="fechaTramite">
						<select name="categoriaEscogida" class="form-select" aria-label="Default select example">
							<option selected>Tipo de categor�a</option>
							<%for(Categoria categoria : categorias) {%>
								<%if(!categoria.isEsIngreso()){ %>
									<option value=<%=categoria.getCategoriaId()%>><%=categoria.getNombre()%></option>
								<%} %>
							<%}%>
						</select>
					</div>
				</div>
				<input class="btn addTramiteGastos" type="submit" name="submit" value="Agregar gasto">
			</form>
		</div>
	</div>
	
	<%@ include file="PieDePagina.jsp"%>
</body>
</html>