<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Search Response Codes</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            padding-top: 70px;
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        h2 {
            margin-bottom: 30px;
            font-weight: 700;
            color: #212529;
        }
        form.filter-form {
            max-width: 400px;
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
        }
        form.filter-form input[type="text"] {
            flex-grow: 1;
        }
        .message {
            font-weight: 600;
            margin-bottom: 20px;
        }
        .message.success {
            color: #198754;
        }
        .message.error {
            color: #dc3545;
        }
        .image-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .image-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            width: 160px;
            padding: 15px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .image-card img {
            width: 150px;
            border-radius: 6px;
            margin-bottom: 10px;
        }
        .image-card form button {
            background-color: #0d6efd;
            border: none;
            color: white;
            padding: 7px 14px;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .image-card form button:hover {
            background-color: #084298;
        }
        .nav-links {
            margin-top: 40px;
            font-size: 1rem;
        }
        .nav-links a {
            color: #0d6efd;
            text-decoration: none;
            margin-right: 20px;
            font-weight: 600;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
        .image-code {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #212529;
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
        <h2>Search Response Codes</h2>

        <form action="search" method="get" class="filter-form">
            <input type="text" name="filter" placeholder="Filter (e.g. 2xx, 203, 2)" value="${filter}" class="form-control" />
            <button type="submit" class="btn btn-primary">Filter</button>
        </form>

        <c:if test="${not empty message}">
            <p class="message success">${message}</p>
        </c:if>

        <c:choose>
            <c:when test="${empty imageUrls}">
                <p class="message error">No images found for this filter</p>
            </c:when>
            <c:otherwise>
                <div class="image-grid">
                    <c:forEach var="url" items="${imageUrls}">

                        <div class="image-card">

                            <img src="${url}" alt="HTTP Code" />

                            <form action="search/save-single" method="post">
                                <input type="hidden" name="imageUrl" value="${url}" />
                                <input type="hidden" name="filter" value="${filter}" />
                                <button type="submit">Add to List</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
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
