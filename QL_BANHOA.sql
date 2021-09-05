	--Tạo CSDL QLSINHVIEN
	USE MASTER
	GO
	IF EXISTS (SELECT*FROM MASTER..SYSDATABASES WHERE NAME = 'QL_BAN_HOA')
	DROP DATABASE  QL_BAN_HOA
	GO
	CREATE DATABASE QL_BAN_HOA
	GO
	--Sử dụng CSDL QL_BAN_HOA
	USE QL_BAN_HOA
	GO
	--Cài đặt ngày tháng năm
	SET DATEFORMAT YMD

	--Tạo các bảng dữ liệu
	CREATE TABLE CHUDE
	(
		MACD	CHAR(4)			PRIMARY KEY,
		TENCD	NVARCHAR(20)		UNIQUE	
	)

	CREATE TABLE LOAIHOA
	(
		MALH	CHAR(4)			PRIMARY KEY,
		TENLH	NVARCHAR(20)		UNIQUE
	)

	CREATE TABLE HOA
	(
		MAHOA		CHAR(4)		PRIMARY KEY,
		TENHOA		NVARCHAR(50)	UNIQUE,
		YNGHIA		NVARCHAR(50),
		THANHPHAN	NVARCHAR(100),
		DONGIA		MONEY		CHECK(DONGIA > 0),
		HINHMH		VARCHAR(15),
		MACD		CHAR(4),
		MALH		CHAR(4)		
	)
 
	CREATE TABLE DONHANG
	(
		SOHD		CHAR(4)			PRIMARY KEY,
		NGAYDAT		DATETIME		,
		NGAYGIAO	DATETIME		,
		DIADIEM		NVARCHAR(50)	,
		HOKH		NVARCHAR(35)	,
		TENKH		NVARCHAR(15)	,
		GHICHU		NVARCHAR(50)	,
		TINHTRANG	BIT				DEFAULT 0
	)

	CREATE TABLE CT_DONHANG
	(
		SOHD	CHAR(4),
		MAHOA	CHAR(4)	,
		SOLUONG	INT		CHECK ( SOLUONG > 0) DEFAULT 1,
		GIABAN	MONEY	CHECK ( GIABAN > 0),
		PRIMARY KEY (SOHD,MAHOA)
	)

	--Tạo các ràng buộc tham chiếu
	ALTER TABLE	HOA
	ADD CONSTRAINT FK_HOA_MACD FOREIGN KEY (MACD) REFERENCES CHUDE (MACD),
		CONSTRAINT FK_HOA_MALH FOREIGN KEY (MALH) REFERENCES LOAIHOA (MALH)

	ALTER TABLE DONHANG
	ADD CONSTRAINT DF_DONHANG_NGAYDAT DEFAULT GETDATE() FOR NGAYDAT,
		CONSTRAINT DF_DONHANG_NGAYGIAO DEFAULT GETDATE() FOR NGAYGIAO,
		CONSTRAINT CK_DONHANG_NGAYDAT_NGAYGIAO CHECK (NGAYDAT <= NGAYGIAO)

	ALTER TABLE CT_DONHANG
	ADD CONSTRAINT FK_CT_DONHANG_SOHD FOREIGN KEY (SOHD) REFERENCES DONHANG (SOHD),
		CONSTRAINT FK_CT_DONHANG_MAHOA FOREIGN KEY (MAHOA) REFERENCES HOA (MAHOA)

	--Thêm dữ liệu vào các bảng
		--+BẢNG CHUDE
			INSERT INTO CHUDE VALUES ('CD01',N'Sinh nhật')
			INSERT INTO CHUDE VALUES ('CD02',N'Tặng mẹ')
			INSERT INTO CHUDE VALUES ('CD03',N'Tình yêu')
			INSERT INTO CHUDE VALUES ('CD04',N'Chúc mừng')
			INSERT INTO CHUDE VALUES ('CD05',N'Tình bạn')
			INSERT INTO CHUDE VALUES ('CD06',N'Thầy Cô')
		--+BẢNG LOAIHOA
			INSERT INTO LOAIHOA VALUES ('LH01',N'Hoa lan')
			INSERT INTO LOAIHOA VALUES ('LH02',N'Hoa hồng')
			INSERT INTO LOAIHOA VALUES ('LH03',N'Hoa cúc')
			INSERT INTO LOAIHOA VALUES ('LH04',N'Hoa hướng dương')
			INSERT INTO LOAIHOA VALUES ('LH05',N'Hoa sen')
			INSERT INTO LOAIHOA VALUES ('LH06',N'Hoa ly')
			INSERT INTO LOAIHOA VALUES ('LH07',N'Hoa cẩm chướng')
			INSERT INTO LOAIHOA VALUES ('LH08',N'Hoa loa kèn')
			INSERT INTO LOAIHOA VALUES ('LH09',N'Hoa tulip')
			INSERT INTO LOAIHOA VALUES ('LH10',N'Hoa cẩm tú cầu')
			INSERT INTO LOAIHOA VALUES ('LH11',N'Hoa thược dược')
		--+BẢNG HOA
			INSERT INTO HOA VALUES('H001',N'Nắng Sớm',N'Mỗi ngày đều đẹp',N'Hoa hướng dương, lá dương xỉ, baby trắng',450000,'h001.jpg','CD01','LH04')
			INSERT INTO HOA VALUES('H002',N'Nụ Cười',N'Cười mỗi ngày',N'Hoa cẩm chướng, hoa tulip, lá phụ khác',550000,'h002.jpg','CD01','LH07')
			INSERT INTO HOA VALUES('H003',N'Yêu Mẹ',N'Yêu thương đong đầy',N'Hoa sen, hoa ly,lá phụ khác',350000,'h003.jpg','CD02','LH05')
			INSERT INTO HOA VALUES('H004',N'An Yên',N'Bình yên hạnh phúc',N'Hoa cúc, hoa hồng, baby trắng, lá lưỡi cọp',350000,'h004.jpg','CD02','LH03')
			INSERT INTO HOA VALUES('H005',N'Yêu Thương',N'Tình yêu bền vững',N'Hoa hồng, hoa ly, lá dương xỉ',520000,'h005.jpg','CD03','LH02')
			INSERT INTO HOA VALUES('H006',N'Mãi Mãi',N'Tình yêu lâu dài',N'Hoa loa kèn, hoa hồng, lá phụ khác',850000,'h006.jpg','CD03','LH08')
			INSERT INTO HOA VALUES('H007',N'Lộc Phát',N'Mừng khai trương',N'Hoa ly, hoa đồng tiền, lá dương xỉ',950000,'h007.jpg','CD04','LH06')
			INSERT INTO HOA VALUES('H008',N'Ngày Nắng',N'Chúc phát đạt',N'Hoa lan, hoa hồng, baby trắng, có lưới nhện',1000000,'h008.jpg','CD04','LH01')
			INSERT INTO HOA VALUES('H009',N'Tuổi Trẻ',N'Thời thanh xuân',N'Hoa tulip, hoa cúc, lá dương xỉ',670000,'h009.jpg','CD05','LH09')
			INSERT INTO HOA VALUES('H010',N'Lòng Tin',N'Bạn bè bên nhau',N'Hoa cẩm tú cầu, hoa hướng dương',700000,'h010.jpg','CD05','LH10')
			INSERT INTO HOA VALUES('H011',N'Tri Ân',N'Tri ân Thầy Cô',N'Hoa sen, hoa hướng dương, lá phụ khác',500000,'h011.jpg','CD06','LH05')
			INSERT INTO HOA VALUES('H012',N'Người Đưa Đò',N'Thầy Cô là những người đưa đò lặng lẽ',N'Hoa ly, hoa hướng dương, lá phụ khác',400000,'h012.jpg','CD06', 'LH06')
		--+BẢNG DONHANG
			INSERT INTO DONHANG VALUES ('D001','2019/03/05','2019/03/05',N'345/12 Phan Văn Trị, Bình Thạnh, TPHCM',N'Nguyễn Thị',N'Nhi',N'Giao buổi sáng',1)
			INSERT INTO DONHANG VALUES ('D002','2019/04/15','2019/04/20',N'123/45 Lê Quang Định, Bình Thạnh, TPHCM',N'Đặng Ngọc',N'Sơn',N'Giao buổi chiều',1)
			INSERT INTO DONHANG VALUES ('D003','2019/07/01','2019/07/15',N'46/B4 Nguyễn Văn Đậu, Bình Thạnh, TPHCM',N'Phan Văn',N'Đàn',N'Giao từ 9g30 đến 10g',1)
			INSERT INTO DONHANG VALUES ('D004','2019/09/02','2019/09/02',N'227/A Nguyễn Thái Sơn, Gò Vấp, TPHCM',N'Trịnh Văn',N'Lư',N'Giao từ 13g30 đến 15g30',1)
			INSERT INTO DONHANG VALUES ('D005','2019/11/01','2019/11/20',N'81B Nguyễn Hữu Cảnh, Bình Thạnh',N'Hà Thị Thiên',N'Lý',null,0)
			INSERT INTO DONHANG VALUES ('D006','2019/11/08','2019/11/20',N'123 Lê Văn Sỹ, Phú Nhuận',N'Lý Phi',N'Phụng',null,0)
			INSERT INTO DONHANG VALUES ('D007','2019/11/09','2019/11/20',N'68Bis CMT8, Tân Bình',N'Võ Trần Hải',N'Đăng',N'Giao buổi sáng',0)
		--+BẢNG CT_DONHANG
			INSERT INTO CT_DONHANG VALUES('D002','H001',1,450000)
			INSERT INTO CT_DONHANG VALUES('D007','H003',1,350000)
			INSERT INTO CT_DONHANG VALUES('D003','H004',1,350000)
			INSERT INTO CT_DONHANG VALUES('D006','H004',8,350000)
			INSERT INTO CT_DONHANG VALUES('D001','H007',1,920000)
			INSERT INTO CT_DONHANG VALUES('D004','H007',2,930000)
			INSERT INTO CT_DONHANG VALUES('D004','H008',3,980000)
			INSERT INTO CT_DONHANG VALUES('D005','H011',5,520000)
			INSERT INTO CT_DONHANG VALUES('D006','H011',4,520000)
			INSERT INTO CT_DONHANG VALUES('D005','H012',5,420000)
			INSERT INTO CT_DONHANG VALUES('D006','H012',10,400000)

		/*
		SELECT*FROM CHUDE ORDER BY MACD
		SELECT*FROM LOAIHOA ORDER BY MALH
		SELECT*FROM HOA
		SELECT*FROM DONHANG
		SELECT*FROM CT_DONHANG
		*/

/*
1. Xem d/s hoa.
*/
	SELECT * FROM HOA

/*
2. Xem d/s hoa, thông tin gồm: Mã hoa, Tên hoa, Đơn giá.
*/	
	SELECT MAHOA, TENHOA, DONGIA FROM HOA

/*
3. Cho biết d/s các hoa đã bán.
*/
	SELECT * FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA

/*
4. Cho biết thông tin 2 hoa có đơn giá cao nhất.
*/
	SELECT TOP 2 WITH TIES * FROM HOA ORDER BY DONGIA DESC

/*
5. Chọn 50% d/s hoa thuộc chủ đề “Tình yêu” có giá bán từ 500.000đ trở lên.
*/
	SELECT TOP 50 PERCENT *
	FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	WHERE TENCD = N'Tình yêu' AND DONGIA > 500000

/*
6. Hiển thị chi tiết đơn hàng, bổ sung cột Đánh giá là “Tốt” nếu số lượng từ 5 trở lên, ngược lại để trống.
*/
	ALTER TABLE CT_DONHANG
	ADD DANHGIA NVARCHAR(10)

	UPDATE CT_DONHANG
	SET DANHGIA = CASE WHEN SOLUONG >= 5 THEN N'Tốt' ELSE NULL END
	
	SELECT * FROM CT_DONHANG

/*
7. Hiển thị chi tiết đơn hàng, bổ sung cột Xếp loại như sau:
 0 ≤ Số lượng < 3: Bình thường
 3 ≤ Số lượng < 5: Khá
 5 ≤ Số lượng < 10: Tốt
 Số lượng ≥ 10: Đặc biệt
*/

	SELECT *, CASE  WHEN SOLUONG < 3 THEN N'Bình thường'
					WHEN SOLUONG < 5 THEN N'Khá'
					WHEN SOLUONG <10 THEN N'Tốt'
					ELSE N'Đặc biệt' END AS XEPLOAI
	FROM CT_DONHANG

/*
8. Cho biết d/s hoa thuộc loại “Hoa hồng”, gồm các thông tin: Tên hoa, Mã loại hoa, Tên loại hoa, Giá bán.
*/
	SELECT TENHOA, HOA.MALH, TENLH, DONGIA
	FROM HOA INNER JOIN LOAIHOA ON HOA.MALH = LOAIHOA.MALH
	WHERE TENLH = N'Hoa hồng'

/*
9. Cho biết d/s hoa và chi tiết đơn hàng nếu có, gồm các thông tin: Mã hoa, Tên hoa,Số đơn hàng, Tên khách hàng, Số lượng, Giá bán.
*/
	SELECT HOA.MAHOA, TENHOA, DONHANG.SOHD, TENKH, SOLUONG, GIABAN
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA INNER JOIN DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD
	
/*
10.Cho biết d/s đơn hàng và chi tiết nếu có, gồm các thông tin: Số đơn hàng, Họ tênkhách hàng, Mã hoa, Tên hoa, Số lượng và Giá bán. D/s sắp thứ tự theo Số đơn hàng.
*/
	SELECT DONHANG.SOHD, HOKH+' '+TENKH AS HO_TENKH, HOA.MAHOA, TENHOA, SOLUONG, GIABAN
	FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD INNER JOIN HOA ON HOA.MAHOA = CT_DONHANG.MAHOA
	ORDER BY SOHD

/*
11.Chi tiết đơn hàng của các hoa mà trong thành phần có chứa cụm từ “Hoa sen”, gồmcác thông tin: Mã hoa, Tên hoa, Thành phần, Số đơn hàng, Số lượng, Đơn giá. D/ssắp thứ tự theo Mã hoa.
*/
	SELECT HOA.MAHOA, TENHOA, THANHPHAN, SOLUONG, GIABAN, CT_DONHANG.SOHD
	FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD INNER JOIN HOA ON HOA.MAHOA = CT_DONHANG.MAHOA
	WHERE THANHPHAN LIKE N'Hoa sen%'
	ORDER BY MAHOA	

/*
12.Cho biết d/s các hoa có giá bán cao hơn đơn giá, bao gồm: Số đơn hàng, Mã hoa,Tên hoa, Số lượng, Đơn giá, Giá bán.
*/
	SELECT SOHD, HOA.MAHOA, TENHOA, SOLUONG, DONGIA, GIABAN
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	WHERE GIABAN > DONGIA

/*
13.Liệt kê d/s các hoa có giá bán thấp hơn so với đơn giá, gồm các thông tin: Mã hoa, Tênhoa, Đơn giá, Giá bán.
*/
	SELECT HOA.MAHOA, TENHOA, SOLUONG, DONGIA, GIABAN
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	WHERE GIABAN < DONGIA
	
/*
14.Cho biết tổng số hoa của mỗi chủ đề, gồm các thông tin: Mã chủ đề, Tên chủ đề, Tổng số hoa (liệt kê cả các chủ đề chưa có hoa).
*/
	SELECT HOA.MACD, TENCD, COUNT(MAHOA) AS TONG_SO_HOA
	FROM HOA FULL JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	GROUP BY HOA.MACD, TENCD

