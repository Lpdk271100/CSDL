/************************************************************
 * Code formatted by SoftTree SQL Assistant © v11.0.35
 * Time: 13/09/2021 8:59:57 SA
 ************************************************************/

CREATE DATABASE BTLSQL
GO
USE QLDiemSV
GO
-- Tao Bang Mon Hoc --
CREATE TABLE MonHoc
(
	MaMH        CHAR(5) PRIMARY KEY,
	TenMH       NVARCHAR(30) NOT NULL,
	SoTrinh     INT NOT NULL CHECK((SoTrinh > 0) AND (SoTrinh < 7))
)
--- Tao Bang He Dao Tao ---
CREATE TABLE HeDT
(
	MaHeDT      CHAR(5) PRIMARY KEY,
	TenHeDT     NVARCHAR(40) NOT NULL
)

--- Tao Bang Khoa Hoc ---
CREATE TABLE KhoaHoc
(
	MaKhoaHoc      CHAR(5) PRIMARY KEY,
	TenKhoaHoc     NVARCHAR(20) NOT NULL
)
--- Tao Bang Khoa --
CREATE TABLE Khoa
(
	MaKhoa        CHAR(5) PRIMARY KEY,
	TenKhoa       NVARCHAR(30) NOT NULL,
	DiaChi        NVARCHAR(100) NOT NULL,
	DienThoai     VARCHAR(20) NOT NULL
)
-- Tao Bang Lop ---
CREATE TABLE Lop
(
	MaLop         CHAR(5) PRIMARY KEY,
	TenLop        NVARCHAR(30) NOT NULL,
	MaKhoa        CHAR(5) FOREIGN KEY REFERENCES Khoa(MaKhoa),
	MaHeDT        CHAR(5) FOREIGN KEY REFERENCES HeDT(MaHeDT),
	MaKhoaHoc     CHAR(5) FOREIGN KEY REFERENCES KhoaHoc(MaKhoaHoc),
)
--- Tao Bang Sinh Vien ---
CREATE TABLE SinhVien
(
	MaSV         CHAR(15) PRIMARY KEY,
	TenSV        NVARCHAR(20),
	GioiTinh     BIT,
	NgaySinh     DATETIME,
	QueQuan      NVARCHAR(50),
	MaLop        CHAR(5) FOREIGN KEY REFERENCES Lop(MaLop)
)
--- Tao Bang Diem ---
CREATE TABLE Diem
(
	MaSV         CHAR(15) FOREIGN KEY REFERENCES SinhVien(MaSV),
	MaMH         CHAR(5) FOREIGN KEY REFERENCES MonHoc(MaMH),
	HocKy        INT CHECK(HocKy > 0) NOT NULL,
	DiemLan1     INT,
	DiemLan2     INT
)

---Nhap Du Lieu Cho Bang He Dao Tao --
INSERT INTO HeDT
VALUES
  (
    'A01',
    N'Ðại Học'
  )
INSERT INTO HeDT
VALUES
  (
    'B01',
    N'Cao Ðẳng'
  )
INSERT INTO HeDT
VALUES
  (
    'C01',
    N'Trung Cấp'
  )
INSERT INTO HeDT
VALUES
  (
    'D01',
    N'Công nhân'
  )

SELECT *
FROM   HeDT

-- Nhap Du Lieu Bang Ma Khoa Hoc ---
INSERT INTO KhoaHoc
VALUES
  (
    'K1',
    N'Ðại học khóa 1'
  )
INSERT INTO KhoaHoc
VALUES
  (
    'K2',
    N'Ðại học khóa 2'
  )
INSERT INTO KhoaHoc
VALUES
  (
    'K3',
    N'Ðại học khóa 3'
  )
INSERT INTO KhoaHoc
VALUES
  (
    'K9',
    N'Ðại học khóa 4'
  )
INSERT INTO KhoaHoc
VALUES
  (
    'K10',
    N'Ðại học khóa 5'
  )
INSERT INTO KhoaHoc
VALUES
  (
    'K11',
    N'Ðại học khóa 6'
  )

