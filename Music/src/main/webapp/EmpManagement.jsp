<%@page import="java.util.List"%>
<%@page import="com.letslearn.DBcon.DbCon"%>
<%@page import="com.letslearn.Dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.letslearn.Modal.*"%>
<%@ page import="com.letslearn.Interface.*" %>
<!DOCTYPE html>
<html lang="en">
<%
PensionerDao pensionerDao = new PensionerDao(DbCon.getConnection());
List<Pensioner> pensioners = pensionerDao.getAllPensioners();

RoleImplementation roleImpl = new RoleImplementation();
roleImpl.displayRole();

Admin authin = (Admin) request.getSession().getAttribute("auth");
if (authin != null) {
	//System.out.println("gmmac");
} else {
	response.sendRedirect("auth-login.jsp");
}
%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/bootstrap.css">

<link rel="stylesheet" href="assets/vendors/iconly/bold.css">
<link rel="stylesheet" href="assets/vendors/simple-datatables/style.css">

<link rel="stylesheet"
	href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="assets/css/app.css">
<link rel="shortcut icon" href="assets/images/favicon.svg"
	type="image/x-icon">
</head>

<body>
	<div id="app">
		<div id="sidebar" class="active">
			<div class="sidebar-wrapper active">
				<div class="sidebar-header px-0 pb-0">
					<div class="d-flex justify-content-between">
						<div>
							<!-- <img src="assets/images/logo/logo.png" class="h-100 w-100"
								alt="Logo" srcset=""> -->
						</div>
						<div class="toggler">
							<a href="#" class="sidebar-hide d-xl-none d-block"><i
								class="bi bi-x bi-middle"></i></a>
						</div>
					</div>
				</div>
				<div class="sidebar-menu">
					<ul class="menu px-3">
						<li class="sidebar-title">Admin Dashboard</li>

						<li class="sidebar-item active "><a
							href="EmpManagement.jsp" class='sidebar-link'> <i
								class="bi bi-grid-fill"></i> <span>Employee Management</span>
						</a></li>
						<li class="sidebar-item"><a href="albumManagement.jsp"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>Album
									Management</span>
						</a></li>
						
						<li class="sidebar-item "><a href="musicianManagement.jsp"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>Musician
									Management</span>
						</a></li>
						<li class="sidebar-item"><a
							href="PackageM.jsp" class='sidebar-link'> <i
								class="bi bi-grid-fill"></i> <span>Package
									Management</span>
						</a></li>
                        <li class="sidebar-item  "><a href="LogoutServlet"
							class='sidebar-link'> <i class="bi bi-life-preserver"></i> <span>Logout</span>
						</a></li>
					</ul>
				</div>
				<button class="sidebar-toggler btn x">
					<i data-feather="x"></i>
				</button>
			</div>
		</div>
		<div id="main">
			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>

			<div class="page-heading">
				<h3>Employee Management</h3>
			</div>
			<section class="section">
				<div class="card">
					<div class="card-header d-flex justify-content-between">
						<h4>Employee List</h4>
						<div>
							<button class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#staticBackdrop">Add Employee</button>
						</div>
					</div>
					<div class="card-body">
						<table class="table table-hover" id="table1">
							<thead>
								<tr>
									<th>Name</th>
									<th>Email</th>
									<th>Phone</th>
									<th>City</th>
									<th>NIC</th>
									<th>Grade</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (Pensioner pensioner : pensioners) {
								%>
								<tr>
									<td><%=pensioner.getName()%></td>
									<td><%=pensioner.getEmail()%></td>
									<td><%=pensioner.getTel()%></td>
									<td><%=pensioner.getCity()%></td>
									<td><%=pensioner.getNic()%></td>
									<td><%=pensioner.getGrade()%></td>
									<td>
									<a
										href="PensionerServlet?action=delete&email=<%=pensioner.getEmail()%>"><span
											class="badge bg-danger py-2" style="cursor: pointer;">Delete</span>
									</a>
									
									<a href="#" class="edit-link" data-bs-toggle="modal"
										data-bs-target="#updateStaticBackdrop"
										data-pensioner-name="<%=pensioner.getName()%>"
										data-pensioner-email="<%=pensioner.getEmail()%>"
										data-pensioner-city="<%=pensioner.getCity()%>"
										data-pensioner-nic="<%=pensioner.getNic()%>"
										data-pensioner-grade="<%=pensioner.getGrade()%>"
										data-pensioner-tel="<%=pensioner.getTel()%>"> 
										<span class="badge bg-warning py-2" style="cursor: pointer;">Edit</span>
									</a>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</section>
			<!-- update Modal -->
			<div class="modal fade" id="updateStaticBackdrop"
				data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="updateStaticBackdrops">Edit
								Employee</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form class="row g-3 needs-validation" action="PensionerServlet"
								method="POST">
								<input type="hidden"  value="update" name="action" />
								<div class="row">
									<div class="col-md-12 position-relative">
										<label for="validationTooltip01" class="form-label">Name</label>
										<input type="text" id="pensionerName" class="form-control" name="fname" required>

									</div>

									<div class="col-md-6 position-relative d-none">
										<label for="validationTooltipUsername" class="form-label">Email</label>
										<div class="input-group has-validation">
											<input type="email" id="pensionerEmail02"  name="email"
												title="Enter Email" >
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 position-relative">
										<label for="validationTooltip03" class="form-label">City</label>
										<input type="text" id="pensionerCity" class="form-control" name="city"
											title="Enter City" required>

									</div>
									<div class="col-md-6 position-relative">
										<label for="validationTooltip05" class="form-label">NIC</label>
										<input pattern="^\d{12}$" id="pensionerNic" maxlength="12" name="nic"
											type="text" class="form-control" title="Enter NIC" required>

									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 position-relative">
										<label for="validationTooltip04" class="form-label">Grade</label>
										<select class="form-select" name="grade" required>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
										</select>
										<div class="invalid-tooltip">Please select a valid
											Grade.</div>
									</div>
									<div class="col-md-6 position-relative">
										<label for="validationTooltip06" class="form-label">Telephone</label>
										<input type="text" class="form-control" id="pensionerTel"
											title="Enter Phone number" name="tel" required
											pattern="^\d{10}$" maxlength="10">

									</div>
								</div>


								<div class="mt-3 d-flex justify-content-end">
									<button type="button" class="btn btn-secondary mx-3"
										data-bs-dismiss="modal">Close</button>
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal -->
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
				data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="staticBackdropLabel">Add New
								Employee</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form class="row g-3 needs-validation" action="PensionerServlet"
								method="POST">
								<input type="hidden" value="addPensioner" name="action" />

								<div class="col-md-6 position-relative">
									<label for="validationTooltip01" class="form-label">Name</label>
									<input type="text" class="form-control" placholder="Mark"
										name="fname" required>

								</div>

								<div class="col-md-6 position-relative">
									<label for="validationTooltipUsername" class="form-label">Email</label>
									<div class="input-group has-validation">
										<input type="email" class="form-control" name="email"
											title="Enter Email" required>

									</div>
								</div>
								<div class="col-md-6 position-relative">
									<label for="validationTooltip03" class="form-label">City</label>
									<input type="text" name="city" class="form-control"
										title="Enter City" required>

								</div>
								<div class="col-md-6 position-relative">
									<label for="validationTooltip05" class="form-label">NIC</label>
									<input type="text" name="nic" maxlength="12"
										class="form-control" title="Enter NIC" required
										pattern="^\d{12}$">

								</div>
								<div class="row">
									<div class="col-md-12 position-relative">
										<label for="validationTooltip03" class="form-label">Salary</label>
										<input type="number"  class="form-control" name="salary"
											title="Enter Salary" required>

									</div>
									
								</div>
								<div class="col-md-6 position-relative">
									<label for="validationTooltip04" class="form-label">Grade</label>
									<select class="form-select" name="grade" required>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
									</select>
									<div class="invalid-tooltip">Please select a valid Grade.
									</div>
								</div>


								<div class="col-md-6 position-relative">
									<label for="validationTooltip06" class="form-label">Telephone</label>
									<input type="text" class="form-control" name="tel"
										title="Enter Phone number" required pattern="^\d{10}$"
										maxlength="10">

								</div>

								<div class="d-flex justify-content-end">
									<button type="button" class="btn btn-secondary mx-3"
										data-bs-dismiss="modal">Close</button>
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			
		</div>
	</div>
	<script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script src="assets/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendors/simple-datatables/simple-datatables.js"></script>

	<script>
		// Simple Datatable
		let table1 = document.querySelector('#table1');
		let dataTable = new simpleDatatables.DataTable(table1);
	</script>

	<script src="assets/js/main.js"></script>
	<script>
    // JavaScript to update modal content when "Edit" link is clicked
    document.querySelectorAll('.edit-link').forEach(link => {
        link.addEventListener('click', function () {
            const modal = document.getElementById('updateStaticBackdrop');
            const pensionerName = link.getAttribute('data-pensioner-name');
            const pensionerEmail = link.getAttribute('data-pensioner-email');
            const pensionerCity = link.getAttribute('data-pensioner-city');
            const pensionerNic = link.getAttribute('data-pensioner-nic');
            const pensionerGrade = link.getAttribute('data-pensioner-grade');
            const pensionerTel = link.getAttribute('data-pensioner-tel');
           
            
            // Update modal content with pensioner details
            document.getElementById('pensionerName').value = pensionerName;
            document.getElementById('pensionerTel').value = pensionerTel;
            document.getElementById('pensionerNic').value = pensionerNic;
            document.getElementById('pensionerCity').value = pensionerCity;
            document.getElementById('pensionerEmail02').value = pensionerEmail;
            // Update other input fields with pensioner details
        });
    });
</script>
</body>

</html>