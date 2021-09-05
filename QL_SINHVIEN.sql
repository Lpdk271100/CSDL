--Tạo CSDL QLSINHVIEN
USE MASTER
GO
IF EXISTS (SELECT*FROM MASTER..SYSDATABASES WHERE NAME = 'QLSINHVIEN')
DROP DATABASE QLSINHVIEN 
GO
CREATE DATABASE QLSINHVIEN
GO
--Sử dụng CSDL QLSINHVIEN
USE QLSINHVIEN
GO
--Cài đặt ngày tháng năm
SET DATEFORMAT DMY

--Tạo các bảng dữ liệu
CREATE TABLE KHOA
(
	MAKH	CHAR(2)		PRIMARY KEY,
	TENKH	NVARCHAR(30)	UNIQUE
)
CREATE TABLE MONHOC
(
	MAMH	CHAR(2)		PRIMARY KEY,
	TENMH	NVARCHAR(25)	UNIQUE,
	SOTIET	INT			CHECK( SOTIET >= 30 ) DEFAULT 30
)
CREATE TABLE SINHVIEN
(
	MASV	CHAR(3)		PRIMARY KEY,
	HOSV		NVARCHAR(15),
	TENSV	NVARCHAR(30),
	PHAI		BIT			DEFAULT 1,
	NGAYSINH	DATETIME,
	NOISINH	NVARCHAR(15),
	MAKH	CHAR(2) FOREIGN KEY(MAKH) REFERENCES KHOA(MAKH),
	HOCBONG	INT		CHECK (HOCBONG >= 0) DEFAULT 0
)
CREATE TABLE KETQUA
(
	MASV	CHAR(3) FOREIGN KEY(MASV) REFERENCES SINHVIEN(MASV),
	MAMH	CHAR(2) FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH),
	DIEM		REAL		CHECK ( DIEM >= 0 AND DIEM <= 10 ),
	CONSTRAINT PK_KETQUA_MASV_MAMH PRIMARY KEY (MASV, MAMH)
)
--Thêm dữ liệu vào các bảng
	--+BẢNG KHOA
		INSERT INTO KHOA VALUES ('AV',N'Anh văn')
		INSERT INTO KHOA VALUES ('LS',N'Lịch sử')
		INSERT INTO KHOA VALUES ('TH',N'Tin học')
		INSERT INTO KHOA VALUES ('TR',N'Triết')
		INSERT INTO KHOA VALUES ('VL',N'Vật lý')
		INSERT INTO KHOA VALUES ('SH',N'Sinh học')
	--+BẢNG MONHOC
		INSERT INTO MONHOC VALUES ('01',N'Nhập môn máy tính',30)
		INSERT INTO MONHOC VALUES ('02',N'Trí tuệ nhân tạo',45)
		INSERT INTO MONHOC VALUES ('03',N'Truyền tin',45)
		INSERT INTO MONHOC VALUES ('04',N'Đồ họa',50)
		INSERT INTO MONHOC VALUES ('05',N'Văn phạm',40)
		INSERT INTO MONHOC VALUES ('06',N'Đàm thoại',30)
		INSERT INTO MONHOC VALUES ('07',N'Vật lý nguyên tử',30)
	--+BẢNG SINHVIEN
		INSERT INTO SINHVIEN VALUES ('A01',N'Nguyễn Thu',N'Hải',0,'23/02/1980',N'TP.HCM','AV',100000)
		INSERT INTO SINHVIEN VALUES ('A02',N'Trần Văn',N'Chính',1,'24/12/1982',N'TP.HCM','TH',100000)
		INSERT INTO SINHVIEN VALUES ('A03',N'Lê Thu Bạch',N'Yến',0,'21/02/1982',N'Hà Nội','AV',140000)
		INSERT INTO SINHVIEN VALUES ('A04',N'Trần Anh',N'Tuấn',1,'08/12/1984',N'Long An','LS',80000)
		INSERT INTO SINHVIEN VALUES ('A05',N'Trần Thanh',N'Triều',1,'01/02/1980',N'Hà Nội','VL',80000)
		INSERT INTO SINHVIEN VALUES ('B01',N'Trần Thanh',N'Mai',0,'20/12/1981',N'Bến Tre','TH',200000)
		INSERT INTO SINHVIEN VALUES ('B02',N'Trần Thị Thu',N'Thủy',0,'13/02/1982',N'TP.HCM','TH',30000)
		INSERT INTO SINHVIEN VALUES ('B03',N'Trần Thị',N'Thanh',0,'31/12/1982',N'TP.HCM','TH',50000)
	--+BẢNG KETQUA
		INSERT INTO KETQUA VALUES ('A01','01',10)
		INSERT INTO KETQUA VALUES ('A01','02',4)
		INSERT INTO KETQUA VALUES ('A01','05',9)
		INSERT INTO KETQUA VALUES ('A01','06',3)
		INSERT INTO KETQUA VALUES ('A02','01',5)
		INSERT INTO KETQUA VALUES ('A03','02',5)
		INSERT INTO KETQUA VALUES ('A03','04',10)
		INSERT INTO KETQUA VALUES ('A03','06',1)
		INSERT INTO KETQUA VALUES ('A04','02',4)
		INSERT INTO KETQUA VALUES ('A04','04',6)
		INSERT INTO KETQUA VALUES ('B01','01',0)
		INSERT INTO KETQUA VALUES ('B01','04',8)
		INSERT INTO KETQUA VALUES ('B02','03',6)
		INSERT INTO KETQUA VALUES ('B02','04',8)
		INSERT INTO KETQUA VALUES ('B03','02',10)
		INSERT INTO KETQUA VALUES ('B03','03',9)

	/*
	SELECT*FROM KHOA
	SELECT*FROM MONHOC
	SELECT*FROM SINHVIEN
	SELECT*FROM KETQUA
	*/
	
/*
1. Xem d/s toàn trường 
*/
	SELECT * FROM SINHVIEN

/*
2. Xem d/s SV toàn trường, thông tin gồm: mã SV, họ tên, mã khoa, học bổng
*/
	SELECT MASV, HOSV, TENSV, MAKH, HOCBONG
	FROM SINHVIEN

/*
3. Cho biết các mã môn học đã thi
*/
	SELECT DISTINCT MAMH
	FROM KETQUA

/*
4. Cho biết thông tin 2 môn học có số tiết nhiều nhất
*/
	SELECT TOP 2 WITH TIES*
	FROM MONHOC
	ORDER BY SOTIET DESC

/*
5. Chọn 50% d/s SV nữ khoa Tin Học
*/
	SELECT TOP 50 PERCENT *
	FROM SINHVIEN
	WHERE PHAI = 0 AND
		  MAKH = 'TH'

/*
6. Hiển thị bảng kết quả thi, bổ sung cột Kết quả là “Thi lại” nếu điểm dưới 5, ngược lại để trống
*/
	ALTER TABLE KETQUA
	ADD THILAI NVARCHAR(10) NULL
	
	UPDATE KETQUA
	SET THILAI = CASE WHEN DIEM < 5 THEN N'Thi lại' ELSE NULL END
	
	SELECT * FROM KETQUA

/*
7. Hiển thị bảng kết quả thi, bổ sung cột Xếp loại như sau:
•0 <= điểm < 5 : Yếu
•5 <= điểm < 7 : TB
•7 <= điểm < 8 : Khá
•8 <= điểm < 9 : Giỏi
•9 <= điểm < =10 : Xuất sắc
*/
	ALTER TABLE KETQUA
	ADD XEPLOAI NVARCHAR(10) NULL

	UPDATE KETQUA

	SET XEPLOAI = (CASE WHEN DIEM < 5 THEN N'Yếu' 
						WHEN DIEM < 7 THEN N'TB' 
						WHEN DIEM < 8 THEN N'Khá' 
						WHEN DIEM < 9 THEN N'Giỏi'ELSE N'Xuất sắc' END)

	SELECT * FROM KETQUA

