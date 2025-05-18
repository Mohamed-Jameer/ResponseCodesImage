<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        body {
            padding-top: 70px;
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            margin-bottom: 25px;
            color: #212529;
            font-weight: 700;
            text-align: center;
        }

        .form-label {
            font-weight: 600;
        }

        .form-control {
            margin-bottom: 15px;
            height: 42px;
            font-size: 1rem;
        }

        .btn-primary {
            width: 100%;
            font-size: 1.1rem;
            padding: 10px;
        }

        .error-message {
            color: #dc3545;
            margin-top: 10px;
            text-align: center;
            font-weight: 600;
        }

        .signup-link {
            margin-top: 20px;
            text-align: center;
            font-size: 0.95rem;
        }

        .signup-link a {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
  <div class="container">
    <a class="navbar-brand" href="/">MyApp</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="/lists">My Lists</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/search">Search</a>
        </li>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <li class="nav-item">
                  <a class="nav-link" href="/logout">Logout</a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="nav-item">
                  <a class="nav-link" href="/login">Login</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/signup">Sign Up</a>
                </li>
            </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>

<!-- Main Content -->
<main>
    <div class="login-container">
        <h2>Login</h2>
        <form action="login" method="post">
            <label for="username" class="form-label">Username:</label>
            <input type="text" id="username" name="username" class="form-control" required>

            <label for="password" class="form-label">Password:</label>
            <input type="password" id="password" name="password" class="form-control" required>

            <button type="submit" class="btn btn-primary">Login</button>
        </form>

        <c:if test="${param.error == 'Invalid'}">
            <p class="error-message">Invalid username or password</p>
        </c:if>

        <p class="signup-link">Don't have an account? <a href="signup">Sign Up</a></p>
    </div>
</main>

<!-- Footer -->
<footer class="bg-primary text-white text-center py-3">
    <div class="container">
        <small>© 2025 MyApp. All rights reserved.</small>
    </div>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
