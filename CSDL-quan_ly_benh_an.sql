-- Tạo CSDL QLBenhAn
	USE MASTER
	GO
	IF EXISTS (SELECT*FROM MASTER..SYSDATABASES WHERE NAME = 'QLBenhAn')
	DROP DATABASE  QLBenhAn
	GO
	CREATE DATABASE QLBenhAn
	GO
	--Sử dụng CSDL QL_BAN_HOA
	USE QLBenhAn
	GO

-- Tạo các bảng 
create table THUOC (
mathuoc char(4) not null,
tenthuoc nvarchar(50),
dvt nvarchar(10),
dongia int
)

create table BENH_NHAN (
sobn char(3) not null,
tenbn nvarchar(40),
nam bit,
ngaysinh datetime
)

create table BENH_AN (
soba char(3) not null,
ngaykham datetime,
sobn char(3),
tenbenh nvarchar(100),
tienkham money
)

create table DON_THUOC (
soba char(3) not null,
mathuoc char(4) not null,
soluong int
)

go

-- Định nghĩa các ràng buộc của các bảng

alter table THUOC
add constraint PK_THUOC_mathuoc primary key(mathuoc),
constraint UQ_THUOC_tenthuoc unique (tenthuoc),
constraint CK_THUOC_dongia check(dongia>0)

alter table BENH_NHAN
add constraint PK_BENH_NHAN_sobn primary key(sobn)

alter table BENH_AN
add constraint PK_BENH_AN_soba primary key(soba),
constraint FK_BENH_AN_sobn foreign key(sobn) references BENH_NHAN(sobn),
constraint CK_BENH_AN_tienkham check(tienkham>=0),
constraint DF_BENH_AN_tienkham default 0 for tienkham

alter table DON_THUOC
add constraint PK_DON_THUOC_soba_mathuoc primary key (soba,mathuoc),
constraint FK_DON_THUOC_soba foreign key(soba) references BENH_AN(soba),
constraint FK_DON_THUOC_mathuoc foreign key(mathuoc) references THUOC(mathuoc),
constraint CK_DON_THUOC_soluong check(soluong>0),
constraint DF_DON_THUOC_soluong default 1 for soluong

go

-- Nhập dữ liệu mẫu cho các bảng

insert into THUOC values ('A001',N'Ampicyl 500',N'Viên',1000)
insert into THUOC values ('A002',N'Aspirine 500',N'Viên',1000)
insert into THUOC values ('A003',N'Ampi 1G chích',N'Ống',2000)
insert into THUOC values ('D002',N'Deltasone 5mg',N'Viên',2000)
insert into THUOC values ('E001',N'Erythromycine 500',N'Viên',3000)
insert into THUOC values ('F001',N'Famotidin 40mg',N'Gói',10000)
insert into THUOC values ('T001',N'Tetraxyclin 500mg',N'Gói',2500)

insert into BENH_NHAN values ('A01',N'Hoàng Thị Ngọc Anh',0,'4/18/1956')
insert into BENH_NHAN values ('B01',N'Trần Văn Bình',1,'11/12/1963')
insert into BENH_NHAN values ('C01',N'Lê Thị Châu',0,'1/1/1972')
insert into BENH_NHAN values ('C02',N'Nguyễn Văn Chính',1,'8/6/1965')
insert into BENH_NHAN values ('D01',N'Lê Văn Dũng',1,'9/2/1972')

insert into BENH_AN values ('001','2012-2-15','A01',N'Nhức đầu',0)
insert into BENH_AN values ('002','2012-3-7','B01',N'Cảm sốt',0)
insert into BENH_AN values ('003','2012-4-23','C01',N'Viêm phế quản',0)
insert into BENH_AN values ('004','2012-5-1','C02',N'Viêm dạ dày',0)
insert into BENH_AN values ('005','2012-5-1','D01',N'Viêm họng',0)

insert into DON_THUOC values ('001','A002',10)
insert into DON_THUOC values ('001','E001',10)
insert into DON_THUOC values ('002','A001',20)
insert into DON_THUOC values ('002','D002',20)
insert into DON_THUOC values ('003','A001',18)
insert into DON_THUOC values ('003','T001',3)
insert into DON_THUOC values ('003','D002',6)
insert into DON_THUOC values ('004','F001',15)
insert into DON_THUOC values ('004','A001',5)
insert into DON_THUOC values ('005','A001',8)
insert into DON_THUOC values ('005','D002',4)