/*
8. Cho biết d/s SV khoa Anh Văn, gồm các thông tin: Họ tên sinh viên, Mã khoa, Tên khoa, Học bổng
*/
	SELECT HOSV, TENSV, KHOA.MAKH, TENKH, HOCBONG
	FROM SINHVIEN, KHOA
	WHERE 	SINHVIEN.MAKH = KHOA.MAKH AND
			KHOA.MAKH = 'AV'

/*
9. Cho biết d/s SV toàn trường và kết quả thi nếu có, gồm các thông tin: Mã SV, Họ tên sinh viên, Tên môn học, Điểm
*/
	SELECT SINHVIEN.MASV, HOSV, TENSV, TENMH, DIEM
	FROM SINHVIEN, MONHOC, KETQUA
	WHERE	SINHVIEN.MASV = KETQUA.MASV AND
			MONHOC.MAMH = KETQUA.MAMH

--C2:
	SELECT SINHVIEN.MASV, HOSV, TENSV, TENMH, DIEM
	FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV LEFT JOIN MONHOC ON MONHOC.MAMH = KETQUA.MAMH

/*
10. Cho biết d/s môn học và kết quả thi nếu có, gồm các thông tin: Mã môn học, Tên môn học, Mẫ SV, Họ tên sinh viên, Điểm. D/s sắp thứ tự theo Mã môn học
*/
	SELECT MONHOC.MAMH, TENMH, KETQUA.MASV, HOSV, TENSV, DIEM
	FROM MONHOC, KETQUA, SINHVIEN
	WHERE   SINHVIEN.MASV = KETQUA.MASV AND
			MONHOC.MAMH = KETQUA.MAMH
	ORDER BY MAMH

/*
11. Cho biết d/s SV toàn trường và kết quả thi nếu có, d/s môn học và kết quả thi nếu có, gồm các thông tin: Mã SV, Họ tên sinh viên, Tên môn học, Điểm. D/s sắp thứ tự theo Mã sinh viên
*/
	SELECT SINHVIEN.MASV, HOSV, TENSV,TENMH, DIEM
	FROM MONHOC, KETQUA, SINHVIEN
	WHERE   SINHVIEN.MASV = KETQUA.MASV AND
			MONHOC.MAMH = KETQUA.MAMH
	ORDER BY MASV

/*
12. Cho biết d/s sinh viên sinh ở TpHCM, tuổi từ 30 đến 35
*/
	SELECT *
	FROM SINHVIEN
	WHERE NOISINH = 'TP.HCM' AND
		  (YEAR(GETDATE()) - YEAR(NGAYSINH)) BETWEEN 30 AND 35

/*
13. Kết quả học tập của các SV họ Trần, gồm các thông tin: Mã SV, Họ tên sinh viên, Tên môn học, Điểm. D/s sắp thứ tự theo Mã sinh viên
*/
	SELECT DISTINCT SINHVIEN.MASV, HOSV, TENSV, TENMH, DIEM
	FROM KETQUA, SINHVIEN, MONHOC
	WHERE	SINHVIEN.MASV = KETQUA.MASV AND
			MONHOC.MAMH = KETQUA.MAMH AND
			HOSV LIKE N'Trần%'
	ORDER BY MASV

/*
14. Cho biết tổng số sinh viên ở mỗi khoa, gồm các thông tin: Tên khoa, Tổng số sinh viên (liệt kê cả các khoa chưa có sinh viên)
*/
	SELECT TENKH, COUNT(MASV) AS TONG_SV
	FROM KHOA LEFT JOIN SINHVIEN ON KHOA.MAKH = SINHVIEN.MAKH
	GROUP BY TENKH

/*
15. Liệt kê số môn thi của từng sinh viên (kể cả các sinh viên chưa thi), gồm các thông tin: Họ tên sinh viên, Tên khoa, Tổng số môn thi. D/s sắp thứ tự theo Mã sinh viên.
*/
	SELECT DISTINCT SINHVIEN.MASV, HOSV+' '+TENSV AS HO_TENSV , TENKH, COUNT(MAMH) AS TONG_MON_THI
	FROM SINHVIEN FULL JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV LEFT JOIN KHOA ON KHOA.MAKH = SINHVIEN.MAKH
	GROUP BY SINHVIEN.MASV,  HOSV+' '+TENSV, TENKH
	ORDER BY MASV

/*
16.Cho biết điểm cao nhất và thấp nhất của từng môn nếu có, gồm các thông tin: Mã môn học, Tên môn học, điểm cao nhất, điểm thấp nhất
*/
	SELECT MONHOC.MAMH, TENMH, MAX(DIEM) AS DIEM_CAO_NHAT, MIN(DIEM) AS DIEM_THAP_NHAT
	FROM MONHOC, KETQUA
	WHERE MONHOC.MAMH = KETQUA.MAMH
	GROUP BY MONHOC.MAMH, TENMH

/*
17. Cho biết điểm trung bình của từng sinh viên nếu có, gồm các thông tin: Mã SV, Họ tên SV, điểm trung bình (làm tròn 2 số lẻ)
*/
	SELECT SINHVIEN.MASV, HOSV, TENSV, ROUND(AVG(DIEM),2) AS DTB
	FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV
	GROUP BY SINHVIEN.MASV, HOSV, TENSV

/*
18. Cho biết học bổng cao nhất của từng khoa, gồm các thông tin: Mã khoa, Tên khoa, Học bổng cao nhất.
*/
	SELECT KHOA.MAKH, TENKH, MAX(HOCBONG) AS HOCBONG_CAO_NHAT
	FROM KHOA INNER JOIN SINHVIEN ON KHOA.MAKH = SINHVIEN.MAKH
	GROUP BY KHOA.MAKH, TENKH

/*
19. Cho biết khoa nào có đông sinh viên nhất, bao gồm: Mã khoa, Tên khoa, Tổng số sinh viên.
*/
	SELECT KHOA.MAKH, TENKH, COUNT(TENKH) AS TONG_SO_SV
	FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
	GROUP BY KHOA.MAKH, TENKH
	HAVING COUNT(TENKH) >= ALL (SELECT COUNT(MASV)
								FROM SINHVIEN
								GROUP BY MAKH)
	
/*
20. Thống kê sinh viên theo khoa, gồm các thông tin: Mã khoa, Tên khoa, Tổng số sinh viên, Tổng số sinh viên nam, Tổng số sinh viên nữ (kẻ cả những khoa chưa có sinh viên)
*/
	SELECT SINHVIEN.MAKH, TENKH, COUNT(MASV) AS TONG_SV, SUM(CASE WHEN PHAI = 1 THEN 1 ELSE 0 END) AS TONG_SV_NAM, SUM(CASE WHEN PHAI = 0 THEN 1 ELSE 0 END) AS TONG_SV_NU
	FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
	GROUP BY SINHVIEN.MAKH, TENKH

/*
21. Cho biết khoa nào có nhiều sinh viên nữ nhất: gồm các thông tin: Mã khoa, tên khoa, số sv nữ
*/
	SELECT KHOA.MAKH, TENKH, COUNT(TENKH) AS SO_SV_NU
	FROM KHOA, SINHVIEN
	WHERE KHOA.MAKH = SINHVIEN.MAKH AND
		  PHAI = 0
	GROUP BY KHOA.MAKH, TENKH
	HAVING  COUNT(TENKH) >= ALL (SELECT COUNT(MASV) AS SO_SV_NU
								 FROM SINHVIEN
								 WHERE PHAI = 0
								 GROUP BY MAKH)

/*
22. Cho biết trung bình điểm thi của từng môn, chỉ lấy môn nào có trung bình điểm thi lớn hơn 7, thông tin gồm có: Mã môn, Tên môn, Trung bình điểm
*/
	SELECT MONHOC.MAMH, TENMH, AVG(DIEM) AS DTB
	FROM MONHOC, KETQUA
	WHERE MONHOC.MAMH = KETQUA.MAMH
	GROUP BY MONHOC.MAMH, TENMH
	HAVING AVG(DIEM) > 7

