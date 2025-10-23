package com.demo.retest.controller;

import com.demo.retest.entity.MonAn;
import com.demo.retest.repo.MonAnRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Date;


public class ThemMonAnController extends HttpServlet {
    private final MonAnRepository monAnRepository = new MonAnRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String tenMonAn = req.getParameter("tenMonAn");
        String maDanhMucStr = req.getParameter("maDanhMuc");
        String moTa = req.getParameter("moTa");
        String anhDaiDien = req.getParameter("anhDaiDien");
        String giaStr = req.getParameter("gia");
        String ngayBatDauBanStr = req.getParameter("ngayBatDauBan");

        if (isBlank(tenMonAn) || isBlank(maDanhMucStr) || isBlank(giaStr) || isBlank(ngayBatDauBanStr)) {
            req.setAttribute("errorMessage", "Vui lòng điền đầy đủ các trường bắt buộc.");
            req.getRequestDispatcher("/home").forward(req, resp);
            return;
        }

        MonAn monAn = new MonAn();
        monAn.setTenMonAn(tenMonAn.trim());
        monAn.setMoTa(isBlank(moTa) ? null : moTa.trim());
        monAn.setAnhDaiDien(isBlank(anhDaiDien) ? null : anhDaiDien.trim());
        monAn.setTrangThai("dang_ban");

        try {
            monAn.setMaDanhMuc(Integer.parseInt(maDanhMucStr));
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Danh mục không hợp lệ.");
            req.getRequestDispatcher("/home").forward(req, resp);
            return;
        }

        try {
            monAn.setGia(Double.parseDouble(giaStr));
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Giá phải là số.");
            req.getRequestDispatcher("/home").forward(req, resp);
            return;
        }

        try {
            LocalDate localDate = LocalDate.parse(ngayBatDauBanStr);
            monAn.setNgayBatDauBan(java.sql.Date.valueOf(localDate));
        } catch (DateTimeParseException e) {
            req.setAttribute("errorMessage", "Ngày bắt đầu bán không hợp lệ.");
            req.getRequestDispatcher("/home").forward(req, resp);
            return;
        }

        monAn.setNgaySua(new Date());

        try {
            monAnRepository.insert(monAn);
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Thêm món ăn thành công.");
            resp.sendRedirect(req.getContextPath() + "/home");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Lỗi khi thêm món ăn: " + e.getMessage());
            req.getRequestDispatcher("/home").forward(req, resp);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
