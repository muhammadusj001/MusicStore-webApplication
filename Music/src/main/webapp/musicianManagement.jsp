<%@page import="java.util.List"%>
<%@page import="com.letslearn.DBcon.DbCon"%>
<%@page import="com.letslearn.Dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.letslearn.Modal.*"%>
<%@ page import="com.letslearn.Interface.*"%>
<!DOCTYPE html>
<html lang="en">
<%
MusicianDao musicianDao = new MusicianDao(DbCon.getConnection());
List<Musician> musicians = musicianDao.getAllMusicians();

Admin authin = (Admin) request.getSession().getAttribute("auth");
if (authin != null) {
	// If authenticated, continue
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
						<div></div>
						<div class="toggler">
							<a href="#" class="sidebar-hide d-xl-none d-block"><i
								class="bi bi-x bi-middle"></i></a>
						</div>
					</div>
				</div>
				<div class="sidebar-menu">
					<ul class="menu px-3">
						<li class="sidebar-title">Admin Dashboard</li>

						<li class="sidebar-item "><a href="EmpManagement.jsp"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>Employee
									Management</span>
						</a></li>
						<li class="sidebar-item "><a href="albumManagement.jsp"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>Album
									Management</span>
						</a></li>
						
						<li class="sidebar-item active"><a
							href="musicianManagement.jsp" class='sidebar-link'> <i
								class="bi bi-grid-fill"></i> <span>Musician Management</span>
						</a></li>
						<li class="sidebar-item"><a href="PackageM.jsp"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>Package
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
				<h3>Musician Management</h3>
			</div>
			<section class="section">
				<div class="card">
					<div class="card-header d-flex justify-content-between">
						<h4>Musician List</h4>
						<div>
							<button class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#addMusicianModal">Add Musician</button>
						</div>
					</div>
					<div class="card-body">
						<table class="table table-hover" id="table1">
							<thead>
								<tr>
									<th>Name</th>
									<th>Age</th>
									<th>Genre</th>
									<th>Instrument</th>
									<th>Telephone</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (Musician musician : musicians) {
								%>
								<tr>
									<td><%=musician.getName()%></td>
									<td><%=musician.getAge()%></td>
									<td><%=musician.getGenre()%></td>
									<td><%=musician.getInstrument()%></td>
									<td><%=musician.getTel()%></td>
									<td><a
										href="MusicianServlet?action=delete&musicianId=<%=musician.getId()%>"><span
											class="badge bg-danger py-2" style="cursor: pointer;">Delete</span>
									</a> <a href="#" class="edit-link" data-bs-toggle="modal"
										data-bs-target="#updateStaticBackdrop"
										data-musician-name="<%=musician.getName()%>"
										data-musician-age="<%=musician.getAge()%>"
										data-musician-genre="<%=musician.getGenre()%>"
										data-musician-instrument="<%=musician.getInstrument()%>"
										data-musician-telephone="<%=musician.getTel()%>"
										data-musician-id="<%=musician.getId()%>"> <span
											class="badge bg-warning py-2" style="cursor: pointer;">Edit</span>
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
								Musician</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form class="row g-3 needs-validation" action="MusicianServlet"
								method="POST">
								<input type="hidden" value="update" name="action" /> <input
									type="hidden" id="musicianId" name="musicianId" />
								<div class="row">
									<div class="col-md-12 position-relative">
										<label for="validationTooltip01" class="form-label">Name</label>
										<input type="text" id="musicianName" class="form-control"
											name="name" required>

									</div>

								</div>
								<div class="row">
									<div class="col-md-6 position-relative">
										<label for="validationTooltip03" class="form-label">Age</label>
										<input type="number" id="musicianAge" class="form-control"
											name="age" required>

									</div>
									<div class="col-md-6 position-relative">
										<label for="validationTooltip04" class="form-label">Genre</label>
										<input type="text" id="musicianGenre" class="form-control"
											name="genre" required>

									</div>
								</div>

								<div class="row">
									<div class="col-md-6 position-relative">
										<label for="validationTooltip05" class="form-label">Instrument</label>
										<input type="text" id="musicianInstrument"
											class="form-control" name="instrument" required>

									</div>
									<div class="col-md-6 position-relative">
										<label for="validationTooltip06" class="form-label">Telephone</label>
										<input type="text" id="musicianTelephone" class="form-control"
											name="tel" title="Enter Telephone" pattern="^\d{10}$"
											maxlength="10" required>

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
			<div class="modal fade" id="addMusicianModal"
				data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="staticBackdropLabel">Add New
								Musician</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form class="row g-3 needs-validation" action="MusicianServlet"
								method="POST">
								<input type="hidden" value="addMusician" name="action" />

								<div class="col-md-12 position-relative">
									<label for="validationTooltip01" class="form-label">Name</label>
									<input type="text" class="form-control" name="name"
										placeholder="Enter name" required>

								</div>
								<div class="col-md-6 position-relative">
									<label for="validationTooltip03" class="form-label">Age</label>
									<input type="number" class="form-control" name="age"
										placeholder="Enter age" required>

								</div>

								<div class="col-md-6 position-relative">
									<label for="validationTooltip04" class="form-label">Genre</label>
									<input type="text" class="form-control" name="genre"
										placeholder="Enter genre" required>

								</div>
								<div class="col-md-6 position-relative">
									<label for="validationTooltip05" class="form-label">Instrument</label>
									<input type="text" class="form-control" name="instrument"
										placeholder="Enter instrument" required>

								</div>
								<div class="col-md-6 position-relative">
									<label for="validationTooltip06" class="form-label">Telephone</label>
									<input type="text" class="form-control" name="tel"
										placeholder="Enter telephone" title="Enter Telephone"
										pattern="^\d{10}$" maxlength="10" required>

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

			<footer>
				<div class="footer clearfix mb-0 text-muted">
					<div class="float-start">
						<p>2023 &copy; OOP</p>
					</div>
					<div class="float-end">
						<p>
							Crafted with <span class="text-danger"><i
								class="bi bi-heart"></i></span> For <a href="#">OOP Module</a>
						</p>
					</div>
				</div>
			</footer>
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
            const musicianName = link.getAttribute('data-musician-name');
            const musicianAge = link.getAttribute('data-musician-age');
            const musicianGenre = link.getAttribute('data-musician-genre');
            const musicianInstrument = link.getAttribute('data-musician-instrument');
            const musicianTelephone = link.getAttribute('data-musician-telephone');
            const musicianId = link.getAttribute('data-musician-id');
            
            // Update modal content with musician details
            document.getElementById('musicianName').value = musicianName;
            document.getElementById('musicianAge').value = musicianAge;
            document.getElementById('musicianGenre').value = musicianGenre;
            document.getElementById('musicianInstrument').value = musicianInstrument;
            document.getElementById('musicianTelephone').value = musicianTelephone;
            document.getElementById('musicianId').value = musicianId;
        });
    });
</script>
</body>

</html>
