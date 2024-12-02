<%@page import="java.util.List"%>
<%@page import="com.letslearn.DBcon.DbCon"%>
<%@page import="com.letslearn.Dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.letslearn.Modal.*"%>
<%@ page import="com.letslearn.Interface.*"%>
<!DOCTYPE html>
<html lang="en">
<%
MusicPackageDao musicPackageDao = new MusicPackageDao(DbCon.getConnection());
List<MusicPackage> musicPackages = musicPackageDao.getAllMusicPackages();

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
					
						<li class="sidebar-item "><a href="musicianManagement.jsp"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>Musician
									Management</span>
						</a></li>
						<li class="sidebar-item active"><a href="PackageM.jsp"
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
				<h3>Music Package Management</h3>
			</div>
			<section class="section">
				<div class="card">
					<div class="card-header d-flex justify-content-between">
						<h4>Music Package List</h4>
						<div>
							<button class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#staticBackdrop">Add Music Package</button>
						</div>
					</div>
					<div class="card-body">
						<table class="table table-hover" id="table1">
							<thead>
								<tr>
									<th>Name</th>
									<th>Price</th>
									<th>Number of Songs</th>
									<th>Unlimited Streaming</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (MusicPackage musicPackage : musicPackages) {
								%>
								<tr>
									<td><%=musicPackage.getName()%></td>
									<td><%=musicPackage.getPrice()%></td>
									<td><%=musicPackage.getNumberOfSongs()%></td>
									<td><%=musicPackage.isUnlimitedStreaming() ? "Yes" : "No"%></td>
									<td><a
										href="MPackageServlet?action=delete&musicPackageId=<%=musicPackage.getId()%>"><span
											class="badge bg-danger py-2" style="cursor: pointer;">Delete</span>
									</a> <a href="#" class="edit-link" data-bs-toggle="modal"
										data-bs-target="#updateStaticBackdrop"
										data-music-package-name="<%=musicPackage.getName()%>"
										data-music-package-price="<%=musicPackage.getPrice()%>"
										data-music-package-number-of-songs="<%=musicPackage.getNumberOfSongs()%>"
										data-music-package-unlimited-streaming="<%=musicPackage.isUnlimitedStreaming()%>"
										data-music-package-id="<%=musicPackage.getId()%>"> <span
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
								Music Package</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form class="row g-3 needs-validation" action="MPackageServlet"
								method="POST">
								<input type="hidden" value="update" name="action" /> <input
									type="hidden" id="musicPackageId" name="musicPackageId" />
								<div class="row">
									<div class="col-md-12 position-relative">
										<label for="validationTooltip01" class="form-label">Name</label>
										<input type="text" id="musicPackageName" class="form-control"
											name="packageName" required>
									</div>
								</div>

								<div class="row">
									<div class="col-md-6 position-relative">
										<label for="validationTooltip03" class="form-label">Price</label>
										<input type="text" id="musicPackagePrice" class="form-control"
											name="packagePrice" title="Enter Price"
											pattern="^\d+(\.\d{1,2})?$" required>
									</div>
									<div class="col-md-6 position-relative">
										<label for="validationTooltip03" class="form-label">Number
											of Songs</label> <input type="number" id="musicPackageNumberOfSongs"
											class="form-control" name="packageNumberOfSongs" required>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 position-relative">
										<label for="validationTooltip04" class="form-label">Unlimited
											Streaming</label> <select class="form-select"
											id="musicPackageUnlimitedStreaming"
											name="packageUnlimitedStreaming" required>
											<option value="true">Yes</option>
											<option value="false">No</option>
										</select>
										<div class="invalid-tooltip">Please select an option.</div>
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
								Music Package</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form class="row g-3 needs-validation" action="MPackageServlet"
								method="POST">
								<input type="hidden" value="addMusicPackage" name="action" />

								<div class="col-md-12 position-relative">
									<label for="validationTooltip01" class="form-label">Name</label>
									<input type="text" class="form-control" name="packageName"
										required>
								</div>

								<div class="col-md-6 position-relative">
									<label for="validationTooltip03" class="form-label">Price</label>
									<input type="text" class="form-control" name="packagePrice"
										title="Enter Price" pattern="^\d+(\.\d{1,2})?$" required>
								</div>

								<div class="col-md-6 position-relative">
									<label for="validationTooltip03" class="form-label">Number
										of Songs</label> <input type="number" class="form-control"
										name="packageNumberOfSongs" required>
								</div>

								<div class="col-md-12 position-relative">
									<label for="validationTooltip04" class="form-label">Unlimited
										Streaming</label> <select class="form-select"
										name="packageUnlimitedStreaming" required>
										<option value="true">Yes</option>
										<option value="false">No</option>
									</select>
									<div class="invalid-tooltip">Please select an option.</div>
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
                const packageName = link.getAttribute('data-music-package-name');
                const packagePrice = link.getAttribute('data-music-package-price');
                const packageNumberOfSongs = link.getAttribute('data-music-package-number-of-songs');
                const packageUnlimitedStreaming = link.getAttribute('data-music-package-unlimited-streaming');
                const packageId = link.getAttribute('data-music-package-id');
                
                // Update modal content with music package details
                document.getElementById('musicPackageName').value = packageName;
                document.getElementById('musicPackagePrice').value = packagePrice;
                document.getElementById('musicPackageNumberOfSongs').value = packageNumberOfSongs;
                document.getElementById('musicPackageUnlimitedStreaming').value = packageUnlimitedStreaming;
                document.getElementById('musicPackageId').value = packageId;
                // Update other input fields with music package details
            });
        });
    </script>
</body>
</html>
