<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.demo.retest.entity.MonAn" %>
<%
    List<MonAn> listMonAn = (List<MonAn>) request.getAttribute("listMonAn");
    if (listMonAn == null) {
        listMonAn = Collections.emptyList();
    }
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Món Ăn</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .navbar-brand { font-weight: bold; color: #ff6b6b !important; }
        .logo { height: 40px; margin-right: 10px; }
        .card-img-top { height: 200px; object-fit: cover; }
        .price { color: #28a745; font-weight: bold; font-size: 1.2rem; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-utensils logo"></i>
                Nhà Hàng Ngon
            </a>
            <button class="btn btn-success" data-toggle="modal" data-target="#addModal">
                <i class="fas fa-plus"></i> Thêm Món Ăn
            </button>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">Danh Sách Món Ăn</h2>
        <% if (successMessage != null) { %>
            <div class="alert alert-success" role="alert"><%= successMessage %></div>
        <% } %>
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
        <% } %>

        <div class="row">
            <%
                if (!listMonAn.isEmpty()) {
                    for (MonAn mon : listMonAn) {
            %>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <img src="<%= mon.getAnhDaiDien() %>" class="card-img-top" alt="<%= mon.getTenMonAn() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= mon.getTenMonAn() %></h5>
                            <p class="card-text"><%= mon.getMoTa() %></p>
                            <p class="price"><%= mon.getGia() %> VNĐ</p>
                            <button class="btn btn-primary btn-sm" onclick="editMon(<%= mon.getMaMonAn() %>)">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <button class="btn btn-danger btn-sm" onclick="deleteMon(<%= mon.getMaMonAn() %>)">
                                <i class="fas fa-trash"></i> Xóa
                            </button>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="col-12">
                    <p class="text-center">Chưa có món ăn nào.</p>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Modal Thêm Món -->
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm Món Ăn Mới</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form id="addForm" method="post" action="themMonAn">
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tên Món Ăn *</label>
                            <input type="text" class="form-control" name="tenMonAn" id="tenMonAn" required>
                            <small class="form-text text-danger" id="errorTen"></small>
                        </div>
                        <div class="form-group">
                            <label>Danh Mục *</label>
                            <select class="form-control" name="maDanhMuc" required>
                                <option value="1">Món nướng</option>
                                <option value="2">Món luộc</option>
                                <option value="3">Món chay</option>
                                <option value="4">Đồ uống</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Mô Tả</label>
                            <textarea class="form-control" name="moTa" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Ảnh Đại Diện (URL)</label>
                            <input type="text" class="form-control" name="anhDaiDien" id="anhDaiDien" placeholder="https://..." pattern="https?://.+" title="Vui lòng nhập URL hợp lệ">
                        </div>
                        <div class="form-group">
                            <label>Giá *</label>
                            <input type="number" class="form-control" name="gia" id="gia" required>
                            <small class="form-text text-danger" id="errorGia"></small>
                        </div>
                        <div class="form-group">
                            <label>Ngày Bắt Đầu Bán *</label>
                            <input type="date" class="form-control" name="ngayBatDauBan" id="ngayBatDauBan" required>
                            <small class="form-text text-danger" id="errorNgay"></small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-success">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Sửa Món -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Sửa Món Ăn</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form id="editForm" method="post" action="suaMonAn">
                    <input type="hidden" name="maMonAn" id="editMaMonAn">
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tên Món Ăn *</label>
                            <input type="text" class="form-control" name="tenMonAn" id="editTenMonAn" required>
                            <small class="form-text text-danger" id="editErrorTen"></small>
                        </div>
                        <div class="form-group">
                            <label>Danh Mục *</label>
                            <select class="form-control" name="maDanhMuc" id="editMaDanhMuc" required>
                                <option value="1">Món nướng</option>
                                <option value="2">Món luộc</option>
                                <option value="3">Món chay</option>
                                <option value="4">Đồ uống</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Mô Tả</label>
                            <textarea class="form-control" name="moTa" id="editMoTa" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Ảnh Đại Diện (URL)</label>
                            <input type="text" class="form-control" name="anhDaiDien" id="editAnhDaiDien" placeholder="https://..." pattern="https?://.+" title="Vui lòng nhập URL hợp lệ">
                        </div>
                        <div class="form-group">
                            <label>Giá *</label>
                            <input type="number" class="form-control" name="gia" id="editGia" required>
                            <small class="form-text text-danger" id="editErrorGia"></small>
                        </div>
                        <div class="form-group">
                            <label>Ngày Bắt Đầu Bán *</label>
                            <input type="date" class="form-control" name="ngayBatDauBan" id="editNgayBatDauBan" required>
                            <small class="form-text text-danger" id="editErrorNgay"></small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Cập Nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('ngayBatDauBan').value = today;
        document.getElementById('ngayBatDauBan').min = today;

        document.getElementById('addForm').addEventListener('submit', function(e) {
            let valid = true;
            const ten = document.getElementById('tenMonAn').value;
            const gia = document.getElementById('gia').value;
            const ngay = document.getElementById('ngayBatDauBan').value;

            if (ten.length <= 7) {
                document.getElementById('errorTen').textContent = 'Tên món ăn phải dài hơn 7 ký tự';
                valid = false;
            } else {
                document.getElementById('errorTen').textContent = '';
            }

            if (parseFloat(gia) <= 0) {
                document.getElementById('errorGia').textContent = 'Giá phải lớn hơn 0';
                valid = false;
            } else {
                document.getElementById('errorGia').textContent = '';
            }

            if (ngay !== today) {
                document.getElementById('errorNgay').textContent = 'Ngày bắt đầu bán phải là ngày hiện tại';
                valid = false;
            } else {
                document.getElementById('errorNgay').textContent = '';
            }

            if (!valid) e.preventDefault();
        });

        document.getElementById('editForm').addEventListener('submit', function(e) {
            let valid = true;
            const ten = document.getElementById('editTenMonAn').value;
            const gia = document.getElementById('editGia').value;
            const ngay = document.getElementById('editNgayBatDauBan').value;

            if (ten.length <= 7) {
                document.getElementById('editErrorTen').textContent = 'Tên món ăn phải dài hơn 7 ký tự';
                valid = false;
            } else {
                document.getElementById('editErrorTen').textContent = '';
            }

            if (parseFloat(gia) <= 0) {
                document.getElementById('editErrorGia').textContent = 'Giá phải lớn hơn 0';
                valid = false;
            } else {
                document.getElementById('editErrorGia').textContent = '';
            }

            if (ngay !== today) {
                document.getElementById('editErrorNgay').textContent = 'Ngày bắt đầu bán phải là ngày hiện tại';
                valid = false;
            } else {
                document.getElementById('editErrorNgay').textContent = '';
            }

            if (!valid) e.preventDefault();
        });

        function editMon(maMonAn) {
            $.ajax({
                url: 'getMonAn?id=' + maMonAn,
                success: function(data) {
                    document.getElementById('editMaMonAn').value = data.maMonAn;
                    document.getElementById('editTenMonAn').value = data.tenMonAn;
                    document.getElementById('editMaDanhMuc').value = data.maDanhMuc;
                    document.getElementById('editMoTa').value = data.moTa || '';
                    document.getElementById('editAnhDaiDien').value = data.anhDaiDien || '';
                    document.getElementById('editGia').value = data.gia;
                    document.getElementById('editNgayBatDauBan').value = data.ngayBatDauBan;
                    document.getElementById('editNgayBatDauBan').min = today;
                    $('#editModal').modal('show');
                }
            });
        }

        function deleteMon(maMonAn) {
            if (confirm('Bạn có chắc muốn xóa món ăn này?')) {
                window.location.href = 'xoaMonAn?id=' + maMonAn;
            }
        }
    </script>
</body>
</html>