SELECT *
FROM   KhoaHoc

-- Nhap Du Lieu bang Khoa --
INSERT INTO Khoa
VALUES
  (
    'CNTT',
    N'Công nghệ thông tin',
    N'Tầng 4 nhà B',
    '043768888'
  )
INSERT INTO Khoa
VALUES
  (
    'CK',
    N'Cõ Khí',
    N'Tầng 5 nhà B',
    '043768888'
  )
INSERT INTO Khoa
VALUES
  (
    'DT',
    N'Ðiện tử',
    N'Tằng 6 nhà B',
    '043768888'
  )
INSERT INTO Khoa
VALUES
  (
    'KT',
    N'Kinh Tế',
    N'Tầng 2 nhà C',
    '043768888'
  )

SELECT *
FROM   Khoa

--- Nhap Du Lieu Cho Bang Lop --
INSERT INTO Lop
VALUES
  (
    'MT1',
    N'MÁy Tính 1',
    'CNTT',
    'A01',
    'K2'
  )
INSERT INTO Lop
VALUES
  (
    'MT2',
    N'MÁy Tính 2',
    'CNTT',
    'A01',
    'K2'
  )
INSERT INTO Lop
VALUES
  (
    'MT3',
    N'MÁy Tính 3',
    'CNTT',
    'A01',
    'K2'
  )
INSERT INTO Lop
VALUES
  (
    'MT4',
    N'MÁy Tính 4',
    'CNTT',
    'A01',
    'K2'
  )
INSERT INTO Lop
VALUES
  (
    'KT1',
    N'Kinh tế 1',
    'KT',
    'A01',
    'K2'
  )

SELECT *
FROM   Lop

-- Nhap Du Lieu Bang Sinh Vien --
INSERT INTO SinhVien
VALUES
  (
    '0241060218',
    N'Nguyễn Minh Một',
    1,
    '08/27/1989',
    'Hải Dýõng',
    'MT3'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060318',
    N'Nguyễn Minh Hai',
    1,
    '2/08/1989',
    'Nam Dinh',
    'MT1'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060418',
    N'Nguyễn Minh Ba',
    1,
    '7/04/1989',
    'Ninh Binh',
    'MT2'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060518',
    N'Nguyễn Minh Bốn',
    1,
    '7/08/1989',
    'Ninh Binh',
    'MT1'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060618',
    N'Nguyễn Minh Nãm',
    0,
    '7/08/1989',
    'Nam Dinh',
    'MT3'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060718',
    N'Nguyễn Minh Sáu',
    1,
    '7/08/1989',
    'Ha Noi',
    'MT3'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060818',
    N'Nguyễn Minh Bảy',
    1,
    '7/08/1989',
    'Ha Noi',
    'MT3'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060918',
    N'Nguyễn Minh Tám',
    1,
    '7/08/1989',
    'Hai Duong',
    'MT2'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060128',
    N'Nguyễn Minh Chín',
    1,
    '7/08/1989',
    'Hai Duong',
    'MT2'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060138',
    N'Nguyễn Minh Mýời',
    1,
    '7/08/1989',
    'Ha Nam',
    'MT2'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060148',
    N'Nguyễn Minh Mýời Một',
    0,
    '7/08/1989',
    'Bac Giang',
    'MT4'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060158',
    N'Nguyễn Minh Mýời Hai',
    0,
    '7/08/1989',
    'Ha Noi',
    'MT4'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060168',
    N'Nguyễn Minh Mýời Ba',
    1,
    '7/08/1989',
    'Hai Duong',
    'MT4'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060178',
    N'Nguyễn Minh Mýời Bốn',
    1,
    '7/08/1989',
    'Nam Dinh',
    'MT1'
  )
INSERT INTO SinhVien
VALUES
  (
    '0241060978',
    N'Nguyễn Minh Mýời Nãm',
    1,
    '7/08/1989',
    'Nam Dinh',
    'KT1'
  )

SELECT *
FROM   SinhVien

-- Nhap Du Lieu Bang Mon Hoc --
INSERT INTO MonHoc
VALUES
  (
    'SQL',
    'SQL',
    5
  )