/*
15.Liệt kê tổng số lượng của từng đơn hàng gồm các thông tin: Số đơn hàng, Tổng số lượng đặt. D/s sắp thứ tự theo Tổng số lượng đặt giảm dần.
*/
	SELECT DISTINCT SOHD ,COUNT(SOHD) AS TONG_SOLUONG_DATHANG
	FROM CT_DONHANG
	GROUP BY SOHD
	ORDER BY TONG_SOLUONG_DATHANG DESC
	
/*
16.Cho biết giá bán cao nhất và thấp nhất của từng hoa nếu có, gồm các thông tin: Mã hoa, Tên hoa, Giá bán cao nhất, Giá bán thấp nhất.
*/
	SELECT HOA.MAHOA, TENHOA, MAX(GIABAN) AS GIA_BAN_CAO_NHAT, MIN(GIABAN) AS GIA_BAN_THAP_NHAT
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	GROUP BY HOA.MAHOA, TENHOA

/*
17.Cho biết giá bán trung bình của từng hoa nếu có, gồm các thông tin: Mã hoa, Tên hoa, Giá bán trung bình.
*/
	SELECT HOA.MAHOA, TENHOA, AVG(GIABAN) AS GIA_BAN_TB
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	GROUP BY HOA.MAHOA, TENHOA

/*
18.Cho biết đơn giá cao nhất của từng chủ đề, gồm các thông tin: Mã chủ đề, Tên chủ đề, Đơn giá cao nhất.
*/
	SELECT CHUDE.MACD, TENCD, MAX(DONGIA) AS DON_GIA_CAO_NHAT
	FROM CHUDE INNER JOIN HOA ON CHUDE.MACD = HOA.MACD
	GROUP BY CHUDE.MACD, TENCD

/*
19.Cho biết loại hoa nào có nhiều hoa nhất, bao gồm: Mã loại, Tên loại, Tổng số hoa.
*/
	SELECT HOA.MALH, TENLH, COUNT(TENHOA) AS TONG_SO_HOA
	FROM HOA INNER JOIN LOAIHOA ON HOA.MALH = LOAIHOA.MALH
	GROUP BY HOA.MALH, TENLH
	HAVING COUNT(TENHOA) >= ALL(SELECT COUNT(MAHOA)
							    FROM HOA
							    GROUP BY MALH)

/*
20.Thống kê hoa theo loại hoa, gồm các thông tin: Mã loại, Tên loại, Tổng số hoa, Tổng số hoa có giá bán từ 500.000đ trở lên, Tổng số hoa có giá bán dưới 500.000đ (kể cả những loại chưa có hoa).
*/	
	SELECT LOAIHOA.MALH, TENLH, COUNT(HOA.MAHOA) AS TONG_SO_HOA, SUM(CASE WHEN GIABAN >= 500000 THEN 1 ELSE 0 END) AS HOA_GIA_TREN_500Đ, SUM(CASE WHEN GIABAN < 500000 THEN 1 ELSE 0 END) AS HOA_GIA_DUOI_500Đ 
	FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA RIGHT JOIN LOAIHOA ON LOAIHOA.MALH = HOA.MALH
	GROUP BY LOAIHOA.MALH, TENLH

/*
21.Cho biết giá bán trung bình của từng chủ đề, chỉ lấy chủ đề nào có giá bán trung bình từ 500.000đ đến 1.000.000đ, thông tin gồm có: Mã chủ đề, Tên chủ đề, Giá bán trung bình.
*/
	SELECT CHUDE.MACD, TENCD, AVG(GIABAN) AS GIA_TB 
	FROM CHUDE INNER JOIN HOA ON CHUDE.MACD = HOA.MACD INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	GROUP BY CHUDE.MACD, TENCD
	HAVING AVG(GIABAN) BETWEEN 500000 AND 1000000

/*
22.Cho biết chi tiết đơn hàng, gồm các thông tin: Số đơn hàng, Tổng số lượng đặt, Đánhgiá. Trong đó, Đánh giá sẽ là "Cao" nếu Tổng số lượng đặt từ 5 trở lên, ngược lại thì để trống.
*/
	ALTER TABLE CT_DONHANG ADD DANHGIA NVARCHAR(5)

	SELECT SOHD, SUM(SOLUONG) AS TONG_SOLUONG, DANHGIA = CASE WHEN SUM(SOLUONG) >= 5 THEN N'Cao' ELSE NULL END
	FROM CT_DONHANG
	GROUP BY SOHD

/*
23.Cho biết hoa thuộc chủ đề “Thầy Cô” có đơn giá thấp nhất, gồm các thông tin: Mã hoa, Tên hoa, Tên chủ đề, Đơn giá.
*/
	SELECT MAHOA, TENHOA, TENCD, MIN(DONGIA) AS DON_GIA_THAP_NHAT
	FROM CHUDE INNER JOIN HOA ON CHUDE.MACD = HOA.MACD
	WHERE DONGIA = (SELECT MIN(DONGIA)
					FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
					WHERE TENCD = N'Thầy Cô')
	GROUP BY MAHOA, TENHOA, TENCD

/*
24.Cho biết d/s hoa thuộc loại “Hoa hướng dương”, bán sau ngày 20/10/2017 và d/s hoa thuộc chủ đề “Chúc mừng” có đơn giá cao nhất.
*/
	SET DATEFORMAT DMY
	
	(SELECT HOA.*
	FROM LOAIHOA, HOA, CT_DONHANG, DONHANG 
	WHERE LOAIHOA.MALH = HOA.MALH AND
		  HOA.MAHOA = CT_DONHANG.MAHOA AND
		  CT_DONHANG.SOHD = DONHANG.SOHD AND
		  TENLH = N'Hoa hướng dương' AND
		  NGAYDAT > '20/10/2019')
	UNION
	(SELECT HOA.*
	FROM CHUDE INNER JOIN HOA ON CHUDE.MACD = HOA.MACD
	WHERE DONGIA = (SELECT MAX(DONGIA)
					FROM  CHUDE INNER JOIN HOA ON CHUDE.MACD = HOA.MACD
					WHERE TENCD = N'Chúc Mừng'))

/*
25.Liệt kê d/s hoa chưa có đơn đặt hàng, thông tin gồm: Mã hoa, Tên hoa, Tên chủ đề,Tên loại hoa.
*/
	SELECT HOA.MAHOA, TENHOA, TENCD, TENLH
	FROM HOA FULL JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA, CHUDE, LOAIHOA
	WHERE HOA.MACD = CHUDE.MACD AND
		  HOA.MALH = LOAIHOA.MALH AND
		  HOA.MAHOA NOT IN (SELECT MAHOA FROM CT_DONHANG) 
--C2:
	SELECT HOA.MAHOA, TENHOA, TENCD, TENLH
	FROM HOA FULL JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA LEFT JOIN CHUDE ON CHUDE.MACD = HOA.MACD LEFT JOIN LOAIHOA ON HOA.MALH = LOAIHOA.MALH
	WHERE HOA.MAHOA NOT IN (SELECT MAHOA FROM CT_DONHANG) 

/*
26.Liệt kê d/s hoa chưa được giao hàng, bao gồm: Mã hoa, Tên hoa, Số đơn hàng, Ngày đặt, Ngày giao, Tên khách hàng và Tình trạng.
*/
	SELECT HOA.MAHOA, TENHOA, SOLUONG, NGAYDAT, NGAYGIAO, TENKH, TINHTRANG
	FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD INNER JOIN HOA ON HOA.MAHOA = CT_DONHANG.MAHOA
	WHERE TINHTRANG = 0

/*
27.Liệt kê d/s các đơn đặt hàng chưa giao gồm: Số đơn hàng, Ngày đặt, Ngày giao, Họ tên khách hàng, Địa chỉ giao hàng, bổ sung cột “Tổng trị giá” với trị giá từng hoa tính bằng Số lượng x Giá bán.
*/
	SELECT T.SOHD, NGAYDAT, NGAYGIAO, HOKH+' '+ TENKH AS HO_TENKH, DIADIEM, TONG_TRI_GIA
	FROM DONHANG INNER JOIN (SELECT SOHD, SUM(SOLUONG* GIABAN) AS TONG_TRI_GIA
							 FROM CT_DONHANG
							 GROUP BY SOHD) AS T ON DONHANG.SOHD = T.SOHD

/*
28.Cho biết thông tin chi tiết các đơn hàng sẽ giao trong hôm nay, bao gồm: Số đơn hàng, Mã hoa, Tên hoa, Số lượng, Đơn giá, Ngày đặt, Ngày giao.
*/
	SELECT DONHANG.SOHD, HOA.MAHOA, TENHOA, SOLUONG, DONGIA, NGAYDAT, NGAYGIAO
	FROM CT_DONHANG INNER JOIN DONHANG ON CT_DONHANG.SOHD = DONHANG.SOHD INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
	WHERE NGAYGIAO = GETDATE()

/*
29. Cho biết d/s các đơn hàng sẽ giao trong vòng 1 tuần kể từ hôm nay.
*/
	SELECT	* FROM DONHANG WHERE NGAYGIAO between getdate() and getdate()+7

--C2:
	SELECT * FROM DONHANG WHERE NGAYGIAO >= getdate() and NGAYGIAO <= getdate()+7

/*
30.Thêm vào bảng Đơn hàng:
	 Số đơn hàng: D008
	 Ngày đặt: hôm nay
	 Ngày giao: 3 ngày sau
	 Địa điểm: Khoa CNTT – ĐH. NTT
	 Họ tên khách hàng: Nguyễn Thị Hoàn Sinh

	 Ghi chú: Giao giờ hành chính
	 Tình trạng: chưa giao
*/
	INSERT INTO DONHANG
	VALUES ('D008', '2019/07/29', '2019/08/01', N'KHOA CNTT - ĐH.NTT', N'Nguyễn Thị Hoàn', N'Sinh', N'Giao giờ hành chính', 0)

	SELECT*FROM DONHANG

/*
31.Thêm vào bảng chi tiết đơn hàng gồm các thông tin sau:
 Mã hoa: lấy tất cả những hoa thuộc chủ đề “Tình bạn”.
 Mã đơn hàng: D008
 Số lượng: 5
 Giá bán: 75% Đơn giá.
*/
	INSERT INTO CT_DONHANG(SOHD, MAHOA, SOLUONG,GIABAN)
	SELECT 'D008', HOA.MAHOA,5,(5*DONGIA*75/100)
	FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	WHERE TENCD = N'Tình bạn'

	SELECT * FROM CT_DONHANG

/*
32.Cập nhật Ngày giao của đơn hàng D008 là hôm nay và Tình trạng là “Đã giao”.
*/
	UPDATE DONHANG
	SET NGAYGIAO = GETDATE(), TINHTRANG = 1
	WHERE SOHD = 'D008'

/*
33.Tăng 5% Giá bán cho các hoa đã đặt trong ngày 20/11/2017. Giá bán tối đa là 500.000đ.
*/
	UPDATE CT_DONHANG
	SET GIABAN = CASE WHEN NGAYDAT = '2019/11/20' THEN (CASE WHEN GIABAN +5/100 >= 500000 THEN 500000 ELSE GIABAN + 5/100 END)
					  ELSE GIABAN END
	FROM CT_DONHANG INNER JOIN DONHANG ON CT_DONHANG.SOHD = DONHANG.SOHD

/*
34.Thay đổi chi tiết đơn hàng theo mô tả sau:
		 Nếu hoa thuộc chủ đề “Tình yêu” thì tăng giá bán 100.000đ.
		 Nếu hoa thuộc loại “Hoa cúc” thì giảm giá bán 50.000đ.
		 Những hoa khác thì không thay đổi giá bán.
		 Giá bán thấp nhất là 300.000đ và cao nhất là 900.000đ.
*/
	UPDATE CT_DONHANG
	SET GIABAN = CASE WHEN TENCD = N'Tình yêu' THEN (CASE WHEN GIABAN + 100000 > 900000 THEN 900000 ELSE GIABAN + 100000 END)
					  WHEN TENCD =N'Hoa cúc' THEN (CASE WHEN GIABAN - 50000 < 300000 THEN 300000 ELSE GIABAN - 50000 END)
					  ELSE GIABAN END
	FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD

/*
35.Xóa đơn hàng D008.
*/
	IF EXISTS (SELECT * FROM CT_DONHANG WHERE SOHD = 'D008')
	BEGIN
		DELETE CT_DONHANG WHERE SOHD = 'D008'
		DELETE DONHANG WHERE SOHD = 'D008'
	END

/*
36.Tạo lại đơn hàng D008 và thêm vào bảng chi tiết đơn hàng này các thông tin sau:
 Mã hoa: lấy tất cả các mã hoa.
 Mã đơn hàng: D008
 Số lượng: 1
 Giá bán: 50% Đơn giá.
*/
	INSERT INTO DONHANG(SOHD) VALUES ('D008')	
	INSERT INTO CT_DONHANG (MAHOA, SOHD, SOLUONG, GIABAN)
	SELECT MAHOA, 'D008', 1, (1* DONGIA * 50/100)
	FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	WHERE CHUDE.TENCD = N'Tình bạn'

	SELECT * FROM CT_DONHANG

/*
37.Viết câu truy vấn để tạo bảng có tên DeleteTable có cấu trúc và dữ liệu mẫu lấy từ bảng HOA.
*/
	SELECT * INTO DELETETABLE FROM HOA

/*
38.Xoá tất cả những hoa mà thành phần có chứa cụm từ “lá dương xỉ” trong bảng DeleteTable.
*/
	DELETE DELETETABLE FROM DELETETABLE WHERE THANHPHAN LIKE N'%lá dương xỉ%'

/*
39.Xóa tất cả các chủ đề chưa có hoa.
*/
	DELETE CHUDE
	FROM CHUDE FULL JOIN HOA ON CHUDE.MACD = HOA.MACD
	WHERE CHUDE.MACD NOT IN (SELECT MACD FROM HOA)

/*
40.D/s các hoa có giá bán cao nhất theo từng chủ đề, gồm các thông tin: Mã hoa, Tên hoa, Tên chủ đề, Giá bán.
*/
	SELECT T.MAHOA, TENHOA, TENCD, GIA_BAN_CAO_NHAT
	FROM HOA, ( SELECT CT_DONHANG.MAHOA, MAX(GIABAN) AS GIA_BAN_CAO_NHAT
				FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
				GROUP BY CT_DONHANG.MAHOA) AS T, CHUDE
	WHERE HOA.MAHOA = T.MAHOA AND
		  HOA.MACD = CHUDE.MACD

/*
41.D/s các hoa có đơn giá thấp nhất theo từng loại hoa, gồm các thông tin: Mã hoa, Tên hoa, Tên loại, Đơn giá.
*/
	SELECT DISTINCT T.MALH, TENHOA, DON_GIA_THAP_NHAT 
	FROM HOA RIGHT JOIN (SELECT HOA.MALH, MIN(DONGIA) AS DON_GIA_THAP_NHAT
						 FROM HOA INNER JOIN LOAIHOA ON HOA.MALH = LOAIHOA.MALH
						 GROUP BY HOA.MALH) AS T ON T.MALH = HOA.MALH
	WHERE DONGIA = DON_GIA_THAP_NHAT

/*
42.D/s các hoa mà tất cả các đơn hàng đều đặt.
*/
	SELECT * FROM HOA
	WHERE HOA.MAHOA IN (SELECT DISTINCT MAHOA
					   FROM CT_DONHANG INNER JOIN DONHANG ON CT_DONHANG.SOHD = DONHANG.SOHD)

