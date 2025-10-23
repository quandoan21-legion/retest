<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.demo.retest.entity.MonAn" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<MonAn> listMonAn = (List<MonAn>) request.getAttribute("listMonAn");
    if (listMonAn == null) {
        listMonAn = Collections.emptyList();
    }
    String errorMessage = (String) request.getAttribute("errorMessage");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách món ăn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 24px;
            background-color: #f5f7fa;
        }
        h1 {
            margin-bottom: 16px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
        }
        th, td {
            border: 1px solid #d6d9de;
            padding: 8px 12px;
            text-align: left;
        }
        th {
            background-color: #eef1f6;
        }
        tr:nth-child(even) {
            background-color: #f9fbff;
        }
        .alert {
            color: #c53030;
            background-color: #fed7d7;
            border: 1px solid #fc8181;
            padding: 12px;
            margin-bottom: 16px;
        }
        .empty-row {
            text-align: center;
            color: #667;
        }
    </style>
</head>
<body></body>
</html>
