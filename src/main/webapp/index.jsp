<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management | Admin Dashboard</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <style>
        body {
            background-color: #f4f6f9;
            font-family: "Poppins", sans-serif;
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.4rem;
            letter-spacing: 0.5px;
        }

        .welcome-section {
            background: linear-gradient(135deg, #0d6efd, #6610f2);
            color: white;
            padding: 60px 0;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .welcome-section h1 {
            font-weight: 700;
            font-size: 2.2rem;
        }

        .welcome-section p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .dashboard-cards {
            margin-top: 50px;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.1);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.15);
        }

        .card i {
            font-size: 2.8rem;
            margin-bottom: 15px;
            color: #0d6efd;
        }

        footer {
            margin-top: 60px;
            background-color: #212529;
            color: #ccc;
            text-align: center;
            padding: 20px;
            border-radius: 10px 10px 0 0;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">UserMgmt Admin</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="users">Manage Users</a></li>
                <li class="nav-item"><a class="nav-link" href="profile">Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item">
                    <form action="logout" class="d-inline">
                        <button type="submit" class="btn btn-link nav-link px-0">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero / Welcome Section -->
<section class="welcome-section container mt-4">
    <h1>Welcome Back, Admin!</h1>
    <p>Manage users, monitor activity, and control access from your central dashboard.</p>
</section>

<!-- Dashboard Summary Cards -->
<div class="container dashboard-cards">
    <div class="row g-4">
        <div class="col-md-3">
            <div class="card text-center p-4">
                <i class="bi bi-people"></i>
                <h5>Total Users</h5>
                <p class="text-muted mb-0">132 Active Users</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-4">
                <i class="bi bi-person-check"></i>
                <h5>Verified Accounts</h5>
                <p class="text-muted mb-0">89 Verified Users</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-4">
                <i class="bi bi-lock"></i>
                <h5>Access Requests</h5>
                <p class="text-muted mb-0">12 Pending Approvals</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-4">
                <i class="bi bi-bar-chart"></i>
                <h5>System Logs</h5>
                <p class="text-muted mb-0">View Analytics</p>
            </div>
        </div>
    </div>
</div>

<!-- Recent Activity -->
<div class="container mt-5">
    <h3 class="mb-4">Recent Activity</h3>
    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th scope="col">User</th>
                <th scope="col">Action</th>
                <th scope="col">Timestamp</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>john.doe@example.com</td>
                <td>Updated Profile</td>
                <td><%= new Date() %></td>
            </tr>
            <tr>
                <td>mary.adams@example.com</td>
                <td>Created New User</td>
                <td><%= new Date() %></td>
            </tr>
            <tr>
                <td>sam.wilson@example.com</td>
                <td>Changed Password</td>
                <td><%= new Date() %></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <p>© <%= new Date().getYear() + 1900 %> UserMgmt Admin Panel | Built with ❤️ using JSP & Bootstrap</p>
</footer>

<!-- Bootstrap 5 JS & Icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
</body>
</html>
