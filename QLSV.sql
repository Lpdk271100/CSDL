/************************************************************
 * Code formatted by SoftTree SQL Assistant © v11.0.35
 * Time: 13/09/2021 8:51:48 SA
 ************************************************************/
CREATE DATABASE QLSV
USE QLSV

--Tạo bảng Lớp
CREATE TABLE tblLOP
(
	MaLop      VARCHAR(10) PRIMARY KEY,
	TenLop     NVARCHAR(40) NOT NULL
)
--Tạo bảng Tỉnh
CREATE TABLE tblTINH
(
	MaTinh      VARCHAR(10) PRIMARY KEY,
	TenTinh     NVARCHAR(40) NOT NULL,
)

--Tạo bảng Sinh Viên
CREATE TABLE tblSINHVIEN
(
	MaSv         VARCHAR(10) PRIMARY KEY,
	HoTen        NVARCHAR(40) NOT NULL,
	NgaySinh     DATE NOT NULL,
	GioiTinh     NVARCHAR(4) NOT NULL,
	MaLop        VARCHAR(10) NOT NULL,
	MaTinh       VARCHAR(10) NOT NULL,
	DTB          FLOAT NOT NULL
)

ALTER TABLE tblSINHVIEN
ADD CONSTRAINT KN_tblSINHVIEN_1 FOREIGN KEY(MaLop) REFERENCES tblLOP(MaLop),
 CONSTRAINT KN_tblSINHVIEN_2 FOREIGN KEY(MaTinh) REFERENCES tblTINH(MaTinh)

INSERT INTO tblLOP
VALUES
('ML01', 'CNTTK12A'),
('ML02', 'CNTTK12B'),
('ML03', 'CNTTK12C'),
('ML04', 'CNTTK12D'),
('ML05', 'CNTTK12E'),
('ML06', 'CNTTK12F'),
('ML07', 'CNTTK12G')

INSERT INTO tblTINH
VALUES
('MT01', N'Quảng Ninh'),
('MT02', N'Quảng Bình'),
('MT03', N'Quảng Trị'),
('MT04', N'Quảng Nam'),
('MT05', N'Quảng Ngãi'),
('MT06', N'Hà Nội'),
('MT07', N'Quảng Ninh'),
('MT08', N'Thái Nguyên'),
('MT09', N'Bắc Giang')

INSERT INTO tblSINHVIEN
VALUES
(
    'SV01',
    N'Hoàng Vũ Thanh Thủy',
    '3/30/1995',
    N'Nữ',
    'ML01',
    'MT08',
    9.5
),
(
    'SV02',
    N'Chu Xuân Linh',
    '3/25/1991',
    'Nam',
    'ML01',
    'MT01',
    9.5
),
(
    'SV03',
    N'Ngô Doãn Tình',
    '2/20/1995',
    'Nam',
    'ML01',
    'MT02',
    8
),
(
    'SV04',
    N'Phạm Xuân Tú',
    '3/18/1995',
    'Nam',
    'ML02',
    'MT03',
    9
),
(
    'SV05',
    N'Dương Xuân Tùng',
    '5/5/1995',
    'Nam',
    'ML02',
    'MT01',
    8.5
),
(
    'SV06',
    N'Nguyễn Thị Thảo',
    '7/27/1995',
    N'Nữ',
    'ML03',
    'MT01',
    6.5
),
(
    'SV07',
    N'Trần Văn Cương',
    '10/19/1995',
    'Nam',
    'ML03',
    'MT04',
    7.5
),
(
    'SV08',
    N'Dương Thành Đô',
    '1/27/1995',
    'Nam',
    'ML05',
    'MT05',
    7.5
),
(
    'SV09',
    N'Tô Thành Đồng',
    '12/14/1995',
    'Nam',
    'ML05',
    'MT08',
    5.5
),
(
    'SV10',
    N'Nguyễn Thị Thương',
    '2/28/1995',
    N'Nữ',
    'ML05',
    'MT09',
    7.5
),
(
    'SV11',
    N'Nguyễn Thị A',
    '12/21/1995',
    N'Nữ',
    'ML05',
    'MT08',
    4.5
),
(
    'SV12',
    N'Nguyễn Thị B',
    '8/28/1995',
    N'Nữ',
    'ML07',
    'MT06',
    4
)