select * from BENH_NHAN
select * from BENH_AN
select * from DON_THUOC
select * from THUOC

/*
Câu 1. Cho biết tổng số lượng thuốc đã cấp cho các bệnh án mà tên bệnh có chứa từ “viêm”? Nếu số lượng này lớn hơn 20 thì in ra “Nhập thêm thuốc kháng sinh”, ngược lại thì in ra “Không cần nhập thêm thuốc kháng sinh”.
*/
	DECLARE @tongsoluong INT
	SELECT @tongsoluong = SUM(soluong)
	FROM DON_THUOC INNER JOIN BENH_AN ON DON_THUOC.soba = BENH_AN.soba
	WHERE tenbenh LIKE N'%viêm%'
	PRINT N'Tổng số lượng thuốc đã cấp cho các bệnh án mà tên bệnh có chứa từ “viêm” là: '+CAST(@tongsoluong AS VARCHAR(3))

	IF @tongsoluong >= 20 
		PRINT N'Nhập thêm thuốc kháng sinh'
	ELSE
		PRINT N'Không cần nhập thêm thuốc kháng sinh'

/*
Câu 2. Cho biết thuốc “Aspirine 500” đã cấp cho bao nhiêu bệnh án? Nếu có thì in ra “Thuốc Aspirine 500 đã cấp cho xxx bệnh án”, ngược lại thì in ra “Thuốc Aspirine 500 chưa cấp cho bệnh án nào”.
*/
	DECLARE @dem INT
	SELECT @dem = COUNT(*)
	FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc INNER JOIN BENH_AN ON DON_THUOC.soba = BENH_AN.soba
	WHERE tenthuoc = 'Aspirine 500'
	PRINT @dem

	IF @dem > 0
		PRINT N'Thuốc Aspirine 500 đã cấp cho '+ CAST(@dem AS VARCHAR(3))+N' bệnh án'
	ELSE
		PRINT N'Thuốc Aspirine 500 chưa cấp cho bệnh án nào'

/*
Câu 3. Duyệt cursor và xử lý hiển thị danh sách các bệnh án gồm các thông tin: mã số bệnh án, ngày khám bệnh, tên bệnh nhân, và có thêm cột tổng số loại thuốc đã cấp.
*/
	DECLARE cur_XuLyDanhSach CURSOR
	FOR SELECT soba, ngaykham, tenbn FROM BENH_AN INNER JOIN BENH_NHAN ON BENH_AN.sobn = BENH_NHAN.sobn

	OPEN cur_XuLyDanhSach
	DECLARE @so_ba CHAR(3), @ngkham DATETIME, @ten_bn NVARCHAR(40), @tongsoloaithuoc INT
	FETCH NEXT FROM cur_XuLyDanhSach INTO @so_ba, @ngkham, @ten_bn
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @tongsoloaithuoc = COUNT(mathuoc)
		FROM DON_THUOC
		WHERE DON_THUOC.soba = @so_ba

		PRINT @so_ba+', '+CONVERT(CHAR(10),@ngkham,105)+', '+@ten_bn+N', tổng số loại thuốc đã cấp: '+CAST(@tongsoloaithuoc AS VARCHAR(5))
		FETCH NEXT FROM cur_XuLyDanhSach INTO @so_ba, @ngkham, @ten_bn 
	END

	CLOSE cur_XuLyDanhSach
	DEALLOCATE cur_XuLyDanhSach
	