/*
23. Cho biết kết quả học tập của sinh viên, gồm các thông tin: Mã sinh viên, Họ tên sinh viên, Tên khoa, Kết quả. Trong đó, Kết quả sẽ là "Đậu" nếu không có môn nào có điểm nhỏ hơn 5, "Rớt" nếu có môn dưới 5, và để trống nếu chưa có kết quả thi. 
*/
	SELECT SINHVIEN.MASV, HOSV+' '+TENSV AS HO_TENSV, MAMH, TENKH, (CASE WHEN DIEM > 5 THEN N'ĐẬU'
																		 WHEN DIEM <= 5  THEN N'RỚT'
																		 ELSE NULL END) AS KETQUA
	FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH FULL JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV

/*
24. Danh sách các sinh viên rớt từ 2 môn trở lên, gồm các thông tin: Mã sinh viên, Họ sinh viên, Tên sinh viên, Mã khoa, Số môn rớt.
*/
		SELECT SINHVIEN.MASV, HOSV+' '+TENSV AS HO_TENSV, MAKH, COUNT(MAMH) AS SO_MON_ROT
		FROM KETQUA INNER JOIN SINHVIEN ON KETQUA.MASV = SINHVIEN.MASV
		GROUP BY SINHVIEN.MASV, HOSV+' '+TENSV, MAKH
		HAVING COUNT(MAMH) >= 2

/*
25. Cho biết sinh viên của khoa Tin học có có học bổng cao nhất, gồm các thông tin: Mã sinh viên, Họ sinh viên, Tên sinh viên, Tên khoa, Học bổng
*/
	SELECT SINHVIEN.MASV, HOSV+' '+TENSV AS HO_TENSV, TENKH, HOCBONG
	FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
	WHERE HOCBONG = (SELECT MAX(HOCBONG)
					 FROM SINHVIEN
					 WHERE MAKH = 'TH')

/*
26. Cho biết d/s SV nữ khoa Anh Văn, sinh sau ngày 5/5/1982 và các sinh viên của khoa Tin học có có học bổng cao nhất.
*/
	(SELECT *
	FROM SINHVIEN
	WHERE PHAI = 0 AND
		MAKH = 'AV' AND
		NGAYSINH > '5/5/1982')
	UNION
	(SELECT *
	FROM SINHVIEN
	WHERE MAKH = 'TH' AND
		 HOCBONG = (SELECT MAX(HOCBONG)
					FROM SINHVIEN
					WHERE MAKH = 'TH'))

/*
27. Liệt kê danh sách sinh viên chưa thi môn nào, thông tin gồm: Mã sinh viên, Họ tên sinh viên, Tên khoa.
*/
	SELECT MASV, HOSV+' '+TENSV AS HO_TENSV, TENKH
	FROM SINHVIEN INNER JOIN KHOA ON KHOA.MAKH = SINHVIEN.MAKH
	WHERE MASV NOT IN (SELECT MASV
						FROM KETQUA)

/*
28. Liệt kê danh sách sinh viên vừa thi môn Nhập Môn Máy Tính, vừa thi môn Đồ Họa.
*/
	SELECT DISTINCT SINHVIEN.MASV, HOSV, TENSV, TENMH, MONHOC.MAMH
	FROM SINHVIEN, MONHOC, KETQUA
	WHERE SINHVIEN.MASV = KETQUA.MASV AND
			MONHOC.MAMH = KETQUA.MAMH AND
			TENMH = N'Nhập môn máy tính' OR TENMH = N'Đồ họa'


	SELECT SINHVIEN.MASV, HOSV, TENSV, TENMH, COUNT(MONHOC.MAMH) AS TONGSOMONTHI
	FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MAMH INNER JOIN MONHOC ON KETQUA.MAMH = MONHOC.MAMH
	WHERE TENMH = N'Nhập môn máy tính' OR TENMH = N'Đồ họa'
	GROUP BY SINHVIEN.MASV, HOSV, TENSV
	HAVING COUNT(MONHOC.MAMH) = 2

/*
29. Thêm vào bảng kết quả gồm các thông tin sau: 
• Mã sinh viên: lấy tất cả những sinh viên của khoa Tinhọc 
• Mã mônhọc:06 
•Điểm7
*/
	INSERT INTO KETQUA
	SELECT MASV, '06', 7
	FROM SINHVIEN
	WHERE MAKH = 'TH'
	
/*
30. Thêm vào bảng kết quả gồm các thông tin sau: 
• Mã sinh viên C02 
• Mã môn học: lấy tất cả những môn học có trong bảng môn học 
•Điểm8
*/
	INSERT INTO KETQUA
	SELECT 'C02', MONHOC.MAMH, 8
	FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV INNER JOIN MONHOC ON KETQUA.MAMH = MONHOC.MAMH
--	The INSERT statement conflicted with the FOREIGN KEY constraint "FK__KETQUA__MASV__44FF419A". The conflict occurred in database "QLSINHVIEN", table "dbo.SINHVIEN", column 'MASV'.
-- Không thể thêm dữ liệu vì điều kiện ràng buộc khóa ngoại

/*
31. Cập nhật số tiết của môn Đồ họa thành 60 tiết.
*/
	UPDATE MONHOC
	SET SOTIET = 60
	WHERE TENMH = N'Đồ họa'

/*
32. Cộng thêm 5 điểm môn Trí Tuệ Nhân Tạo cho các sinh viên thuộc khoa Anh văn. Điểm tối đa của môn là 10 điểm.
*/
	UPDATE KETQUA
	SET DIEM = CASE WHEN DIEM + 5 > 10 THEN 10 ELSE DIEM +5 END
	FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV INNER JOIN MONHOC ON KETQUA.MAMH = MONHOC.MAMH
	WHERE KETQUA.MAMH = 'AV' AND
		  TENMH = N'Trí tuệ nhân tạo'

/*
33. Thay đổi kết quả thi của các sinh viên theo mô tả sau: 
• Nếu sinh viên của khoa Anh văn thì tăng điểm môn Nhập môn máy tính lên 2 điểm. 
• Nếu sinh viên của khoa Tin học thì giảm điểm môn Nhập môn máy tính xuống 1 điểm. 
• Những sinh viên của khoa khác thì không thay đổi kếtquả. 
• Điểm nhỏ nhất là 0 và cao nhất là 10.
*/
	UPDATE KETQUA

	SET DIEM = CASE WHEN MAKH = 'AV' THEN (CASE WHEN DIEM + 2 > 10 THEN 10 ELSE DIEM + 2 END)
					WHEN MAKH = 'TH' THEN (CASE WHEN DIEM - 1 <0 THEN 0 ELSE DIEM - 1 END)
					ELSE DIEM END
	SELECT *
	FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV INNER JOIN MONHOC ON MONHOC.MAMH = KETQUA.MAMH
	WHERE TENMH = N'Nhập môn máy tính'

/*
34. Viết câu truy vấn để tạo bảng có tên DeleteTable, gồm các thông tin sau: Mã sinh viên, Họ tên sinh viên, Phái, Ngày sinh, Nơi sinh, Tên khoa, Học bổng.
*/
	select * into deletetable
	from SINHVIEN

/*
35. Xoá tất cả những sinh viên không có học bổng trong bảng DeleteTable.
*/
	delete deletetable
	from deletetable
	where HOCBONG = 0

/*
36. Xóa tất cả các môn học trong bảng MONHOC chưa có sinh viên nào dự thi.
*/
	DELETE MONHOC
	FROM MONHOC FULL JOIN KETQUA ON MONHOC.MAMH = KETQUA. MAMH
	WHERE MONHOC.MAMH NOT IN (SELECT MAMH FROM KETQUA)

