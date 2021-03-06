-----Tao co so du lieu
CREATE DATABASE QLBanHang 
ON 
     PRIMARY (NAME = QLBanHang_Data, 
     FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\QLBanHang_Data.MDF' , 
     SIZE = 50MB , 
     MAXSIZE = 200MB , 
     FILEGROWTH = 10MB) 
LOG ON (NAME = QLBanHang_Log , 
     FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\QLBanHang_Log.LDB' , 
     SIZE = 10MB, 
     FILEGROWTH = 5MB) 
GO 
-----Chon co so du lieu lam viec
USE QLBanHang
GO
-----Tao cac bang
CREATE TABLE VatTu
( mavtu NCHAR(4) PRIMARY KEY,
  tenvtu NVARCHAR(100),
  dvtinh NVARCHAR(10),
  phantram REAL
)

CREATE TABLE Nhacc
( manhacc NCHAR(3) PRIMARY KEY,
  tennhacc NVARCHAR(100),
  diachi NVARCHAR(200),
  dienthoai NVARCHAR(20)
)

CREATE TABLE DonDH
( sodh NCHAR(4) PRIMARY KEY,
  ngaydh DATETIME,
  manhacc NCHAR(3)
)

CREATE TABLE CTDonDH
( sodh NCHAR(4),
  mavtu NCHAR(4),
  sldat INT,
  PRIMARY KEY(sodh,mavtu)
)

CREATE TABLE PNhap
( sopn NCHAR(4) PRIMARY KEY,
  ngaynhap DATETIME,
  sodh NCHAR(4)
)

CREATE TABLE CTPNhap
( sopn NCHAR(4),
  mavtu NCHAR(4),
  slnhap INT,
  dgnhap MONEY,
  PRIMARY KEY(sopn,mavtu)
)

CREATE TABLE PXuat
( sopx NCHAR(4) PRIMARY KEY,
  ngayxuat DATETIME,
  tenkh NVARCHAR(100)
)

CREATE TABLE CTPXuat
( sopx NCHAR(4),
  mavtu NCHAR(4),
  slxuat INT,
  dgxuat MONEY,
  PRIMARY KEY(sopx,mavtu)
)

CREATE TABLE TonKho
( namthang NCHAR(6),
  mavtu NCHAR(4),
  sldau INT,
  tongslnhap INT,
  tongslxuat INT,
  slcuoi AS sldau+tongslnhap-tongslxuat,
  PRIMARY KEY(namthang,mavtu)
)

-----Tao cac rang buoc
ALTER TABLE VatTu ADD CONSTRAINT UNQ_VATTU_TENVTU UNIQUE(tenvtu),
	CONSTRAINT DEF_VATTU_DVTINH DEFAULT('') FOR dvtinh,
	CONSTRAINT CHK_VATTU_PHANTRAM CHECK(phantram BETWEEN 0 AND 100)

ALTER TABLE Nhacc ADD CONSTRAINT UNQ_NHACC_TENNHACC_DIACHI UNIQUE(tennhacc,diachi),
	CONSTRAINT DEF_NHACC_DIENTHOAI DEFAULT(N'Chưa có') FOR dienthoai

ALTER TABLE DonDH ADD CONSTRAINT DEF_DONDH_NGAYDH DEFAULT(GETDATE()) FOR ngaydh

ALTER TABLE CTDonDH ADD CONSTRAINT CHK_CTDONDH_SLDAT CHECK(sldat>0)

ALTER TABLE CTPNhap ADD CONSTRAINT CHK_CTPNHAP_SLNHAP_DGNHAP CHECK(slnhap>0 AND dgnhap>0)

ALTER TABLE CTPXuat ADD CONSTRAINT CHK_CTPXUAT_SLXUAT_DGXUAT CHECK(slxuat>0 AND dgxuat>0)

ALTER TABLE TonKho ADD CONSTRAINT CHK_TONKHO CHECK(sldau>=0 AND tongslnhap>=0 AND tongslxuat>=0),
	CONSTRAINT DEF_TONKHO_SLDAU DEFAULT(0) FOR sldau,
	CONSTRAINT DEF_TONKHO_TONGSLNHAP DEFAULT(0) FOR tongslnhap,
	CONSTRAINT DEF_TONKHO_TONGSLXUAT DEFAULT(0) FOR tongslxuat
-----Tao cac rang buoc khoa ngoai
ALTER TABLE DonDH ADD CONSTRAINT FRK_DONDH_NHACC FOREIGN KEY(manhacc) REFERENCES NHACC(manhacc) 

ALTER TABLE CTDonDH ADD CONSTRAINT FRK_CTDONDH_VATTU FOREIGN KEY(mavtu) REFERENCES VATTU(mavtu) 
ALTER TABLE CTDonDH ADD CONSTRAINT FRK_CTDONDH_DONDH FOREIGN KEY(sodh) REFERENCES DONDH(sodh) 

ALTER TABLE PNhap ADD CONSTRAINT FRK_PNHAP_DONDH FOREIGN KEY(sodh) REFERENCES DONDH(sodh) 

ALTER TABLE CTPNhap ADD CONSTRAINT FRK_CTPNHAP_VATTU FOREIGN KEY(mavtu) REFERENCES VATTU(mavtu) 
ALTER TABLE CTPNhap ADD CONSTRAINT FRK_CTPNHAP_PNHAP FOREIGN KEY(sopn) REFERENCES PNHAP(sopn) 

ALTER TABLE CTPXuat ADD CONSTRAINT FRK_CTPXUAT_VATTU FOREIGN KEY(mavtu) REFERENCES VATTU(mavtu) 
ALTER TABLE CTPXuat ADD CONSTRAINT FRK_CTPXUAT_PXUAT FOREIGN KEY(sopx) REFERENCES PXUAT(sopx) 