INSERT INTO MonHoc
VALUES
  (
    'JV',
    'Java',
    6
  )
INSERT INTO MonHoc
VALUES
  (
    'CNPM',
    'Công Nghệ phần mềm',
    4
  )
INSERT INTO MonHoc
VALUES
  (
    'PTHT',
    'Phân tích hệ thống',
    4
  )
INSERT INTO MonHoc
VALUES
  (
    'Mang',
    'Mạng máy tính',
    5
  )

SELECT *
FROM   MonHoc
-- Nhap Du Lieu Bang Diem --
INSERT INTO Diem
  (
    MaSV,
    MaMH,
    HocKy,
    DiemLan1
  )
VALUES
  (
    '0241060218',
    'SQL',
    5,
    7
  )
INSERT INTO Diem
  (
    MaSV,
    MaMH,
    HocKy,
    DiemLan1
  )
VALUES
  (
    '0241060418',
    'SQL',
    5,
    6
  )
INSERT INTO Diem
  (
    MaSV,
    MaMH,
    HocKy,
    DiemLan1
  )
VALUES
  (
    '0241060218',
    'CNPM',
    5,
    8
  )
INSERT INTO Diem
VALUES
  (
    '0241060518',
    'SQL',
    5,
    4,
    6
  )
INSERT INTO Diem
VALUES
  (
    '0241060218',
    'Mang',
    5,
    4,
    5
  )
INSERT INTO Diem
VALUES
  (
    '0241060218',
    'JV',
    5,
    4,
    4
  )
INSERT INTO Diem
VALUES
  (
    '0241060518',
    'JV',
    5,
    4,
    6
  )
INSERT INTO Diem
VALUES
  (
    '0241060218',
    'PTHT',
    4,
    2,
    5
  )
INSERT INTO Diem
  (
    MaSV,
    MaMH,
    HocKy,
    DiemLan1
  )
VALUES
  (
    '0241060318',
    'SQL',
    4,
    9
  )
INSERT INTO Diem
  (
    MaSV,
    MaMH,
    HocKy,
    DiemLan1
  )
VALUES
  (
    '0241060618',
    'SQL',
    4,
    8
  )
INSERT INTO Diem
VALUES
  (
    '0241060318',
    'Mang',
    5,
    3,
    4
  )
INSERT INTO Diem
VALUES
  (
    '0241060418',
    'Mang',
    5,
    4,
    4
  )
INSERT INTO Diem
  (
    MaSV,
    MaMH,
    HocKy,
    DiemLan1
  )
VALUES
  (
    '0241060518',
    'Mang',
    5,
    8
  )

SELECT *
FROM   Diem



----- Cac Cau Lenh
-- 1.Hiển thị danh sách sinh viên gồm các thông tin sau:MaSV,TenSV, NgaySinh, GioiTinh,Ten Lop
CREATE PROC show_sv
AS
  
SELECT MaSV,
       TenSV,
       NgaySinh,
       GioiTinh,
       TenLop
FROM   SinhVien,
       Lop
WHERE  SinhVien.MaLop = Lop.MaLop


 -- 2.Hien Thi Top 3 sinh vien lop may tinh 3 co diem mon SQL >=7
CREATE PROC show_top3sv
AS
SELECT TOP 3 TenSV,
       TenLop,
       DiemLan1,
       TenMH
FROM   SinhVien,
       Diem,
       Lop,
       MonHoc
WHERE  TenLop = 'MÁy tính 3'
       AND DiemLan1 >= 7
       AND TenMH = 'SQL'
       AND SinhVien.MaLop = Lop.MaLop
       AND Diem.MaSV = SinhVien.MaSV
       AND Diem.MaMH = MonHoc.MaMH

 -- 3.Hien Thi MaSV,TenSV,Ngay Sinh,Que Quan cua cac sinh vien ten la Ba va co tuoi lon hon 19.
CREATE PROC show_svba19
AS  
SELECT MaSV,
       TenSV,
       NgaySinh,
       QueQuan