/*
37. Danh sách sinh viên có điểm cao nhất ứng với mỗi môn, gồm các thông tin: Mã sinh viên, Họ tên sinh viên, Tên môn, Điểm 
*/
	SELECT KETQUA.MASV, HOSV+' '+TENSV AS HO_TENSV, TENMH, DIEM
	FROM KETQUA,(SELECT MAMH, MAX(DIEM) AS DIEM_CAO_NHAT
				 FROM KETQUA
				 GROUP BY MAMH) AS A, SINHVIEN, MONHOC
	WHERE KETQUA.MAMH = A.MAMH AND
		  KETQUA.MAMH = MONHOC.MAMH AND
		  SINHVIEN.MASV = KETQUA.MASV AND	
		  DIEM = A.DIEM_CAO_NHAT

/*
38. Danh sách các sinh viên có học bổng cao nhất theo từng khoa, gồm các thông tin: Mã sinh viên, Họ tên sinh viên, Tên khoa, Học bổng
*/
	SELECT DISTINCT SINHVIEN.MASV, HOSV, TENSV, TENKH, HOCBONG
	FROM SINHVIEN,(SELECT SINHVIEN.MAKH, MAX(HOCBONG) AS MAX_HOCBONG
					FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
					GROUP BY SINHVIEN.MAKH) AS T, KHOA
	WHERE T.MAX_HOCBONG = SINHVIEN.HOCBONG AND
		  SINHVIEN.MAKH = KHOA.MAKH
	
/*
39. Danh sách sinh viên thi tất cả các môn. 
*/
	SELECT KETQUA.MASV, HOSV, TENSV, DIEM, COUNT(MAMH) AS SOMONTHI
	FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV
	GROUP BY KETQUA.MASV, HOSV, TENSV, DIEM
	HAVING COUNT(MAMH) = (SELECT COUNT(*) FROM MONHOC)
	 
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
/*
I. Sử dụng cấu trúc điều khiển:
A. Sử dụng cú pháp IF để thực hiện các yêu cầu sau:
1. Cho biết học bổng trung bình của SV khoa Tin Học là bao nhiêu? Nếu lớn hơn 100,000 thì in ra “không tăng học bổng”, ngược lại in ra “nên tăng học bổng”.
*/
	DECLARE @hbtb int
	SELECT @hbtb = AVG(HOCBONG)
	FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
	WHERE TENKH = N'Tin học'

	IF (@hbtb >100000)
		PRINT N'KHÔNG TĂNG HỌC BỔNG'
	ELSE
		PRINT N'NÊN TĂNG HỌC BỔNG'

/*
2. Sử dụng hàm DATENAME để tính xem có SV nào sinh vào ngày chủ nhật không? Nếu có thì in ra danh sách các SV đó, ngược lại thì in ra chuỗi “Không có SV nào sinh vào ngày Chủ Nhật”.
*/
	DECLARE @ds INT
	SELECT @ds = COUNT(MASV)
	FROM SINHVIEN
	WHERE 'Monday' = DATENAME(DW, NGAYSINH)

	IF @ds > 0
		BEGIN
		SELECT * FROM SINHVIEN WHERE 'Monday' = DATENAME(DW, NGAYSINH)
		END
	ELSE
	PRINT N'KHÔNG CÓ SV NÀO SINH VÀO NGÀY CHỦ NHẬT'

	PRINT N'TODAY IS ' + DATENAME(dw, GETDATE())

/*
3. Hãy cho biết SV có mã số A01 đã thi bao nhiêu môn, nếu có thì in ra “SV A01 đã thi xxx môn”, ngược lại thì in ra “SV A01 chưa có kết quả thi”.
*/
	DECLARE @smthi int
	SELECT @smthi = COUNT(*)
	FROM KETQUA
	WHERE MASV = 'A01'

	IF @smthi > 0
		PRINT N'SV A01 ĐÃ THI '+ CAST(@smthi AS VARCHAR(5)) + N' MÔN'
	ELSE
		PRINT N'SV A01 CHƯA CÓ KẾT QUẢ THI'

/*
4. Hãy cho biết SV có mã số A01 đã thi đủ tất cả các môn chưa, nếu có thì in ra “SV A01 đã thi đủ tất cả các môn”, ngược lại thì in ra “SV A01 chưa thi đủ tất cả các môn”.
*/	
	DECLARE @demSoMonThi int, @demSoMonHoc int
	SELECT @demSoMonThi = COUNT(*)
	FROM KETQUA
	WHERE MASV = 'A01'

	SELECT @demSoMonHoc = COUNT(*)
	FROM MONHOC

	IF @demSoMonThi = @demSoMonHoc
		PRINT N'SV A01 ĐÃ THI ĐỦ TẤT CẢ CÁC MÔN'
	ELSE
		PRINT N'SV A01 CHƯA THI ĐỦ TẤT CẢ CÁC MÔN'

/*
5. Hãy cho biết môn Vật lý nguyên tử đã SV thi chưa, nếu có thì in ra “Đã có SV thi môn Vật lý nguyên tử với điểm trung bình là xxx”, ngược lại thì in ra “Chưa có SV thi môn Vật lý nguyên tử”.
*/
	DECLARE @dtb real

	IF NOT EXISTS(SELECT * FROM MONHOC INNER JOIN KETQUA ON MONHOC.MAMH = KETQUA.MAMH WHERE TENMH = N'Vật lý nguyên tử')	
		PRINT N'CHƯA CÓ SV THI MÔN VẬT LÝ NGUYÊN TỬ'
	ELSE
		SELECT @dtb = AVG(DIEM) FROM MONHOC INNER JOIN KETQUA ON MONHOC.MAMH = KETQUA.MAMH WHERE TENMH = N'Vật lý nguyên tử'
		PRINT N'ĐÃ CÓ SV THI MÔN VẬT LÝ NGUYÊN TỬ VỚI ĐIỂM TRUNG BÌNH LÀ '+ CAST(@dtb AS VARCHAR(5))
/*
B. Sử dụng cú pháp CASE để thực hiện các yêu cầu sau:
6. Liệt kê danh sách các SV có bổ sung thêm cột hiển thị thứ trong tuần (bằng tiếng Việt) của ngày sinh
*/
		SELECT MASV, TENSV, 
		CASE WHEN DATENAME(DW,NGAYSINH) = 'Monday' THEN N'Thứ 2'
			 WHEN DATENAME(DW,NGAYSINH) = 'Tuesday' THEN N'Thứ 3'
			 WHEN DATENAME(DW,NGAYSINH) = 'Wednesday' THEN N'Thứ 4'
			 WHEN DATENAME(DW,NGAYSINH) = 'Thursday' THEN N'Thứ 5'
			 WHEN DATENAME(DW,NGAYSINH) = 'Friday' THEN N'Thứ 6'
			 WHEN DATENAME(DW,NGAYSINH) = 'Saturday' THEN N'Thứ 7'
			 WHEN DATENAME(DW,NGAYSINH) = 'Sunday' THEN N'Chủ nhật'
			 ELSE NULL END
		FROM SINHVIEN

/*
C. Sử dụng cú pháp WHILE để thực hiện các yêu cầu sau:
7. Tính tổng các số nguyên từ 1 đến 100
*/
	DECLARE @I INT =1, @TONG INT =0
	WHILE (@I <= 100)
	BEGIN
		SET @TONG = @TONG + @I
		SET @I = @I + 1
	END
	PRINT @TONG
		
/*
8. Tính tổng chẵn và tổng lẻ của các số nguyên từ 1 đến 100
*/
	DECLARE @X INT =1, @TONGCHAN INT =0, @TONGLE INT =0
	WHILE (@X <= 100)
	BEGIN
		IF(@X % 2 = 0)
			SET @TONGCHAN = @TONGCHAN + @X
		ELSE
			SET @TONGLE = @TONGLE + @X
			
		SET @X = @X + 1
	END
	PRINT @TONGCHAN
	PRINT @TONGLE

