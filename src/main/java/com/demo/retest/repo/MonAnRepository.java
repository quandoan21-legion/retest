package com.demo.retest.repo;

import com.demo.retest.MySqlHelper;
import com.demo.retest.entity.MonAn;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class MonAnRepository {
    public List<MonAn> findAllDangBan() throws SQLException {
        String query = """
                SELECT MaMonAn, TenMonAn, MaDanhMuc, MoTa, AnhDaiDien, Gia, NgayBatDauBan, NgaySua, TrangThai
                FROM MonAn
                WHERE TrangThai = 'dang_ban'
                """;
        List<MonAn> result = new ArrayList<>();
        Connection connection = requireConnection();
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                result.add(mapRow(resultSet));
            }
        }
        return result;
    }

    public int insert(MonAn monAn) throws SQLException {
        String insertSql = """
                INSERT INTO MonAn (TenMonAn, MaDanhMuc, MoTa, AnhDaiDien, Gia, NgayBatDauBan, NgaySua, TrangThai)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;
        Objects.requireNonNull(monAn, "monAn không được null");
        Objects.requireNonNull(monAn.getNgayBatDauBan(), "ngayBatDauBan không được null");

        Connection connection = requireConnection();
        try (PreparedStatement statement = connection.prepareStatement(
                insertSql,
                Statement.RETURN_GENERATED_KEYS
        )) {
            statement.setString(1, monAn.getTenMonAn());
            statement.setInt(2, monAn.getMaDanhMuc());
            statement.setString(3, monAn.getMoTa());
            statement.setString(4, monAn.getAnhDaiDien());
            statement.setDouble(5, monAn.getGia());
            statement.setDate(6, new java.sql.Date(monAn.getNgayBatDauBan().getTime()));
            if (monAn.getNgaySua() != null) {
                statement.setTimestamp(7, new java.sql.Timestamp(monAn.getNgaySua().getTime()));
            } else {
                statement.setTimestamp(7, null);
            }
            String trangThai = monAn.getTrangThai() != null ? monAn.getTrangThai() : "dang_ban";
            statement.setString(8, trangThai);

            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Không thể thêm món ăn, không có dòng nào bị ảnh hưởng.");
            }
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int generatedId = generatedKeys.getInt(1);
                    monAn.setMaMonAn(generatedId);
                    return generatedId;
                }
            }
        }
        return -1;
    }

    private Connection requireConnection() throws SQLException {
        Connection connection = MySqlHelper.getConnection();
        if (connection == null) {
            throw new SQLException("Không thể kết nối database.");
        }
        return connection;
    }

    private MonAn mapRow(ResultSet resultSet) throws SQLException {
        MonAn monAn = new MonAn();
        monAn.setMaMonAn(resultSet.getInt("MaMonAn"));
        monAn.setTenMonAn(resultSet.getString("TenMonAn"));
        monAn.setMaDanhMuc(resultSet.getInt("MaDanhMuc"));
        monAn.setMoTa(resultSet.getString("MoTa"));
        monAn.setAnhDaiDien(resultSet.getString("AnhDaiDien"));
        monAn.setGia(resultSet.getDouble("Gia"));

        Date ngayBatDauBan = resultSet.getDate("NgayBatDauBan");
        if (ngayBatDauBan != null) {
            monAn.setNgayBatDauBan(new Date(ngayBatDauBan.getTime()));
        }

        Timestamp ngaySua = resultSet.getTimestamp("NgaySua");
        if (ngaySua != null) {
            monAn.setNgaySua(new Date(ngaySua.getTime()));
        }

        monAn.setTrangThai(resultSet.getString("TrangThai"));
        return monAn;
    }
}
