package com.demo.retest.controller;

import com.demo.retest.entity.MonAn;
import com.demo.retest.repo.MonAnRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class IndexController extends HttpServlet {
    private final MonAnRepository monAnRepository = new MonAnRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<MonAn> listMonAn;
        try {
            listMonAn = monAnRepository.findAllDangBan();
        } catch (SQLException e) {
            e.printStackTrace();
            listMonAn = Collections.emptyList();
            req.setAttribute("errorMessage", "Không thể tải danh sách món ăn. Vui lòng thử lại sau.");
        }
        req.setAttribute("listMonAn", listMonAn);

        HttpSession session = req.getSession(false);
        if (session != null) {
            Object successMessage = session.getAttribute("successMessage");
            if (successMessage != null) {
                req.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }
            Object errorMessage = session.getAttribute("errorMessage");
            if (errorMessage != null && req.getAttribute("errorMessage") == null) {
                req.setAttribute("errorMessage", errorMessage);
                session.removeAttribute("errorMessage");
            }
        }

        req.getRequestDispatcher("/index1.jsp").forward(req, resp);
    }
}