/*
Câu 4. Xây dựng thủ tục sp_ChiTietBenhAn với 3 tham số truyền vào là: mã số bệnh nhân, ngày bắt đầu và ngày kết thúc (mặc định cả 3 tham số truyền vào này đều là null). 
Trong thủ tục, kiểm tra 2 giá trị ngày bắt đầu và ngày kết thúc truyền vào nếu là null thì gán giá trị ngày hiện hành. Nếu ngày bắt đầu sau ngày kết thúc thì in thông báo “Ngày bắt đầu phải trước ngày kết thúc”. 
Nếu mã số bệnh nhân là null thì in danh sách các bệnh án của tất cả bệnh nhân trong khoảng thời gian khám bệnh từ ngày bắt đầu đến ngày kết thúc, gồm các thông tin sau: mã số bệnh nhân, tên bệnh nhân, ngày khám bệnh, tên bệnh, tên thuốc, số lượng.
Ngược lại thì chỉ in ra in danh sách các bệnh án của bệnh nhân có mã số là tham số truyền vào.
*/
	GO
	CREATE PROC sp_ChiTietBenhAn(@mabn CHAR(3) = NULL, @ngaybd DATETIME = NULL, @ngaykt DATETIME = NULL)
	AS
	IF @ngaybd IS NULL 
		SET @ngaybd = GETDATE()
	IF @ngaykt IS NULL 
		SET @ngaykt = GETDATE()
	IF @ngaybd > @ngaykt
	BEGIN
		PRINT N'Ngày bắt đầu phải trước ngày kết thúc'
		RETURN
	END
	IF @mabn IS NULL
		IF NOT EXISTS (SELECT soba FROM BENH_AN WHERE ngaykham BETWEEN @ngaybd AND @ngaykt)
			PRINT N'KHÔNG CÓ BỆNH ÁN TỪ NGÀY '+CONVERT(CHAR(10),@ngaybd,105)+N' ĐẾN NGÀY '+CONVERT(CHAR(10),@ngaykt,105)
		ELSE
			SELECT BENH_AN.sobn, tenbn, ngaykham, tenbenh, tenthuoc, soluong
			FROM BENH_NHAN INNER JOIN BENH_AN ON BENH_NHAN.sobn = BENH_AN.sobn INNER JOIN DON_THUOC ON BENH_AN.soba = DON_THUOC.soba INNER JOIN THUOC ON DON_THUOC.mathuoc = THUOC.mathuoc
			WHERE ngaykham BETWEEN @ngaybd AND @ngaykt
	ELSE 
		IF NOT EXISTS (SELECT sobn FROM BENH_NHAN WHERE  sobn = @mabn)
			PRINT N'BỆNH NHÂN KHÔNG CÓ'
		ELSE IF NOT EXISTS (SELECT soba FROM BENH_AN WHERE sobn = @mabn AND ngaykham BETWEEN @ngaybd AND @ngaykt)
			PRINT N'BỆNH NHÂN KHÔNG KHÁM TỪ NGÀY '+CONVERT(CHAR(10),@ngaybd,105)+N' ĐẾN NGÀY '+CONVERT(CHAR(10),@ngaykt,105)
		ELSE
			SELECT BENH_AN.sobn, tenbn, ngaykham, tenbenh, tenthuoc, soluong
			FROM BENH_NHAN INNER JOIN BENH_AN ON BENH_NHAN.sobn = BENH_AN.sobn INNER JOIN DON_THUOC ON BENH_AN.soba = DON_THUOC.soba INNER JOIN THUOC ON DON_THUOC.mathuoc = THUOC.mathuoc
			WHERE BENH_NHAN.sobn = @mabn AND ngaykham BETWEEN @ngaybd AND @ngaykt
	GO

	EXEC sp_ChiTietBenhAn NULL,NULL,NULL

/*
Câu 5. Xây dựng thủ tục thêm, xóa, sửa dữ liệu trong bảng DON_THUOC, kiểm tra các ràng buộc dữ liệu phải hợp lệ trước khi thực hiện.
*/
--Thêm dữ liệu vào bảng
	--+Kiểm tra ràng buộc dữ liệu duy nhất (Primary Key, Unique)
	--+Kiểm tra ràng buộc khóa ngoại (Foreign Key)
	--+Kiểm tra ràng buộc miền giá trị (Check)
	--+Nếu vi phạm các ràng buộc thì không cho thêm dữ liệu mới
	--+Ngược lại thì: 
	--	Thêm dữ liệu mới vào bảng
	--	Cập nhật dữ liệu của các bảng liên quan (nếu có)
	--	Hiển thị thông báo đã thêm dữ liệu thành công
	GO
	CREATE PROC sp_ThemDuLieu_DON_THUOC(@soba CHAR(3), @mathuoc CHAR(4), @soluong INT, @kq NVARCHAR(250) OUTPUT)
	AS
	SET @kq = ''
	IF NOT EXISTS (SELECT soba FROM BENH_AN WHERE soba = @soba)
		SET @kq = @kq + N'SỐ BỆNH ÁN KHÔNG CÓ' + CHAR(13)	
	IF NOT EXISTS (SELECT mathuoc FROM THUOC WHERE mathuoc = @mathuoc)
		SET @kq = @kq + N'MÃ THUỐC KHÔNG CÓ' + CHAR(13)
	IF EXISTS (SELECT * FROM DON_THUOC WHERE soba = @soba AND mathuoc = @mathuoc)
		SET @kq = @kq + N'ĐƠN THUỐC ĐÃ CÓ' + CHAR(13)
	IF @soluong < 1
		SET @kq = @kq + N'SỐ LƯỢNG KHÔNG HỢP LỆ' + CHAR(13)
	IF @kq = ''
	BEGIN
		INSERT INTO DON_THUOC VALUES(@soba, @mathuoc,@soluong)
		SET @kq = N'ĐÃ THÊM ĐƠN THUỐC THÀNH CÔNG' + CHAR(13)
	END
	GO

	DECLARE @chuoi NVARCHAR(250)
	EXEC sp_ThemDuLieu_DON_THUOC '006','A099',-1, @chuoi OUTPUT
	PRINT @chuoi

