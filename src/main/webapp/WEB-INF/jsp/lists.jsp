<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>My Lists</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            padding-top: 70px;
            background-color: #f8f9fa;
        }
        h2 {
            color: #212529;
            margin-bottom: 25px;
            font-weight: 700;
        }
        ul.list-group {
            max-width: 600px;
        }
        ul.list-group li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 20px;
            margin-bottom: 8px;
            background: white;
            border-radius: 6px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        ul.list-group li a {
            text-decoration: none;
            color: #0d6efd;
            font-weight: 600;
            font-size: 1.1rem;
        }
        ul.list-group li a:hover {
            text-decoration: underline;
        }
        form button {
            background-color: #dc3545;
            border: none;
            color: white;
            padding: 6px 14px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }
        form button:hover {
            background-color: #b02a37;
        }
        .nav-links {
            margin-top: 30px;
            font-size: 1rem;
        }
        .nav-links a {
            margin-right: 20px;
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
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

<div class="container">
    <h2>My Saved Lists</h2>
    <c:if test="${not empty lists}">
        <ul class="list-group">
            <c:forEach var="list" items="${lists}">
                <li class="list-group-item">
                    <a href="lists/${list.id}">${list.name}</a>
                    <form action="lists/delete/${list.id}" method="post" style="margin:0;">
                        <button type="submit">Delete</button>
                    </form>
                </li>
            </c:forEach>
        </ul>
    </c:if>
</div>

<footer class="bg-primary text-white text-center py-3 mt-5">
    <div class="container">
        <small>© 2025 MyApp. All rights reserved.</small>
    </div>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
