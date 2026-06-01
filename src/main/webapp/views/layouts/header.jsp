<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1a1a1a;
            --accent-color: #c0392b;
            --text-muted: #777;
            --bg-light: #f8f9fa;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-light);
            color: #333;
        }
        h1, h2, h3, .navbar-brand {
            font-family: 'Playfair+Display', serif;
        }
        .navbar {
            background: #fff !important;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            padding: 15px 0;
        }
        .navbar-brand {
            font-weight: 800;
            letter-spacing: 2px;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
        }
        .nav-link {
            font-weight: 500;
            color: var(--primary-color) !important;
            transition: 0.3s;
        }
        .nav-link:hover {
            color: var(--accent-color) !important;
        }
        .btn-dark {
            background-color: var(--primary-color);
            border: none;
            border-radius: 0;
            padding: 10px 25px;
            transition: 0.4s;
        }
        .btn-dark:hover {
            background-color: #333;
            transform: translateY(-2px);
        }
        .card {
            border: none;
            border-radius: 8px;
            transition: 0.3s;
        }
        .product-card {
            background: #fff;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        .product-img-wrapper {
            position: relative;
            height: 280px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: #fbfbfb;
        }
        .product-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }
        .badge-new {
            position: absolute;
            top: 10px;
            left: 10px;
            background: var(--accent-color);
            color: #fff;
            padding: 5px 12px;
            font-size: 0.7rem;
            text-transform: uppercase;
        }
        .price {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--accent-color);
        }
        .footer {
            background: var(--primary-color);
            color: #fff;
            padding: 60px 0 30px;
            margin-top: 80px;
        }
        .footer a {
            color: #bbb;
            transition: 0.3s;
        }
        .footer a:hover {
            color: #fff;
            text-decoration: none;
        }
        .sidebar-title {
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
            color: var(--primary-color);
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        .filter-item {
            display: block;
            padding: 8px 0;
            color: var(--text-muted);
            font-size: 0.9rem;
            transition: 0.3s;
        }
        .filter-item:hover, .filter-item.active {
            color: var(--accent-color);
            padding-left: 5px;
            text-decoration: none;
        }
    </style>
</head>
<body>