FROM   SinhVien
WHERE  (TenSV LIKE '%Ba')
       AND (YEAR(GETDATE()) - YEAR(NgaySinh) > 19)

 -- 4. Hien Thi Tat Ca Nhung Sinh Vien Khoa Cong Nghe Thong Tin
 CREATE PROC show_svcntt
AS
SELECT TenSV,
       TenLop,
       NgaySinh,
       QueQuan
FROM   (SinhVien INNER JOIN Lop ON SinhVien.MaLop = Lop.MaLop)
       INNER JOIN Khoa
            ON  Khoa.MaKhoa = Lop.MaKhoa
WHERE  TenKhoa = N'Công nghệ thông tin'

 -- 5. Hien Thi Diem cua sinh vien lop May Tinh 3 Khoa 2 Sap Xep Diem Giam Dan
   CREATE PROC show_diemsvmt3
AS
SELECT TenSV,
       TenLop,
       DiemLan1
FROM   SinhVien,
       Lop,
       KhoaHoc,
       Diem
WHERE  SinhVien.MaLop = Lop.MaLop
       AND Lop.MaKhoaHoc = KhoaHoc.MaKhoaHoc
       AND Diem.MaSV = SinhVien.MaSV
       AND TenKhoaHoc = 'dai hoc khoa 2'
       AND TenLop = 'may tinh 3'
ORDER BY
       DiemLan1 DESC 
 
 --6. Tinh Trung Binh Diem Cac Mon Hoc Cua Cac Sinh Vien Lop May tinh 3
    CREATE PROC show_diemtbsvmt3
AS
SELECT SinhVien.MaSV,
       TenSV,
       Lop.TenLop,
       SUM(DiemLan1 * SoTrinh) / SUM(SoTrinh) AS DiemTrungBinh
FROM   SinhVien,
       Diem,
       MonHoc,
       Lop
WHERE  SinhVien.MaLop = Lop.MaLop
       AND Diem.MaSV = SinhVien.MaSV
       AND Diem.MaMH = MonHoc.MaMH
       AND TenLop = N'MÁy Tính 3'
GROUP BY
       SinhVien.MaSV,
       TenSV,
       Lop.TenLop

 --7.Hien Thi Tat Ca Sinh Vien Phai Hoc Lai Mon Mang May Tinh
    CREATE PROC show_svhlmt3
AS
SELECT TenSV,
       TenMH,
       DiemLan1,
       DiemLan2
FROM   SinhVien,
       Diem,
       MonHoc
WHERE  SinhVien.MaSV = Diem.MaSV
       AND Diem.MaMH = MonHoc.MaMH
       AND (DiemLan1 < 5)
       AND (DiemLan2 < 5)
       AND TenMH = 'Mạng máy tính'
--SV phai thi lai
    CREATE PROC show_svthilai
AS
SELECT TenSV,
       DiemLan1
FROM   SinhVien,
       Diem
WHERE  SinhVien.MaSV = Diem.MaSV
       AND (DiemLan1 < 5)
--SV thi lai mang may tinh

CREATE PROC show_svthilaimmt
AS
SELECT TenSV,
       DiemLan1,
       TenMH
FROM   SinhVien,
       Diem,
       MonHoc
WHERE  SinhVien.MaSV = Diem.MaSV
       AND Diem.MaMH = MonHoc.MaMH
       AND (DiemLan1 < 5)
       AND TenMH = 'Mạng máy tính'
  


 --8. Dem So Luong Sinh Vien Cua Khoa Cong Nghe Thong Tin
    CREATE PROC show_demsvcntt
AS
SELECT COUNT(*) AS CNTT
FROM   SINHVIEN,
       KHOA,
       LOP
WHERE  SINHVIEN.MALOP = LOP.MALOP
       AND LOP.MAKHOA = KHOA.MAKHOA
       AND TENKHOA = N'Công nghệ thông tin'

 --9. Dem So Luong Sinh Vien Cua Tung Khoa
      CREATE PROC show_demsvkhoa
AS
SELECT KHOA.MAKHOA,
       COUNT(*) AS SoLuong