--Xóa dữ liệu của bảng
	--+Kiểm tra tham số vào có hợp lệ không? Nếu không thì thông báo lỗi
	--+Kiểm tra dữ liệu xóa có tồn tại trong bảng nhiều(N) không? Nếu có thì không cho xóa dữ liệu vì vi phạm dữ liệu liên quan
	--+Ngược lại thì: 
	--	Xóa dữ liệu của bảng
	--	Cập nhật dữ liệu của các bảng liên quan (nếu có)
	--	Hiển thị thông báo đã xóa dữ liệu thành công
	GO 
	CREATE PROC sp_Xoa_DON_THUOC(@soba CHAR(3), @mathuoc CHAR(4), @kq NVARCHAR(250) OUTPUT)
	AS
	SET @kq = ''
	IF NOT EXISTS (SELECT * FROM DON_THUOC WHERE soba = @soba)
		SET @kq = @kq + N'MÃ BỆNH ÁN KHÔNG CÓ TRONG BẢNG DON_THUOC' + CHAR(13)
	IF NOT EXISTS (SELECT * FROM DON_THUOC WHERE mathuoc = @mathuoc)
		SET @kq = @kq + N'MÃ THUỐC KHÔNG CÓ TRONG BẢNG DON_THUOC' + CHAR(13)
	IF NOT EXISTS (SELECT * FROM DON_THUOC WHERE soba = @soba AND mathuoc = @mathuoc)
		SET @kq = @kq + N'ĐƠN THUỐC KHÔNG CÓ TRONG BẢNG' + CHAR(13)
	IF @kq = ''
	BEGIN
		DELETE DON_THUOC WHERE soba = @soba AND mathuoc = @mathuoc
		SET @kq = N'ĐÃ XÓA THÀNH CÔNG'
	END
	GO

	DECLARE @chuoi NVARCHAR(250)
	EXEC sp_Xoa_DON_THUOC '006','E001', @chuoi OUTPUT
	PRINT @chuoi

--Sửa dữ liệu của bảng
	--+Kiểm tra dữ liệu sửa có tồn tại hay không? Nếu không thì thông báo lỗi
	--+Kiểm tra các ràng buộc: dữ liệu duy nhất, khóa ngoại và miền giá trị
	--+Sửa dữ liệu của bảng (không sửa cột làm khóa chính và cột có thuộc tính tự tăng identity)
	--+Cập nhật dữ liệu của các bảng liên quan (nếu có)
	--+Hiển thị thông báo đã sửa dữ liệu thành công
	GO
	CREATE PROC sp_Sua_DON_HANG(@soba CHAR(3), @mathuoc CHAR(4), @soluong INT, @kq NVARCHAR(250) OUTPUT)
	AS
	SET @kq = ''
	IF NOT EXISTS (SELECT * FROM BENH_AN WHERE soba = @soba)
		SET @kq = @kq + N'MÃ BỆNH ÁN KHÔNG TỒN TẠI' + CHAR(13)
	IF NOT EXISTS(SELECT * FROM THUOC WHERE mathuoc = @mathuoc)
		SET @kq = @kq + N'MÃ THUỐC KHÔNG TỒN TẠI' + CHAR(13)
	IF NOT EXISTS (SELECT * FROM DON_THUOC WHERE soba = @soba AND mathuoc = @mathuoc)
		SET @kq = @kq + N'ĐƠN THUỐC KHÔNG CÓ TRONG BẢNG DON_THUOC' + CHAR(13)
	IF @soluong < 1
		SET @kq = @kq + N'SỐ LƯỢNG KHÔNG HỢP LỆ' + CHAR(13)
	IF @kq = ''
	BEGIN
		UPDATE DON_THUOC
		SET soluong = @soluong WHERE soba = @soba AND mathuoc = @mathuoc
		SET @kq = N'ĐÃ CẬP NHẬT ĐƠN THUỐC THÀNH CÔNG'
	END
	GO
	
	DECLARE @chuoi NVARCHAR(250)
	EXEC sp_Sua_DON_HANG '006','E001',10, @chuoi OUTPUT
	PRINT @chuoi
	