/*
43.D/s các đơn hàng mà đặt tất cả các hoa.
*/
	SELECT SOHD FROM CT_DONHANG GROUP BY SOHD
	HAVING COUNT(DISTINCT MAHOA) = (SELECT COUNT(MAHOA) FROM HOA)

----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
/*
I. Sử dụng cấu trúc điều khiển:
A. Sử dụng cú pháp IF để thực hiện các yêu cầu sau:
1. Cho biết đơn giá cao nhất của hoa thuộc chủ đề “Thầy Cô” là bao nhiêu? Nếu lớn hơn 1.000.000đ thì in ra “không tăng giá”, ngược lại in ra “nên tăng giá”.
*/
	DECLARE @DGMAX MONEY
	SELECT @DGMAX = MAX(DONGIA)
	FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	WHERE TENCD = N'Thầy Cô'
	PRINT N'Đơn giá cao nhất của hoa thuộc chủ đề "Thầy Cô" là:  '+ FORMAT(@DGMAX, '#,### VNĐ')

	IF @DGMAX > 1000000
		PRINT N'Không tăng giá'
	ELSE
		PRINT N'Nên tăng giá'

/*
2. Sử dụng hàm DATENAME để xem có đơn hàng nào giao vào Thứ Bảy hoặc Chủ Nhật không? Nếu có thì in ra danh sách các đơn hàng đó, ngược lại thì in ra chuỗi “Không có đơn hàng giao vào Thứ Bảy hoặc Chủ Nhật”.
*/	
	IF EXISTS (SELECT * FROM DONHANG WHERE DATENAME(DW, NGAYGIAO) IN ('Saturday', 'Sunday'))
		SELECT * FROM DONHANG
		WHERE DATENAME(DW, NGAYGIAO) IN ('Saturday', 'Sunday')
	ELSE
		PRINT N'Không có đơn hàng giao vào Thứ Bảy hoặc Chủ Nhật'
	
/*
3. Hãy cho biết hoa có mã số H004 đã có bao nhiêu đơn đặt hàng, nếu có thì in ra “Hoa H004 đã có xxx đơn đặt hàng”, ngược lại thì in ra “Hoa H004 chưa có đơn đặt hàng”.
*/	
	DECLARE @DH INT
	SELECT @DH = COUNT(SOHD) 
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA 
	WHERE HOA.MAHOA = 'H004' 
	
	IF @DH> 0		
		PRINT N'Hoa H004 đã có '+ CAST(@DH AS VARCHAR(5)) +' đơn đặt hàng'
	ELSE 
		PRINT N'Hoa H004 chưa có đơn đặt hàng'

/*
4. Hãy cho biết tất cả các đơn hàng giao vào ngày 20/11/2017 đều có hoa “Tri Ân Thầy Cô” phải không, nếu đúng thì in ra “Tất cả các đơn hàng giao vào ngày 20/11/2017 đều có hoa “Tri Ân Thầy Cô”, ngược lại thì in ra “Không phải tất cả các đơn hàng giao vào ngày 20/11/2017 đều có hoa “Tri Ân Thầy Cô”.
*/
	DECLARE @sodh int, @tongsodh int
	SELECT @sodh = COUNT(DONHANG.SOHD)
	FROM DONHANG JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
	WHERE NGAYGIAO = '2019/11/20' AND
		  YNGHIA =N'Tri ân Thầy Cô'
		   
	SELECT  @tongsodh = COUNT(CT_DONHANG.SOHD)
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA INNER JOIN DONHANG ON CT_DONHANG.SOHD = DONHANG.SOHD
	WHERE NGAYGIAO = '2019/11/20'

	IF(@sodh <> @tongsodh)
		PRINT N'Không phải tất cả các đơn hàng giao vào ngày 20/11/2017 đều có hoa “Tri Ân Thầy Cô”'
	ELSE
		PRINT N'Tất cả các đơn hàng giao vào ngày 20/11/2017 đều có hoa “Tri Ân Thầy Cô”'

/*
5. Hãy cho biết hoa “Nụ Cười” đã đơn hàng nào đặt chưa, nếu có thì in ra “Đã có đơn hàng đặt hoa “Nụ Cười” với giá bán trung bình là xxx”, ngược lại thì in ra “Chưa có đơn hàng đặt hoa “Nụ Cười”.
*/
	DECLARE @gbTB MONEY
	SELECT @gbTB = AVG(GIABAN) FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA WHERE TENHOA = N'Nụ Cười'
	IF EXISTS (SELECT * FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA WHERE TENHOA = N'Nụ Cười')
		PRINT N'Đã có đơn hàng đặt hoa “Nụ Cười” với giá bán trung bình là '+ CAST(@gbTB AS VARCHAR(30))
	ELSE 
		PRINT N'Chưa có đơn hàng đặt hoa “Nụ Cười”'

/*
B. Sử dụng cú pháp CASE để thực hiện các yêu cầu sau:
6. Liệt kê danh sách các đơn hàng có bổ sung thêm cột hiển thị thứ trong tuần (bằng tiếng Việt) của ngày đặt và ngày giao.
*/
	SELECT SOHD,
	CASE WHEN DATENAME(DW,NGAYDAT) = 'Monday' THEN N'Thứ 2'
		 WHEN DATENAME(DW,NGAYDAT) = 'Tuesday' THEN N'Thứ 3'
		 WHEN DATENAME(DW,NGAYDAT) = 'Wednesday' THEN N'Thứ 4'
		 WHEN DATENAME(DW,NGAYDAT) = 'Thursday' THEN N'Thứ 5'
		 WHEN DATENAME(DW,NGAYDAT) = 'Friday' THEN N'Thứ 6'
		 WHEN DATENAME(DW,NGAYDAT) = 'Saturday' THEN N'Thứ 7'
		 WHEN DATENAME(DW,NGAYDAT) = 'Sunday' THEN N'Chủ nhật'
		 ELSE NULL END,
	CASE WHEN DATENAME(DW,NGAYGIAO) = 'Monday' THEN N'Thứ 2'
		 WHEN DATENAME(DW,NGAYGIAO) = 'Tuesday' THEN N'Thứ 3'
		 WHEN DATENAME(DW,NGAYGIAO) = 'Wednesday' THEN N'Thứ 4'
		 WHEN DATENAME(DW,NGAYGIAO) = 'Thursday' THEN N'Thứ 5'
		 WHEN DATENAME(DW,NGAYGIAO) = 'Friday' THEN N'Thứ 6'
		 WHEN DATENAME(DW,NGAYGIAO) = 'Saturday' THEN N'Thứ 7'
		 WHEN DATENAME(DW,NGAYGIAO) = 'Sunday' THEN N'Chủ nhật'
		 ELSE NULL END
	FROM DONHANG

/*
C. Sử dụng cú pháp WHILE để thực hiện các yêu cầu sau:
7. Tạo một bảng tên CHUDE_1 có cấu trúc và dữ liệu dựa vào bảng CHUDE.
	Sau đó, sử dụng vòng lặp WHILE viết đoạn chương trình dùng để xóa từng dòng dữ liệu trong bảng CHUDE_1 với điều kiện câu lệnh bên trong vòng lặp khi mỗi lần thực hiện chỉ được phép xóa một dòng dữ liệu trong bảng CHUDE_1.
		Sau khi xóa một dòng thì thông báo  ra màn hình nội dung “Đã xóa chủ đề hoa ” + Tên chủ đề.
*/
	SELECT * INTO CHUDE_1
	FROM CHUDE

	DECLARE @macd char(4), @tencd nvarchar(20) 
	WHILE EXISTS(SELECT * FROM CHUDE_1)
		BEGIN
			SELECT @macd = MACD, @tencd = TENCD
			FROM CHUDE_1
			DELETE CHUDE_1 WHERE MACD = @macd
			PRINT N'Đã xóa chủ đề '+ @tencd
		END
		DROP TABLE CHUDE_1
	PRINT N'ĐÃ XÓA BẢNG CHU_DE_1'

/*
II. Sử dụng đối tượng Cursor:
8. Duyệt cursor và xử lý hiển thị danh sách các hoa gồm các thông tin: mã hoa, tên hoa, mã chủ đề, và có thêm cột tổng số đơn hàng.
*/
	DECLARE CURSOR_DANHSACH CURSOR
	FOR SELECT CT_DONHANG.MAHOA, TENHOA, MACD
		FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA

	OPEN CURSOR_DANHSACH

	DECLARE @mh CHAR(4), @tenhoa NVARCHAR(50), @mcd CHAR(4), @tongdh INT
	FETCH NEXT FROM CURSOR_DANHSACH INTO @mh, @tenhoa, @mcd

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @tongdh = ISNULL(COUNT(CT_DONHANG.MAHOA),0)
			FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
			WHERE CT_DONHANG.MAHOA = @mh

			PRINT N'MÃ HOA: '+ @mh+', '+@tenhoa+', '+N'CHỦ ĐỀ: '+@mcd+', '+N'TỔNG SỐ ĐƠN HÀNG ' + CAST(@tongdh AS VARCHAR(3))
			FETCH NEXT FROM CURSOR_DANHSACH INTO @mh, @tenhoa, @mcd
		END

	CLOSE CURSOR_DANHSACH
	DEALLOCATE CURSOR_DANHSACH

/*
9. Duyệt cursor và xử lý hiển thị danh sách các hoa có thêm cột Ghi chú, biết rằng nếu đã có đơn đặt hàng thi thì in ra “Đã có xxx đơn đặt hàng” ngược lại thì in ra “Chưa có đơn đặt hàng”.
*/
	DECLARE CURSOR_HienThiDanhSach CURSOR

	FOR SELECT HOA.MAHOA, TENHOA, MACD, MALH
		FROM CT_DONHANG FULL JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
	
	OPEN CURSOR_HienThiDanhSach 
	DECLARE @mahoa CHAR(4), @thoa NVARCHAR(50), @machude CHAR(4), @maloaihoa CHAR(4), @sohoadon INT
	FETCH NEXT FROM CURSOR_HienThiDanhSach INTO @mahoa, @thoa, @machude, @maloaihoa
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @sohoadon = COUNT(CT_DONHANG.SOHD)
			FROM CT_DONHANG
			WHERE MAHOA = @mahoa
			IF @sohoadon > 0
				PRINT @mahoa+' '+@thoa+' '+@machude+' '+@maloaihoa+' '+N' ĐÃ CÓ '+ CAST(@sohoadon AS NVARCHAR(5))+N' ĐƠN ĐẶT HÀNG'
			ELSE
				PRINT @mahoa+' '+@thoa+' '+@machude+' '+@maloaihoa+' '+N' CHƯA CÓ ĐƠN ĐẶT HÀNG'
			FETCH NEXT FROM CURSOR_HienThiDanhSach INTO @mahoa, @thoa, @machude, @maloaihoa
		END
	CLOSE CURSOR_HienThiDanhSach 
	DEALLOCATE CURSOR_HienThiDanhSach 

/*
10.Duyệt cursor và xử lý giảm đơn giá của các hoa theo các qui tắc sau:
		- Tăng 5% nếu có 10 đơn đặt hàng trở lên.
		- Giảm 5% nếu không có đơn hàng đặt hàng.
		- Giữ nguyên đơn giá cho các trường hợp khác.
*/
	DECLARE CUR_XuLyDonGia CURSOR
	FOR SELECT MAHOA, TENHOA, DONGIA FROM HOA
	
	OPEN CUR_XuLyDonGia 
	DECLARE @mah CHAR(4), @tenh NVARCHAR(50), @donG MONEY , @tongsohd INT
	FETCH NEXT FROM CUR_XuLyDonGia INTO @mah, @tenh, @donG
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @tongsohd = COUNT(SOHD) FROM CT_DONHANG WHERE MAHOA = @mah
			
			UPDATE HOA
			SET @donG = DONGIA + CASE   WHEN @tongsohd > 10 THEN + (DONGIA*5/100)
										WHEN @tongsohd = 0  THEN - (DONGIA*5/100)
										ELSE 0 END
			PRINT N'ĐÃ CẬP NHẬT XONG'
			PRINT @mah+', '+@tenh+', '+CAST(@donG AS VARCHAR(10))
			FETCH NEXT FROM CUR_XuLyDonGia INTO @mah, @tenh, @donG
		END
	
	CLOSE CUR_XuLyDonGia 
	DEALLOCATE CUR_XuLyDonGia 

/*
In GIÁ TRỊ các số LẺ VÀ ĐẾM SỐ LƯỢNG từ 1=>10
*/
DECLARE @I INT = 1, @DEMLE INT = 0
WHILE (@I<=10)
BEGIN
	IF(@I % 2 != 0)
		BEGIN
			PRINT @I
			SET @DEMLE = @DEMLE +1
	END
	SET @I = @I+1
END
PRINT N'CÓ '+ CAST(@DEMLE AS VARCHAR(2)) + N'SỐ LẺ TỪ 1=>10'



--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
/*
A. Tạo các thủ tục nội tại hiển thị dữ liệu sau:
1. Xây dựng thủ tục tên sp_DSHoa_ChuDe để hiển thị danh sách các hoa gồm các thông tin sau: mã hoa, tên hoa, ý nghĩa, đơn giá, tên chủ đề, với tên chủ đề do người dùng nhập vào.
*/	
	GO
	CREATE PROC sp_DSHoa_ChuDe (@tencd NVARCHAR(20))
	AS

	IF  @tencd IS NULL
		SELECT MAHOA, TENHOA, YNGHIA, TENCD
		FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	ELSE IF NOT EXISTS (SELECT * FROM CHUDE WHERE TENCD = @tencd)
			PRINT N'CHỦ ĐỀ KHÔNG TỒN TẠI'
	ELSE IF NOT EXISTS (SELECT * FROM HOA INNER JOIN CHUDE ON CHUDE.MACD = HOA.MACD WHERE TENCD = @tencd)
			PRINT N'CHỦ ĐỀ CHƯA CÓ HOA'
	ELSE
	SELECT MAHOA, TENHOA, YNGHIA, DONGIA, TENCD
	FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	WHERE TENCD = @tencd
	GO

	EXEC sp_DSHoa_ChuDe N'Thầy cô'
	GO

/*
2. Xây dựng thủ tục tên sp_ChiTietDH để hiển thị chi tiết đơn hàng gồm các thông tin sau: tên hoa, số lượng, giá bán, với số đơn hàng do người dùng nhập vào. Nếu người dùng không nhập số đơn hàng thì hiển thị chi tiết của tất cả các đơn hàng.
*/
	GO
	CREATE PROC sp_ChiTietDH (@sodh CHAR(4))
	AS
	IF @sodh IS NULL
		SELECT TENHOA, SOLUONG, GIABAN
		FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
	ELSE IF NOT EXISTS (SELECT * FROM CT_DONHANG WHERE SOHD = @sodh)
		PRINT N'SỐ ĐƠN HÀNG KHÔNG TỒN TẠI'
	ELSE IF NOT EXISTS (SELECT * FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA WHERE SOHD = @sodh)
		PRINT N'SỐ ĐƠN HÀNG CHƯA CÓ CHI TIẾT'
	ELSE
	SELECT TENHOA, SOLUONG, GIABAN
	FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
	WHERE SOHD = @sodh
	GO

	EXEC sp_ChiTietDH 'D005'
	GO