FROM   SINHVIEN,
       LOP,
       KHOA
WHERE  SINHVIEN.MALOP = LOP.MALOP
       AND LOP.MAKHOA = KHOA.MAKHOA
GROUP BY
       KHOA.MAKHOA

 --10. Cho biet diem thap nhat cua moi mon hoc
     CREATE PROC show_diemthapnhat
AS
SELECT MonHoc.MAMH,
       MIN(diemlan1) AS [Min diem]
FROM   MonHoc
       INNER JOIN diem
            ON  MonHoc.MAMH = diem.MAMH
GROUP BY
       MonHoc.MAMH

                   
---11. Tao cac Thu Tuc Sau:
-- 11.1 Hien Thi Chi Tiet Sinh Vien Va Diem
  CREATE PROC hienthisv_diem
  AS
SELECT SinhVien.MaSV,
       TenSV,
       QueQuan,
       MaMH,
       DiemLan1
FROM   SinhVien
       JOIN diem
            ON  Sinhvien.masv = diem.masv
  
   --11.4 Tao thu tuc nhap them sinh vien moi
CREATE PROCEDURE nhapmoiSV
@Masv CHAR(15),
@Tensv NVARCHAR(20),
@gioitinh BIT,
@ngaysinh DATETIME,
@quequan NVARCHAR(50),
@malop CHAR(5)
AS
BEGIN
	INSERT INTO sinhvien
	VALUES
	  (
	    @Masv,
	    @Tensv,
	    @gioitinh,
	    @ngaysinh,
	    @quequan,
	    @malop
	  )
END
--test
nhapmoiSV '0241060898','my love',0,'5/5/1987','vung tau','KT1'
GO
SELECT *
FROM   sinhvien
 
 --12. CAC THAO TAC DU LIEU VOI CAC BANG
 -- 12.1 BANG SINH VIEN
 --A. THEM DU LIEU
CREATE PROCEDURE sp_insSINHVIEN(
    @MASV         CHAR(15),
    @TENSV        NVARCHAR(20),
    @GIOITINH     BIT,
    @NGAYSINH     DATETIME,
    @QueQuan      NVARCHAR(50),
    @MALOP        CHAR(5)
)
AS
BEGIN
	INSERT INTO SINHVIEN
	  (
	    MASV,
	    TENSV,
	    GIOITINH,
	    NGAYSINH,
	    QueQuan,
	    MALOP
	  )
	VALUES
	  (
	    @MASV,
	    @TENSV,
	    @GIOITINH,
	    @NGAYSINH,
	    @QUEQUAN,
	    @MALOP
	  )
END

--TEST
sp_insSINHVIEN '0241061298','BANG KIEU',1,'5/5/1987','HA NOI','MT3'
SELECT *
FROM   SINHVIEN

