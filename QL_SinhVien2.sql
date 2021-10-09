/************************************************************
 * Code formatted by SoftTree SQL Assistant © v11.0.35
 * Time: 13/09/2021 8:30:34 SA
 ************************************************************/

/*=====================CREATE DATABASE======================*/
USE MASTER
GO
IF EXISTS(
       SELECT NAME
       FROM   SYSDATABASES
       WHERE  NAME = 'QL_DiemSinhVien'
   )
    DROP DATABASE QL_DiemSinhVien
GO
CREATE DATABASE QL_DiemSinhVien
GO
USE QL_DiemSinhVien
GO

/*=============DANH MUC KHOA==============*/
CREATE TABLE DMKHOA
(
	MAKHOA      CHAR(2) PRIMARY KEY,
	TENKHOA     NVARCHAR(30) NOT NULL
)
/*==============DANH MUC SINH VIEN============*/
CREATE TABLE DMSV
(
	MASV         CHAR(3) NOT NULL PRIMARY KEY,
	HOSV         NVARCHAR(15) NOT NULL,
	TENSV        NVARCHAR(7) NOT NULL,
	PHAI         NCHAR(7),
	NGAYSINH     DATETIME NOT NULL,
	NOISINH      NVARCHAR(20),
	MAKHOA       CHAR(2),
	HOCBONG      FLOAT
)
/*===================MON HOC========================*/
CREATE TABLE DMMH
(
	MAMH       CHAR(2) NOT NULL,
	TENMH      NVARCHAR(25) NOT NULL,
	SOTIET     TINYINT
	CONSTRAINT DMMH_MAMH_PK PRIMARY KEY(MAMH)
)
/*=====================KET QUA===================*/
CREATE TABLE KETQUA
(
	MASV       CHAR(3) NOT NULL,
	MAMH       CHAR(2) NOT NULL,
	LANTHI     TINYINT,
	DIEM       DECIMAL(4, 2),
	CONSTRAINT KETQUA_MASV_MAMH_LANTHI_PK PRIMARY KEY(MASV, MAMH, LANTHI)
)
/*==========================TAO KHOA NGOAI==============================*/
ALTER TABLE DMSV
ADD CONSTRAINT DMKHOA_MAKHOA_FK FOREIGN KEY(MAKHOA)
REFERENCES DMKHOA(MAKHOA)

ALTER TABLE KETQUA
ADD CONSTRAINT KETQUA_MASV_FK FOREIGN KEY(MASV) REFERENCES DMSV(MASV),
CONSTRAINT DMMH_MAMH_FK FOREIGN KEY(MAMH) REFERENCES DMMH(MAMH)
/*==================NHAP DU LIEU====================*/
/*==============NHAP DU LIEU DMMH=============*/
INSERT INTO DMMH
VALUES
('01', N'CƠ SỞ DỮ LIỆU', 45),
('02', N'TRÍ TUỆ NHÂN TẠO', 45),
('03', N'TRUYỀN TIN', 45),
('04', N'ĐỒ HỌA', 60),
('05', N'VĂN PHẠM', 60)
/*==============NHAP DU LIEU DMKHOA=============*/
INSERT INTO DMKHOA
VALUES
('AV', N'ANH VĂN'),
('TH', N'TIN HỌC'),
('TR', N'TRIẾT'),
('VL', N'VẬT LÝ')
/*==============NHAP DU LIEU DMSV=============*/
SET DATEFORMAT DMY
GO
INSERT INTO DMSV
VALUES
(
	'A01',
	N'NGUYỄN THỊ',
	N'HẢI',
	N'NỮ',
	'23/02/1990',
	N'HÀ NỘI',
	'TH',
	130000
),
(
    'A02',
    N'TRẦN VĂN',
    N'CHÍNH',
    N'NAM',
    '24/12/1992',
    N'BÌNH ĐỊNH',
    'VL',
    150000
),
(
    'A03',
    N'LÊ THU BẠCH',
    N'YẾN',
    N'NỮ',
    '21/02/1990',
    N'TP HỒ CHÍ MINH',
    'TH',
    170000
),
(
    'A04',
    N'TRẦN ANH',
    N'TUẤN',
    N'NAM',
    '20/12/1990',
    N'HÀ NỘI',
    'AV',
    80000
),
(
    'B01',
    N'TRẦN THANH',
    N'MAI',
    N'NỮ',
    '12/08/1991',
    N'HẢI PHÒNG',
    'TR',
    0
),
(
    'B02',
    N'TRẦN THỊ THU',
    N'THỦY',
    N'NỮ',
    '02/01/1991',
    N'TP HỒ CHÍ MINH',
    'AV',
    0
)
/*==============NHAP DU LIEU BANG KET QUA=============*/
INSERT INTO KETQUA
VALUES
('A01', '01', 1, 3),
('A01', '01', 2, 6),
('A01', '02', 2, 6),
('A01', '03', 1, 5),
('A02', '01', 1, 4.5),
('A02', '01', 2, 7),
('A02', '03', 1, 10),
('A02', '05', 1, 9),
('A03', '01', 1, 2),
('A03', '01', 2, 5),
('A03', '03', 1, 2.5),
('A03', '03', 2, 4),
('A04', '05', 2, 10),
('B01', '01', 1, 7),
('B01', '03', 1, 2.5),
('B01', '03', 2, 5),
('B02', '02', 1, 6),
('B02', '04', 1, 10)
/*===============CAP NHAT THONG TIN=================*/
--CÂU 2--
UPDATE DMMH
SET    SOTIET     = 45
WHERE  MAMH       = '05'
--CÂU 3,4---
UPDATE DMSV
SET    TENSV     = N'KỲ',
       PHAI      = 'NAM'
WHERE  MASV      = 'B01'
-------CÂU 5-----
UPDATE DMSV
SET    NGAYSINH     = '05/07/1990'
WHERE  MASV         = 'B02'
----------CÂU 6----------
UPDATE DMSV
SET    HOCBONG     = HOCBONG + 100000
WHERE  MAKHOA      = 'AV'
-------CÂU 7----------
DELETE 
FROM   KETQUA
WHERE  LANTHI = 2
       AND DIEM < 5
-------CÂU 8---------
DELETE FROM DMSV
WHERE HOCBONG=0
--KHÔNG ĐƯỢC VÌ CÓ RÀNG BUỘC KHÓA NGOẠI --

