-- TẠO CSDL QL_BanHangOnline
USE MASTER
GO
IF EXISTS (SELECT * FROM MASTER..SYSDATABASES WHERE NAME = 'QL_BanHangOnline')
DROP DATABASE QL_BanHangOnline
GO
CREATE DATABASE QL_BanHangOnline
GO
--CÀI ĐẶT NGÀY/THÁNG/NĂM
SET DATEFORMAT dmy;

-- SỬ DỤNG CSDL QL_BanHangOnline
USE QL_BanHangOnline
GO

--TABLE: nhomTK
CREATE TABLE nhomTK
(
	maNhom			INT					NOT NULL		PRIMARY KEY IDENTITY,
	tenNhom			NVARCHAR(35)		NOT NULL		DEFAULT N'Giao hàng',
	ghiChu			Ntext								DEFAULT N'', 
)

--TABLE: quanHuyen
CREATE TABLE quanHuyen
(
	maQH			INT					NOT NULL		PRIMARY KEY IDENTITY,
	tenQH			NVARCHAR(50)		NOT NULL,
	tinhThanh		NVARCHAR(50)		NOT NULL,
	ghiChu			NTEXT								DEFAULT N'', 
)

--TABLE: taiKhoanTV
CREATE TABLE taiKhoanTV
(
	taiKhoan		VARCHAR(20)			NOT NULL	PRIMARY KEY,
	matKhau			VARCHAR(20)			NOT NULL,
	hoDem			NVARCHAR(50),
	tenTV			NVARCHAR(30)		NOT NULL,
	ngaySinh		DATETIME,
	gioiTinh		BIT								DEFAULT 0,
	soDT			NVARCHAR(20),
	email			NVARCHAR(20),
	diaChi			NVARCHAR(250),
	trangThai		BIT								DEFAULT 0,
	ghiChu			NTEXT,
	maNhom			INT					NOT NULL	FOREIGN KEY(maNhom) REFERENCES nhomTK(maNhom),
	maQH			INT					NOT NULL	FOREIGN KEY(maQH) REFERENCES quanHuyen(maQH),
)

--TABLE: loaiSP
CREATE TABLE loaiSP
(
	maLoai			INT					NOT NULL	PRIMARY KEY IDENTITY,
	loaiSP			NVARCHAR(90)		NOT NULL	DEFAULT N'Dụng cụ nhà bếp',
	ghiChu			NTEXT							DEFAULT N'',
)

--TABLE: baiViet
CREATE TABLE baiViet
(
	maBV			VARCHAR(10)			NOT NULL	PRIMARY KEY,
	tenBV			NVARCHAR(250)		NOT NULL,
	hinhDD			VARCHAR(MAX),
	ndTomTat		NVARCHAR(2000),
	ngayDang		DATETIME,
	noiDung			NVARCHAR(4000),
	taiKhoan		VARCHAR(20)			NOT NULL	FOREIGN KEY (taiKhoan) REFERENCES taiKhoanTV(taiKhoan),
	daDuyet			BIT								DEFAULT 0,
	maLoai			INT								FOREIGN KEY (maLoai) REFERENCES loaiSP(maLoai),
)

--TABLE: sanPham
CREATE TABLE sanPham
(
	maSP			VARCHAR(10)			NOT NULL	PRIMARY KEY,
	tenSP			NVARCHAR(250)		NOT NULL,
	hinhDD			VARCHAR(MAX)					DEFAULT N'',
	ndTomTat		NVARCHAR(2000)					DEFAULT N'',
	ngayDang		DATETIME						DEFAULT CURRENT_TIMESTAMP,
	noiDung			NVARCHAR(4000)					DEFAULT N'',
	taiKhoan		VARCHAR(20)			NOT NULL	FOREIGN KEY (taiKhoan) REFERENCES taiKhoanTV(taiKhoan), 
	daDuyet			BIT								DEFAULT 0,
	giaBan			INT								DEFAULT 0 CHECK (giaBan >= 0),
	giamGia			INT								DEFAULT 0 CHECK (giamGia >= 0 AND giamGia <= 100),
	maLoai			INT					NOT NULL	FOREIGN KEY (maLoai) REFERENCES loaiSP(maLoai),
	dvt				NVARCHAR(10),
	nhaSanXuat		NVARCHAR(50),
)

--TABLE: khachHang
CREATE TABLE khachHang
(
	maKH			VARCHAR(10)			NOT NULL	PRIMARY KEY,
	tenKH			NVARCHAR(50)		NOT NULL,
	soDT			VARCHAR(10),
	email			VARCHAR(20),
	diaChi			NVARCHAR(250),
	ngaySinh		DATETIME,
	gioiTinh		BIT								DEFAULT 0,
	ghiChu			NTEXT,
	maQH			INT					NOT NULL	FOREIGN KEY (maQH) REFERENCES quanHuyen(maQH),
)

--TABLE: donHang
CREATE TABLE donHang
(
	soDH			VARCHAR(10)			NOT NULL	PRIMARY KEY,
	maKH			VARCHAR(10)			NOT NULL	FOREIGN KEY (maKH) REFERENCES khachHang(maKH),
	taiKhoan		VARCHAR(20)			NOT NULL	FOREIGN KEY (taiKhoan) REFERENCES taiKhoanTV(taiKhoan),
	ngayDat			DATETIME,
	daKichHoat		BIT								DEFAULT 1,
	ngayGH			DATETIME,
	diaChiGH		NVARCHAR(250),
	ghiChu			NTEXT,
)

--TABLE: ctDonHang
CREATE TABLE ctDonHang
(
	soDH			VARCHAR(10)			NOT NULL	FOREIGN KEY (soDH) REFERENCES donHang(soDH),
	maSP			VARCHAR(10)			NOT NULL	FOREIGN KEY (maSP) REFERENCES sanPham(maSP),
	CONSTRAINT PK_ctDonHang_soDH_maSP PRIMARY KEY (soDH, maSP),
	soLuong			INT								CHECK (soLuong >= 1),
	giaBan			BIGINT							CHECK (giaBan >= 0),
	giamGia			BIGINT							CHECK (giamGia >= 0),
)