/*
9. Tạo một bảng tên MONHOC_1 có cấu trúc và dữ liệu dựa vào bảng MONHOC (chỉ lấy hai cột: MAMH, TENMH). Sau đó, sử dụng vòng lặp WHILE viết đoạn chương trình dùng để xóa từng dòng dữ liệu trong bảng MONHOC_1 với điều kiện câu lệnh bên trong vòng lặp khi mỗi lần thực hiện chỉ được phép xóa một dòng dữ liệu trong bảng MONHOC_1. Sau khi xóa một dòng thì thông báo ra màn hình nội dung “Đã xóa môn học ” + Tên môn học
*/
	SELECT MAMH, TENMH INTO MONHOC_1 
	FROM MONHOC

	DECLARE @mamh CHAR(2), @tenmh NVARCHAR(25)
	WHILE EXISTS (SELECT * FROM MONHOC_1)
		BEGIN
			SELECT @mamh = MAMH, @tenmh = TENMH
			FROM MONHOC_1
			DELETE MONHOC_1 WHERE MAMH =@mamh
			PRINT N'ĐÃ XÓA MÔN HỌC '+ @tenmh
		END
	DROP TABLE MONHOC_1
	PRINT N'ĐÃ XÓA BẢNG MONHOC_1'

/*
II. Sử dụng đối tượng Cursor:
10.Duyệt cursor và xử lý hiển thị danh sách các SV gồm các thông tin: mã SV, họ tên SV, mã khoa, và có thêm cột tổng số môn thi.
*/
	DECLARE CUR_SINHVIEN CURSOR
	FOR SELECT MASV, HOSV, TENSV, MAKH FROM SINHVIEN

	OPEN CUR_SINHVIEN

	DECLARE @masv CHAR(3), @hosv NVARCHAR(15), @tensv NVARCHAR(30), @makh CHAR(2), @tongmonthi int
	FETCH NEXT FROM CUR_SINHVIEN  INTO @masv, @hosv, @tensv, @makh 
	WHILE @@FETCH_STATUS =0
	BEGIN
		SELECT @tongmonthi = ISNULL(COUNT(MAMH),0) FROM KETQUA WHERE MASV = @masv
		PRINT @masv+' '+@hosv+' '+@tensv+' '+@makh+' '+CAST(@tongmonthi AS VARCHAR(3))

		FETCH NEXT FROM CUR_SINHVIEN INTO @masv, @hosv, @tensv, @makh
	END

	CLOSE CUR_SINHVIEN
	DEALLOCATE CUR_SINHVIEN

/*
11.Duyệt cursor và xử lý hiển thị danh sách các môn học có thêm cột Ghi chú, biết rằng nếu đã có SV thi thì in ra “Đã có xxx SV thi”, ngược lại thì in ra “Chưa có SV thi”.
*/
	DECLARE CUR_DANHSACH CURSOR
	FOR SELECT MAMH, TENMH, SOTIET FROM MONHOC

	OPEN CUR_DANHSACH
	DECLARE @maMonHoc CHAR(2), @tenMonHoc NVARCHAR(25), @soTiet INT, @dem INT
	FETCH NEXT FROM CUR_DANHSACH INTO @maMonHoc, @tenMonHoc, @soTiet

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @dem = COUNT(MASV)
		FROM KETQUA
		WHERE MAMH = @maMonHoc

		IF @dem > 0
			PRINT @maMonHoc+' '+@tenMonHoc+' '+CAST(@soTiet AS NVARCHAR(2))+N' ĐÃ CÓ '+ CAST(@dem AS NVARCHAR(5))+N' SV THI'
		ELSE
			PRINT @maMonHoc+' '+@tenMonHoc+' '+CAST(@soTiet AS NVARCHAR(2))+N' CHƯA CÓ SV THI'
		FETCH NEXT FROM CUR_DANHSACH INTO @maMonHoc, @tenMonHoc, @soTiet
	END

	CLOSE CUR_DANHSACH 
	DEALLOCATE CUR_DANHSACH 
									/*
									12.Duyệt cursor và xử lý giảm học bổng của các SV theo các qui tắc sau:
									- Không giảm nếu ĐTB >=8.5
									- Giảm 5% nếu 7.5 ≤ ĐTB < 8.5
									- Giảm 10% nếu 7 ≤ ĐTB < 7.5
									*/
	DECLARE CUR_XuLyHocBong CURSOR
	FOR SELECT MASV, TENSV, HOCBONG FROM SINHVIEN

	OPEN CUR_XuLyHocBong 
	DECLARE @mSV CHAR(3), @tSV NVARCHAR(30), @hocbong INT, @diemTB REAL
	FETCH NEXT FROM CUR_XuLyHocBong INTO @mSV, @tSV, @hocbong
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @diemTB = AVG(DIEM) FROM KETQUA WHERE MASV = @mSV

			UPDATE SINHVIEN
			SET @hocbong = HOCBONG - CASE WHEN @diemTB >= 7   THEN (HOCBONG * 10/100)
										  WHEN @diemTB >= 7.5 THEN (HOCBONG * 5/100)
										  WHEN @diemTB >= 8.5 THEN 0 ELSE  NULL END

			PRINT @mSV+', '+@tSV+', '+CAST(@hocbong AS VARCHAR(20))+', ĐTB: '+CAST(ROUND(@diemTB,2) AS VARCHAR(5))
			PRINT N'CẬP NHẬP THÀNH CÔNG'
			
			FETCH NEXT FROM CUR_XuLyHocBong INTO @mSV, @tSV, @hocbong
		END

	CLOSE CUR_XuLyHocBong 
	DEALLOCATE CUR_XuLyHocBong 

	SELECT * FROM SINHVIEN

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
/*
A. Tạo các thủ tục nội tại hiển thị dữ liệu sau:
1. Xây dựng thủ tục liệt kê các cột dữ liệu trong bảng SINHVIEN có thể hiện thêm cột TENKH trong bảng KHOA với tên sp_DSSV_Khoa gồm có 1 tham số vào là Tên Khoa muốn lọc dữ liệu
*/
	GO
	CREATE PROC sp_DSSV_KHOA (@tenkh nvarchar(30))
	AS
	IF NOT EXISTS(SELECT TENKH FROM KHOA WHERE TENKH =@tenkh)
	BEGIN
		PRINT N'TÊN KHOA KHÔNG TỒN TẠI'
		RETURN
	END
	IF(SELECT COUNT(*) FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH WHERE TENKH = @tenkh) >0
		SELECT SINHVIEN.*, TENKH
		FROM SINHVIEN JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
		WHERE TENKH=@tenkh
	ELSE
		PRINT N'KHÔNG CÓ SINH VIÊN THUỘC KHOA'+ @tenkh
	GO

	EXEC sp_DSSV_KHOA N'Tin Học'
	GO

/*
2. Xây dựng thủ tục liệt kê các cột dữ liệu trong hai bảng dữ liệu SINHVIEN và KETQUA có thể hiện thêm một cột TENMH trong bảng MONHOC với tên là sp_KetQuaThi gồm có 1 tham số vào là mã số SV muốn lọc dữ liệu có giá trị mặc định là NULL. Tuy nhiên, nếu lúc gọi thực hiện thủ tục mà không truyền giá trị mã số SV thì thủ tục sẽ liệt kê kết quả thi của tất cả các sinh viên trong bảng SINHVIEN.
*/
	GO
	CREATE PROC sp_KetQuaThi (@masv CHAR(3)= NULL)
	AS
	IF @masv IS NULL
		SELECT SINHVIEN.*, KETQUA.*
		FROM KETQUA INNER JOIN SINHVIEN ON KETQUA.MASV = SINHVIEN.MASV
	ELSE IF NOT EXISTS(SELECT * FROM SINHVIEN WHERE MASV = @masv)
		PRINT N'MÃ SINH VIÊN KHÔNG TỒN TẠI'
	ELSE IF NOT EXISTS (SELECT * FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV WHERE SINHVIEN.MASV = @masv)
		PRINT N'SINH VIÊN CHƯA CÓ KẾT QUẢ THI'
	ELSE
		SELECT SINHVIEN.*, KETQUA.*, TENMH
		FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV INNER JOIN MONHOC ON KETQUA.MAMH = MONHOC.MAMH
		WHERE SINHVIEN.MASV = @masv
	GO

	EXEC sp_KetQuaThi 'A05'
	GO