/*
B. Tạo các thủ tục tính toán sau:
3. Xây dựng thủ tục tên sp_DemHoaHong để đếm số lượng các hoa thuộc loại “Hoa hồng”.
*/
	CREATE PROC sp_DemHoaHong
	AS
	SELECT COUNT(*)
	FROM LOAIHOA INNER JOIN HOA ON LOAIHOA.MALH = HOA.MALH
	WHERE TENLH = 'Hoa hồng'
	GO

	EXEC sp_DemHoaHong
	GO

	--GO
	--CREATE PROC sp_DemHoaTheoLoai(@tenlh NVARCHAR(20), @sohoatheoloai int output)
	--AS
	--SELECT @sohoatheoloai = COUNT(MAHOA)
	--FROM LOAIHOA INNER JOIN HOA ON LOAIHOA.MALH = HOA.MALH
	--WHERE TENLH = @tenlh
	--GO

	--DECLARE @sohoa INT, @tenloai NVARCHAR(20) = N'Hoa cẩm chướng'
	--EXEC sp_DemHoaTheoLoai @tenloai, @sohoa OUTPUT
	--PRINT N'CÓ '+ CAST(@sohoa as VARCHAR(5))+ N' HOA THUỘC LOẠI '+ @tenloai

	--IF @sohoa >= 5
	--	PRINT N'KHÔNG CẦN BỔ SUNG THÊM HOA'
	--ELSE
	--	PRINT N'CẦN BỔ SUNG THÊM HOA'
	--GO

/*
4. Xây dựng thủ tục tên sp_DonGiaThapNhatChuDeTinhYeu để tính đơn giá thấp nhất của các hoa thuộc chủ đề “Tình yêu”.
*/
	GO
	CREATE PROC sp_DonGiaThapNhatChuDeTinhYeu
	AS
	SELECT MIN(DONGIA) 
	FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	WHERE TENCD = N'Tình yêu'
	GO

	EXEC sp_DonGiaThapNhatChuDeTinhYeu
	GO

	--GO
	--CREATE PROC sp_DonGiaThapNhatChuDe (@tencd NVARCHAR(20))
	--AS
	--SELECT MIN(DONGIA)
	--FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	--WHERE TENCD = @tencd
	--GO

	--EXEC sp_DonGiaThapNhatChuDe N'Tình yêu'
	--GO

/*
5. Xây dựng thủ tục tên spud_TongTriGiaDH gồm 2 tham số vào là từ ngày x và đến ngày y (x, y mặc định là ngày hiện hành) để hiển thị thông tin các đơn hàng trong khoảng thời gian từ ngày x đến ngày y, bổ sung thêm cột Trị giá đơn hàng tính bằng tổng (số lượng x giá bán) của tất cả các hoa đã đặt trong đơn hàng.
*/
	GO
	CREATE PROC spud_TongTriGiaDH (@ngayX DATETIME = NULL, @ngayY DATETIME = NULL)
	AS
	IF @ngayX is NULL
		SET @ngayX = GETDATE()
	IF @ngayY is NULL
		SET @ngayY = GETDATE()
	IF @ngayX > @ngayY
		PRINT N'KHOẢNG THỜI GIAN KHÔNG HỢP LỆ'
	ELSE IF NOT EXISTS (SELECT * FROM DONHANG WHERE NGAYDAT BETWEEN @ngayX AND @ngayY)
		PRINT N'KHÔNG CÓ ĐƠN HÀNG TỪ NGÀY '+ CONVERT(CHAR(10),@ngayX,105)+ N' ĐẾN NGÀY '+ CONVERT(CHAR(10),@ngayY,105)
	ELSE
		SELECT DONHANG.SOHD, NGAYDAT, NGAYGIAO,TENKH, TINHTRANG, SUM(SOLUONG*GIABAN) AS TONGTRIGIA
		FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD
		WHERE NGAYDAT BETWEEN @ngayX AND @ngayY
		GROUP BY DONHANG.SOHD, NGAYDAT, NGAYGIAO,TENKH, TINHTRANG
	GO
	
	EXEC spud_TongTriGiaDH '2019/04/01','2019/04/01'
	GO

/*
LÀM THÊM: Xây dựng thủ tục tên spud_HienThi_DSHoa_TheoChuDe gồm 1 tham số vào là mã chủ đề. Thủ tục dùng để hiển thị thông tin trong bảng Hoa có lọc theo mã chủ đề truyền vào và có thêm cột GHI CHÚ biết rằng nếu hoa đã có đơn đặt hàng thì in ra "Đã có xxx đơn đặt hàng", ngược lại nếu chưa có đơn đặt hàn thì in ra "Chưa có đơn đặt hàng"
*/
	GO
	CREATE PROC spud_HienThi_DSHoa_TheoChuDe (@maChuDe CHAR(4))
	AS
	IF NOT EXISTS (SELECT * FROM CHUDE WHERE MACD = @maChuDe)
		PRINT N'CHỦ ĐỀ KHÔNG TỒN TẠI'
	ELSE IF NOT EXISTS (SELECT * FROM HOA WHERE MACD = @maChuDe)
		PRINT N'CHỦ ĐỀ KHÔNG CÓ HOA'
	ELSE
	BEGIN
		DECLARE CUR_HienThi_DSHoa_TheoChuDe CURSOR
		FOR SELECT MAHOA, TENHOA, YNGHIA, DONGIA, MACD FROM HOA WHERE MACD = @maChuDe
		
		OPEN CUR_HienThi_DSHoa_TheoChuDe
		DECLARE @mahoa CHAR(4), @tenhoa NVARCHAR(50), @ynghia NVARCHAR(50), @dongia MONEY, @macd CHAR(4), @sodonhang INT
		FETCH NEXT FROM CUR_HienThi_DSHoa_TheoChuDe INTO @mahoa, @tenhoa, @ynghia, @dongia, @macd 
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @sodonhang = COUNT(*) FROM CT_DONHANG WHERE MAHOA = @mahoa
			IF @sodonhang > 0
				PRINT @mahoa+' '+@tenhoa+' '+@ynghia+' '+FORMAT(DONGIA,'#,### VNĐ')+N' ĐÃ CÓ '+CAST(@sodonhang AS VARCHAR(5))+N' ĐƠN ĐẶT HÀNG'
			ELSE
				PRINT @mahoa+' '+@tenhoa+' '+@ynghia+' '+FORMAT(DONGIA,'#,### VNĐ')+N' CHƯA CÓ ĐƠN ĐẶT HÀNG '
			FETCH NEXT FROM CUR_HienThi_DSHoa_TheoChuDe INTO @mahoa, @tenhoa, @ynghia, @dongia, @macd 
		END
		
		CLOSE CUR_HienThi_DSHoa_TheoChuDe 
		DEALLOCATE CUR_HienThi_DSHoa_TheoChuDe 
	END
	GO
	
	EXEC spud_HienThi_DSHoa_TheoChuDe 'CD06'
	GO

/*
C. Tạo các thủ tục cập nhật dữ liệu sau:
6. Xây dựng thủ tục thêm mới một hoa với tên sp_ThemHoa, lưu ý phải kiểm tra các ràng buộc dữ liệu hợp lệ trước khi thêm.
*/
	GO
	CREATE PROC sp_ThemHoa(@mahoa CHAR(4), @tenhoa NVARCHAR(50), @ynghia NVARCHAR(50),@thanhphan NVARCHAR(100), @dongia MONEY, @hinhmh VARCHAR(15), @macd CHAR(4), @malh CHAR(4))
	AS
	DECLARE @loi INT = 0
	
	IF EXISTS (SELECT * FROM HOA WHERE MAHOA = @mahoa)
	BEGIN
		PRINT N'MÃ HOA ĐÃ CÓ => VI PHẠM RÀNG BUỘC KHÓA CHÍNH'
		SET @loi = 1
	END
	IF EXISTS (SELECT * FROM HOA WHERE TENHOA = @tenhoa)
	BEGIN
		PRINT N'TÊN HOA ĐÃ CÓ => VI PHẠM RÀNG BUỘC DUY NHẤT'
		SET @loi =1
	END
	IF NOT EXISTS (SELECT * FROM CHUDE WHERE MACD = @macd)
	BEGIN 
		PRINT N'MÃ CHỦ ĐỀ KHÔNG TỒN TẠI => VI PHẠM RÀNG BUỘC KHÓA NGOẠI'
		SET @loi =1
	END
	IF NOT EXISTS (SELECT * FROM LOAIHOA WHERE MALH = @malh)
	BEGIN 
		PRINT N'MÃ LOẠI HOA KHÔNG TỒN TẠI => VI PHẠM RÀNG BUỘC KHÓA NGOẠI'
		SET @loi =1
	END
	IF @loi = 1 
	RETURN 
	INSERT INTO HOA VALUES(@mahoa, @tenhoa, @ynghia, @thanhphan, @dongia, @hinhmh, @macd, @malh)
	PRINT N'ĐÃ THÊM THÀNH CÔNG'
	GO

	EXEC sp_ThemHoa 'H016', N'EM YÊU', N'I love you', N'Hoa hông, baby trắng', 1000000, 'h015.jpg', 'CD03', 'LH02'
	GO
	
/*
7. Xây dựng thủ tục tên sp_XoaHoa để xóa một hoa trong bảng HOA với tham số vào là mã hoa cần xóa, phải kiểm tra hoa chưa có đơn đặt hàng thì mới xóa.
*/
	GO
	CREATE PROC sp_XoaHoa(@mahoa CHAR(4), @tenhoa NVARCHAR(50), @ynghia NVARCHAR(50),@thanhphan NVARCHAR(100), @dongia MONEY, @hinhmh VARCHAR(15), @macd CHAR(4), @malh CHAR(4))
	AS
	DECLARE @loi INT = 0
	--1
	IF NOT EXISTS (SELECT * FROM HOA WHERE MAHOA = @mahoa)
	BEGIN
		PRINT N'MÃ HOA KHÔNG TỒN TẠI => VI PHẠM RÀNG BUỘC KHÓA CHÍNH'
		SET @loi =1
	END
	--2
	IF EXISTS (SELECT * FROM CT_DONHANG WHERE MAHOA = @mahoa)
	BEGIN
		PRINT N'MÃ HOA ĐÃ CÓ TRONG BẢNG CT_DONHANG NÊN KHÔNG THỂ XÓA => VI PHẠM ...'
		SET @loi = 1
	END
	--3
	IF NOT EXISTS (SELECT * FROM HOA WHERE TENHOA = @tenhoa OR YNGHIA = @ynghia OR THANHPHAN = @thanhphan OR DONGIA = @dongia OR HINHMH = @hinhmh)
	BEGIN
		PRINT N'DỮ LIỆU KHÔNG TỒN TẠI'
		SET @loi =1
	END
	--4
	IF EXISTS (SELECT * FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD WHERE HOA.MACD = @macd)
	BEGIN 
		PRINT N'MÃ CHỦ ĐỀ ĐÃ TỒN TẠI TRONG BẢNG CHỦ ĐỀ => VI PHẠM RÀNG BUỘC KHÓA NGOẠI'
		SET @loi =1
	END
	--5
	IF EXISTS (SELECT * FROM HOA INNER JOIN LOAIHOA ON HOA.MALH = LOAIHOA.MALH WHERE HOA.MALH = @malh)
	BEGIN 
		PRINT N'MÃ LOẠI HOA ĐÃ TỒN TẠI TRONG BẢNG LOẠI HOA => VI PHẠM RÀNG BUỘC KHÓA NGOẠI'
		SET @loi =1
	END

	IF @loi = 1 RETURN 
	DELETE HOA WHERE MAHOA = @mahoa AND TENHOA = @tenhoa AND YNGHIA = @ynghia AND THANHPHAN = @thanhphan AND DONGIA = @dongia AND HINHMH = @hinhmh AND MACD = @macd AND MALH = @malh
	PRINT N'ĐÃ XÓA THÀNH CÔNG'
	GO

	EXEC sp_XoaHoa 'H016', N'EM YÊU', N'I love you', N'Hoa hông, baby trắng', 1000000, 'h015.jpg', 'CD03', 'LH02'
	GO
/*
8. Xây dựng thủ tục sửa thông tin một hoa trong bảng HOA với tên sp_SuaHoa.
*/
	GO
	CREATE PROC sp_SuaHoa(@mahoa CHAR(4), @tenhoa NVARCHAR(50), @ynghia NVARCHAR(50),@thanhphan NVARCHAR(100), @dongia MONEY, @hinhmh VARCHAR(15), @macd CHAR(4), @malh CHAR(4))
	AS

	DECLARE @loi INT = 0
	--1
	IF NOT EXISTS (SELECT * FROM HOA WHERE MAHOA = @mahoa)
	BEGIN
		PRINT N'MÃ HOA KHÔNG TỒN TẠI'
		SET @loi =1
	END
	--2
	IF EXISTS (SELECT TENHOA FROM HOA WHERE TENHOA = @tenhoa AND MAHOA <> @mahoa)
	BEGIN
		PRINT N'TRÙNG TÊN HOA ĐÃ CÓ'
		SET @loi = 1
	END
	--3
	IF NOT EXISTS (SELECT * FROM HOA WHERE TENHOA = @tenhoa OR YNGHIA = @ynghia OR THANHPHAN = @thanhphan OR DONGIA = @dongia OR HINHMH = @hinhmh)
	BEGIN
		PRINT N'DỮ LIỆU KHÔNG TỒN TẠI'
		SET @loi =1
	END
	--4
	IF NOT EXISTS (SELECT * FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD WHERE HOA.MACD = @macd)
	BEGIN 
		PRINT N'MÃ CHỦ ĐỀ KHÔNG TỒN TẠI TRONG BẢNG CHỦ ĐỀ => VI PHẠM RÀNG BUỘC KHÓA NGOẠI'
		SET @loi =1
	END
	--5
	IF NOT EXISTS (SELECT * FROM HOA INNER JOIN LOAIHOA ON HOA.MALH = LOAIHOA.MALH WHERE HOA.MALH = @malh)
	BEGIN 
		PRINT N'MÃ LOẠI HOA KHÔNG TỒN TẠI TRONG BẢNG LOẠI HOA => VI PHẠM RÀNG BUỘC KHÓA NGOẠI'
		SET @loi =1
	END

	IF @loi = 1 RETURN 
	UPDATE HOA
	SET TENHOA = @tenhoa, YNGHIA = @ynghia, THANHPHAN = @thanhphan, DONGIA = @dongia, HINHMH = @hinhmh, MACD = @macd, MALH = @malh
	WHERE MAHOA = @mahoa
	PRINT N'ĐÃ SỬA DỮ LIỆU THÀNH CÔNG'
	GO

	EXEC sp_SuaHoa 'H016', N'NoName', N'VL', N'Hoa hông, baby trắng', 1000000, 'h015.jpg', 'CD02', 'LH03'
	GO

/*
II. Thủ tục nội tại có giá trị trả về:
9. Xây dựng thủ tục tên sp_SoLanDH để tính số lần đặt hàng gồm 1 tham số vào là mã hoa, 1 tham số ra là số lần đặt hàng của mã hoa truyền vào.
*/
	GO
	CREATE PROC sp_SoLanDH (@mahoa CHAR(4), @solandh INT OUTPUT)
	AS
	
	SELECT @solandh =COUNT(SOHD)
	FROM CT_DONHANG
	WHERE MAHOA = @mahoa
	GO

	DECLARE @MAHOA CHAR(4)= 'H008', @SLDH INT
	EXEC sp_SoLanDH @MAHOA, @SLDH OUTPUT
	PRINT @MAHOA +N' CÓ ' + CAST(@SLDH AS VARCHAR(2))+N' ĐƠN HÀNG'

	IF @SLDH > 5
		PRINT N'CẦN MUA THÊM HOA'
	ELSE
		PRINT N'KHÔNG CẦN MUA THÊM HOA'
	GO