--B.TRUY VẤN NHỮNG CÂU ĐƠN GIẢN
--9. LIỆT KÊ DANH SÁCH SINH VIÊN, GỒM CÁC THÔNG TIN SAU: MÃ SINH VIÊN, HỌ SINH VIÊN, TÊN SINH VIÊN, HỌC BỔNG. DANH SÁCH SẼ ĐƯỢC SẮP XẾP THEO THỨ TỰ MÃ SINH VIÊN TĂNG DẦN.
SELECT MASV     AS 'MÃ SINH VIÊN',
       HOSV     AS 'HỌ SINH VIÊN',
       TENSV    AS 'TÊN SINH VIÊN',
       HOCBONG  AS 'HỌC BỔNG'
FROM   DMSV
ORDER BY
       MASV     ASC

--10. DANH SÁCH CÁC SINH VIÊN GỒM THÔNG TIN SAU: MÃ SINH VIÊN, HỌ TÊN SINH VIÊN, PHÁI, NGÀY SINH. DANH SÁCH SẼ ĐƯỢC SẮP XẾP THEO THỨ TỰ NAM/NỮ.
SELECT MASV                AS 'MÃ SINH VIÊN',
       HOSV + ' ' + TENSV  AS 'HỌ TÊN SINH VIÊN',
       PHAI                AS 'PHÁI',
       NGAYSINH            AS 'NGÀY SINH'
FROM   DMSV
ORDER BY
       PHAI                ASC

--11. THÔNG TIN CÁC SINH VIÊN GỒM: HỌ TÊN SINH VIÊN, NGÀY SINH, HỌC BỔNG. THÔNG TIN SẼ ĐƯỢC SẮP XẾP THEO THỨ TỰ NGÀY SINH TĂNG DẦN VÀ HỌC BỔNG GIẢM DẦN.
SELECT HOSV + ' ' + TENSV  AS 'HỌ TÊN SINH VIÊN',
       NGAYSINH            AS 'NGÀY SINH',
       HOCBONG             AS 'HỌC BỔNG'
FROM   DMSV
ORDER BY
       NGAYSINH            ASC,
       HOCBONG                DESC

--12. DANH SÁCH CÁC MÔN HỌC CÓ TÊN BẮT ĐẦU BẰNG CHỮ T, GỒM CÁC THÔNG TIN: MÃ MÔN, TÊN MÔN, SỐ TIẾT.
SELECT MAMH    AS 'MÃ MÔN HỌC',
       TENMH   AS 'TÊN MÔN HỌC',
       SOTIET  AS 'SỐ TIẾT'
FROM   DMMH
WHERE  TENMH      LIKE 'T%'

--13. LIỆT KÊ DANH SÁCH NHỮNG SINH VIÊN CÓ CHỮ CÁI CUỐI CÙNG TRONG TÊN LÀ I, GỒM CÁC THÔNG TIN: HỌ TÊN SINH VIÊN, NGÀY SINH, PHÁI.
SELECT HOSV + ' ' + TENSV  AS 'HỌ TÊN SINH VIÊN',
       NGAYSINH            AS 'NGÀY SINH',
       PHAI                AS 'PHÁI'
FROM   DMSV
WHERE  TENSV                  LIKE '%I'

--14. DANH SÁCH NHỮNG KHOA CÓ KÝ TỰ THỨ HAI CỦA TÊN KHOA CÓ CHỨA CHỮ N, GỒM CÁC THÔNG TIN: MÃ KHOA, TÊN KHOA.
SELECT MAKHOA   AS 'MÃ KHOA',
       TENKHOA  AS 'TÊN KHOA'
FROM   DMKHOA
WHERE  TENKHOA     LIKE '_N%'

--15. LIỆT KÊ NHỮNG SINH VIÊN MÀ HỌ CÓ CHỨA CHỮ THỊ.
SELECT *
FROM   DMSV
WHERE  HOSV LIKE N'%THỊ%'

--16. CHO BIẾT DANH SÁCH NHỮNG SINH VIÊN CÓ KÝ TỰ ĐẦU TIÊN CỦA TÊN NẰM TRONG KHOẢNG TỪ A ĐẾN M, GỒM CÁC THÔNG TIN: MÃ SINH VIÊN, HỌ TÊN SINH VIÊN, PHÁI, HỌC BỔNG.
SELECT MASV                AS N'MÃ SINH VIÊN',
       HOSV + ' ' + TENSV  AS N'HỌ TÊN SINH VIÊN',
       PHAI                AS N'PHÁI',
       HOCBONG             AS N'HỌC BỔNG'
FROM   DMSV
WHERE  TENSV BETWEEN          'A' AND 'M'

--17. CHO BIẾT DANH SÁCH NHỮNG SINH VIÊN MÀ TÊN CÓ CHỨA KÝ TỰ NẰM TRONG KHOẢNG TỪ A ĐẾN M, GỒM CÁC THÔNG TIN: HỌ TÊN SINH VIÊN, NGÀY SINH, NƠI SINH, HỌC BỔNG. DANH SÁCH ĐƯỢC SẮP XẾP TĂNG DẦN THEO HỌ TÊN SINH VIÊN.
SELECT MASV                AS N'MÃ SINH VIÊN',
       HOSV + ' ' + TENSV  AS N'HỌ TÊN SINH VIÊN',
       PHAI                AS N'PHÁI',
       HOCBONG             AS N'HỌC BỔNG'
FROM   DMSV
WHERE  TENSV                  LIKE '%[A-M]%'
ORDER BY
       HOSV + ' ' + TENSV ASC

--18. CHO BIẾT DANH SÁCH CÁC SINH VIÊN CÓ HỌC BỔNG LỚN HƠN 100,000, GỒM CÁC THÔNG TIN: MÃ SINH VIÊN, HỌ TÊN SINH VIÊN, MÃ KHOA, HỌC BỔNG. DANH SÁCH SẼ ĐƯỢC SẮP XẾP THEO THỨ TỰ MÃ KHOA GIẢM DẦN.
SELECT MASV                AS N'MÃ SINH VIÊN',
       HOSV + ' ' + TENSV  AS N'HỌ TÊN SINH VIÊN',
       MAKHOA              AS N'MÃ KHOA',
       HOCBONG             AS N'HỌC BỔNG'
FROM   DMSV
WHERE  HOCBONG > 100000
ORDER BY
       MAKHOA                 DESC