/*
B. Tạo các thủ tục tính toán sau:
3. Xây dựng thủ tục nội tại tính tổng hai số nguyên với tên sp_TongHaiSo gồm 2 tham số vào là Số 1 và Số 2. Sử dụng câu lệnh PRINT để in kết quả tính được.
*/
	GO
	CREATE PROC sp_TongHaiSo (@so1 int, @so2 int)
	AS
	PRINT N'TỔNG HAI SỐ LÀ: '+CAST(@so1 AS VARCHAR(5))+' + '+CAST(@so2 AS VARCHAR(5))+' = '+CAST((@so1+@so2) AS VARCHAR(5))
	GO
	EXEC sp_TongHaiSo 1,2
	GO

/*
4. Xây dựng thủ tục tên sp_DemSVNu để đếm số lượng các sinh viên nữ.
*/
	CREATE PROC sp_DemSVNu
	AS
	SELECT COUNT(*) AS TONG_SL_SV_NU
	FROM SINHVIEN
	WHERE PHAI = 0
	GO

	EXEC sp_DemSVNu
	GO

	--GO
	--CREATE PROC sp_DemSVTheoGT(@soSVTheoGT INT OUTPUT, @phai BIT)
	--AS
	--SELECT @soSVTheoGT = COUNT(PHAI)
	--FROM SINHVIEN 
	--WHERE PHAI = @phai

	--GO 
	--DECLARE @SoSV INT, @phai BIT = 0
	--EXEC sp_DemSVTheoGT @SoSV OUTPUT, 0
	--PRINT N'CÓ '+ CAST(@SoSV AS VARCHAR(5)) +N' SINH VIÊN '
	--GO

/*
5. Xây dựng thủ tục tên sp_TongHocBongSVKhoaTH để tính tổng học bổng của các sinh viên khoa Tin Học.
*/
	GO
	CREATE PROC sp_TongHocBongSVKhoaTH
	AS
	SELECT SUM(HOCBONG) AS HOC_BONG
	FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
	WHERE TENKH = N'Tin học'
	GO

	EXEC sp_TongHocBongSVKhoaTH
	GO

	--GO
	--CREATE PROC sp_TongHocBongSVKhoa (@tenkh NVARCHAR(30))
	--AS
	--SELECT SUM(HOCBONG)
	--FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKH = KHOA.MAKH
	--WHERE TENKH = @tenkh
	--GO

	--EXEC sp_TongHocBongSVKhoa N'Tin học'
	--GO

/*
6. Xây dựng thủ tục tính điểm trung bình sp_DTB gồm 2 tham số vào là mã môn học và mã khoa
*/
	GO
	CREATE PROC sp_DTB (@maMH CHAR(2), @maKH CHAR(2))
	AS
	SELECT AVG(DIEM)
	FROM KETQUA INNER JOIN SINHVIEN ON KETQUA.MASV = SINHVIEN.MASV
	WHERE MAMH = @maMH AND MAKH = @maKH
	GO

	EXEC sp_DTB '01','TH'
	GO

/*
7. Xây dựng thủ tục tên spud_HienThi_DSSV_TheoKhoa gồm 1 tham số vào là mã khoa. Thủ tục dùng để hiển thị thông tin trong bảng SINHVIEN có lọc theo mã khoa truyền vào và có thêm cột GHI CHÚ biết rằng nếu SV đã có kết quả thi thì in ra “Đã thi xxx môn”, ngược lại nếu chưa có kết quả thi thì in ra “Chưa có kết quả thi”.
*/
	GO
	CREATE PROC spud_HienThi_DSSV_TheoKhoa (@makh CHAR(2))
	AS
	IF NOT EXISTS (SELECT * FROM KHOA WHERE @makh = MAKH)
		PRINT N'MÃ KHOA KHÔNG TỒN TẠI'
	ELSE IF NOT EXISTS (SELECT * FROM SINHVIEN WHERE MAKH = @makh)
		PRINT N'KHOA KHÔNG CÓ SINH VIÊN'
	ELSE
	BEGIN
		DECLARE CUR_HienThi_DSSV_TheoKhoa CURSOR
		FOR SELECT MASV, TENSV, NGAYSINH, MAKH, HOCBONG FROM SINHVIEN WHERE MAKH = @makh
		
		OPEN CUR_HienThi_DSSV_TheoKhoa
		DECLARE @msv CHAR(3), @tensv NVARCHAR(25), @ngsinh DATETIME, @makhoa CHAR(2), @hb INT, @tongmonthi INT
		FETCH NEXT FROM CUR_HienThi_DSSV_TheoKhoa INTO @msv, @tensv, @ngsinh, @makhoa, @hb 

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @tongmonthi = COUNT(*) FROM KETQUA WHERE MASV = @msv

			IF @tongmonthi > 0 
				PRINT @msv+'|'+@tensv+N' NGÀY SINH: '+CONVERT(CHAR(10),@ngsinh,105)+N' THUỘC KHOA '+@makhoa+' '+ CAST(@hb AS VARCHAR(15))+ N' ĐÃ THI '+CAST(@tongmonthi AS VARCHAR(15))+' MÔN'
			ELSE
				PRINT @msv+'|'+@tensv+N' NGÀY SINH: '+CONVERT(CHAR(10),@ngsinh,105)+N' THUỘC KHOA '+@makhoa+' '+ CAST(@hb AS VARCHAR(15))+ N' CHƯA CÓ KẾT QUẢ THI'
			FETCH NEXT FROM CUR_HienThi_DSSV_TheoKhoa INTO @msv, @tensv, @ngsinh, @makhoa, @hb 
		END

		CLOSE CUR_HienThi_DSSV_TheoKhoa
		DEALLOCATE CUR_HienThi_DSSV_TheoKhoa
	END

	EXEC spud_HienThi_DSSV_TheoKhoa 'SH'
	GO

/*
C. Tạo các thủ tục cập nhật dữ liệu sau:
8. Xây dựng thủ tục thêm mới dữ liệu vào bảng MONHOC với tên sp_ThemMonHoc gồm có 3 tham số vào chính là giá trị thêm mới cho các cột trong bảng MONHOC: mã môn học, tên môn học và số tiết. Trong đó, cần kiểm tra các ràng buộc dữ liệu phải hợp lệ
trước khi thực hiện lệnh INSERT INTO để thêm dữ liệu vào bảng MONHOC:
					- Mã môn học phải chưa có trong bảng MONHOC
					- Tên môn học phải duy nhất trong bảng MONHOC
					- Số tiết mặc định là 30
					- Số tiết phải từ 30 trở lên9. Xây dựng thủ tục xóa một môn học trong bảng MONHOC với tên sp_XoaMonHoc gồm 			có 1 tham số vào chính là mã môn học cần xóa. Trong đó cần kiểm tra ràng buộc dữ liệu trước khi thực hiện lệnh DELETE để xóa dữ liệu trong bảng MONHOC:
					- Mã môn học phải chưa có trong bảng KETQUA
*/
	CREATE PROC sp_ThemMonHoc (@mamh CHAR(2), @tenmh NVARCHAR(25), @sotiet int=30)
	AS
		DECLARE @LOI INT =0
		IF EXISTS (SELECT MAMH FROM MONHOC WHERE MAMH = @mamh)
		BEGIN
			PRINT N'VI PHẠM RÀNG BUỘC DỮ LIỆU DUY NHẤT: MÃ MÔN HỌC ĐÃ CÓ => TRÙNG KHÓA CHÍNH'
			SET @LOI = 1
		END
		IF EXISTS (SELECT TENMH FROM MONHOC WHERE TENMH = @tenmh)
		BEGIN
			PRINT N'VI PHẠM RÀNG BUỘC DỮ LIỆU DUY NHẤT: TÊN MÔN HỌC ĐÃ CÓ'
			SET @LOI = 1
		END
		IF @sotiet < 30
		BEGIN
			PRINT N'VI PHẠM RÀNG BUỘC MIỀN GIÁ TRỊ: SỐ TIẾT PHẢI >= 30'
			SET @LOI = 1
		END
		IF @LOI = 1 RETURN
		INSERT INTO MONHOC VALUES(@mamh, @tenmh, @sotiet)
		PRINT N'ĐÃ THÊM MÔN HỌC MỚI THÀNH CÔNG'
	GO

	EXEC sp_ThemMonHoc '08', N'Đồ họa ứng dụng'
	GO

