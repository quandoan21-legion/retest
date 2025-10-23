package com.demo.retest.entity;

import lombok.Data;

import java.util.Date;

@Data
public class MonAn {
    private int maMonAn;
    private String tenMonAn;
    private int maDanhMuc;
    private String moTa;
    private String anhDaiDien;
    private double gia;
    private Date ngayBatDauBan;
    private Date ngaySua;
    private String trangThai;
}