/*
10.Xây dựng thủ tục tính số hoa với tên sp_SoLuongHoa gồm 1 tham số vào là: mã loại hoa, 1 tham số ra là số lượng hoa của mã loại hoa truyền vào.
*/
	GO
	CREATE PROC sp_SoLuongHoa (@mahoa CHAR(4), @soluonghoa INT OUTPUT)
	AS

	SELECT @soluonghoa = SUM(SOLUONG)
	FROM CT_DONHANG
	WHERE MAHOA = @mahoa
	GO

	DECLARE @mh CHAR(4)= 'H012', @SLH INT
	EXEC sp_SoLuongHoa @mh, @SLH OUTPUT
	GO

/*
11.Xây dựng thủ tục tính giá bán trung bình của hoa với tên sp_GiaBanTB gồm 1 tham số vào là mã hoa, 1 tham số ra là giá bán trung bình của mã hoa truyền vào.
*/
	GO
	CREATE PROC sp_GiaBanTB (@mahoa CHAR(4), @giabantb MONEY OUTPUT)
	AS

	SELECT @giabantb = AVG(GIABAN)
	FROM CT_DONHANG
	WHERE MAHOA = @mahoa
	GO

	DECLARE @GBTB MONEY, @MAHOA CHAR(4)= 'H008'
	EXEC sp_GiaBanTB @MAHOA, @GBTB OUTPUT
	PRINT N'GIÁ BÁN TB CỦA HOA CÓ MÃ SỐ '+@MAHOA+ N' LÀ '+ FORMAT(@GBTB, '#,### VNĐ')
	
	IF @GBTB > 500000
		PRINT N'NÊN TĂNG GIÁ BÁN'
	ELSE
		PRINT N'NÊN GIẢM GIÁ BÁN'
	GO

/*
12.Xây dựng thủ tục tính giá bán cao nhất và giá bán thấp nhất của hoa với tên sp_GiaBanCaoNhatThapNhat gồm 1 tham số vào là mã hoa, 2 tham số ra là giá bán cao nhất và giá bán thấp nhất của mã hoa truyền vào.
*/
	GO
	CREATE PROC sp_GiaBanCaoNhatThapNhat (@mh CHAR(4), @giabanCaoNhat MONEY OUTPUT, @giabanThapNhat MONEY OUTPUT)
	AS

	SELECT @giabanCaoNhat = MAX(GIABAN), @giabanThapNhat = MIN(GIABAN)
	FROM CT_DONHANG
	WHERE MAHOA = @mh
	GO

	DECLARE @GBCN MONEY, @GBTN MONEY, @maHoa CHAR(4)= 'H008'
	EXEC sp_GiaBanCaoNhatThapNhat @maHoa, @GBCN OUTPUT, @GBTN OUTPUT
	PRINT @maHoa+ N' CÓ GIÁ BÁN CAO NHẤT LÀ: '+ FORMAT(@GBCN,'#,### VNĐ')+ N' VÀ GIÁ BÁN THẤP NHẤT LÀ: '+FORMAT(@GBTN,'#,### VNĐ')
	GO

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
/*
A. Hàm tính toán và không sử dụng dữ liệu trong các bảng:
1. Xây dựng hàm fn_TongHaiSoNguyen(@so1, @so2) trả về tổng của hai số nguyên.
*/
	GO
	CREATE FUNCTION fn_TongHaiSoNguyen(@so1 INT, @so2 INT)
	RETURNS INT
	AS

	BEGIN
		DECLARE @tong INT
		SET @tong = @so1 + @so2
		RETURN @tong
	END
	GO

	PRINT DBO.fn_TongHaiSoNguyen(2,3)

/*
2. Xây dựng hàm fn_TongDaySoNguyen(@n) trả về tổng của các số nguyên từ 1 đến n.
*/
	GO
	CREATE FUNCTION fn_TongDaySoNguyen(@n INT)
	RETURNS INT
	AS

	BEGIN
		DECLARE @tong INT =0,@i INT=1
		WHILE @i <= @n
		BEGIN
			SET @tong = @tong + @i
			SET @i = @i +1
		END
		RETURN @tong
	END
	GO

	PRINT DBO.fn_TongDaySoNguyen(10)
								/*
								3. Xây dựng hàm fn_SoNT(@n) trả về 1 nếu @n là số nguyên tố, ngược lại thì trả về 0.
								*/
	GO
	ALTER FUNCTION fn_SoNT(@n INT)
	RETURNS BIT
	AS

	BEGIN
		DECLARE @i INT =2, @b BIT
		IF @n < 2 
			SET @b = 0
		ELSE
			WHILE @i <= SQRT(@n)
			BEGIN
				IF(@n % @i =0) SET @b = 0
				ELSE SET @b = 1
				SET @i = @i + 1
			END
		RETURN @b
	END
	GO

	PRINT DBO.fn_SoNT(10)
				/*
				4. Xây dựng hàm fn_CacSoNT(@n) trả về chuỗi các số nguyên tố nằm trong khoảng từ 2 đến n.
				*/
	--GO
	--CREATE FUNCTION fn_CacSoNT(@n INT)
	--RETURNS INT
	--AS

	--BEGIN
	--	DECLARE @i INT =2, @j INT =1, @dem INT 
	--	IF @n < 2
	--		RETURN 0

	--	WHILE @i <= @n
	--	BEGIN
	--		SET @dem = 0
	--		WHILE @j < @i
	--		BEGIN
	--			IF @i % @j =0
	--				SET @dem = @dem + 1
	--				SET @j = @j +1
	--			IF @dem = 2
	--				SET @i = @i
	--		END
	--		SET @i = @i +1
	--	END
	--	RETURN @dem
	--END
	--GO

	--PRINT DBO.fn_CacSoNT(5)
/*
5. Xây dựng hàm fn_NgayThangVN(@ngay) trả về chuỗi ngày tháng kiểu Việt Nam dd-MMyyyy.
*/
	GO
	CREATE FUNCTION fn_NgayThangVN(@ngay DATETIME, @dau CHAR(1))
	RETURNS CHAR(10)
	AS
	BEGIN
		
		DECLARE @date CHAR(10)
		IF @ngay IS NULL SET @ngay = GETDATE()
		
		DECLARE @DD INT
		IF @dau ='/'
			SET @DD = 103
		ELSE 
			SET @DD = 105
		
		RETURN CONVERT(CHAR(10),@ngay,@DD)
	END
	GO

	DECLARE @ngaythang DATETIME
	PRINT DBO.fn_NgayThangVN(@ngaythang,'/')
	GO
	--1  Sử dụng hàm fn_NgayThangVN trong mệnh đề select để hiển thị d/s đơn hàng với cột ngày đặt và ngày giao theo định dạng ngày tháng kiểu Việt Nam.
	SELECT SOHD, DBO.fn_NgayThangVN(NGAYDAT,'/') AS NG_DAT, DBO.fn_NgayThangVN(NGAYGIAO,'/') AS NG_GIAO,
			CASE TINHTRANG WHEN 1 THEN N'ĐÃ GIAO' ELSE N'CHƯA GIAO' END AS TINHTRANG
	FROM DONHANG

	--2  Sử dụng hàm fn_NgayThangVN trong mệnh đề where để lọc d/s đơn hàng có ngày đặt (ngày giao) theo định dạng ngày tháng kiểu Việt Nam.
	SELECT SOHD, NGAYDAT, TINHTRANG
	FROM DONHANG
	WHERE DBO.fn_NgayThangVN(NGAYDAT,'/') = '27/11/2019'

	SELECT SOHD, NGAYGIAO, TINHTRANG
	FROM DONHANG
	WHERE DBO.fn_NgayThangVN(NGAYGIAO,'/') = '20/11/2019'

	--3  Sử dụng hàm fn_NgayThangVN trong mệnh đề group by để hiển thị d/s đơn hàng gồm các thông tin: số đơn hàng, ngày đặt và ngày giao theo định dạng ngày tháng kiểu Việt Nam và tổng thành tiền.
	SELECT DONHANG.SOHD, dbo.fn_NgayThangVN(NGAYDAT,'/') AS NG_DAT, DBO.fn_NgayThangVN(NGAYGIAO,'/') AS NG_GIAO, FORMAT(SUM(SOLUONG*GIABAN),'#,### VNĐ') AS TONG_TIEN
	FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD
	GROUP BY DONHANG.SOHD, dbo.fn_NgayThangVN(NGAYDAT,'/'), DBO.fn_NgayThangVN(NGAYGIAO,'/')

/*
6. Xây dựng hàm fn_ChuanHoaChuoi(@chuoi) trả về chuỗi đã được cắt bỏ các khoảng trắng thừa và IN HOA:
*/	
	GO
	CREATE FUNCTION fn_ChuanHoaChuoi(@chuoi NVARCHAR(255))
	RETURNS NVARCHAR(255)
	AS
	BEGIN
		SET @chuoi = LTRIM(RTRIM(@chuoi))
		WHILE CHARINDEX('  ',@chuoi) > 0
			SET @chuoi = REPLACE(@chuoi,'  ',' ')
		SET @chuoi = UPPER(@chuoi)
		RETURN @chuoi
	END
	GO
	PRINT DBO.fn_ChuanHoaChuoi(N'nguyễn văn    a')
	GO

	--1  Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề select để hiển thị d/s hoa với cột tên hoa đã được chuẩn hóa.
	SELECT MAHOA, DBO.fn_ChuanHoaChuoi(TENHOA) AS TENHOA, DONGIA, MACD, MALH
	FROM HOA

	--2  Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề where để hiển thị thông tin hoa có tên là “YÊU MẸ”.
	SELECT MAHOA, TENHOA, DONGIA, MACD, MALH
	FROM HOA
	WHERE DBO.fn_ChuanHoaChuoi(TENHOA) = N'YÊU MẸ'

	--3  Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề set của câu update để chuẩn hóa chuỗi cột TENHOA trong bảng HOA.
	UPDATE HOA
	SET TENHOA = DBO.fn_ChuanHoaChuoi(TENHOA)

	--4  Sử dụng hàm fn_ChuanHoaChuoi trong mệnh đề values của câu insert để chuẩn hóa chuỗi cột TENHOA khi thêm mới 1 hoa vào bảng HOA.
	INSERT INTO HOA VALUES ('H013',DBO.fn_ChuanHoaChuoi(N'Cô   đơn'),N'LONELY',N'Hoa tulip, baby trắng',1000000,'h013.jpg','CD05','LH09')

/*
B. Hàm tính toán và có sử dụng dữ liệu trong các bảng:
7. Xây dựng hàm fn_GiaBanTB_MaHoa(@mahoa) trả về giá bán TB của hoa có mã số truyền vào.
*/
	GO
	CREATE FUNCTION fn_GiaBanTB_MaHoa(@mahoa CHAR(4))
	RETURNS MONEY
	AS
	BEGIN
		RETURN ( SELECT SUM(GIABAN)/SUM(SOLUONG) FROM CT_DONHANG WHERE MAHOA = @mahoa)
	END
	GO	
	PRINT DBO.fn_GiaBanTB_MaHoa('H001')
	GO
	--1  Xây dựng thủ tục sp_CapNhatHoa có sử dụng hàm fn_GiaBanTB_MaHoa để cập nhật lại đơn giá trong bảng HOA theo các qui tắc sau:
	-- Giảm 100.000 nếu giá bán TB của hoa dưới 500.000.
	-- Giảm 50.000 nếu 500.000 < giá bán TB < 700.000.
	-- Không giảm đơn giá nếu giá bán TB ≥ 700.000 hoặc không có đơn hàng.
	SELECT *FROM HOA
	GO
	CREATE PROC sp_CapNhatHoa
	AS

	UPDATE HOA
	SET DONGIA = DONGIA - CASE  WHEN DBO.fn_GiaBanTB_MaHoa(MAHOA) < 500000 THEN 100000
								WHEN DBO.fn_GiaBanTB_MaHoa(MAHOA) < 700000 THEN 50000
								ELSE 0 END
	GO
	EXEC sp_CapNhatHoa


	-- 2  Xây dựng thủ tục sp_CapNhatHoa_KyTuDau(@kytudau) có sử dụng hàm fn_GiaBanTB_MaHoa để cập nhật lại đơn giá trong bảng HOA cho các hoa mà tên có ký tự đầu là “Y”.
	GO
	CREATE PROC sp_CapNhatHoa_KyTuDau(@kytudau CHAR(1) OUTPUT)
	AS

	UPDATE HOA
	SET DONGIA = CASE WHEN LEFT(TENHOA,1) = @kytudau THEN DBO.fn_GiaBanTB_MaHoa(MAHOA) ELSE DONGIA END
	GO

	EXEC sp_CapNhatHoa_KyTuDau 'Y'
	SELECT * FROM HOA
	
/*
8. Xây dựng hàm fn_GiaBanTB_Hoa(@mahoa) trả về giá bán TB của hoa có mã hoa truyền vào.
*/	
	GO
	CREATE FUNCTION fn_GiaBanTB_Hoa(@mahoa CHAR(4))
	RETURNS MONEY
	AS

	BEGIN
		DECLARE @gbtb MONEY
		SELECT @gbtb = SUM(GIABAN)/SUM(SOLUONG) FROM CT_DONHANG WHERE MAHOA = @mahoa
		RETURN @gbtb
	END
	GO

	PRINT DBO.fn_GiaBanTB_Hoa('H001')

--	 Xây dựng thủ tục sp_CapNhatDonGia_TheoChuDe(@macd) có sử dụng hàm fn_GiaBanTB_Hoa để cập nhật lại đơn giá cho hoa có mã chủ đề truyền vào theo các qui tắc sau:
				-- Không tăng đơn giá nếu giá bán TB < 500.000
				-- Tăng đơn giá thêm 50.000đ nếu 500.000 ≤ giá bán TB < 700.000
				-- Tăng đơn giá thêm 100.000đ nếu 700.000 ≤ giá bán TB < 850.000
				-- Tăng đơn giá thêm 200.000đ nếu giá bán TB ≥ 850.000
				--Nếu không truyền mã chủ đề thì cập nhật lại đơn giá cho tất cả các hoa.
	GO
	CREATE PROC sp_CapNhatDonGia_TheoChuDe(@macd CHAR(4))
	AS

	UPDATE HOA
	SET DONGIA = CASE WHEN MACD = @macd THEN (DONGIA + CASE WHEN DBO.fn_GiaBanTB_Hoa(MACD) < 500000 THEN 0
															WHEN DBO.fn_GiaBanTB_Hoa(MACD) < 700000 THEN 50000
															WHEN DBO.fn_GiaBanTB_Hoa(MACD) < 850000 THEN 100000
															ELSE 200000 END) ELSE NULL END
	EXEC sp_CapNhatDonGia_TheoChuDe 'CD01'
	SELECT * FROM HOA

/*
9. Xây dựng hàm fn_DanhSachDonHang(@mahoa) trả về chuỗi danh sách số đơn hàng đã đặt mua hoa có mã hoa truyền vào.
*/
	GO
	CREATE FUNCTION fn_DanhSachDonHang(@mahoa CHAR(4)) 
	RETURNS NVARCHAR(255)
	AS
	BEGIN
		DECLARE @chuoi NVARCHAR(255)=''
		SELECT @chuoi = @chuoi+MAHOA+'. '
		FROM CT_DONHANG 
		WHERE MAHOA = @mahoa
		--SET @chuoi = LEFT(@chuoi, LEN(@chuoi) - 1)
		RETURN @chuoi
		END
	GO

	PRINT DBO.fn_DanhSachDonHang('H011')
	GO