/*
10.Xây dựng thủ tục sửa môn học trong bảng MONHOC với tên sp_SuaMonHoc gồm có tối đa 3 tham số vào chính là giá trị cần thay đổi của các cột trong bảng MONHOC (trừ cột mã môn học): mã môn học, tên môn học và số tiết. Trong thủ tục chỉ thực hiện lệnh UPDATE SET để sửa dữ liệu bảng MONHOC với các giá trị tương ứng.
*/
	CREATE PROC sp_SuaMonHoc (@mamh CHAR(2), @tenmh NVARCHAR(25), @sotiet int =30)
	AS
	IF NOT EXISTS (SELECT MAMH FROM MONHOC WHERE MAMH = @mamh)
	BEGIN
		PRINT N'MÃ MÔN HỌC KHÔNG TỒN TẠI'
		RETURN
	END
	IF EXISTS (SELECT TENMH FROM MONHOC WHERE TENMH = @tenmh)
	BEGIN
		PRINT N'TRÙNG TÊN MÔN HỌC ĐÃ CÓ'
		RETURN
	END
	IF @sotiet < 30
	BEGIN
		PRINT N'SỐ TIẾT PHẢI >= 30'
		RETURN
	END
	UPDATE MONHOC
	SET TENMH = @tenmh, SOTIET = @sotiet
	WHERE MAMH = @mamh
	PRINT N'ĐÃ SỬA DỮ LIỆU THÀNH CÔNG'
	GO

	EXEC sp_SuaMonHoc '07', N'Vật lý nguyên tử', 50
	GO

/*
II. Thủ tục nội tại có giá trị trả về:
11.Xây dựng thủ tục tính số môn thi với tên sp_SoMonThi gồm 1 tham số vào là: mã sinh viên, 1 tham số ra là số môn thi của sinh viên có mã bằng với mã sinh viên truyền vào.
*/
	GO
	CREATE PROC sp_SoMonThi (@masv CHAR(3), @somonthi INT OUTPUT)
	AS
	SELECT @somonthi = COUNT(*)
	FROM KETQUA
	WHERE MASV = @masv
	GO

	DECLARE @MASV CHAR(3)='A01', @somon INT
	EXEC sp_SoMonThi @MASV, @somon OUTPUT
	PRINT @MASV+ N' ĐÃ THI '+ CAST(@somon AS VARCHAR(5))+ N' MÔN'
	GO


/*
12.Xây dựng thủ tục tính số sinh viên với tên sp_SoSinhVien gồm 1 tham số vào là: mã khoa, 1 tham số ra là số lượng sinh viên của khoa có mã khoa bằng với mã khoa truyền vào.
*/
	GO
	CREATE PROC sp_SoSinhVien (@makh CHAR(2), @soluongsv INT OUTPUT)
	AS

	SELECT @soluongsv = COUNT(*)
	FROM SINHVIEN
	WHERE MAKH = @makh
	GO

	DECLARE @MAKH CHAR(2)='TH', @sosv INT
	EXEC sp_SoSinhVien @MAKH, @sosv OUTPUT
	PRINT 'KHOA '+@MAKH+N' CÓ '+CAST(@sosv AS VARCHAR(5))+' SV'
	GO

/*
13.Xây dựng thủ tục tính số điểm trung bình của sinh viên với tên sp_DTB_SV gồm 1 tham số vào là mã sinh viên, 1 tham số ra là điểm trung bình của sinh viên có mã sinh viên bằng với mã sinh viên truyền vào.
*/
	GO
	CREATE PROC sp_DTB_SV (@masv CHAR(3), @dtb REAL OUTPUT)
	AS

	SELECT @dtb = AVG(DIEM)
	FROM KETQUA
	WHERE MASV = @masv
	GO

	DECLARE @MASV CHAR(3) ='A01', @dtb REAL
	EXEC sp_DTB_SV @MASV, @dtb OUTPUT
	PRINT 'SV '+@MASV+' CÓ ĐIỂM TRUNG BÌNH LÀ: '+CAST(@dtb AS VARCHAR(5)) 
	GO

/*
14.Xây dựng thủ tục tính số môn đậu, số môn rớt của sinh viên với tên sp_SoMonDauRot gồm 1 tham số vào là mã sinh viên, 2 tham số ra là số môn đậu, số môn rớt của sinh viên có mã sinh viên bằng với mã sinh viên truyền vào.
*/
	GO
	CREATE PROC sp_SoMonDauRot (@masv CHAR(3), @somondau INT OUTPUT, @somonrot INT OUTPUT)
	AS

	SELECT @somondau = SUM(CASE WHEN DIEM > 5 THEN 1 ELSE 0 END), @somonrot = SUM(CASE WHEN DIEM < 5 THEN 1 ELSE 0 END)
	FROM KETQUA
	WHERE MASV = @masv
	GO

	DECLARE @MASV CHAR(3) = 'A01', @SMDau INT, @SMRot INT
	EXEC sp_SoMonDauRot @MASV, @SMDau OUTPUT, @SMRot OUTPUT
	PRINT 'SV '+@MASV+N' ĐẬU '+CAST(@SMDau AS VARCHAR(5))+N' MÔN VÀ RỚT '+CAST(@SMRot AS VARCHAR(5))+N' MÔN'
	GO
	
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
/*
XÂY DỰNG HÀM (FUNCTIONS) VỚI CSDL QUẢN LÝ SINH VIÊN
I. Hàm trả về một giá trị (hàm đơn trị):
A. Hàm tính toán và không sử dụng dữ liệu trong các bảng:
1. Xây dựng hàm fn_TongHaiSoNguyen(@so1, @so2) trả về tổng của hai số nguyên.
*/
	GO 
	CREATE FUNCTION fn_TongHaiSoNguyen(@so1 INT, @so2 INT)
	RETURNS INT
	AS
	BEGIN
		DECLARE @tong INT=0
		SET @tong = @so1 + @so2
		RETURN (@so1+@so2)
	END
	GO

	PRINT DBO.fn_TongHaiSoNguyen(8,9)

/*
2. Xây dựng hàm fn_TongDaySoNguyen(@n) trả về tổng của các số nguyên từ 1 đến n.
*/

/*
3. Xây dựng hàm fn_SoNT(@n) trả về 1 nếu @n là số nguyên tố, ngược lại thì trả về 0.
*/

/*
4. Xây dựng hàm fn_CacSoNT(@n) trả về chuỗi các số nguyên tố nằm trong khoảng từ 2 đến n.
*/

/*
5. Xây dựng hàm fn_NgayThangVN(@ngay) trả về chuỗi ngày tháng kiểu Việt Nam ddMM-yyyy. 
 Sử dụng hàm fn_NgayThangVN trong mệnh đề group by để hiển thị d/s SV gồm
các thông tin: mã SV, họ tên SV, ngày sinh theo định dạng ngày tháng kiểu Việt
Nam, mã khoa và điểm trung bình.
*/
	GO
	CREATE FUNCTION fn_NgayThangVN(@ngay DATETIME)
	RETURNS CHAR(10)
	AS
	BEGIN
		DECLARE @day CHAR(10)
		IF @ngay IS NULL 
			SET @day = CONVERT(CHAR(10),GETDATE(),105)
		ELSE
			SET @day = CONVERT(CHAR(10),@ngay,105)
		RETURN @day
	END
	GO

	DECLARE @ngay DATETIME
	PRINT DBO.fn_NgayThangVN('23/02/1982')
	GO