--19. LIỆT KÊ CÁC SINH VIÊN CÓ HỌC BỔNG TỪ 150,000 TRỞ LÊN VÀ SINH Ở HÀ NỘI, GỒM CÁC THÔNG TIN: HỌ TÊN SINH VIÊN, MÃ KHOA, NƠI SINH, HỌC BỔNG.
SELECT HOSV + ' ' + TENSV  AS N'HỌ TÊN SINH VIÊN',
       MAKHOA              AS N'MÃ KHOA',
       NOISINH             AS N'NƠI SINH',
       HOCBONG             AS N'HỌC BỔNG'
FROM   DMSV
WHERE  HOCBONG >= 150000
       AND NOISINH = N'HÀ NỘI'

--20. DANH SÁCH CÁC SINH VIÊN CỦA KHOA ANH VĂN VÀ KHOA VẬT LÝ, GỒM CÁC THÔNG TIN: MÃ SINH VIÊN, MÃ KHOA, PHÁI.
SELECT MASV    AS N'MÃ SINH VIÊN',
       MAKHOA  AS N'MÃ KHOA',
       PHAI    AS N'PHÁI'
FROM   DMSV
WHERE  MAKHOA = 'AV'
       OR  MAKHOA = 'VL'

--21. CHO BIẾT NHỮNG SINH VIÊN CÓ NGÀY SINH TỪ NGÀY 01/01/1991 ĐẾN NGÀY 05/06/1992 GỒM CÁC THÔNG TIN: MÃ SINH VIÊN, NGÀY SINH, NƠI SINH, HỌC BỔNG.
SELECT MASV      AS N'MÃ SINH VIÊN',
       NGAYSINH  AS N'NGÀY SINH',
       NOISINH   AS N'NƠI SINH',
       HOCBONG   AS N'HỌC BỔNG'
FROM   DMSV
WHERE  NGAYSINH >= '01/01/1991'
       AND NGAYSINH <= '05/06/1992'

--22. DANH SÁCH NHỮNG SINH VIÊN CÓ HỌC BỔNG TỪ 80.000 ĐẾN 150.000, GỒM CÁC THÔNG TIN: MÃ SINH VIÊN, NGÀY SINH, PHÁI, MÃ KHOA.
SELECT MASV      AS N'MÃ SINH VIÊN',
       NGAYSINH  AS N'NGÀY SINH',
       PHAI      AS N'PHÁI',
       MAKHOA    AS N'MÃ KHOA'
FROM   DMSV
WHERE  HOCBONG >= 80000
       AND HOCBONG <= 150000

--23. CHO BIẾT NHỮNG MÔN HỌC CÓ SỐ TIẾT LỚN HƠN 30 VÀ NHỎ HƠN 45, GỒM CÁC THÔNG TIN: MÃ MÔN HỌC, TÊN MÔN HỌC, SỐ TIẾT.
SELECT MAMH    AS N'MÃ MÔN HỌC',
       TENMH   AS N'TÊN MÔN HỌC',
       SOTIET  AS N'SỐ TIẾT'
FROM   DMMH
WHERE  SOTIET > 30
       AND SOTIET < 45
       
--24. LIỆT KÊ NHỮNG SINH VIÊN NAM CỦA KHOA ANH VĂN VÀ KHOA TIN HỌC, GỒM CÁC THÔNG TIN: MÃ SINH VIÊN, HỌ TÊN SINH VIÊN, TÊN KHOA, PHÁI.
SELECT MASV 'MÃ SINH VIÊN',
       'HỌ TÊN SINH VIÊN' = HOSV + ' ' + TENSV,
       TENKHOA 'TÊN KHOA',
       PHAI 'PHÁI'
FROM   DMSV       SV,
       DMKHOA     KHOA
WHERE  SV.MAKHOA = KHOA.MAKHOA

--25. LIỆT KÊ NHỮNG SINH VIÊN NỮ, TÊN CÓ CHỨA CHỮ N--
SELECT *
FROM   DMSV
WHERE  PHAI = N'NỮ'
       AND TENSV LIKE N'%N%'

--C. TRUY VẤN SỬ DỤNG HÀM: YEAR, MONTH, DAY, GETDATE, CASE, ….
--26. DANH SÁCH SINH VIÊN CÓ NƠI SINH Ở HÀ NỘI VÀ SINH VÀO THÁNG 02, GỒM CÁC THÔNG TIN: HỌ SINH VIÊN, TÊN SINH VIÊN, NƠI SINH, NGÀY SINH.
SELECT HOSV 'HỌ SINH VIÊN',
       TENSV 'TÊN SINH VIÊN',
       NOISINH 'NƠI SINH',
       NGAYSINH 'NGÀY SINH'
FROM   DMSV
WHERE  NOISINH = N'HÀ NỘI'
       AND MONTH(NGAYSINH) = 2
       
--27. CHO BIẾT NHỮNG SINH VIÊN CÓ TUỔI LỚN HƠN 20, THÔNG TIN GỒM: HỌ TÊN SINH VIÊN, TUỔI,HỌC BỔNG.
SELECT HOSV + ' ' + TENSV 'TÊN SINH VIÊN',
       'TUỔI' = YEAR(GETDATE()) -YEAR(NGAYSINH),
       HOCBONG 'HỌC BỔNG'
FROM   DMSV
WHERE  YEAR(GETDATE()) -YEAR(NGAYSINH) > 20

--28. DANH SÁCH NHỮNG SINH VIÊN CÓ TUỔI TỪ 20 ĐẾN 25, THÔNG TIN GỒM: HỌ TÊN SINH VIÊN, TUỔI, TÊN KHOA.
SELECT HOSV + ' ' + TENSV 'TÊN SINH VIÊN',
       'TUỔI' = YEAR(GETDATE()) -YEAR(NGAYSINH),
       TENKHOA 'TÊN KHOA'
FROM   DMSV       SV,
       DMKHOA     KHOA
WHERE  SV.MAKHOA = KHOA.MAKHOA
       AND (YEAR(GETDATE()) -YEAR(NGAYSINH)BETWEEN 20 AND 25)
       
--29. DANH SÁCH SINH VIÊN SINH VÀO MÙA XUÂN NĂM 1990, GỒM CÁC THÔNG TIN: HỌ TÊN SINH VIÊN, PHÁI, NGÀY SINH.
SELECT HOSV + ' ' + TENSV 'TÊN SINH VIÊN',
       PHAI 'PHÁI',
       NGAYSINH 'NGÀY SINH'
FROM   DMSV
WHERE  YEAR(NGAYSINH) = 1990
       AND (MONTH(NGAYSINH)IN (1, 2, 3)) --BETWEEN 1 AND 3
       