-- Xây dựng thủ tục sp_DanhSachDonHang có sử dụng hàm fn_DanhSachDonHang để hiển thị thông tin hoa gồm: Mã hoa, Tên hoa, Tên chủ đề, Danh sách số đơn hàng đã đặt mua hoa.
	GO
	CREATE PROC sp_DanhSachDonHang
	AS
	BEGIN
		SELECT HOA.MAHOA, TENHOA, TENCD, DBO.fn_DanhSachDonHang(HOA.MAHOA) AS SODH
		FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD
	END
	GO

	EXEC sp_DanhSachDonHang

-- Xây dựng thủ tục sp_DanhSachDonHangTheoLoaiHoa(@malh) có sử dụng hàm fn_DanhSachDonHang để hiển thị thông tin hoa gồm: Mã hoa, Tên hoa, Danh sách số đơn hàng đã đặt mua hoa có mã loại hoa truyền vào.
	GO
	CREATE PROC sp_DanhSachDonHangTheoLoaiHoa(@malh CHAR(4))
	AS
	BEGIN
		SELECT HOA.MAHOA, TENHOA, DBO.fn_DanhSachDonHang(HOA.MAHOA) AS SODH
		FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
		WHERE MALH = @malh 
	END
	GO

	EXEC sp_DanhSachDonHangTheoLoaiHoa 'LH01'

/*
10. Xây dựng hàm fn_ChiTietDonHang(@mahoa) trả về chuỗi danh sách số đơn hàng đã đặt mua hoa và giá bán tương ứng của hoa có mã hoa truyền vào.
*/
	GO
	CREATE FUNCTION fn_ChiTietDonHang(@mahoa CHAR(4))
	RETURNS NVARCHAR(400)
	AS
	BEGIN
		DECLARE @chuoi NVARCHAR(400)=''
		SELECT @chuoi = @chuoi + SOHD+': '+CAST(GIABAN AS VARCHAR(15))+'.'
		FROM CT_DONHANG 
		WHERE MAHOA = @mahoa
		--SET @chuoi = LEFT(@chuoi, LEN(@chuoi)-1)
		RETURN @chuoi
	END
	
	GO
	PRINT DBO.fn_ChiTietDonHang('H002')

-- Xây dựng thủ tục sp_ChiTietDonHang_Hoa có sử dụng hàm fn_ChiTietDonHang và fn_GiaBanTB_Hoa để hiển thị thông tin hoa gồm: Mã hoa, Tên hoa, Chủ đề, Chi tiết đơn hàng và Giá bán TB.	
	GO
	CREATE PROC sp_ChiTietDonHang_Hoa
	AS
	BEGIN 
		SELECT CT_DONHANG.MAHOA, TENHOA, TENCD, DBO.fn_ChiTietDonHang(CT_DONHANG.MAHOA) AS CHI_TIET, CAST(DBO.fn_GiaBanTB_Hoa(CT_DONHANG.MAHOA) AS VARCHAR(50)) AS GB_TB
		FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD INNER JOIN CT_DONHANG ON CT_DONHANG.MAHOA = HOA.MAHOA
	END
	GO

	EXEC sp_ChiTietDonHang_Hoa
	GO

	-- Xây dựng thủ tục sp_ChiTietDonHang_Hoa_TheoChuDe(@macd) có sử dụng hàm ChiTietDonHang và fn_GiaBanTB_Hoa để hiển thị thông tin hoa gồm: Mã hoa, Tên hoa, Chi tiết đơn hàng và Giá bán TB của các hoa có mã chủ đề truyền vào.
	GO
	CREATE PROC sp_ChiTietDonHang_Hoa_TheoChuDe(@macd CHAR(4))
	AS
	BEGIN
		SELECT CT_DONHANG.MAHOA, TENHOA, TENCD, DBO.fn_ChiTietDonHang(CT_DONHANG.MAHOA) AS CHI_TIET, CAST(DBO.fn_GiaBanTB_Hoa(CT_DONHANG.MAHOA) AS VARCHAR(50)) AS GB_TB
		FROM HOA INNER JOIN CHUDE ON HOA.MACD = CHUDE.MACD INNER JOIN CT_DONHANG ON CT_DONHANG.MAHOA = HOA.MAHOA
		WHERE CHUDE.MACD = @macd
	END
	GO

	EXEC sp_ChiTietDonHang_Hoa_TheoChuDe 'CD01'
		
/*
II. Tạo các thủ tục cập nhật dữ liệu sau:
A. Hàm đọc bảng:
11. Xây dựng hàm fn_DanhSachHoa(@maloai) trả về danh sách các hoa của mã loại truyền vào.
*/
	GO
	CREATE FUNCTION fn_DanhSachHoa(@maloai CHAR(4))
	RETURNS TABLE
	AS
		RETURN SELECT * FROM HOA WHERE MALH = @maloai
	GO

	SELECT * FROM DBO.fn_DanhSachHoa('LH01')

/*
12. Xây dựng hàm fn_DanhSachHoa_GiaBanTB(@macd) trả về danh sách các hoa của mã chủ đề truyền vào, gồm các thông tin: Mã hoa, Tên hoa, Giá bán trung bình.
*/
	GO
	CREATE FUNCTION fn_DanhSachHoa_GiaBanTB(@macd CHAR(4))
	RETURNS TABLE
	AS
		RETURN  SELECT HOA.MAHOA, TENHOA, AVG(GIABAN) AS GiaBanTB
				FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA 
				WHERE MACD = @macd
				GROUP BY HOA.MAHOA, TENHOA
	GO

	SELECT * FROM DBO.fn_DanhSachHoa_GiaBanTB('CD01')

/*
13. Xây dựng hàm fn_DanhSachDonHang(@mahoa) trả về danh sách gồm các thông tin: số đơn hàng, ngày đặt, ngày giao và số lượng tương ứng của mã hoa truyền vào.
*/
	GO 
	CREATE FUNCTION fn_DanhSachDonHangDH(@mahoa CHAR(4))
	RETURNS TABLE
	AS
		RETURN  SELECT DONHANG.SOHD, NGAYDAT, NGAYGIAO, SOLUONG
				FROM CT_DONHANG INNER JOIN DONHANG ON CT_DONHANG.SOHD = DONHANG.SOHD
				WHERE MAHOA = @mahoa
	GO

	SELECT * FROM DBO.fn_DanhSachDonHangDH('H001')

/*
14. Xây dựng hàm fn_DanhSachDonHang_TheoLoai(@maloai) trả về danh sách các đơn hàng của hoa có mã loại truyền vào.
*/
	GO
	CREATE FUNCTION fn_DanhSachDonHang_TheoLoai(@maloai CHAR(4))
	RETURNS TABLE
	AS
		RETURN  SELECT DONHANG.*
				FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
				WHERE MALH = @maloai
	GO

	SELECT * FROM DBO.fn_DanhSachDonHang_TheoLoai('LH01')

/*
B. Hàm tạo bảng:
15. Xây dựng hàm fn_DSHoa_DonHang(@sodh) để lọc danh sách hoa đã được đặt mua trong đơn hàng với số đơn hàng truyền vào, gồm các thông tin: Mã hoa, Tên hoa, Tên loại.
*/
	GO
	CREATE FUNCTION fn_DSHoa_DonHang(@sodh CHAR(4))
	RETURNS @DSHoa TABLE(MAHOA CHAR(4), TENHOA NVARCHAR(50), TENLOAI NVARCHAR(20))
	AS
	BEGIN
		INSERT INTO @DSHoa(MAHOA,TENHOA,TENLOAI)
		SELECT HOA.MAHOA, TENHOA, TENLH
		FROM HOA INNER JOIN LOAIHOA ON HOA.MALH = LOAIHOA.MALH INNER JOIN CT_DONHANG ON CT_DONHANG.MAHOA = HOA.MAHOA
		WHERE SOHD = @sodh
		RETURN
	END
	GO

	SELECT * FROM DBO.fn_DSHoa_DonHang('D001')
	GO

/*
16. Xây dựng hàm fn_DSChuDe_DonHang(@sodh) để lọc danh sách chủ đề có hoa đã có đơn hàng đặt mua với số đơn hàng truyền vào.
*/
	GO
	CREATE FUNCTION fn_DSChuDe_DonHang(@sodh CHAR(4))
	RETURNS @DSChuDe TABLE (MAHOA CHAR(4), TENHOA NVARCHAR(50), GIABAN MONEY)
	AS
	BEGIN
		INSERT INTO @DSChuDe(MAHOA, TENHOA, GIABAN)
		SELECT HOA.MAHOA, TENHOA, GIABAN 
		FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
		WHERE SOHD = @sodh
		RETURN
	END
	GO

	SELECT * FROM DBO.fn_DSChuDe_DonHang('D001')

/*
17. Xây dựng hàm fn_DSChuDe_DonHang_Giaban(@sodh) để lọc danh sách chủ đề có hoa được đặt mua trong đơn hàng với số đơn hàng truyền vào, gồm các thông tin: mã chủ đề, Tên chủ đề, Giá bán cao nhất, Giá bán thấp nhất và Giá bán trung bình.
*/
	GO
	CREATE FUNCTION fn_DSChuDe_DonHang_Giaban(@sodh CHAR(4))
	RETURNS @DSChuDe_DH_GB TABLE (MACD CHAR(4), TENCD NVARCHAR(20), GB_MAX MONEY, GB_MIN MONEY, GB_TB MONEY)
	AS
	BEGIN
		INSERT INTO @DSChuDe_DH_GB(MACD, TENCD, GB_MAX, GB_MIN, GB_TB)
		SELECT CHUDE.MACD, TENCD, MAX(GIABAN), MIN(GIABAN), AVG(GIABAN)
		FROM CHUDE INNER JOIN HOA ON HOA.MACD = CHUDE.MACD INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
		WHERE SOHD = @sodh
		GROUP BY CHUDE.MACD, TENCD
		RETURN
	END
	GO

	SELECT * FROM DBO.fn_DSChuDe_DonHang_Giaban('D005')
	
/*
18. Xây dựng hàm fn_LocDSHoa_CapNhatDonGia(@maloai) để lọc danh sách hoa (gồm các thông tin: Mã hoa, Tên hoa, Đơn giá mới) của mã loại hoa truyền vào, có cập nhật lại đơn giá của hoa theo các qui tắc sau:
				 Không tăng Đơn giá nếu Giá bán trung bình < 500.000.
				 Tăng Đơn giá 50.000 nếu 500.000 ≤ Giá bán trung bình < 750.000.
				 Tăng Đơn giá 100.000 nếu 750.000 ≤ Giá bán trung bình < 1.000.000.
				 Tăng Đơn giá 150.000 nếu Giá bán trung bình ≥ 1.000.000.
*/
	GO
	CREATE FUNCTION fn_GiaBanTB(@mahoa char(4))
	RETURNS MONEY
	AS
	BEGIN
		DECLARE @x MONEY
		SELECT @x = AVG(GIABAN) FROM CT_DONHANG
		WHERE MAHOA = @mahoa
		RETURN @x
	END
	GO

	PRINT DBO.fn_GiaBanTB('H001')

	GO
	CREATE FUNCTION fn_LocDSHoa_CapNhatDonGia(@Malh CHAR(4))
	RETURNS @BANG TABLE (MAHOA CHAR(4), TENHOA NVARCHAR(50), DONGIAMOI MONEY)
	AS
	BEGIN
		INSERT INTO @BANG(MAHOA, TENHOA, DONGIAMOI)
		SELECT MAHOA, TENHOA, DONGIA
		FROM HOA INNER JOIN LOAIHOA On HOA.MALH = LOAIHOA.MALH
		WHERE HOA.MALH = @Malh
		UPDATE @BANG
		SET DONGIAMOI = DONGIAMOI + CASE WHEN DBO.fn_GiaBanTB(MAHOA) >=1000000 THEN 150000
										 WHEN DBO.fn_GiaBanTB(MAHOA) >=750000 THEN 100000
										 WHEN DBO.fn_GiaBanTB(MAHOA) >=500000 THEN 50000
										 ELSE 0 END
		RETURN
	END
	GO

	SELECT * FROM DBO.fn_LocDSHoa_CapNhatDonGia('LH01') 
	GO