ALTER TABLE TonKho ADD CONSTRAINT FRK_TONKHO_VATTU FOREIGN KEY(mavtu) REFERENCES VATTU(mavtu) 
-----Them mau tin
INSERT INTO NHACC VALUES('C01',N'Lê Minh Trí',N'54 Hậu Giang Q6 HCM','8781024') 
INSERT INTO NHACC VALUES('C02',N'Trần Minh Thạch',N'145 Hùng Vương Mỹ Tho','7698154')
INSERT INTO NHACC VALUES('C03',N'Hồng Phương',N'154/85 Lê Lai Q1 HCM','9600125')
INSERT INTO NHACC VALUES('C04',N'Nhật Thắng',N'198/40 Hương lộ 14 QTB HCM','8757757')
INSERT INTO NHACC VALUES('C05',N'Lưu Nguyệt Quế',N'178 Nguyễn Văn Luông','7964251')
INSERT INTO NHACC VALUES('C07',N'Cao Minh Trung',N'125 Lê Quang Sung Nha Trang',N'Chưa có')

INSERT INTO VATTU VALUES('DD01',N'Đầu DVD Hitachi 1 đĩa',N'Bộ', 	40)
INSERT INTO VATTU VALUES('DD02',N'Đầu DVD Hitachi 3 đĩa',N'Bộ', 	40)
INSERT INTO VATTU VALUES('TL15',N'Tủ lạnh Sanyo 150 lít',N'Cái', 25)
INSERT INTO VATTU VALUES('TL90',N'Tủ lạnh Sanyo 90 lít',N'Cái',20)
INSERT INTO VATTU VALUES('TV14',N'Tivi Sony 14 inches',N'Cái',15)
INSERT INTO VATTU VALUES('TV21',N'Tivi Sony 21 inches',N'Cái',10)
INSERT INTO VATTU VALUES('TV29',N'Tivi Sony 29 inches',N'Cái',10)
INSERT INTO VATTU VALUES('VD01',N'Đầu VCD Sony 1 đĩa',N'Bộ',30)
INSERT INTO VATTU VALUES('VD02',N'Đầu VCD Sony 3 đĩa',N'Bộ',30)

INSERT INTO DONDH VALUES('D001','01/15/2015','C03')
INSERT INTO DONDH VALUES('D002','01/30/2015','C01')
INSERT INTO DONDH VALUES('D003','02/10/2015','C02')
INSERT INTO DONDH VALUES('D004','02/17/2015','C05')
INSERT INTO DONDH VALUES('D005','03/01/2015','C02')
INSERT INTO DONDH VALUES('D006','03/12/2015','C05')

INSERT INTO CTDONDH VALUES('D001','DD01',	10)
INSERT INTO CTDONDH VALUES('D001','DD02',	15)
INSERT INTO CTDONDH VALUES('D002','VD02',	30)
INSERT INTO CTDONDH VALUES('D003','TV14',	10)
INSERT INTO CTDONDH VALUES('D003','TV29',	20)
INSERT INTO CTDONDH VALUES('D004','TL90',	10)
INSERT INTO CTDONDH VALUES('D005','TV14',	10)
INSERT INTO CTDONDH VALUES('D005','TV29',	20)
INSERT INTO CTDONDH VALUES('D006','TV14',	10)
INSERT INTO CTDONDH VALUES('D006','TV29',	20)
INSERT INTO CTDONDH VALUES('D006','VD01',	20)

INSERT INTO PNHAP VALUES('N001','01/17/2015','D001')
INSERT INTO PNHAP VALUES('N002','01/20/2015','D001')
INSERT INTO PNHAP VALUES('N003','01/31/2015','D002')
INSERT INTO PNHAP VALUES('N004','02/15/2015','D003')

INSERT INTO CTPNHAP VALUES('N001','DD01',	8,	2500000)
INSERT INTO CTPNHAP VALUES('N001','DD02',	10,	3500000)
INSERT INTO CTPNHAP VALUES('N002','DD01',	2,	2500000)
INSERT INTO CTPNHAP VALUES('N002','DD02',	5,	3500000)
INSERT INTO CTPNHAP VALUES('N003','VD02',	30,	2500000)
INSERT INTO CTPNHAP VALUES('N004','TV14',	5,	2500000)
INSERT INTO CTPNHAP VALUES('N004','TV29',	12,	3500000)

INSERT INTO PXUAT VALUES('X001','01/17/2020',N'Nguyễn Ngọc Phương Nhi')
INSERT INTO PXUAT VALUES('X002','01/25/2020',N'Nguyễn Hồng Phương')
INSERT INTO PXUAT VALUES('X003','01/31/2020',N'Nguyễn Tuấn Tú')

INSERT INTO CTPXUAT VALUES('X001','DD01',	2,	3500000)
INSERT INTO CTPXUAT VALUES('X002','DD01',	1,	3500000)
INSERT INTO CTPXUAT VALUES('X002','DD02',	5,	4900000)
INSERT INTO CTPXUAT VALUES('X003','DD01',	3,	3500000)
INSERT INTO CTPXUAT VALUES('X003','DD02',	2,	4900000)
INSERT INTO CTPXUAT VALUES('X003','VD02',	10,	3250000)

INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201501','DD01',	0,	10,	6)
INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201501','DD02',	0,	15,	7)
INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201501','VD02',	0,	30,	10)
INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201502','DD01',	4,	0,	0)
INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201502','DD02',	8,	0,	0)
INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201502','VD02',	20,	0,	0)
INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201502','TV14',	5,	0,	0)
INSERT INTO TONKHO (namthang,mavtu,sldau,tongslnhap,tongslxuat) VALUES('201502','TV29',	12,	0,	0)