--30. CHO BIẾT THÔNG TIN VỀ MỨC HỌC BỔNG CỦA CÁC SINH VIÊN, GỒM: MÃ SINH VIÊN, PHÁI, MÃ KHOA, MỨC HỌC BỔNG. TRONG ĐÓ, MỨC HỌC BỔNG SẼ HIỂN THỊ LÀ “HỌC BỔNG CAO” NẾU GIÁ TRỊ CỦA FIELD HỌC BỔNG LỚN HƠN 500,000 VÀ NGƯỢC LẠI HIỂN THỊ LÀ “MỨC TRUNG BÌNH”
SELECT MASV'MÃ SINH VIÊN',
       PHAI'PHÁI',
       MAKHOA 'MÃ KHOA',
       'MỨC TRUNG BÌNH' = CASE 
                               WHEN HOCBONG > 500000 THEN N'HỌC BỔNG CAO'
                               ELSE N' MỨC TRUNG BÌNH'
                          END
FROM   DMSV

--D. TRUY VẤN SỬ DỤNG HÀM KẾT HỢP: MAX, MIN, COUNT, SUM, AVG VÀ GOM NHÓM
--32. CHO BIẾT TỔNG SỐ SINH VIÊN CỦA TOÀN TRƯỜNG
SELECT 'TỔNG SINH VIÊN TOÀN TRƯỜNG' = COUNT(MASV)
FROM   DMSV

--33. CHO BIẾT TỔNG SINH VIÊN VÀ TỔNG SINH VIÊN NỮ. ĐÂY LÀ CÁCH VIẾT GỘP TRONG BẢNG
SELECT 'TỔNG SINH VIÊN' = COUNT(MASV),
       'TỔNG SINH VIÊN NỮ' = SUM(CASE PHAI WHEN N'NỮ' THEN 1 ELSE 0 END)
FROM   DMSV
------------
SELECT 'TỔNG SINH VIÊN' = COUNT(MASV),
       T.NU 'TỔNG SINH VIÊN NỮ'
FROM   DMSV,
       (
           SELECT COUNT(MASV) AS 'NU'
           FROM   DMSV
           WHERE  PHAI = N'NỮ'
       ) AS T
GROUP BY
       T.NU
       
--34. CHO BIẾT TỔNG SỐ SINH VIÊN CỦA TỪNG KHOA.
SELECT MAKHOA 'MÃ KHOA',
       'MÃ SINH VIÊN' = COUNT(MASV)
FROM   DMSV
GROUP BY
       MAKHOA

--35. CHO BIẾT SỐ LƯỢNG SINH VIÊN HỌC TỪNG MÔN.
SELECT TENMH'TÊN MÔN HỌC',
       COUNT(DISTINCT MASV)'MÃ SINH VIÊN'
FROM   KETQUA     KQ,
       DMMH       MH
WHERE  KQ.MAMH = MH.MAMH
GROUP BY
       TENMH
       
--36. CHO BIẾT SỐ LƯỢNG MÔN HỌC MÀ SINH VIÊN ĐÃ HỌC(TỨC TỔNG SỐ MÔN HỌC CÓ TORNG BẢNG KQ)
SELECT COUNT(DISTINCT MAMH)'TỔNG SỐ MÔN HỌC'
FROM   KETQUA

--37. CHO BIẾT TỔNG SỐ HỌC BỔNG CỦA MỖI KHOA.
SELECT MAKHOA 'MÃ KHOA',
       SUM(HOCBONG)'TỔNG HỌC BỔNG'
FROM   DMSV
GROUP BY
       MAKHOA
       
--38. CHO BIẾT HỌC BỔNG CAO NHẤT CỦA MỖI KHOA.
SELECT MAKHOA 'MÃ KHOA',
       MAX(HOCBONG)'HỌC BỔNG CAO NHẤT'
FROM   DMSV
GROUP BY
       MAKHOA
       
--39. CHO BIẾT TỔNG SỐ SINH VIÊN NAM VÀ TỔNG SỐ SINH VIÊN NỮ CỦA MỖI KHOA.
SELECT MAKHOA,
       'TỔNG SINH VIÊN NAM'     = SUM(CASE PHAI WHEN N'NAM' THEN 1 ELSE 0 END),
       'TỔNG SINH VIÊN NỮ'      = SUM(CASE PHAI WHEN N'NỮ' THEN 1 ELSE 0 END)
FROM   DMSV
GROUP BY
       MAKHOA
       
--40. CHO BIẾT SỐ LƯỢNG SINH VIÊN THEO TỪNG ĐỘ TUỔI.
SELECT YEAR(GETDATE()) -YEAR(NGAYSINH) 'TUỔI',
       COUNT(MASV) 'SỐ SINH VIÊN'
FROM   DMSV
GROUP BY
       YEAR(GETDATE()) -YEAR(NGAYSINH)

--41. CHO BIẾT NHỮNG NĂM SINH NÀO CÓ 2 SINH VIÊN ĐANG THEO HỌC TẠI TRƯỜNG.
SELECT YEAR(NGAYSINH)'NĂM',
       COUNT(MASV)'SỐ SINH VIÊN'
FROM   DMSV
GROUP BY
       YEAR(NGAYSINH)
HAVING COUNT(MASV) = 2

--42. CHO BIẾT NHỮNG NƠI NÀO CÓ HƠN 2 SINH VIÊN ĐANG THEO HỌC TẠI TRƯỜNG.
SELECT NOISINH,
       COUNT(MASV)'SỐ SINH VIÊN'
FROM   DMSV
GROUP BY
       NOISINH
HAVING COUNT(MASV) >= 2

--43. CHO BIẾT NHỮNG MÔN NÀO CÓ TRÊN 3 SINH VIÊN DỰ THI.
SELECT MAMH 'MÃ MÔN HỌC',
       COUNT(MASV)'SỐ SINH VIÊN'
FROM   KETQUA
GROUP BY
       MAMH
HAVING COUNT(MASV) > 3

--44. CHO BIẾT NHỮNG SINH VIÊN THI LẠI TRÊN 2 LẦN.
SELECT MASV,
       MAMH,
       COUNT(LANTHI)'SO LAN THI LAI'
FROM   KETQUA
GROUP BY
       MASV,
       MAMH
HAVING COUNT(LANTHI) > 2

--45. CHO BIẾT NHỮNG SINH VIÊN NAM CÓ ĐIỂM TRUNG BÌNH LẦN 1 TRÊN 7.0
SELECT HOSV + ' ' + TENSV 'HỌ TÊN SINH VIÊN',
       PHAI,
       LANTHI,
       AVG(DIEM)'DIEM TRUNG BINH'