/*
19. Xây dựng hàm fn_LocDSDonHang_CapNhatNgayGiao để lọc danh sách đơn hàng (gồm các thông tin: Số đơn hàng, Giá bán trung bình, Ngày giao cũ, Ngày giao mới) với Ngày giao mới được tính theo các qui tắc sau:
				 Không thay đổi Ngày giao nếu Giá bán trung bình < 500.000.
				 Dời lại 3 ngày nếu 500.000 ≤ Giá bán trung bình < 1.000.000.
				 Dời lại 5 ngày nếu Giá bán trung bình ≥ 1.000.000.
*/
	GO
	CREATE FUNCTION fn_GiaBanTB(@SODH char(4))
	RETURNS MONEY
	AS
	BEGIN
		DECLARE @x MONEY
		SELECT @x = AVG(GIABAN) 
		FROM CT_DONHANG
		WHERE SOHD = @SODH
		RETURN @x
	END
	GO

	PRINT DBO.fn_GiaBanTB('D001')

	GO
	CREATE FUNCTION fn_LocDSDonHang_CapNhatNgayGiao (@sodh CHAR(4))
	RETURNS @LocDSDonHang TABLE(SODH1 CHAR(4), GIABANTB MONEY, NGAYGIAOMOI DATE)
	AS
	BEGIN
		INSERT INTO @LocDSDonHang(SODH1, GIABANTB, NGAYGIAOMOI)
		SELECT DONHANG.SOHD, DBO.fn_GiaBanTB(DONHANG.SOHD), NGAYGIAO				    
		FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA INNER JOIN DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD
		WHERE DONHANG.SOHD = @sodh
		UPDATE @LocDSDonHang
		SET NGAYGIAOMOI = CASE  WHEN DBO.fn_GiaBanTB(SODH1) < 1000000 THEN DATEADD(D, 3, NGAYGIAOMOI)
								When DBO.fn_GiaBanTB(SODH1) >= 1000000 THEN DATEADD(D, 5, NGAYGIAOMOI)
								ELSE NGAYGIAOMOI END
		RETURN
	 END
	 GO

	SELECT * FROM DBO.fn_LocDSDonHang_CapNhatNgayGiao('D001')
	
	/*
	1.Cho biết giá bán trung bình của các kiểu hoa mà tên có chứa cụm từ 'Yêu thương' là bao nhiêu? Nếu <500.000 thì in ra 'Tăng giá bán' ngược lại in ra 'Giữ nguyên giá bán'
	*/	
		DECLARE @giabanTB MONEY
		SELECT @giabanTB = AVG(GIABAN)
		FROM CT_DONHANG INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
		WHERE TENHOA = N'Yêu thương'

		IF @giabanTB < 500000
			PRINT N'TĂNG GIÁ BÁN'
		ELSE
			PRINT N'GIỮ NGUYÊN GIÁ BÁN'

	/*
	2.Duyệt cursor và xử lý hiển thị danh sách các kiểu hoa gồm các thông tin: Mã hoa, Tên hoa, Ý nghĩa, thành phần, đơn giá và có thêm cột giá bán cao nhất
	*/
		DECLARE cur_HienThiDS CURSOR
		FOR SELECT MAHOA, TENHOA, YNGHIA, THANHPHAN, DONGIA FROM HOA
		OPEN cur_HienThiDS		
		DECLARE @mh CHAR(4), @tenhoa NVARCHAR(50), @ynghia NVARCHAR(50), @thanhphan NVARCHAR(50), @dongia MONEY, @giaban_cn MONEY
		FETCH NEXT FROM cur_HienThiDS INTO @mh, @tenhoa, @ynghia, @thanhphan, @dongia
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
		SELECT @giaban_cn = MAX(GIABAN)
		FROM CT_DONHANG 
		WHERE MAHOA = @mh

		PRINT N'MÃ HOA: '+@mh+', '+@tenhoa+', '+@ynghia+', '+@thanhphan+', '+N' ĐƠN GIÁ: '+CAST(@dongia AS VARCHAR(15))+', '+N' GIÁ BÁN CAO NHẤT: '+ CAST(@giaban_cn AS VARCHAR(15))
		FETCH NEXT FROM cur_HienThiDS INTO @mh, @tenhoa, @ynghia, @thanhphan, @dongia
		END

		CLOSE cur_HienThiDS
		DEALLOCATE cur_HienThiDS
	/*
	3.Xây dựng thủ tục sp_HoaTheoDonHang(@mahoa) để hiển thị danh sách các hoa bao gồm: Mã hoa, tên hoa, ý nghĩa, thành phần, số đh, số lượng, giá bán bổ sung thêm cột ghi chú nên tăng giá bán nếu giá bán < đơn giá ngược lại null. Nếu không truyền vào mã hoa thì hiển thị thông tin tất cả mã hoa trong bảng
	*/
	GO
	CREATE PROC sp_HoaTheoDonHang(@mahoa CHAR(4))
	AS
	IF @mahoa IS NULL
		SELECT HOA.MAHOA, TENHOA, YNGHIA, THANHPHAN, SOHD, SOLUONG, GIABAN
		FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	ELSE IF NOT EXISTS(SELECT * FROM HOA WHERE MAHOA = @mahoa)
		PRINT N'MÃ HOA KHÔNG TỒN TẠI'
	ELSE IF NOT EXISTS (SELECT * FROM CT_DONHANG WHERE MAHOA = @mahoa)
		PRINT N'MÃ HOA CHƯA CÓ CHI TIẾT ĐƠN HÀNG'
	ELSE 
	SELECT HOA.MAHOA, TENHOA, YNGHIA, THANHPHAN, SOHD, SOLUONG, GIABAN, GHICHU = CASE WHEN GIABAN < DONGIA THEN N'TĂNG GIÁ BÁN' ELSE NULL END
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	WHERE HOA.MAHOA = @mahoa
	GO

	EXEC sp_HoaTheoDonHang 'H001'
	GO
	/*
	4.Xây dựng hàm fn_GiaBanTrungBinh(@sodh) trả về giá bán trung bình ứng với số đơn hàng truyền vào. 
	*/
	GO
	CREATE FUNCTION fn_GiaBanTrungBinh(@sodh CHAR(4))
	RETURNS MONEY
	AS
	BEGIN
		RETURN (SELECT AVG(GIABAN) 
				FROM CT_DONHANG
				WHERE SOHD = @sodh)
	END
	GO
	DECLARE @SOdh CHAR(4)
	PRINT DBO.fn_GiaBanTrungBinh('D001')

	-- Sau đó xây dựng thủ tục sp_ThongKeDonHang có sử dụng hàm fn_GiaBanTrungBinh để thống kê danh sách tất cả các đơn hàng
	GO
	CREATE PROC sp_ThongKeDonHang
	AS
	SELECT DONHANG.SOHD, NGAYDAT, NGAYGIAO, TENKH, TINHTRANG, DBO.fn_GiaBanTrungBinh(DONHANG.SOHD) AS GIABANTB
	FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD
	GO

	EXEC sp_ThongKeDonHang 
	GO
---------------------------------------------------------------------------------------------------------------------------
/*
a. Bổ sung cột tổng số hoa (SOHOA: int) trong 2 bảng LOAIHOA và CHUDE, cột tổng trị giá đơn hàng (TRIGIADH: money) trong bảng DONHANG.
*/
	ALTER TABLE LOAIHOA
	ADD SOHOA INT
	GO
	UPDATE LOAIHOA
	SET SOHOA = (SELECT COUNT(MAHOA) FROM HOA WHERE MALH = LOAIHOA.MALH)
	
	ALTER TABLE CHUDE
	ADD SOHOA INT
	GO	
	UPDATE CHUDE
	SET SOHOA = (SELECT COUNT(MAHOA) FROM HOA WHERE MACD = CHUDE.MACD)

	ALTER TABLE DONHANG
	ADD TRIGIADH MONEY
	GO
	UPDATE DONHANG
	SET TRIGIADH = (SELECT SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = DONHANG.SOHD)