--1. Đưa ra thông tin về những sinh viên có điểm trung bình dưới 5
SELECT *
FROM   tblSINHVIEN
WHERE  DTB < 5

--2. Đưa ra thông tin về sinh viên có địa chỉ ở Thái Nguyên
SELECT *
FROM   tblSINHVIEN
WHERE  MaTinh IN (SELECT MaTinh
                  FROM   tblTINH
                  WHERE  TenTinh = N'Thái Nguyên')
--3. Đưa ra thông tin về các lớp học không có sinh viên nào ở Hà Nội
SELECT *
FROM   tblLOP
WHERE  MaLop NOT IN (SELECT MaLop
                     FROM   tblSINHVIEN
                     WHERE  MaTinh  IN (SELECT MaTinh
                                        FROM   tblTINH
                                        WHERE  TenTinh = N'Hà Nội'))

--4. Đưa ra thông tin về các sinh viên có điểm trung bình cao nhất

SELECT *
FROM   tblSINHVIEN
WHERE  DTB = (
           SELECT MAX(DTB)
           FROM   tblSINHVIEN
       )
--5. Đưa ra thông tin về các sinh viên có điểm trung bình cao nhất theo từng lớp học.
SELECT MaLop,
       MaSv,
       HoTen,
       NgaySinh,
       GioiTinh,
       MaTinh,
       DTB
FROM   tblSINHVIEN AS A
WHERE  DTB = (
           SELECT MAX(DTB)
           FROM   tblSINHVIEN AS B
           WHERE  A.MaLop = B.MaLop
       )
ORDER BY
       MaLop ASC

SELECT A.MaLop,
       tblLOP.TenLop,
       MaSv,
       HoTen,
       NgaySinh,
       GioiTinh,
       MaTinh,
       a.DTB
FROM   (
           SELECT MaLop,
                  MAX(DTB) AS DTB
           FROM   tblSINHVIEN
           GROUP BY
                  MaLop
       )      AS A,
       tblSINHVIEN,
       tblLOP
WHERE  A.DTB = tblSINHVIEN.DTB
       AND a.MaLop = tblSINHVIEN.MaLop
       AND a.MaLop = tblLOP.MaLop
ORDER BY
       MaLop  ASC

-- 6. Tạo View để tổng hợp thông tin về các sinh viên có điểm trung bình cao nhất. 
CREATE VIEW DTBCaoNhat AS 
SELECT *
FROM   tblSINHVIEN
WHERE  DTB = (
           SELECT MAX(DTB)
           FROM   tblSINHVIEN
       )

--7. Tạo View để tổng hợp thông tin về các sinh viên có điểm trung bình cao nhất theo từng lớp học. 
CREATE VIEW DTBTheoLop AS
SELECT MaLop,
       MaSv,
       HoTen,
       NgaySinh,
       GioiTinh,
       MaTinh,
       DTB
FROM   tblSINHVIEN AS A
WHERE  DTB = (
           SELECT MAX(DTB)
           FROM   tblSINHVIEN AS B
           WHERE  A.MaLop = B.MaLop
       ) 

--Tạo bảng view DTB cao nhất của từng lớp
CREATE VIEW MaxDTB_LOP AS
SELECT MaLop,
       MAX(DTB) AS DTB
FROM   tblSINHVIEN
GROUP BY
       MaLop
-- Kết nối với bảng sinh viên :v 
CREATE VIEW TT_SV_LOP AS
SELECT tblSINHVIEN.MaLop,
       MaSv,
       HoTen,
       NgaySinh,
       GioiTinh,
       MaTinh,
       tblSINHVIEN.DTB
FROM   tblSINHVIEN,
       MaxDTB_LOP
WHERE  tblSINHVIEN.MaLop = MaxDTB_LOP.MaLop
       AND tblSINHVIEN.DTB = MaxDTB_LOP.DTB

-- Tạo thủ tục để đưa ra sĩ số sinh viên cho từng lớp học (Danh sách đưa ra phải có các thuộc tính sau: MaLop, 
 CREATE PROC SPSS
 AS
SELECT tblLOP.MaLop,
       TenLop,
       A.SiSo
FROM   (
           SELECT MaLop,
                  COUNT(MaSV) AS SiSo
           FROM   tblSINHVIEN
           GROUP BY
                  MaLop
       ) AS A,
       tblLOP
WHERE  A.MaLop = tblLOP.MaLop

EXEC SPSS