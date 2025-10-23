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
<body>
<h1>Danh sách món đang bán</h1>
<% if (errorMessage != null) { %>
    <div class="alert"><%= errorMessage %></div>
<% } %>
<table>
    <thead>
    <tr>
        <th>#</th>
        <th>Tên món</th>
        <th>Danh mục</th>
        <th>Mô tả</th>
        <th>Giá</th>
        <th>Ngày bắt đầu bán</th>
        <th>Ngày sửa</th>
        <th>Trạng thái</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (listMonAn.isEmpty()) {
    %>
    <tr>
        <td class="empty-row" colspan="8">Chưa có món ăn nào đang bán.</td>
    </tr>
    <%
        } else {
            int index = 1;
            for (MonAn monAn : listMonAn) {
    %>
    <tr>
        <td><%= index++ %></td>
        <td><%= monAn.getTenMonAn() %></td>
        <td><%= monAn.getMaDanhMuc() %></td>
        <td><%= monAn.getMoTa() != null ? monAn.getMoTa() : "" %></td>
        <td><%= String.format("%,.0f", monAn.getGia()) %></td>
        <td><%= monAn.getNgayBatDauBan() != null ? dateFormat.format(monAn.getNgayBatDauBan()) : "" %></td>
        <td><%= monAn.getNgaySua() != null ? dateTimeFormat.format(monAn.getNgaySua()) : "" %></td>
        <td><%= monAn.getTrangThai() %></td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
</body>
</html>