/*
Câu 6. Xây dựng hàm fn_SoBA_BN(@sobn) trả về số bệnh án của bệnh nhân có mã số truyền vào.
*/
	GO
	CREATE FUNCTION fn_SoBA_BN(@sobn CHAR(3))
	RETURNS NVARCHAR(50)
	AS
	BEGIN
		DECLARE @chuoi NVARCHAR(50)=''
		SELECT @chuoi = @chuoi +soba+ CHAR(13)
		FROM BENH_AN WHERE sobn = @sobn
		--SET @chuoi = LEFT(@chuoi, LEN(@chuoi)-1)
		RETURN @chuoi
	END
	GO

	PRINT DBO.fn_SoBA_BN('A01')

/*
Câu 7. Xây dựng hàm fn_DanhSachThuoc(@soba) trả về chuỗi danh sách tên các thuốc và số lượng tương ứng của bệnh án có mã số truyền vào.
*/
	GO
	CREATE FUNCTION fn_DanhSachThuoc(@soba CHAR(3))
	RETURNS NVARCHAR(255)
	AS
	BEGIN
		DECLARE @chuoikq NVARCHAR(255)=''
		SELECT @chuoikq = @chuoikq + tenthuoc+' : '+CAST(soluong AS VARCHAR(3)) + CHAR(13)
		FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc
		WHERE soba = @soba
		--SET @chuoikq = LEFT(@chuoikq,LEN(@chuoikq)-1)
		RETURN @chuoikq
	END
	GO

	PRINT DBO.fn_DanhSachThuoc('002')

/*
Câu 8. Xây dựng trigger ứng với hành động thêm, xóa, sửa bảng DON_THUOC.
*/
	UPDATE BENH_AN
	SET tienkham = (SELECT SUM(soluong * dongia) FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc WHERE soba = BENH_AN.soba) + 100000

---------------------INSTEAD OF ---------------------------

---------Thêm DON THUOC
	GO
	CREATE TRIGGER tg_Them_DT ON DON_THUOC
	INSTEAD OF INSERT
	AS

	DECLARE @soba CHAR(3), @mathuoc CHAR(4), @soluong INT 
	SELECT @soba = soba, @mathuoc = @mathuoc, @soluong = soluong FROM inserted
	
	IF NOT EXISTS(SELECT soba FROM BENH_AN WHERE soba = @soba)
	BEGIN
		RAISERROR(N'SỐ BỆNH ÁN KHÔNG TỒN TẠI',16,1)
		ROLLBACK
		RETURN
	END
	
	IF NOT EXISTS(SELECT mathuoc FROM THUOC WHERE mathuoc = @mathuoc)
	BEGIN
		RAISERROR(N'MÃ THUỐC KHÔNG TỒN TẠI',16,1)
		ROLLBACK
		RETURN
	END
	
	IF EXISTS(SELECT * FROM DON_THUOC WHERE soba = @soba AND mathuoc = @mathuoc)
	BEGIN
		RAISERROR(N'ĐƠN THUỐC ĐÃ CÓ',16,1)
		ROLLBACK
		RETURN
	END
	
	IF @soluong < 0
	BEGIN
		RAISERROR(N'SỐ LƯỢNG PHẢI > 0',16,1)
		ROLLBACK
		RETURN
	END

	INSERT INTO DON_THUOC VALUES (@soba, @mathuoc, @soluong)
	
	UPDATE BENH_AN
	SET tienkham = (SELECT SUM(dongia * soluong) FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc WHERE soba = @soba) + 100000
	WHERE soba = @soba
	