FROM   KETQUA     KQ,
       DMSV       SV
WHERE  KQ.MASV = SV.MASV
       AND LANTHI = 1
       AND PHAI = N'NAM'
GROUP BY
       LANTHI,
       PHAI,
       HOSV + ' ' + TENSV
HAVING AVG(DIEM) > 7.0

--46. CHO BIẾT DANH SÁCH CÁC SINH VIÊN RỚT TRÊN 2 MÔN Ở LẦN THI 1.
SELECT MASV 'MÃ SINH VIÊN',
       COUNT(MAMH)'SỐ MÔN RỚT'
FROM   KETQUA
WHERE  LANTHI = 1
       AND DIEM < 5
GROUP BY
       MASV
HAVING COUNT(MAMH) >= 2

--47. CHO BIẾT DANH SÁCH NHỮNG KHOA CÓ NHIỀU HƠN 2 SINH VIÊN NAM
SELECT MAKHOA 'MÃ KHOA',
       'SỐ SINH VIÊN NAM'     = COUNT(MASV)
FROM   DMSV
WHERE  PHAI                   = N'NAM'
GROUP BY
       MAKHOA
HAVING COUNT(MASV) >= 2

--48. CHO BIẾT NHỮNG KHOA CÓ 2 SINH ĐẠT HỌC BỔNG TỪ 200.000 ĐẾN 300.000.
SELECT MAKHOA 'MÃ KHOA',
       'SỐ SINH VIÊN' = COUNT(MASV)
FROM   DMSV
WHERE  HOCBONG BETWEEN 200000 AND 300000
GROUP BY
       MAKHOA
HAVING COUNT(MASV) > 2

--49. CHO BIẾT SỐ LƯỢNG SINH VIÊN ĐẬU VÀ SỐ LƯỢNG SINH VIÊN RỚT CỦA TỪNG MÔN TRONG LẦN THI 1.
--LÀM TỪNG BẢNG
SELECT TENMH,
       'SỐ SINH VIÊN ĐẬU' = COUNT(MASV)
FROM   KETQUA     KQ,
       DMMH       MH
WHERE  KQ.MAMH = MH.MAMH
       AND LANTHI = 1
       AND DIEM >= 5
GROUP BY
       TENMH

SELECT TENMH,
       'SỐ SINH VIÊN RỚT' = COUNT(MASV)
FROM   KETQUA     KQ,
       DMMH       MH
WHERE  KQ.MAMH = MH.MAMH
       AND LANTHI = 1
       AND DIEM < 5
GROUP BY
       TENMH
--LÀM GỘP
SELECT TENMH 'TÊN MÔN HỌC',
       'SỐ SINH VIÊN ĐẬU'     = SUM(CASE WHEN DIEM >= 5 THEN 1 ELSE 0 END),
       'SỐ SINH VIÊN RỚT'     = SUM(CASE WHEN DIEM < 5 THEN 1 ELSE 0 END)
FROM   KETQUA     KQ,
       DMMH       MH
WHERE  KQ.MAMH = MH.MAMH
       AND LANTHI = 1
GROUP BY
       TENMH
--50. CHO BIẾT SỐ LƯỢNG SINH VIÊN NAM VÀ SỐ LƯỢNG SINH VIÊN NỮ CỦA TỪNG KHOA. TRÙNG LẠI CÂU 39
SELECT MAKHOA,
       'TỔNG SINH VIÊN NAM'     = SUM(CASE PHAI WHEN N'NAM' THEN 1 ELSE 0 END),
       'TỔNG SINH VIÊN NỮ'      = SUM(CASE PHAI WHEN N'NỮ' THEN 1 ELSE 0 END)
FROM   DMSV
GROUP BY
       MAKHOA

--F. TRUY VẤN CON TRẢ VỀ MỘT GIÁ TRỊ
--51. CHO BIẾT SINH VIÊN NÀO CÓ HỌC BỔNG CAO NHẤT.
SELECT HOSV + ' ' + TENSV 'HỌ TÊN SINH VIÊN',
       HOCBONG
FROM   DMSV
WHERE  HOCBONG = 
		(
           SELECT MAX(HOCBONG)
           FROM   DMSV
		)

--52. CHO BIẾT SINH VIÊN NÀO CÓ ĐIỂM THI LẦN 1 MÔN CƠ SỞ DỮ LIỆU CAO NHẤT.

SELECT HOSV + ' ' + TENSV 'HỌ TÊN SINH VIÊN',
       TENMH 'TÊN MÔN HỌC',
       LANTHI,
       DIEM
FROM   KETQUA     KQ,
       DMMH       MH,
       DMSV       SV
WHERE  SV.MASV = KQ.MASV
       AND KQ.MAMH = MH.MAMH
       AND LANTHI = 1
       AND TENMH = N'CƠ SỞ DỮ LIỆU'
       AND DIEM = (
               SELECT MAX(DIEM)
               FROM   KETQUA     KQ,
                      DMMH       MH
               WHERE  KQ.MAMH = MH.MAMH
                      AND TENMH = N'CƠ SỞ DỮ LIỆU'
                      AND LANTHI = 1
       )
       
--53. CHO BIẾT SINH VIÊN KHOA ANH VĂN CÓ TUỔI LỚN NHẤT.
SELECT HOSV + ' ' + TENSV 'HỌ TÊN SINH VIÊN',
       NGAYSINH 'NGÀY SINH',
       MAKHOA 'MÃ KHOA'
FROM   DMSV
WHERE  /*MAKHOA='AV' AND*/ NGAYSINH = (
           SELECT MIN(NGAYSINH)
           FROM   DMSV
           WHERE  MAKHOA = 'AV'
       )
--OR
SELECT HOSV + ' ' + TENSV 'HỌ TÊN SINH VIÊN',
       NGAYSINH 'NGÀY SINH',
       MAKHOA 'MÃ KHOA'
FROM   DMSV
WHERE  (GETDATE() -NGAYSINH) = (
           SELECT MAX(GETDATE() -NGAYSINH)
           FROM   DMSV
           WHERE  MAKHOA = 'AV'
)

--54. CHO BIẾT KHOA NÀO CÓ ĐÔNG SINH VIÊN NHẤT.
--CACH 1:
SELECT TENKHOA
FROM   DMSV       SV,
       DMKHOA     KH
WHERE  SV.MAKHOA = KH.MAKHOA
GROUP BY
       TENKHOA