--B. XOA DU LIEU
CREATE PROCEDURE sp_delSINHVIEN
@MASV CHAR(15)
AS
	DELETE 
	FROM   SINHVIEN
	WHERE  MASV = @MASV
	       
	       -- TEST
	       sp_delSINHVIEN '0241060218'
	
	SELECT *
	FROM   sinhvien
	
	--C. HIEN THI DU LIEU
	CREATE PROC sp_showSINHVIEN
	AS
	SELECT *
	FROM   SINHVIEN
	       
	       --TEST
	       sp_showSINHVIEN
	
	--D. SUA DU LIEU
	CREATE PROCEDURE sp_updateSINHVIEN(
	    @MASV         CHAR(15),
	    @TENSV        NVARCHAR(20),
	    @GIOITINH     BIT,
	    @NGAYSINH     DATETIME,
	    @QUEQUAN      NVARCHAR(50),
	    @MALOP        CHAR(5)
	)
	AS
		UPDATE SINHVIEN
		SET    MASV = @MASV,
		       TENSV = @TENSV,
		       GIOITINH = @GIOITINH,
		       NGAYSINH = @NGAYSINH,
		       QUEQUAN = @QUEQUAN,
		       MALOP = @MALOP
		WHERE  MASV = @MASV
		       --- KIEM TRA
		       sp_updateSINHVIEN '0241060218','BANG KIEU',1,'5/5/1987','HA NOI','MT3'
		
		SELECT *
		FROM   SINHVIEN
		
		-- 12.2 BANG LOP
		--A. THEM DU LIEU
		CREATE PROCEDURE sp_insLOP(
		    @MALOP         CHAR(5),
		    @TENLOP        NVARCHAR(30),
		    @MAKHOA        CHAR(5),
		    @MaHeDT        CHAR(5),
		    @MaKhoaHoc     CHAR(5)
		)
		AS
		BEGIN
			INSERT INTO LOP
			  (
			    MALOP,
			    TENLOP,
			    MAKHOA,
			    MaHeDT,
			    MaKhoaHoc
			  )
			VALUES
			  (
			    @MALOP,
			    @TENLOP,
			    @MAKHOA,
			    @MaHeDT,
			    @MaKhoaHoc
			  )
		END
		
		--TEST
		
		sp_insLOP 'KT4','KINH TE 4','KT','A01','K2'
		SELECT *
		FROM   lop
		
		--B. XOA DU LIEU
		CREATE PROCEDURE sp_delLOP
		@MALOP CHAR(5)
		AS
			DELETE 
			FROM   LOP
			WHERE  MALOP = @MALOP
			       -- TEST
			       sp_delLOP 'KT4'
			
			--C. HIEN THI DU LIEU
			CREATE PROC sp_showLOP
			AS
			SELECT *
			FROM   LOP
			
			
			--D. SUA DU LIEU
			CREATE PROCEDURE sp_updateLOP(
			    @MALOP         CHAR(5),
			    @TENLOP        NVARCHAR(30),
			    @MAKHOA        CHAR(5),
			    @MaHeDT        CHAR(5),
			    @MaKhoaHoc     CHAR(5)
			)
			AS
				UPDATE LOP
				SET    MALOP = @MALOP,
				       TENLOP = @TENLOP,
				       MAKHOA = @MAKHOA,
				       MaHeDT = @MaHeDT,
				       MaKhoaHoc = @MaKhoaHoc
				WHERE  MALOP = @MALOP
				
				-- 12.3 BANG MON HOC
				
				--A. THEM DU LIEU
				CREATE PROCEDURE sp_insMONHOC(@MaMH CHAR(5), @TenMH NVARCHAR(30), @SoTrinh INT)
				AS
				BEGIN
					INSERT INTO MONHOC
					  (
					    MAMH,
					    TENMH,
					    SOTRINH
					  )
					VALUES
					  (
					    @MAMH,
					    @TENMH,
					    @SOTRINH
					  )
				END
				--B. XOA DU LIEU
				CREATE PROCEDURE sp_delMONHOC
				@MAMH CHAR(5)
				AS
					DELETE 
					FROM   MonHoc
					WHERE  MAMH = @MAMH
					
					--C. HIEN THI DU LIEU
					CREATE PROC sp_showMONHOC
					AS
					SELECT *
					FROM   MONHOC
					
					
					--D. SUA DU LIEU
					CREATE PROCEDURE sp_updateMONHOC(@MaMH CHAR(5), @TenMH NVARCHAR(30), @SoTrinh INT)
					AS
						UPDATE MONHOC
						SET    MAMH = @MAMH,
						       TENMH = @TENMH,
						       SOTRINH = @SOTRINH
						WHERE  MAMH = @MAMH
						
						--- 12.4 BANG KHOA HOC
						--A. THEM DU LIEU
						CREATE PROCEDURE sp_insKHOAHOC(@MaKhoaHoc CHAR(5), @TenKhoaHoc NVARCHAR(20))
						AS
						BEGIN
							INSERT INTO KHOAHOC
							  (
							    MaKhoaHoc,
							    TenKhoaHoc
							  )
							VALUES
							  (
							    @MaKhoaHoc,
							    @TenKhoaHoc
							  )
						END
						
						--B. XOA DU LIEU
						CREATE PROCEDURE sp_delKHOAHOC
						@MaKhoaHoc CHAR(5)
						AS
							DELETE 
							FROM   KHOAHOC
							WHERE  MaKhoaHoc = @MaKhoaHoc
							
							--C. HIEN THI DU LIEU
							CREATE PROC sp_showKHOAHOC
							AS
							SELECT *
							FROM   KHOAHOC
							
							
							--D. SUA DU LIEU
							CREATE PROCEDURE sp_updateKHOAHOC(@MaKhoaHoc CHAR(5), @TenKhoaHoc NVARCHAR(20))
							AS
								UPDATE KHOAHOC
								SET    MaKhoaHoc = @MaKhoaHoc,
								       TenKhoaHoc = @TenKhoaHoc
								WHERE  MaKhoaHoc = @MaKhoaHoc
								
								--- 12.5 BANG KHOA
								--A. THEM DU LIEU
								CREATE PROCEDURE sp_insKHOA(
								    @MaKhoa CHAR(5),
								    @TenKhoa NVARCHAR(30),
								    @DiaChi NVARCHAR(100),
								    @DienThoai VARCHAR(20)
								)
								AS
								BEGIN
									INSERT INTO KHOA
									  (
									    MaKhoa,
									    TenKhoa,
									    DiaChi,
									    DienThoai
									  )
									VALUES
									  (
									    @MaKhoa,
									    @TenKhoa,
									    @DiaChi,
									    @DienThoai
									  )
								END
								--B. XOA DU LIEU
								CREATE PROCEDURE sp_delKHOA
								@MAKHOA CHAR(5)
								AS
									DELETE 
									FROM   KHOA
									WHERE  MAKHOA = @MAKHOA
									
									--C. HIEN THI DU LIEU
									CREATE PROC sp_showKHOA
									AS
									SELECT *
									FROM   KHOA
									
									
									--D. SUA DU LIEU
									CREATE PROCEDURE sp_updateKHOA(
									    @MaKhoa CHAR(5),
									    @TenKhoa NVARCHAR(30),
									    @DiaChi NVARCHAR(100),
									    @DienThoai VARCHAR(20)
									)
									AS
										UPDATE KHOA
										SET    MaKhoa = @MaKhoa,
										       TenKhoa = @TenKhoa,
										       DiaChi = @DiaChi,
										       DienThoai = @DienThoai
										WHERE  MaKhoa = @MaKhoa
										
										-- 12.6 BANG HE DAO TAO
										--A. THEM DU LIEU
										CREATE PROCEDURE sp_HEDT(@MaHeDT CHAR(5), @TenHeDT NVARCHAR(40))
										AS
										BEGIN
											INSERT INTO HEDT
											  (
											    MaHeDT,
											    TenHeDT
											  )
											VALUES
											  (
											    @MaHeDT,
											    @TenHeDT
											  )
										END
										
										--B. XOA DU LIEU
										CREATE PROCEDURE sp_delHEDT
										@MaHeDT CHAR(5)
										AS
											DELETE 
											FROM   HEDT
											WHERE  MaHeDT = @MaHeDT
											
											--C. HIEN THI DU LIEU
											CREATE PROC sp_showHEDT
											AS
											SELECT *
											FROM   HEDT
											
											
											--D. SUA DU LIEU
											CREATE PROCEDURE sp_updateHEDT(@MaHeDT CHAR(5), @TenHeDT NVARCHAR(40))
											AS
												UPDATE HEDT
												SET    MaHeDT = @MaHeDT,
												       TenHeDT = @TenHeDT
												WHERE  MaHeDT = @MaHeDT
												
												-- 12.7 BANG DIEM
												--A. THEM DU LIEU
												CREATE PROCEDURE sp_insDIEM(
												    @MaSV CHAR(15),
												    @MaMH CHAR(5),
												    @HocKy INT,
												    @DiemLan1 INT,
												    @DiemLan2 INT
												)
												AS
												BEGIN
													INSERT INTO DIEM
													  (
													    MASV,
													    MAMH,
													    HOCKY,
													    DIEMLAN1,
													    DIEmLAN2
													  )
													VALUES
													  (
													    @MaSV,
													    @MaMH,
													    @HocKy,
													    @DiemLan1,
													    @DiemLan2
													  )
												END
												--B. XOA DU LIEU
												CREATE PROCEDURE sp_delDIEM
												@MASV CHAR(15)
												AS
													DELETE 
													FROM   DIEM
													WHERE  MASV = @MASV
													
													--C. HIEN THI DU LIEU
													CREATE PROC sp_showDIEM
													AS
													SELECT *
													FROM   DIEM
													
													
													--D. SUA DU LIEU
													CREATE PROCEDURE sp_updateDIEM(
													    @MaSV CHAR(15),
													    @MaMH CHAR(5),
													    @HocKy INT,
													    @DiemLan1 INT,
													    @DiemLan2 INT
													)
													AS
														UPDATE DIEM
														SET    MaSV = @MaSV,
														       MaMH = @MaMH,
														       HocKy = @HocKy,
														       DiemLan1 = @DiemLan1,
														       DiemLan2 = @DiemLan2
														WHERE  MaSV = @MaSV
														
														
														
														
														--- TAO TRIGGER
														
														---13. Tao trigger khong cho phep xoa mon hoc
														
														--- Tao Trigger insert Bang Diem
														CREATE TRIGGER trginsert_Diem
														ON Diem
														FOR INSERT
														AS
															DECLARE @DiemLan1 INT
															DECLARE @DiemLan2 INT
															SELECT @DiemLan1 = DiemLan1,
															       @DiemLan2 = DiemLan2
															FROM   INSERTED
															
															IF (@DiemLan1 < 0)
															   OR (@DiemLan1 > 10)
															   OR (@DiemLan2 < 0)
															   OR (@DiemLan2 > 10)
															BEGIN
															    PRINT 'Sai gia tri diem'
															    ROLLBACK TRANSACTION
															END
															ELSE
															BEGIN
															    PRINT 'qua trinh chen dl thanh cong'
															END
														GO
														-- check
														INSERT INTO Diem
														VALUES
														  (
														    '0241060148',
														    'SQL',
														    5,
														    14,
														    8
														  )
														INSERT INTO Diem
														VALUES
														  (
														    '0241060158',
														    'SQL',
														    5,
														    -2,
														    8
														  )
														INSERT INTO Diem
														VALUES
														  (
														    '0241060168',
														    'SQL',
														    5,
														    8,
														    8
														  )
														INSERT INTO Diem
														VALUES
														  (
														    '0241060178',
														    'SQL',
														    5,
														    12,
														    24
														  )
														INSERT INTO Diem
														VALUES
														  (
														    '0241060918',
														    'JV',
														    5,
														    12,
														    24
														  )
													GO
													SELECT *
													FROM   Diem
													
													-- Tao trigger de tat cac truong trong bang sv phai nhap
													
													CREATE TRIGGER trginsert_Sinhvien
													ON Sinhvien
													FOR INSERT
													AS
													BEGIN
														-- khai bao 4 bien luu tru
														DECLARE @tensv NVARCHAR(20)
														DECLARE @quequan NVARCHAR(50)
														DECLARE @gioitinh BIT
														DECLARE @ngaysinh DATETIME
														-- lay du lieu ra cac bien tu bang inserterd
														SELECT @tensv = INSERTED.tensv,
														       @quequan = INSERTED.quequan,
														       @gioitinh = INSERTED.gioitinh,
														       @ngaysinh = INSERTED.ngaysinh
														FROM   INSERTED
														
														IF (
														       (@tensv IS NULL)
														       OR (@quequan IS NULL)
														       OR (@gioitinh IS NULL)
														       OR (@ngaysinh IS NULL)
														   )
														BEGIN
														    PRINT'Ban phai day du cac thong'
														    PRINT'qua trinh them dl khong thanh cong'
														    ROLLBACK TRAN
														END
														ELSE
														BEGIN
														    PRINT'ban da them du lieu thanh cong'
														END
													END
													-- kiem tra
													
													SELECT *
													FROM   sinhvien