-- Sử dụng hàm fn_NgayThangVN trong mệnh đề select để hiển thị d/s SV với cột ngày sinh theo định dạng ngày tháng kiểu Việt Nam.
	SELECT MASV, TENSV, DBO.fn_NgayThangVN(NGAYSINH) AS NGSINH
	FROM SINHVIEN

-- Sử dụng hàm fn_NgayThangVN trong mệnh đề where để lọc d/s SV có ngày sinh theo định dạng ngày tháng kiểu Việt Nam.
	SELECT MASV, HOSV, TENSV, NGAYSINH
	FROM SINHVIEN 
	WHERE DBO.fn_NgayThangVN(NGAYSINH) = '23/02/1982'
	SELECT * FROM SINHVIEN
/*
6. Xây dựng hàm fn_ChuanHoaChuoi(@chuoi) trả về chuỗi đã được cắt bỏ các khoảng
trắng thừa và IN HOA:
 Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề select để hiển thị d/s SV với cột
họ tên đã được chuẩn hóa.
 Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề where để hiển thị thông tin SV có
họ tên là LÊ THU BẠCH YẾN.
 Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề set của câu update để chuẩn hóa
chuỗi 2 cột: HOSV và TENSV trong bảng SINHVIEN.
 Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề values của câu insert để chuẩn
hóa chuỗi 2 cột: HOSV và TENSV khi thêm mới 1 SV vào bảng SINHVIEN.
*/

/*
B. Hàm tính toán và có sử dụng dữ liệu trong các bảng:
7. Xây dựng hàm fn_DTB_MH(@mamh) trả về điểm TB của môn học có mã số truyền vào.
 Xây dựng thủ tục sp_CapNhatMH có sử dụng hàm fn_DTB_MH để cập nhật lại số
tiết trong bảng MONHOC theo các qui tắc sau:
 Tăng 10 tiết nếu ĐTB của SV học dưới 5.
 Tăng 5 tiết nếu ĐTB của SV học từ 5 ≤ ĐTB < 7
 Không tăng số tiết nếu ĐTB của SV học ≥ 7 hoặc không có SV học. Xây dựng thủ tục sp_CapNhatMH_KyTuDau(@kytudau) có sử dụng hàm
fn_DTB_MH để cập nhật lại số tiết trong bảng MONHOC cho các môn học mà tên
có ký tự đầu là “T”.
*/

/*
8. Xây dựng hàm fn_DTB_SV(@masv) trả về điểm TB của sinh viên có mã số truyền vào.
 Xây dựng thủ tục sp_CapNhatHocBong_TheoKhoa(@makh) có sử dụng hàm
fn_DTB_SV để cập nhật lại học bổng cho SV có mã khoa truyền vào theo các qui
tắc sau:
 Không cấp học bổng nếu ĐTB < 7
 Cấp học bổng 500.000đ nếu 7 ≤ ĐTB < 8
 Cấp học bổng 800.000đ nếu 8 ≤ ĐTB < 9
 Cấp học bổng 1.000.000đ nếu 9 ≤ ĐTB ≤ 10.
Nếu không truyền mã khoa thì cập nhật lại học bổng cho SV toàn trường.
*/

/*
9. Xây dựng hàm fn_DanhSachMonThi(@masv) trả về chuỗi danh sách tên các môn thi của SV có mã số truyền vào.
 Xây dựng thủ tục sp_DanhSachMonThiCuaSV có sử dụng hàm
fn_DanhSachMonThi để hiển thị thông tin SV gồm: Mã SV, Họ tên SV, Tên Khoa,
Danh sách tên các môn đã thi.
 Xây dựng thủ tục sp_DanhSachMonThiCuaSVTheoKhoa(@makh) có sử dụng hàm
fn_DanhSachMonThi để hiển thị thông tin SV gồm: Mã SV, Họ tên SV, Danh sách
tên các môn đã thi của các SV có mã khoa truyền vào.
/*

/*
10. Xây dựng hàm fn_KetQuaThi(@masv) trả về chuỗi danh sách tên các môn thi và điểm
thi tương ứng của SV có mã số truyền vào.
 Xây dựng thủ tục sp_KetQuaThiCuaSV có sử dụng hàm fn_KetQuaThi và
fn_DTB_SV để hiển thị thông tin SV gồm: Mã SV, Họ tên SV, Tên Khoa, Kết quả thi
và ĐTB.
 Xây dựng thủ tục sp_KetQuaThiCuaSVTheoKhoa có sử dụng hàm fn_KetQuaThi
và fn_DTB_SV để hiển thị thông tin SV gồm: Mã SV, Họ tên SV, Kết quả thi và ĐTB
của các SV có mã khoa truyền vào.
*/

/*
II. Tạo các thủ tục cập nhật dữ liệu sau:
A. Hàm đọc bảng:
11. Xây dựng hàm fn_DanhSachSinhVien(@makh) trả về danh sách các SV của mã khoa
truyền vào.
*/

/*
12. Xây dựng hàm fn_DanhSachSinhVien_DTB(@makh) trả về danh sách các SV của mã
khoa truyền vào, gồm các thông tin: mã SV, họ tên SV, ĐTB.
*/

/*
13. Xây dựng hàm fn_DanhSachMonHoc(@masv) trả về danh sách gồm các thông tin: mã
môn học, tên môn học và điểm số tương ứng của mã SV truyền vào.
*/

/*
14. Xây dựng hàm fn_DanhSachMonHoc_TheoKhoa(@makh) trả về danh sách các môn
học của SV có mã Khoa truyền vào.
*/

/*
B. Hàm tạo bảng:
15. Xây dựng hàm fn_DSSV_ThiMon(@mamh) để lọc danh sách SV đã thi môn học với mã
môn truyền vào, gồm các thông tin: mã SV, họ tên SV, tên khoa.
*/

/*
16. Xây dựng hàm fn_DSKhoa_ThiMon(@mamh) để lọc danh sách khoa có SV đã thi môn
học với mã môn truyền vào.
*/

/*
17. Xây dựng hàm fn_DSKhoa_ThiMon_Diem(@mamh) để lọc danh sách khoa có SV đã
thi môn học với mã môn truyền vào, gồm các thông tin: mã khoa, tên khoa, điểm thi cao
nhất, điểm thi thấp nhất và ĐTB.
*/

/*
18. Xây dựng hàm fn_LocDSSV_CapNhatHB(@makh) để lọc danh sách SV (gồm các
thông tin: mã SV, họ tên SV, học bổng mới) của mã Khoa truyền vào, có cập nhật lại
học bổng của SV theo các qui tắc sau:
 Không cấp học bổng nếu ĐTB < 7
 Cấp học bổng 500.000đ nếu 7 ≤ ĐTB < 8
 Cấp học bổng 800.000đ nếu 8 ≤ ĐTB < 9
 Cấp học bổng 1.000.000đ nếu 9 ≤ ĐTB ≤ 10
*/

/*
19. Xây dựng hàm fn_LocDSMH_CapNhatSoTiet để lọc danh sách môn học (gồm các
thông tin: mã MH, tên MH, ĐTB thi của SV, số tiết cũ, số tiết mới) với số tiết mới của SV
được tính theo các qui tắc sau:
 Không tăng số tiết nếu không có SV học hoặc ĐTB của SV học dưới 5.
 Tăng 5 tiết nếu ĐTB của SV học từ 5 ≤ ĐTB < 7
 Tăng 10 tiết nếu ĐTB của SV học ≥ 7
*/