/*
b. Hãy tạo các Trigger khi thêm – xóa – sửa dữ liệu của các bảng trong CSDL.
*/
-----CT_DONHANG--------
-----Thêm CT_DH-------------
	GO
	CREATE TRIGGER tg_ThemCT_DH ON CT_DONHANG
	INSTEAD OF INSERT
	AS

	DECLARE @sodh CHAR(4), @mahoa CHAR(4), @soluong INT, @giaban MONEY
	SELECT @sodh = SOHD, @mahoa = MAHOA, @soluong = SOLUONG, @giaban = GIABAN FROM inserted

	IF NOT EXISTS(SELECT SOHD FROM DONHANG WHERE SOHD = @sodh)
	BEGIN
		RAISERROR (N'SỐ HÓA ĐƠN KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END

	IF NOT EXISTS(SELECT MAHOA FROM HOA WHERE MAHOA = @mahoa)
	BEGIN
		RAISERROR (N'MÃ HOA KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END
	
	IF EXISTS(SELECT * FROM CT_DONHANG WHERE SOHD = @sodh AND MAHOA = @mahoa)
	BEGIN
		RAISERROR (N'ĐƠN HÀNG ĐÃ CÓ TRONG BẢNG', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @soluong < 0
	BEGIN
		RAISERROR (N'SỐ LƯỢNG PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @giaban < 0
	BEGIN
		RAISERROR (N'GIÁ BÁN PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	INSERT INTO CT_DONHANG VALUES(@sodh, @mahoa, @soluong, @giaban)

	UPDATE DONHANG
	SET TRIGIADH = (SELECT SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = @sodh)
	WHERE SOHD = @sodh
	
--------Xóa CT_DH---------------
	GO
	CREATE TRIGGER tg_XoaCT_DH ON CT_DONHANG
	INSTEAD OF DELETE
	AS

	DECLARE @sodh CHAR(4), @mahoa CHAR(4)
	SELECT @sodh = SOHD, @mahoa = MAHOA FROM DELETED

	IF NOT EXISTS (SELECT SOHD FROM DONHANG WHERE SOHD = @sodh)
	BEGIN
		RAISERROR (N'SỐ HÓA ĐƠN KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END
	IF NOT EXISTS (SELECT MAHOA FROM HOA WHERE MAHOA = @mahoa)
	BEGIN
		RAISERROR (N'MÃ HOA KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END

	DELETE CT_DONHANG WHERE SOHD = @sodh AND MAHOA = @mahoa

	UPDATE DONHANG
	SET TRIGIADH = (SELECT SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = @sodh)
	WHERE SOHD = @sodh

----------Sửa CT_DH-------------
	GO
	CREATE TRIGGER tg_SuaCT_DH ON CT_DONHANG
	INSTEAD OF UPDATE
	AS

	DECLARE @sodh CHAR(4), @mahoa CHAR(4), @soluongcu INT, @soluongmoi INT, @giabancu MONEY, @giabanmoi MONEY
	SELECT @soluongcu = SOLUONG, @giabancu = GIABAN FROM deleted
	SELECT @sodh = SOHD, @mahoa = MAHOA, @soluongmoi = SOLUONG, @giabanmoi = GIABAN FROM inserted

	IF UPDATE(SOHD) OR UPDATE(MAHOA)
	BEGIN
		RAISERROR (N'KHÔNG ĐƯỢC SỬA KHÓA CHÍNH', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @soluongmoi < 0
	BEGIN
		RAISERROR (N'SỐ LƯỢNG PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @giabanmoi < 0
	BEGIN
		RAISERROR (N'GIÁ BÁN PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END



	UPDATE CT_DONHANG 
	SET SOLUONG = @soluongmoi, GIABAN = @giabanmoi
	WHERE SOHD = @sodh AND MAHOA = @mahoa

	UPDATE DONHANG
	SET TRIGIADH = (SELECT SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = @sodh)
	WHERE SOHD = @sodh

	UPDATE CT_DONHANG
	SET SOLUONG = -5, GIABAN =-500000
	WHERE SOHD = 'D099' AND MAHOA = 'H019' 

---------HOA-----------
--------Thêm HOA-------
	GO
	CREATE TRIGGER tg_ThemHOA ON HOA
	INSTEAD OF INSERT
	AS

	DECLARE @mahoa CHAR(4), @tenhoa NVARCHAR(50), @ynghia NVARCHAR(50), @thanhphan NVARCHAR(100), @dongia MONEY, @hinhmh VARCHAR(15), @macd CHAR(4), @malh CHAR(4)
	SELECT @mahoa = MAHOA, @tenhoa = TENHOA, @ynghia = YNGHIA, @thanhphan = THANHPHAN, @dongia = DONGIA, @hinhmh = HINHMH, @macd = MACD, @malh = MALH FROM inserted

	IF NOT EXISTS (SELECT MACD FROM CHUDE WHERE MACD = @macd)
	BEGIN
		RAISERROR (N'CHỦ ĐỀ KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END
	
	IF NOT EXISTS (SELECT MALH FROM LOAIHOA WHERE MALH = @malh)
	BEGIN
		RAISERROR (N'MÃ LOẠI HOA KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END
	
	IF EXISTS (SELECT TENHOA FROM HOA WHERE TENHOA = @tenhoa)--AND MAHOA <> @mahoa
	BEGIN
		RAISERROR (N'TÊN HOA ĐÃ CÓ TRONG BẢNG', 16, 1)
		ROLLBACK
		RETURN
	END
	
	IF EXISTS (SELECT MAHOA FROM HOA WHERE MAHOA = @mahoa)
	BEGIN
		RAISERROR (N'MÃ HOA ĐÃ CÓ TRONG BẢNG', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @dongia < 0
	BEGIN 
		RAISERROR (N'ĐƠN GIÁ PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	INSERT INTO HOA VALUES(@mahoa, @tenhoa, @ynghia, @thanhphan, @dongia, @hinhmh, @macd, @malh)

	UPDATE CHUDE
	SET SOHOA = (SELECT COUNT(MACD) FROM HOA WHERE MACD = @macd)
	WHERE MACD = @macd

	UPDATE LOAIHOA
	SET SOHOA = (SELECT COUNT(MALH) FROM HOA WHERE MALH = @malh)
	WHERE MALH = @malh

------Xóa HOA----------
	GO
	CREATE TRIGGER tg_XoaHOA ON HOA
	INSTEAD OF DELETE
	AS

	DECLARE @mahoa CHAR(4), @malh CHAR(4), @macd CHAR(4)
	SELECT @mahoa = MAHOA FROM deleted

	IF EXISTS (SELECT * FROM CT_DONHANG WHERE MAHOA = @mahoa)
	BEGIN
		RAISERROR (N'HOA ĐÃ CÓ TRONG CHI TIẾT ĐƠN HÀNG', 16, 1)
		ROLLBACK
		RETURN
	END
	
	DELETE HOA WHERE MAHOA = @mahoa

	UPDATE CHUDE
	SET SOHOA = (SELECT COUNT(MACD) FROM HOA WHERE MACD = @macd)
	WHERE MACD = @macd

	UPDATE LOAIHOA
	SET SOHOA = (SELECT COUNT(MALH) FROM HOA WHERE MALH = @malh)
	WHERE MALH = @malh

-------Sửa HOA----------------
	GO
	CREATE TRIGGER tg_SuaHOA ON HOA
	INSTEAD OF UPDATE
	AS

	IF UPDATE(MAHOA)
	BEGIN
		RAISERROR (N'KHÔNG ĐƯỢC SỬA KHÓA CHÍNH', 16, 1)
		ROLLBACK
		RETURN
	END

	DECLARE @mahoa CHAR(4), @tenhoacu NVARCHAR(50), @tenhoamoi NVARCHAR(50) , @ynghiacu NVARCHAR(50), @ynghiamoi NVARCHAR(50), @thanhphancu NVARCHAR(100), @thanhphanmoi NVARCHAR(100), @dongiacu MONEY, @dongiamoi MONEY, @hinhmhcu VARCHAR(15), @hinhmhmoi VARCHAR(15), @malhcu CHAR(4), @malhmoi CHAR(4), @macdcu CHAR(4), @macdmoi CHAR(4)
	SELECT @tenhoacu, @ynghiacu, @thanhphancu, @dongiacu, @hinhmhcu, @malhcu, @macdcu FROM deleted
	SELECT @tenhoamoi = TENHOA, @ynghiamoi = YNGHIA, @thanhphanmoi = THANHPHAN, @dongiamoi = DONGIA, @hinhmhmoi = HINHMH, @malhmoi = MALH, @macdmoi = MACD FROM inserted 
	
	IF EXISTS(SELECT TENHOA FROM HOA WHERE TENHOA = @tenhoamoi)
	BEGIN
		RAISERROR (N'TÊN HOA ĐÃ CÓ TRONG BẢNG', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @dongiamoi < 0
	BEGIN
		RAISERROR (N'ĐƠN GIÁ PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	IF NOT EXISTS (SELECT MALH FROM LOAIHOA WHERE MALH = @malhmoi)
	BEGIN
		RAISERROR (N'MÃ LOẠI HOA KHÔNG CÓ TRONG BẢNG LOAIHOA', 16, 1)
		ROLLBACK
		RETURN
	END

	IF NOT EXISTS (SELECT MACD FROM CHUDE WHERE MACD = @macdmoi)
	BEGIN
		RAISERROR (N'MÃ CHỦ ĐỀ KHÔNG CÓ TRONG BẢNG CHUDE', 16, 1)
		ROLLBACK
		RETURN
	END

	UPDATE HOA
	SET TENHOA = @tenhoamoi, YNGHIA = @ynghiamoi, THANHPHAN = @thanhphanmoi, DONGIA = @dongiamoi, HINHMH = @hinhmhmoi, MACD = @macdmoi, MALH = @malhmoi
	WHERE MAHOA = @mahoa

	UPDATE CHUDE
	SET SOHOA = (SELECT COUNT(MACD) FROM HOA WHERE MACD = @macdmoi)
	WHERE MACD = @macdmoi

	UPDATE LOAIHOA
	SET SOHOA = (SELECT COUNT(MALH) FROM HOA WHERE MALH = @malhmoi)
	WHERE MALH = @malhmoi
	
---------------------------------------------------------------------------------------------------------------------------
/*
1. Cho biết đơn giá cao nhất của các kiểu hoa mà tên có chứa từ “Yêu” là bao nhiêu? Nếu lớn hơn 1.000.000đ thì in ra “Tăng đơn giá”, ngược lại in ra “Giữ nguyên đơn giá”.
*/
	DECLARE @max MONEY
	SELECT @max = MAX(DONGIA) 
	FROM HOA 
	WHERE TENHOA LIKE N'%YÊU%'
	
	IF @max > 1000000
		PRINT N'TĂNG ĐƠN GIÁ'
	ELSE
		PRINT N'GIỮ NGUYÊN ĐƠN GIÁ'
	
/*
2. Hãy cho biết hoa “Tri ân” được đặt hàng với số lượng trung bình là bao nhiêu, nếu có thì in ra “Hoa Tri Ân được đặt hàng với số lượng trung bình là xxx”, ngược lại thì in ra “Hoa Tri Ân chưa được đặt hàng”.
*/
	DECLARE @avg INT
	SELECT @avg = AVG(SOLUONG)
	FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA
	WHERE TENHOA = N'Tri ân'

	IF @avg > 0
		PRINT N'Hoa Tri Ân được đặt hàng với số lượng trung bình là: '+ CAST(@avg AS VARCHAR(3))
	ELSE
		PRINT N'Hoa Tri Ân chưa được đặt hàng'
	select * from HOA
/*
3. Duyệt cursor và xử lý hiển thị danh sách các chi tiết đơn hàng gồm các thông tin: số đơn hàng, ngày đặt, ngày giao và có thêm cột trị giá = tổng (số lượng * giá bán).
*/
	DECLARE cur_XuLyDS CURSOR
	FOR SELECT SOHD, NGAYDAT, NGAYGIAO FROM DONHANG

	OPEN cur_XuLyDS
	DECLARE @sohd CHAR(4), @ngdat DATETIME, @nggiao DATETIME, @trigia MONEY
	FETCH NEXT FROM cur_XuLyDS INTO @sohd, @ngdat, @nggiao
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @trigia = SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = @sohd
		PRINT @sohd +N', Ngày đặt: '+CONVERT(CHAR(10),@ngdat,105)+N', Ngày giao: '+CONVERT(CHAR(10),@nggiao,105)+' :'+CAST(@trigia AS VARCHAR(15))
		FETCH NEXT FROM cur_XuLyDS INTO @sohd, @ngdat, @nggiao
	END

	CLOSE cur_XuLyDS
	DEALLOCATE cur_XuLyDS
	
/*
4. Xây dựng thủ tục sp_DonHangTheoNgay(@tungay,@denngay) để hiển thị danh sách các đơn hàng đặt từ ngày @tungay đến ngày @denngay (mặc định cả 2 tham số truyền vào đều là null). Nếu ngày bắt đầu, ngày kết thúc là null thì lấy ngày hiện hành. Nếu ngày bắt đầu sau ngày kết thúc thì báo lỗi. Thông tin bao gồm: số đơn hàng, ngày đặt, tên hoa, số lượng, giá bán và thành tiền = (số lượng * giá bán).
*/
	GO
	CREATE PROC sp_DonHangTheoNgay(@tungay DATETIME = NULL,@denngay DATETIME = NULL)
	AS

	IF @tungay IS NULL
		SET @tungay = GETDATE()
	IF @denngay IS NULL 
		SET @denngay = GETDATE()
	IF @tungay > @denngay
		PRINT N'NGÀY KHÔNG HỢP LỆ'
	ELSE IF NOT EXISTS (SELECT * FROM DONHANG WHERE NGAYDAT BETWEEN @tungay AND @denngay)
		PRINT N'KHÔNG CÓ ĐƠN HÀNG TỪ NGÀY '+ CONVERT(CHAR(10),@tungay,105)+N' ĐẾN NGÀY '+ CONVERT(CHAR(10),@denngay,105)
	ELSE
		SELECT DONHANG.SOHD, NGAYDAT, TENHOA, SOLUONG, GIABAN, SOLUONG * GIABAN AS THANHTIEN
		FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD INNER JOIN HOA ON CT_DONHANG.MAHOA = HOA.MAHOA
		WHERE NGAYDAT BETWEEN @tungay AND @denngay
	GO

	EXEC sp_DonHangTheoNgay
		
	--GO
	--CREATE PROC spud_TongTriGiaDH (@ngayX DATETIME = NULL, @ngayY DATETIME = NULL)
	--AS
	--IF @ngayX is NULL
	--	SET @ngayX = GETDATE()
	--IF @ngayY is NULL
	--	SET @ngayY = GETDATE()
	--IF @ngayX > @ngayY
	--	PRINT N'KHOẢNG THỜI GIAN KHÔNG HỢP LỆ'
	--ELSE IF NOT EXISTS (SELECT * FROM DONHANG WHERE NGAYDAT BETWEEN @ngayX AND @ngayY)
	--	PRINT N'KHÔNG CÓ ĐƠN HÀNG TỪ NGÀY '+ CONVERT(CHAR(10),@ngayX,105)+ N' ĐẾN NGÀY '+ CONVERT(CHAR(10),@ngayY,105)
	--ELSE
	--	SELECT DONHANG.SOHD, NGAYDAT, NGAYGIAO,TENKH, TINHTRANG, SUM(SOLUONG*GIABAN) AS TONGTRIGIA
	--	FROM DONHANG INNER JOIN CT_DONHANG ON DONHANG.SOHD = CT_DONHANG.SOHD
	--	WHERE NGAYDAT BETWEEN @ngayX AND @ngayY
	--	GROUP BY DONHANG.SOHD, NGAYDAT, NGAYGIAO,TENKH, TINHTRANG
	--GO
	
	--EXEC spud_TongTriGiaDH '2019/04/01','2019/04/01'
	--GO

/*
5. Xây dựng thủ tục thêm, xóa, sửa dữ liệu trong bảng CTDONHANG, kiểm tra các ràng buộc dữ liệu phải hợp lệ trước khi thực hiện.
*/
	GO
	CREATE PROC sp_Them_CTDONHANG (@sodh CHAR(4), @mahoa CHAR(4), @soluong INT, @giaban MONEY, @loi NVARCHAR(250) OUTPUT)
	AS

	SET @loi = ''
	IF NOT EXISTS (SELECT SOHD FROM DONHANG WHERE SOHD = @sodh)
		SET @loi = @loi + N'SỐ ĐƠN HÀNG KHÔNG TỒN TẠI' + CHAR(13)
	IF NOT EXISTS (SELECT MAHOA FROM HOA WHERE MAHOA = @mahoa)
		SET @loi = @loi + N'MÃ HOA KHÔNG TỒN TẠI' + CHAR(13)
	IF @soluong < 0 OR @giaban < 0
		SET @loi = @loi + N'DỮ LIỆU CHƯA CHÍNH XÁC' + CHAR(13)
	IF @loi = ''
	BEGIN
		INSERT INTO CT_DONHANG VALUES (@sodh, @mahoa, @soluong, @giaban)
		SET @loi = N'ĐÃ THÊM THÀNH CÔNG' + CHAR(13)
	END

	DECLARE @chuoi NVARCHAR(250)
	EXEC sp_Them_CTDONHANG 'D001', 'H012', 9, 90000, @chuoi OUTPUT
	PRINT @chuoi

------------------------------------------	
	GO
	CREATE PROC sp_Xoa_CTDONHANG (@sodh CHAR(4), @mahoa CHAR(4), @loi NVARCHAR(250) OUTPUT)
	AS

	SET @loi = ''
	IF NOT EXISTS (SELECT SOHD FROM CT_DONHANG WHERE SOHD = @sodh)
		SET @loi = @loi + N'SỐ ĐƠN HÀNG KHÔNG CÓ TRONG BẢNG' + CHAR(13)
	IF NOT EXISTS (SELECT MAHOA FROM CT_DONHANG WHERE MAHOA = @mahoa)
		SET @loi = @loi + N'MÃ HOA KHÔNG CÓ TRONG BẢNG' + CHAR(13)
	IF NOT EXISTS (SELECT * FROM CT_DONHANG WHERE SOHD = @sodh AND MAHOA = @mahoa)
		SET @loi = @loi + N'ĐƠN HÀNG KHÔNG CÓ TỒN TẠI' + CHAR(13)
	IF @loi = ''
	BEGIN
		DELETE CT_DONHANG WHERE MAHOA = @mahoa AND SOHD = @sodh
		SET @loi = N'ĐÃ XÓA THÀNH CÔNG'
	END
	GO

	DECLARE @chuoi NVARCHAR(250)
	EXEC sp_Xoa_CTDONHANG 'D001', 'H012', @chuoi OUTPUT
	PRINT @chuoi

--------------------------------------------
	GO
	CREATE PROC sp_Sua_CTDONHANG (@sodh CHAR(4), @mahoa CHAR(4), @soluong INT, @giaban MONEY, @loi NVARCHAR(250) OUTPUT)
	AS

	SET @loi = ''
	IF @soluong < 0 OR @giaban < 0 
		SET @loi = @loi + N'DỮ LIỆU KHÔNG CHÍNH XÁC' + CHAR(13)
	IF NOT EXISTS (SELECT SOHD FROM DONHANG WHERE SOHD = @sodh)
		SET @loi = @loi + N'SỐ ĐƠN HÀNG KHÔNG TỒN TẠI' + CHAR(13)
	IF NOT EXISTS (SELECT MAHOA FROM HOA WHERE MAHOA = @mahoa)
		SET @loi = @loi + N'MÃ HOA KHÔNG TÒN TẠI' + CHAR(13)
	IF NOT EXISTS (SELECT SOHD, MAHOA FROM CT_DONHANG WHERE MAHOA = @mahoa AND SOHD = @sodh)
		SET @loi = @loi + N'ĐƠN HÀNG KHÔNG CÓ TRONG BẢNG' + CHAR(13)
	IF @loi = ''
	BEGIN
		UPDATE CT_DONHANG
		SET SOLUONG = @soluong, GIABAN = @giaban
		WHERE SOHD = @sodh AND MAHOA = @mahoa
		SET @loi = N'ĐÃ CẬP NHẬT THÀNH CÔNG' + CHAR(13)
	END

	DECLARE @chuoi NVARCHAR(250)
	EXEC sp_Sua_CTDONHANG 'D001','H012',10,900000, @chuoi OUTPUT
	PRINT @chuoi

/*
6. Xây dựng hàm fn_TriGiaDonHang(@sodh) trả về trị giá đơn hàng = tổng (số lượng * giá bán) với số đơn hàng truyền vào.
*/
	GO
	CREATE FUNCTION fn_TriGiaDonHang(@sodh CHAR(4))
	RETURNS MONEY
	AS
	BEGIN
		DECLARE @trigia MONEY
		SELECT @trigia = SUM(SOLUONG * GIABAN) 
		FROM CT_DONHANG
		WHERE SOHD = @sodh
		RETURN @trigia
	END
	GO

	PRINT DBO.fn_TriGiaDonHang('D001')

/*
7. Xây dựng hàm fn_ChiTietDonHang(@sodh) trả về chuỗi danh sách tên các hoa và số lượng tương ứng với số đơn hàng truyền vào.
*/
	GO
	CREATE FUNCTION fn_ChiTietDonHang(@sodh CHAR(4))
	RETURNS NVARCHAR(250)
	AS
	BEGIN
		DECLARE @chuoi NVARCHAR(250) =''
		SELECT @chuoi = @chuoi + TENHOA+ ' : '+ CAST(SOLUONG AS varchar(3)) + CHAR(13)
		FROM HOA INNER JOIN CT_DONHANG ON HOA.MAHOA = CT_DONHANG.MAHOA INNER JOIN DONHANG ON CT_DONHANG.SOHD = DONHANG.SOHD
		WHERE DONHANG.SOHD = @sodh
		RETURN @chuoi
	END

	PRINT DBO.fn_ChiTietDonHang('D001')

/*
8. Bổ sung cột TRỊ GIÁ (kiểu money) trong bảng DONHANG, tính toán và cập nhật lại giá trị cho cột này. Sau đó, xây dựng trigger tg_ThemCTDonHang ứng với hành động thêm dữ liệu vào bảng CTDONHANG. Trong trigger phải kiểm tra dữ liệu thêm mới không vi phạm các ràng buộc và cập nhật lại trị giá đơn hàng sau khi thêm.
*/
	ALTER TABLE DONHANG
	ADD TRIGIADH MONEY
	GO
	UPDATE DONHANG
	SET TRIGIADH = (SELECT SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = DONHANG.SOHD)

		GO
	CREATE TRIGGER tg_ThemCT_DH ON CT_DONHANG
	INSTEAD OF INSERT
	AS

	DECLARE @sodh CHAR(4), @mahoa CHAR(4), @soluong INT, @giaban MONEY
	SELECT @sodh = SOHD, @mahoa = MAHOA, @soluong = SOLUONG, @giaban = GIABAN FROM inserted

	IF NOT EXISTS(SELECT SOHD FROM DONHANG WHERE SOHD = @sodh)
	BEGIN
		RAISERROR (N'SỐ HÓA ĐƠN KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END

	IF NOT EXISTS(SELECT MAHOA FROM HOA WHERE MAHOA = @mahoa)
	BEGIN
		RAISERROR (N'MÃ HOA KHÔNG TỒN TẠI', 16, 1)
		ROLLBACK
		RETURN
	END
	
	IF EXISTS(SELECT * FROM CT_DONHANG WHERE SOHD = @sodh AND MAHOA = @mahoa)
	BEGIN
		RAISERROR (N'ĐƠN HÀNG ĐÃ CÓ TRONG BẢNG', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @soluong < 0
	BEGIN
		RAISERROR (N'SỐ LƯỢNG PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @giaban < 0
	BEGIN
		RAISERROR (N'GIÁ BÁN PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	INSERT INTO CT_DONHANG VALUES(@sodh, @mahoa, @soluong, @giaban)

	UPDATE DONHANG
	SET TRIGIADH = (SELECT SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = @sodh)
	WHERE SOHD = @sodh

/*
9. Xây dựng trigger tg_SuaCTDonHang ứng với hành động sửa dữ liệu trong bảng CTDONHANG. Trong trigger phải kiểm tra dữ liệu chỉnh sửa không vi phạm các ràng buộc và cập nhật lại trị giá đơn hàng sau khi sửa.
*/
	GO
	CREATE TRIGGER tg_SuaCT_DH ON CT_DONHANG
	INSTEAD OF UPDATE
	AS

	DECLARE @sodh CHAR(4), @mahoa CHAR(4), @soluongcu INT, @soluongmoi INT, @giabancu MONEY, @giabanmoi MONEY
	SELECT @soluongcu = SOLUONG, @giabancu = GIABAN FROM deleted
	SELECT @sodh = SOHD, @mahoa = MAHOA, @soluongmoi = SOLUONG, @giabanmoi = GIABAN FROM inserted

	IF UPDATE(SOHD) OR UPDATE(MAHOA)
	BEGIN
		RAISERROR (N'KHÔNG ĐƯỢC SỬA KHÓA CHÍNH', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @soluongmoi < 0
	BEGIN
		RAISERROR (N'SỐ LƯỢNG PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	IF @giabanmoi < 0
	BEGIN
		RAISERROR (N'GIÁ BÁN PHẢI > 0', 16, 1)
		ROLLBACK
		RETURN
	END

	UPDATE CT_DONHANG 
	SET SOLUONG = @soluongmoi, GIABAN = @giabanmoi
	WHERE SOHD = @sodh AND MAHOA = @mahoa

	UPDATE DONHANG
	SET TRIGIADH = (SELECT SUM(SOLUONG * GIABAN) FROM CT_DONHANG WHERE SOHD = @sodh)
	WHERE SOHD = @sodh

	UPDATE CT_DONHANG
	SET SOLUONG = -5, GIABAN =-500000
	WHERE SOHD = 'D099' AND MAHOA = 'H019' 
