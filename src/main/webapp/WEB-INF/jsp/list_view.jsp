<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>View List</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            padding-top: 70px;
            background-color: #f8f9fa;
        }
        h2 {
            margin-bottom: 20px;
            color: #343a40;
            font-weight: 700;
        }
        .created-at {
            color: #6c757d;
            margin-bottom: 30px;
        }
        .image-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .image-gallery img {
            width: 150px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
            transition: transform 0.2s ease-in-out;
        }
        .image-gallery img:hover {
            transform: scale(1.05);
        }
        .back-link {
            margin-top: 30px;
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
    <h2>List: ${list.name}</h2>
    <p class="created-at">Created at: ${list.createdAt}</p>

    <div class="image-gallery">
        <c:forEach var="img" items="${validImages}">
            <img src="${img}" alt="Image" />
        </c:forEach>
    </div>

    <div class="back-link">
        <a href="/lists" class="btn btn-primary">Back to Lists</a>
    </div>
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