----------Xóa DON THUOC
	GO
	CREATE TRIGGER tg_Xoa_DT ON DON_THUOC
	INSTEAD OF DELETE
	AS

	DECLARE @soba CHAR(3), @mathuoc CHAR(4)
	SELECT @soba = soba, @mathuoc = @mathuoc FROM deleted

	DELETE DON_THUOC WHERE soba = @soba AND mathuoc = @mathuoc

	UPDATE BENH_AN
	SET tienkham = (SELECT SUM(dongia * soluong) FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc WHERE soba = @soba) + 100000
	WHERE soba = @soba
	
----------Sửa DON_THUOC
	GO
	CREATE TRIGGER tg_Sua_DT ON DON_THUOC
	INSTEAD OF UPDATE
	AS
	
	DECLARE @soba CHAR(3), @mathuoc CHAR(4), @soluongcu INT, @soluongmoi INT
	SELECT @soluongcu = soluong  FROM deleted
	SELECT @soba = soba, @mathuoc = @mathuoc, @soluongmoi = soluong FROM inserted

	IF UPDATE(soba) OR UPDATE(mathuoc)
	BEGIN
		RAISERROR (N'KHÔNG ĐƯỢC SỬA KHÓA CHÍNH', 16, 1)
		ROLLBACK
		RETURN
	END
	
	IF @soluongmoi < 0
	BEGIN
		RAISERROR(N'SỐ LƯỢNG PHẢI > 0',16,1)
		ROLLBACK
		RETURN
	END

	UPDATE DON_THUOC
	SET soluong = @soluongmoi WHERE soba = @soba AND mathuoc = @mathuoc
	
	UPDATE BENH_AN
	SET tienkham = (SELECT SUM(soluong * dongia) FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc WHERE soba = @soba) + 100000
	WHERE soba = @soba

------------FOR/AFTER--------------------

---------Thêm DON_THUOC
	GO
	CREATE TRIGGER tg_THEM_DON_THUOC ON DON_THUOC
	AFTER INSERT
	AS

	DECLARE @soba CHAR(3), @mathuoc CHAR(4), @soluong INT 
	SELECT @soba = soba, @mathuoc = mathuoc, @soluong = soluong FROM inserted

	UPDATE BENH_AN
	SET tienkham = (SELECT SUM(soluong * dongia) FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc WHERE sobn = @soba) + 100000
	WHERE soba = @soba

--------Xóa DON_THUOC
	GO
	CREATE TRIGGER tg_XOA_DON_THUOC ON DON_THUOC
	AFTER DELETE
	AS

	DECLARE @soba CHAR(3), @mathuoc CHAR(4)
	SELECT @soba = soba, @mathuoc = mathuoc FROM deleted
	
	DELETE DON_THUOC WHERE soba = @soba AND mathuoc = @mathuoc

	UPDATE BENH_AN
	SET tienkham = (SELECT SUM(soluong * dongia) FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc WHERE sobn = @soba) + 100000
	WHERE soba = @soba

-------Sửa DON_THUOC
	GO
	CREATE TRIGGER tg_SUA_DON_THUOC ON DON_THUOC
	AFTER UPDATE
	AS

	IF UPDATE(soba) OR UPDATE(mathuoc)
	BEGIN
		RAISERROR (N'KHÔNG ĐƯỢC SỬA KHÓA CHÍNH', 16, 1)
		ROLLBACK
		RETURN
	END

	DECLARE @soba CHAR(3), @mathuoc CHAR(4), @soluongcu INT, @soluongmoi INT
	SELECT @soluongcu = soluong FROM deleted
	SELECT @soba = soba, @mathuoc= mathuoc, @soluongmoi = soluong FROM inserted
	
	UPDATE DON_THUOC
	SET soluong = @soluongmoi WHERE soba = @soba AND mathuoc = @mathuoc

	UPDATE BENH_AN
	SET tienkham = (SELECT SUM(soluong * dongia) FROM THUOC INNER JOIN DON_THUOC ON THUOC.mathuoc = DON_THUOC.mathuoc WHERE sobn = @soba) + 100000
	WHERE soba = @soba
	GO