HAVING COUNT(TENKHOA) >= ALL(
           SELECT COUNT(MASV)
           FROM   DMSV
           GROUP BY
                  MAKHOA
       )
--CACH 2:
SELECT TENKHOA
FROM   DMSV       SV,
       DMKHOA     KH
WHERE  SV.MAKHOA = KH.MAKHOA
GROUP BY
       TENKHOA
HAVING COUNT(TENKHOA) = (
           SELECT MAX(T.TONG)
           FROM   (
                      SELECT COUNT(MASV) AS TONG
                      FROM   DMSV
                      GROUP BY
                             MAKHOA
                  ) AS T
       )

--55. CHO BIẾT KHOA NÀO CÓ ĐÔNG NỮ NHẤT.
SELECT TENKHOA 'TÊN KHOA'
FROM   DMSV       SV,
       DMKHOA     KH
WHERE  SV.MAKHOA = KH.MAKHOA
       AND PHAI = N'NỮ'
GROUP BY
       TENKHOA
HAVING COUNT(TENKHOA) >= ALL(
           SELECT COUNT(MASV)
           FROM   DMSV
           WHERE  PHAI = N'NỮ'
           GROUP BY
                  MAKHOA
       )
--56. CHO BIẾT MÔN NÀO CÓ NHIỀU SINH VIÊN RỚT LẦN 1 NHIỀU NHẤT.
SELECT MAMH
FROM   KETQUA
WHERE  LANTHI = 1
       AND DIEM < 5
GROUP BY
       MAMH
HAVING COUNT(DIEM) >= ALL (
           SELECT COUNT(DIEM)
           FROM   KETQUA
           WHERE  LANTHI = 1
                  AND DIEM < 5
           GROUP BY
                  MAMH
)

--57. CHO BIẾT SINH VIÊN KHÔNG HỌC KHOA ANH VĂN CÓ ĐIỂM THI MÔN PHẠM LỚN HƠN ĐIỂM THI VĂN
--PHẠM CỦA SINH VIÊN HỌC KHOA ANH VĂN.
SELECT DISTINCT KQ.MASV
FROM   KETQUA     KQ,
       DMSV       SV
WHERE  SV.MASV = KQ.MASV
       AND MAMH = '05'
       AND MAKHOA NOT LIKE 'AV'
       AND DIEM > (
               SELECT DIEM
               FROM   KETQUA     KQ,
                      DMSV       SV
               WHERE  SV.MASV = KQ.MASV
                      AND MAMH = '05'
                      AND MAKHOA = 'AV'
       )
       
--G. TRUY VẤN CON TRẢ VỀ NHIỀU GIÁ TRỊ, SỬ DỤNG LƯỢNG TỪ ALL, ANY, UNION, TOP.
--58. CHO BIẾT SINH VIÊN CÓ NƠI SINH CÙNG VỚI HẢI.
SELECT MASV,
       HOSV + ' ' + TENSV
FROM   DMSV
WHERE  NOISINH = (
           SELECT NOISINH
           FROM   DMSV
           WHERE  TENSV = N'HẢI'
       )

--59. CHO BIẾT NHỮNG SINH VIÊN NÀO CÓ HỌC BỔNG LỚN HƠN TẤT CẢ HỌC BỔNG CỦA SINH VIÊN THUỘC KHOA ANH VĂN
SELECT MASV
FROM   DMSV
WHERE  HOCBONG >= ALL (
           SELECT HOCBONG
           FROM   DMSV
           WHERE  MAKHOA = 'AV'
		)

--60. CHO BIẾT NHỮNG SINH VIÊN CÓ HỌC BỔNG LỚN HƠN BẤT KỲ HỌC BỔNG CỦA SINH VIÊN HỌC KHÓA ANH VĂN
SELECT MASV,
       HOCBONG
FROM   DMSV
WHERE  HOCBONG >= ANY(
           SELECT HOCBONG
           FROM   DMSV
           WHERE  MAKHOA = 'AV'
       )

--61. CHO BIẾT SINH VIÊN NÀO CÓ ĐIỂM THI MÔN CƠ SỞ DỮ LIỆU LẦN 2 LỚN HƠN TẤT CẢ ĐIỂM THI LẦN 1 MÔN CƠ SỞ DỮ LIỆU CỦA NHỮNG SINH VIÊN KHÁC.
SELECT MASV
FROM   KETQUA
WHERE  MAMH           = '01'
       AND LANTHI     = 2
       AND DIEM >= ALL(
               SELECT DIEM
               FROM   KETQUA
               WHERE  MAMH           = '01'
                      AND LANTHI     = 1
           )

--62. CHO BIẾT NHỮNG SINH VIÊN ĐẠT ĐIỂM CAO NHẤT TRONG TỪNG MÔN.
SELECT MASV,
       KETQUA.MAMH,
       DIEM
FROM   KETQUA,
       (
           SELECT MAMH,
                  MAX(DIEM) AS MAXDIEM
           FROM   KETQUA
           GROUP BY
                  MAMH
       )A
WHERE  KETQUA.MAMH = A.MAMH
       AND DIEM = A.MAXDIEM

--63. CHO BIẾT NHỮNG KHOA KHÔNG CÓ SINH VIÊN HỌC.
SELECT *
FROM   DMKHOA
WHERE  NOT EXISTS (
           SELECT DISTINCT MAKHOA
           FROM   KETQUA,
                  DMSV
           WHERE  KETQUA.MASV = DMSV.MASV
                  AND MAKHOA = DMKHOA.MAKHOA
       )

--64. CHO BIẾT SINH VIÊN CHƯA THI MÔN CƠ SỞ DỮ LIỆU.
SELECT *
FROM   DMSV
WHERE  NOT EXISTS
       (
           SELECT DISTINCT *
           FROM   KETQUA
           WHERE  MAMH         = '01'
                  AND MASV     = DMSV.MASV
       )

--65. CHO BIẾT SINH VIÊN NÀO KHÔNG THI LẦN 1 MÀ CÓ DỰ THI LẦN 2.
SELECT MASV
FROM   KETQUA KQ
WHERE  LANTHI = 2
       AND NOT EXISTS
           (
               SELECT *
               FROM   KETQUA
               WHERE  LANTHI       = 1
                      AND MASV     = KQ.MASV
           )

--66. CHO BIẾT MÔN NÀO KHÔNG CÓ SINH VIÊN KHOA ANH VĂN HỌC.
SELECT TENMH
FROM   DMMH
WHERE  NOT EXISTS
       (
           SELECT MAMH
           FROM   KETQUA     KQ,
                  DMSV       SV
           WHERE  SV.MASV = KQ.MASV
                  AND SV.MAKHOA = 'AV'
                  AND DMMH.MAMH = MAMH
       )

--67. CHO BIẾT NHỮNG SINH VIÊN KHOA ANH VĂN CHƯA HỌC MÔN VĂN PHẠM.
SELECT MASV
FROM   DMSV DMSV
WHERE  MAKHOA = 'AV'
       AND NOT EXISTS (
               SELECT *
               FROM   KETQUA
               WHERE  MAMH         = '05'
                      AND MASV     = DMSV.MASV
           )

--68. CHO BIẾT NHỮNG SINH VIÊN KHÔNG RỚT MÔN NÀO.
SELECT MASV
FROM   DMSV DMSV
WHERE  NOT EXISTS (
           SELECT *
           FROM   KETQUA
           WHERE  DIEM <= 5
                  AND MASV = DMSV.MASV
       )

--69. CHO BIẾT NHỮNG SINH VIÊN HỌC KHOA ANH VĂN CÓ HỌC BỔNG VÀ NHỮNG SINH VIÊN CHƯA BAO GIỜ RỚT.
SELECT MASV,
       MAKHOA,
       HOCBONG
FROM   DMSV DMSV
WHERE  MAKHOA = 'AV'
       AND HOCBONG > 0
       AND NOT EXISTS (
               SELECT *
               FROM   KETQUA
               WHERE  DIEM < 5
                      AND MASV = DMSV.MASV
           )

--70. CHO BIẾT KHOA NÀO CÓ ĐÔNG SINH VIÊN NHẬN HỌC BỔNG NHẤT VÀ KHOA NÀO KHOA NÀO CÓ ÍT SINH VIÊN NHẬN HỌC BỔNG NHẤT.
SELECT MAKHOA,
       COUNT(MASV)'SO LUONG SV'
FROM   DMSV
WHERE  HOCBONG > 0
GROUP BY
       MAKHOA
HAVING COUNT(MASV) >= ALL (
           SELECT COUNT(MASV)
           FROM   DMSV
           WHERE  HOCBONG > 0
           GROUP BY
                  MAKHOA
       )
UNION
SELECT MAKHOA,
       COUNT(MASV)'SO LUONG SV'
FROM   DMSV
WHERE  HOCBONG > 0
GROUP BY
       MAKHOA
HAVING COUNT(MASV) <= ALL (
           SELECT COUNT(MASV)
           FROM   DMSV
           WHERE  HOCBONG > 0
           GROUP BY
                  MAKHOA
       )

--71. CHO BIẾT 3 SINH VIÊN CÓ HỌC NHIỀU MÔN NHẤT.
SELECT TOP 3 MASV,
       COUNT(DISTINCT MAMH)'SỐ MÔN HỌC'
FROM   KETQUA
GROUP BY
       MASV
HAVING COUNT(DISTINCT MAMH) >= ALL(
           SELECT COUNT(DISTINCT MAMH)
           FROM   KETQUA
           GROUP BY
                  MASV
       )
/*==========================H. TRUY VẤN DÙNG PHÉP CHIA =========================*/
--72. CHO BIẾT NHỮNG MÔN ĐƯỢC TẤT CẢ CÁC SINH VIÊN THEO HỌC.
SELECT MAMH
FROM   KETQUA
GROUP BY
       MAMH
HAVING COUNT(DISTINCT MASV) = (
           SELECT COUNT(MASV)
           FROM   DMSV
       )

--73. CHO BIẾT NHỮNG SINH VIÊN HỌC NHỮNG MÔN GIỐNG SINH VIÊN CÓ MÃ SỐ A02 HỌC.
SELECT DISTINCT     MASV
FROM   KETQUA       KQ
WHERE  EXISTS(
           SELECT DISTINCT MAMH
           FROM   KETQUA
           WHERE  MASV         = 'A02'
                  AND MAMH     = KQ.MAMH
       )

--74.CHO BIẾT NHỮNG SINH VIÊN HỌC NHỮNG MÔN BẰNG ĐÚNG NHỮNG MÔN MÀ SINH VIÊN A02 HỌC.
SELECT TENSV
FROM   KETQUA     KQ,
       DMSV       DMSV,
       (
           SELECT MASV,
                  MAMH,
                  COUNT(DISTINCT MAMH)SOMON
           FROM   KETQUA
           WHERE  MASV = 'A02'
           GROUP BY
                  MASV,
                  MAMH
       )          A
WHERE  KQ.MASV = DMSV.MASV
       AND KQ.MAMH = A.MAMH
       AND KQ.MASV <> A .MASV
GROUP BY
       TENSV
HAVING COUNT(DISTINCT KQ.MAMH) = (
           SELECT COUNT(DISTINCT MAMH)
           FROM   KETQUA
           WHERE  MASV = 'A02'
       )

SELECT DMSV.MASV
FROM   KETQUA     KQ,
       DMSV       DMSV
WHERE  KQ.MASV = DMSV.MASV
       AND MAMH = (
               SELECT DISTINCT MAMH
               FROM   KETQUA
               WHERE  MASV         = 'A02'
                      AND MAMH     = KQ.MAMH
           )
       AND DMSV.MASV NOT LIKE 'A02'
GROUP BY
       DMSV.MASV
HAVING COUNT(DISTINCT MAMH) = (
           SELECT COUNT(DISTINCT MAMH)
           FROM   KETQUA
           WHERE  MASV = 'A02'
       )

--75. TẠO MỘT BẢNG MỚI TÊN SINHVIEN-KETQUA: GỒM: MASV, HOSV, TENSV, SOMONHOC. SAU ĐÓ THÊM DỮ LIỆU VÀO BẢNG NÀY DỰA VÀO DỮ LIỆU ĐÃ CÓ.
CREATE TABLE SINHVIEN_KETQUA
(
	MASV         CHAR(3) NOT NULL,
	HOSV         NVARCHAR(15) NOT NULL,
	TENSV        NVARCHAR(7)NOT NULL,
	SOMONHOC     TINYINT
)

INSERT INTO SINHVIEN_KETQUA
SELECT DMSV.MASV,
       HOSV,
       TENSV,
       COUNT(DISTINCT MAMH)
FROM   DMSV       DMSV,
       KETQUA     KQ
WHERE  DMSV.MASV = KQ.MASV
GROUP BY
       DMSV.MASV,
       HOSV,
       TENSV

--76. THÊM VÀO BẢNG KHOA CỘT SISO, CẬP NHẬT SỈ SỐ VÀO KHOA TỪ DỮ LIỆU SINH VIÊN.
GO
ALTER TABLE DMKHOA
ADD SISO TINYINT
GO

UPDATE DMKHOA
SET    SISO = (
           SELECT COUNT(MASV)
           FROM   DMSV
           WHERE  MAKHOA = 'AV'
           GROUP BY
                  (MAKHOA)
       )
WHERE  MAKHOA = 'AV'

UPDATE DMKHOA
SET    SISO = (
           SELECT COUNT(MASV)
           FROM   DMSV
           WHERE  MAKHOA = 'TH'
           GROUP BY
                  (MAKHOA)
       )
WHERE  MAKHOA = 'TH'

UPDATE DMKHOA
SET    SISO = (
           SELECT COUNT(MASV)
           FROM   DMSV
           WHERE  MAKHOA = 'TR'
           GROUP BY
                  (MAKHOA)
       )
WHERE  MAKHOA = 'TR'

UPDATE DMKHOA
SET    SISO = (
           SELECT COUNT(MASV)
           FROM   DMSV
           WHERE  MAKHOA = 'VL'
           GROUP BY
                  (MAKHOA)
       )
WHERE  MAKHOA = 'VL'

--77. TĂNG THÊM 1 ĐIỂM CHO CÁC SINH VIÊN VỚT LẦN 2. NHƯNG CHỈ TĂNG TỐI ĐA LÀ 5 ĐIỂM
UPDATE KETQUA
SET    DIEM = DIEM + 1
WHERE  LANTHI = 2
       AND DIEM + 1 <= 5

SELECT *
FROM   KETQUA

--78. TĂNG HỌC BỔNG LÊN 100000 CHO NHỮNG SINH VIÊN CÓ ĐIỂM TRUNG BÌNH LÀ 6.5 TRỞ LÊN
UPDATE DMSV
SET    HOCBONG = HOCBONG + 100000
WHERE  MASV IN (SELECT MASV
                FROM   KETQUA
                GROUP BY
                       MASV
                HAVING AVG(DIEM) >= 6.5)

--79. THIẾT LẬP HỌC BỔNG BẰNG 0 CHO NHỮNG SINH VIÊN THI HAI MÔN RỐT Ở LẦN 1
UPDATE DMSV
SET    HOCBONG = 0
WHERE  MASV IN (SELECT MASV
                FROM   KETQUA
                WHERE  LANTHI = 1
                       AND DIEM < 5
                GROUP BY
                       MASV
                HAVING COUNT(MAMH) = 2)

--80. XOÁ TẤT CẢ NHỮNG SINH VIÊN CHƯA DỰ THI MÔN NÀO.
DELETE 
FROM   DMSV
WHERE  NOT EXISTS (
           SELECT MASV
           FROM   KETQUA
           WHERE  MASV = DMSV.MASV
       )

--81. XÓA NHỮNG MÔN MÀ KHÔNG CÓ SINH VIÊN HỌC.
DELETE 
FROM   DMMH
WHERE  NOT EXISTS(
           SELECT MAMH
           FROM   KETQUA
           WHERE  MAMH = DMMH.MAMH
       )

-- TẠO VIEW
--82. DANH SÁCH SINH VIÊN KHÔNG BI RỚT MÔN NÀO
CREATE VIEW CAU82
AS
SELECT DMSV.MASV,
       HOSV,
       TENSV,
       PHAI,
       NGAYSINH,
       NOISINH,
       HOCBONG
FROM   DMSV,
       KETQUA
WHERE  DMSV.MASV = KETQUA.MASV
GROUP BY
       DMSV.MASV,
       HOSV,
       TENSV,
       PHAI,
       NGAYSINH,
       NOISINH,
       HOCBONG
HAVING MIN(DIEM) >= 5

--83. DANH SÁCH SINH VIÊN HỌC MÔN VĂN PHẠM VÀ MÔN CƠ SỞ DỮ LIỆU
CREATE VIEW CAU83
AS
SELECT *
FROM   DMSV
WHERE  MASV IN (SELECT DISTINCT KETQUA.MASV
                FROM   KETQUA,
                       DMSV
                WHERE  DMSV.MASV = KETQUA.MASV
                       AND (MAMH = '01' OR MAMH = '05'))

DROP VIEW CAU83

--84. TRONG MỖI SINH VIÊN CHO BIẾT MÔN CÓ ĐIỂM THI LỚN NHẤT. THÔNG TIN GỒM: MÃ SINH VIÊN, TÊN SINH VIÊN, TÊN MÔN, ĐIỂM.
CREATE VIEW CAU84
AS
SELECT DISTINCT DMSV.MASV,
       TENSV,
       TENMH,
       MAX(DIEM)DIEM
FROM   DMSV,
       KETQUA,
       DMMH
WHERE  DMSV.MASV = KETQUA.MASV
       AND DMMH.MAMH = KETQUA.MAMH
GROUP BY
       DMSV.MASV,
       TENSV,
       TENMH

SELECT *
FROM   CAU84
--85. DANH SÁCH SINH VIÊN: KHÔNG RỚT LẦN 1 HOẶC ,KHÔNG HỌC MÔN VĂN PHẠM
CREATE VIEW CAU85
AS
SELECT *
FROM   DMSV
WHERE  MASV IN (SELECT MASV
                FROM   KETQUA
                WHERE  (LANTHI = 1 AND DIEM < 5)
                       OR  NOT EXISTS
                           (
                               SELECT *
                               FROM   KETQUA
                               WHERE  MAMH = '05'
                                      AND MASV = KETQUA.MASV
                           ))

--86. DANH SÁCH NHỮNG SINH VIÊN KHOA CÓ 2 SINH VIÊN NỮ TRỞ LÊN
CREATE VIEW CAU86
AS
SELECT *
FROM   DMSV
WHERE  MAKHOA = (
           SELECT SV.MAKHOA
           FROM   DMSV       SV,
                  DMKHOA     KH
           WHERE  SV.MAKHOA = KH.MAKHOA
                  AND PHAI = N'NỮ'
           GROUP BY
                  SV.MAKHOA
           HAVING COUNT(TENKHOA) >= ALL(
                      SELECT COUNT(MASV)
                      FROM   DMSV
                      WHERE  PHAI = N'NỮ'
                      GROUP BY
                             MAKHOA
                  )
       )
/*===============HẾT================*/