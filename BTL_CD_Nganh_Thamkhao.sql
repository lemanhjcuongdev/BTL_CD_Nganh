USE KinhDoanhTBMayTinh 
SELECT * from tblMathang
-- Tạo bảng Nhân viên--
CREATE TABLE tblNhanVien (
	sMaNV VARCHAR(10) PRIMARY KEY ,
	sTenNV NVARCHAR(25) NOT NULL ,
	dNgaySinh DATE NOT NULL,
	sGioiTinh NVARCHAR(5) CHECK ( sGioiTinh IN ('Nam',N'Nữ')) ,
	sDiaChi NVARCHAR(50) NOT NULL ,
	sSDT VARCHAR(10) NOT NULL ,
	fHSL FLOAT CHECK(fHSL>=2 AND fHSL<=10) NOT NULL,
	fLCB FLOAT NOT NULL CHECK(fLCB>0),
	dNgayVaoLam DATE NOT NULL ,
	CONSTRAINT [Ngày vào làm đủ 18 tuổi] CHECK(DATEDIFF(DAY,dNgaySinh,dNgayVaoLam)/365>=18)
	);
-- Tạo bảng nhà cung cấp--
	CREATE TABLE tblNhaCC(
	sTenNCC VARCHAR(25) PRIMARY KEY ,
	sSDT VARCHAR(10),
	sDiaChi NVARCHAR(50)
	)
-- Tạo bảng sản phẩm--
CREATE TABLE tblSanPham(
	sMaSP VARCHAR(10) PRIMARY KEY ,
	sTenSP NVARCHAR(25) NOT NULL,
	sHangSX NVARCHAR(25) NOT NULL,
	iNamSX INT NOT NULL,
	fDonGiaNhap FLOAT CHECK(fDonGiaNhap>0) NOT NULL,
	fDonGiaXuat FLOAT NOT NULL,
	CONSTRAINT dongia CHECK(fDonGiaXuat>1.1*fDonGiaNhap)
	);
-- Tạo bảng hoá đơn nhập --
CREATE TABLE tblHDNhap(
	sMaHDN VARCHAR(10) PRIMARY KEY,
	sMaNV VARCHAR(10) REFERENCES dbo.tblNhanVien(sMaNV) ON UPDATE CASCADE ON DELETE CASCADE ,
	dNgayNhap DATE CHECK(dNgayNhap<=GETDATE()) NOT NULL,
	sTenNCC VARCHAR(25) REFERENCES dbo.tblNhaCC(stenNCC) ON UPDATE CASCADE ON DELETE CASCADE
	)
-- Tạo bảng khách hàng--
CREATE TABLE tblKhachHang(
	sTenKH NVARCHAR(25)  NOT NULL,
	sSDTKH VARCHAR(10) PRIMARY KEY,
	sEmail VARCHAR(50) ,
	sDiaChi NVARCHAR(50) NOT NULL
	)
-- Tạo bảng Hoá đơn xuất--
CREATE TABLE tblHDXuat(
	sMaHDX VARCHAR(10) PRIMARY KEY,
	sMaNV VARCHAR(10) REFERENCES dbo.tblNhanVien(sMaNV) ON UPDATE CASCADE ON DELETE CASCADE,
	dNgayLap DATE CHECK(dNgayLap<=GETDATE()) NOT NULL ,
	sSDTKH VARCHAR(10) REFERENCES dbo.tblKhachHang(sSDTKH) ON UPDATE CASCADE ON DELETE CASCADE ,
	sHinhThucTT NVARCHAR(20) NOT NULL CHECK(sHinhThucTT IN(N'Tiền mặt',N'Thẻ ngân hàng'))
	)
-- Tạo bảng chi tiết hoá đơn nhập--
CREATE TABLE tblCTNhap(
	sMaHDN VARCHAR(10) REFERENCES tblHDNhap(sMaHDN) ON UPDATE CASCADE ON DELETE CASCADE  ,
	sMaSP VARCHAR(10)  REFERENCES dbo.tblSanPham(sMaSP) ON UPDATE CASCADE ON DELETE CASCADE,
	iSoLuong INT NOT NULL CHECK(iSoLuong>0) ,
	fDonGiaNhap FLOAT 
	)
-- Tạo bảng Chi tiết xuất--
CREATE TABLE tblCTXuat(
	sMaHDX VARCHAR(10) REFERENCES dbo.tblHDXuat(sMaHDX) ON UPDATE CASCADE ON DELETE CASCADE ,
	sMaSP VARCHAR(10) REFERENCES dbo.tblSanPham (sMaSP) ON UPDATE CASCADE ON DELETE CASCADE ,
	iSoLuong INT NOT NULL CHECK(iSoLuong>0) ,
	fDonGiaXuat FLOAT 
	)
--Nhập dữ liệu vào bảng Nhân viên --
insert into tblNhanVien
	values 
	('20a100',N'Phạm Hồng Quân','1/1/2002',N'Nam',N'Thái Bình','0984524831',9,6000000,'5/20/2021'),
	('20a101',N'Trần Văn Cương','8/1/2000',N'Nam',N'Lai Châu','0968597131',8,5000000,'12/1/2020'),
	('20a102',N'Nguyễn Thị Hòa','4/11/1998',N'Nữ',N'Quảng Ninh','0305986843',7,4000000,'3/18/2020'),
	('20a103',N'Võ Thị Hải','3/22/1996',N'Nữ',N'Phú Thọ','0983475013',6,3000000,'1/1/2021'),
	('20a104',N'Đào Văn Tư','8/21/2000',N'Nam',N'Tuyên Quang','0982762300',7.5,5500000,'11/21/2020'),
	('20a105',N'Vui Như Tết','2/18/1999',N'Nữ',N'Hà Nội','0987654321',6,4000000,'2/3/2020'),
	('20a106',N'Mãi Phấn Khởi','8/12/1995',N'Nam',N'Hà Nội','037628401',7,4000000,'6/21/2019'),
	('20a107',N'Trương Vĩnh Phúc','9/13/1999',N'Nam',N'Bắc Ninh','0986275337',6,6100000,'1/23/2020'),
	('20a108',N'Hoàng Vĩnh Lộc','2/13/1998',N'Nam',N'Hòa Bình','0314567899',8,4000000,'5/27/2019'),
	('20a109',N'Thượng Văn Thọ','4/22/1997',N'Nam',N'Hà Nội','0985123123',7,4800000,'9/15/2019')

SELECT  * FROM  tblNhanVien
-- Nhập dữ liệu bảng NHÀ CUNG CẤP --
INSERT  INTO  tblNhaCC
	VALUES 
	('Samsung','0986866868',N'Quảng Ninh'),
	('XiaoMi','0374123123',N'Hà Nội'),
	('Apple','0922383383',N'Hà Nội'),
	('Huawei','0388567567',N'Quảng Bình'),
	('Dell','0982898989',N'Bắc Giang'),
	('Acer','0934999999',N'Bắc Ninh'),
	('Razer','0982633333',N'Thanh Hóa'),
	('Asus','0976911911',N'Vĩnh Phúc'),
	('MSI','0989789789',N'Hòa Bình'),
	('LG','0376161166',N'Thái Nguyên')

SELECT * FROM tblNhaCC

-- Nhập dữ liệu bảng SẢN PHẨM --
INSERT  INTO  tblSanPham
	VALUES 
	('ss100',N'Màn hình Samsung 24 inch','Samsung',2019,2000000,3000000),
	('xm200',N'Webcam máy tính Xiaomi','Xiaomi',2020,300000,600000),
	('ap300',N'Macbook air M1','Apple',2020,23000000,27000000),
	('hw400',N'Laptop Huawei D14','Huawei',2020,15000000,18000000),
	('d500',N'Bàn Phím Dell KB216','Dell',2018,100000,319000),
	('ac600',N'Laptop Acer Nitro 5','Acer',2021,18000000,21000000),
	('ra700',N'Chuột Razer V2 Pro','Razer',2019,2500000,3500000),
	('as800',N'Main PC Asus ROG','Asus',2020,2800000,3200000),
	('ms900',N'Ram PC G.SKILL 16GB','MSI',2021,2500000,3000000),
	('lg000',N'Laptop LG Gram 14 inch','LG',2021,30000000,35100000)

SELECT * FROM tblSanPham

-- Nhập dữ liệu bảng HÓA ĐƠN NHẬP HÀNG --
INSERT INTO tblHDNhap
	VALUES 
	('a100','20a101','3/14/2021','Apple'),
	('a101','20a109','4/15/2020','LG'),
	('a102','20a100','8/16/2021','Huawei'),
	('a103','20a106','6/17/2020','MSI'),
	('a104','20a105','7/18/2020','Asus'),
	('a105','20a108','1/10/2021','Dell'),
	('a106','20a107','8/19/2021','Samsung'),
	('a107','20a104','9/5/2021','Razer'),
	('a108','20a103','1/3/2021','XiaoMi'),
	('a109','20a102','1/13/2021','Acer')

SELECT * FROM dbo.tblHDNhap

-- Nhập dữ liệu bảng KHÁCH HÀNG --
INSERT  INTO  tblKhachHang
	VALUES  
	(N'Nguyễn Văn Bời','0866000240','boi19@gmail.com',N'Định Công'),
	(N'Nguyễn Thị Hồng','0868696548','hongzz@gmail.com',N'Hai Bà Trưng'),
	(N'Chư Bát Giới','0869911171','heo12@gmail.com',N'Trung Trực'),
	(N'Lý Lâm Khải','0862135113','kaiz@gmail.com',N'Tuyên Quang'),
	(N'Trần Văn Sơn','0862300513','sonheungmin@gmail.com',N'Nguyễn Trãi'),
	(N'Lê Đức Mạnh','0867011150','manhto@gmail.com',N'Giáp Bát'),
	(N'Hà Thị Hậu','0867170570','hauve@gmail.com',N'Bắc Từ Liêm'),
	(N'Trần Thị Phương Thảo','0862808799','thaomoc@gmail.com',N'Linh Đàm'),
	(N'Phạm Hồng Thái','0865784560','htmlcss@gmail.com',N'Phố cổ'),
	(N'Tôn Ngộ Không','0867966612','gaynhuy@gmail.com',N'Tây Thiên')

SELECT  * FROM  tblKhachHang

-- Nhập dữ liệu HÓA ĐƠN XUẤT --
INSERT INTO tblHDXuat(sMaHDX,sMaNV,dNgayLap,sSDTKH,sHinhThucTT)
	VALUES
	('HD1','20a101','2/1/2021','0868696548',N'Thẻ ngân hàng'), 
	('HD0','20a100','7/15/2021','0866000240',N'Tiền mặt'),
	('HD2','20a102','10/15/2020','0869911171',N'Tiền mặt'),
	('HD3','20a103','3/1/2021','0862135113',N'Tiền mặt'),
	('HD4','20a104','3/15/2021','0862300513',N'Thẻ ngân hàng'),
	('HD5','20a105','12/1/2020','0867011150',N'Tiền mặt'),
	('HD6','20a106','2/14/2020','0867170570',N'Thẻ ngân hàng'),
	('HD7','20a107','7/16/2020','0862808799',N'Tiền mặt'),
	('HD8','20a108','11/15/2019','0865784560',N'Tiền mặt'),
	('HD9','20a109','10/20/2019','0867966612',N'Tiền mặt')
 SELECT * FROM dbo.tblHDXuat

 -- Nhập giá trị bảng Chi tiết hoá đơn nhập --
 -- Đơn giá nhập sẽ được cập nhật ở phần trigger --
 INSERT INTO dbo.tblCTNhap
 (sMaHDN,sMaSP,iSoLuong,fDonGiaNhap)
 VALUES
	('a100', 'ss100',5 ,2000000),
	('a105', 'd500',25,100000),
	('a106', 'ac600',12,18000000),
	('a107', 'as800',8,2750000),
	('a109', 'ap300',15,23000000),
	('a108', 'hw400',5,15000000),
	('a101', 'ra700',20,2500000),
	('a104', 'ms900',5,2500000),
	('a103', 'xm200',10,300000),
	('a102', 'ss100',10,1950000)
SELECT * FROM dbo.tblCTNhap
-- Nhập giá trị bảng Chi tiết hoá đơn xuất--
-- Đơn giá xuất sẽ được cập nhật ở phần trigger --

 INSERT INTO dbo.tblCTXuat
 VALUES('HD2', 'ss100',3,2900000)
INSERT INTO dbo.tblCTXuat
VALUES('HD1', 'd500',2,290000)
INSERT INTO dbo.tblCTXuat
 VALUES('HD5', 'ac600',1,20999000)
INSERT INTO dbo.tblCTXuat
 VALUES('HD6', 'as800',2,3100000)
INSERT INTO dbo.tblCTXuat
 VALUES('HD8', 'ap300',1,26500000)
INSERT INTO dbo.tblCTXuat
VALUES('HD9', 'hw400',1,17499000)
INSERT INTO dbo.tblCTXuat
VALUES('HD3', 'ra700',2,3468000)
INSERT INTO dbo.tblCTXuat
VALUES('HD4', 'ms900',2,2900000)
INSERT INTO dbo.tblCTXuat
 VALUES('HD7', 'xm200',2,600000)
INSERT INTO dbo.tblCTXuat
 VALUES('HD0' ,'ss100',1,3000000)

SELECT * FROM dbo.tblCTXuat

-- Thêm 3 Sản Phẩm – //Nhà CC Xiaomi + 2SP và Samsung +1
INSERT  INTO  tblSanPham
VALUES 
	('xm300',N'Chuột XiaoMi 7200DPI','Samsung',2021,70000,200000),
	('xm400',N'Tai nghe XiaoMi','Samsung',2021,100000,300000),
	('ss200',N'SSD SS 512GB','Samsung',2019,200000,700000)
-- Thêm HĐNhập -- //NV 103 nhập thêm 2 đơn và 107 thêm 1 đơn
INSERT INTO tblHDNhap
VALUES 
	('a110','20a103','1/3/2021','XiaoMi'),
	('a111','20a103','8/30/2021','XiaoMi'),
	('a112','20a107','9/11/2019','Samsung')
-- Thêm 6 HĐX -- //NV 109 xuất +3 hóa đơn, 108 +2, 107 +1
INSERT INTO tblHDXuat(sMaHDX,sMaNV,dNgayLap,sSDTKH,sHinhThucTT)
VALUES 
	('HD10','20a109','9/25/2019','0867966612',N'Thẻ ngân hàng'),
	('HD11','20a109','1/1/2020','0869911171',N'Tiền mặt'),
	('HD12','20a109','11/20/2019','0869911171',N'Tiền mặt'),
	('HD13','20a108','12/21/2019','0867966612',N'Thẻ ngân hàng'),
	('HD14','20a108','12/28/2019','0866000240',N'Tiền mặt'),
	('HD15','20a107','6/18/2020','0865784560',N'Tiền mặt')

UPDATE dbo.tblHDXuat
SET fTongTien =0
WHERE sMaHDX LIKE 'HD1%' AND sMaHDX != 'HD1'

-- Thêm 3 bản ghi cho CTNhap --
 INSERT INTO dbo.tblCTNhap 
 VALUES
	('a110', 'xm300', 10 ,70000),
	('a111', 'xm400', 11,100000 ),
	('a112', 'ss200', 20,200000)
--Thêm 9 bản ghi cho CTXuat-- //Mã HD1 mua +2sp, HD8 mua +1 
 INSERT INTO dbo.tblCTXuat 
 VALUES('HD10', 'ss100',2,3000000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD11', 'd500',5,319000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD12', 'ac600',1,20900000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD13', 'ap300',1,26500000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD14', 'xm200',1,550000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD15', 'ms900',1,3000000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD1', 'ms900',1,2890000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD1', 'hw400',1,18000000)
INSERT INTO dbo.tblCTXuat 
 VALUES('HD8', 'xm200',1,600000)



	---------------------------------------------------------------------View-------------------------------------------------------
--1.Tạo view gồm tên và số điện thoại của nhân viên
CREATE VIEW vvDSNV 
AS
SELECT sTenNV as[ Tên nhân viên], sSDT as [ SĐT ]
FROM dbo.tblNhanVien

SELECT * FROM vvDSNV
--2.tạo view thống kê số lượng nhân viên theo giới tính
CREATE VIEW vvNV_GT
AS
SELECT sGioiTinh AS [Giới tính] ,COUNT(sMaNV) AS [Số lượng nhân viên]
FROM dbo.tblNhanVien
GROUP BY sGioiTinh 

SELECT * FROM vvNV_GT

--3.Đếm số hoá đơn xuất mà nhân viên đã lập được
create view vvHDX_NV
as 
select 	tblNhanVien.sMaNV AS [Mã nhân viên], 
		tblNhanVien.sTenNV AS [Tên nhân viên],
		COUNT (sMaHDX) AS [Số Hoá đơn xuất đã lập]
FROM  tblNhanVien inner join tblHDXuat
On tblNhanVien.sMaNV = tblHDXuat.sMaNV
group by tblNhanVien.sMaNV , tblNhanVien.sTenNV

SELECT * FROM vvHDX_NV

--4.cho biết thông tin những nhân viên có năm vào làm là 2020
CREATE VIEW vvNV_Ngayvaolam
AS
SELECT *
FROM tblNhanVien
WHERE YEAR(dNgayVaoLam) = 2020

SELECT * FROM vvNV_Ngayvaolam

--5.Tính tổng tiền các hóa đơn đã xuất năm 2020 

Create View vvTongTien_HDX_2020
AS
Select year(dNgayLap) As N'Năm lập ', 
	SUM([iSoLuong]*[dbo].[tblSanPham].fDonGiaXuat) As N'Tổng Tiền'
From [dbo].[tblHDXuat], [dbo].[tblCTXuat], [dbo].[tblSanPham]
Where [dbo].[tblCTXuat].sMaHDX = [dbo].[tblHDXuat].sMaHDX And
	[dbo].[tblCTXuat].sMaSP = [dbo].[tblSanPham].sMaSP
	AND year(dNgayLap) = 2020
GROUP BY year(dNgayLap)

Select * From vvTongTien_HDX_2020

-- 6.Cho biết khách hàng đã mua >2 sản phẩm 
Create View vvKH_SP_UP2
AS
Select sTenKH AS N'Tên Khách Hàng', 
	COUNT([dbo].[tblCTXuat].sMaSP) AS N'Số Sản Phẩm' 
From [dbo].[tblKhachHang],[dbo].[tblHDXuat],[dbo].[tblCTXuat]
Where [dbo].[tblHDXuat].sSDTKH = [dbo].[tblKhachHang].sSDTKH 
	And [dbo].[tblCTXuat].sMaHDX = [dbo].[tblHDXuat].sMaHDX
GROUP BY [dbo].[tblCTXuat].sMaHDX, sTenKH
HAVING COUNT([dbo].[tblCTXuat].sMaSP) > 2

Select * From vvKH_SP_UP2

--7. Cho Biết Sản Phẩm Không Bán Được Trong Năm 2021 
Create View vvSP_KhongBan_2021
AS
Select sMaSP, sTenSP AS N'Tên Sản Phẩm Không Bán Được'
From [dbo].[tblSanPham]
WHERE sMaSP not in ( 
	Select tblCTXuat.sMaSP 
	From tblSanPham inner join tblCTXuat 
		on tblSanPham.sMaSP = tblCTXuat.sMaSP 
		inner join tblHDXuat 
		on tblCTXuat.sMaHDX = tblHDXuat.sMaHDX
	Where 	 YEAR(dNgayLap) = 2021 
	GROUP BY tblCTXuat.sMaSP )
Select * From vvSP_KhongBan_2021

--8.Tạo view cho biết 3 khách hàng đã trả tiền nhiều nhất
create view vvKH_3_TienMax
as
select top 3 tblkhachhang.sTenKH as [Tên khách hàng], 
			sum(tblCTXuat.iSoLuong*tblSanPham.fDongiaxuat) AS [Tổng Tiền]
from tblkhachhang inner join tblHDXuat 
on tblkhachhang.sSDTKH = tblHDXuat.sSDTKH
inner join tblCTXuat 
on tblHDXuat.sMaHDX= tblCTXuat.sMaHDX
inner join tblSanPham 
on tblsanpham.sMaSP = tblCTXuat.sMaSP
group by tblkhachhang.sTenKH
order by sum(tblCTXuat.iSoLuong*tblSanPham.fDongiaXuat) DESC

select *from vvKH_3_TienMax

--9.cho biết tên sản phẩm đã bán được số tiền lớn hơn 20000000 trong năm 2021

create view vvSP_Tien_UP20tr_2021
as
	select tblsanpham.stenSP as [Tên sản phẩm],
	sum (tblCTXuat.iSoLuong*tblSanPham.fDongiaxuat) as [Tổng tiền]
from tblsanpham
INNER JOIN tblCTXuat
on tblsanpham.sMaSP = tblCTXuat.sMaSP
INNER JOIN tblHDXuat
on tblHDXuat.sMaHDX= tblCTXuat.sMaHDX
where year(dNgayLap)=2021
group by stenSP
having 	sum (tblCTXuat.iSoLuong*tblSanPham.fDongiaxuat)>20000000

select *from vvSP_Tien_UP20tr_2021


-- 10.Tạo view cho biết thông tin khách hàng đã mua máy tính hãng Dell--
CREATE VIEW vvKH_SP_Dell
AS
SELECT sTenKH AS [Tên Khách Hàng] ,tblKhachHang.sSDTKH AS [SĐT] , sDiaChi AS [Địa chỉ]
FROM dbo.tblCTXuat inner join dbo.tblHDXuat on dbo.tblCTXuat.sMaHDX = dbo.tblHDXuat.sMaHDX
inner join dbo.tblKhachHang on dbo.tblKhachHang.sSDTKH = dbo.tblHDXuat.sSDTKH 
inner join  dbo.tblSanPham on dbo.tblSanPham.sMaSP = dbo.tblCTXuat.sMaSP
WHERE sHangSX = 'Dell'

SELECT*FROM vvKH_SP_Dell

-- 11.Tạo view cho biết thông tin khách hàng thanh toán hoá đơn giá trị cao nhất --
CREATE VIEW vvKH_HD_MAX
AS 
SELECT sTenKH AS [Tên Khách Hàng] ,tblKhachHang.sSDTKH AS [SĐT] , sDiaChi AS [Địa chỉ] 
, sum(dbo.tblCTXuat.iSoLuong*dbo.tblSanPham.fDonGiaXuat) as [Giá trị hoá đơn ]
FROM dbo.tblCTXuat inner join dbo.tblHDXuat on dbo.tblCTXuat.sMaHDX = dbo.tblHDXuat.sMaHDX
inner join dbo.tblKhachHang on dbo.tblKhachHang.sSDTKH = dbo.tblHDXuat.sSDTKH 
inner join  dbo.tblSanPham on dbo.tblSanPham.sMaSP = dbo.tblCTXuat.sMaSP
WHERE tblCTXuat.sMaHDX =(select tblCTXuat.sMaHDX 
		from tblHDXuat inner join tblCTXuat on tblHDXuat.sMaHDX = tblCTXuat.sMaHDX 
						inner join tblSanPham on tblCTXuat.sMaSP=tblSanPham.sMaSP
		group by tblCTXuat.sMaHDX
		having sum(iSoLuong*tblSanPham.fDonGiaXuat) >= all( select  sum(iSoLuong*tblSanPham.fDonGiaXuat)
				from tblHDXuat inner join tblCTXuat on tblHDXuat.sMaHDX = tblCTXuat.sMaHDX 
								inner join tblSanPham on tblCTXuat.sMaSP=tblSanPham.sMaSP
				group by tblCTXuat.sMaHDX )
				)
group by sTenKH , tblKhachHang.sSDTKH ,sDiaChi ,tblCTXuat.sMaHDX
																		

SELECT*FROM vvKH_HD_MAX
-----------------------------------------------------------PROC-----------------------------------------------------------
-- 1.Tạo thủ tục hiện ra danh sách khách hàng mua hàng vào tháng x năm x --

CREATE PROC prKH_Thangnam (@thang INT, @nam INT)
AS
BEGIN
	IF(@thang<1 OR @thang>12 OR ( @nam-YEAR(GETDATE())) >0 ) 
		BEGIN 
	PRINT N'Giá trị tháng hoặc năm vừa nhập chưa đúng !' RETURN
		END  
	SELECT sTenKH as N'Tên Khách Hàng',
			sTenSP as N'Tên Sản Phẩm',
			iSoLuong as N'Số Lượng',
			SUM([iSoLuong]*[dbo].[tblSanPham].fDonGiaXuat) As N'Tổng Tiền Hóa Đơn',
			dNgayLap AS [Ngày lập] 
	FROM tblKhachHang, tblHDXuat, tblCTXuat, tblSanPham
	WHERE tblHDXuat.sSDTKH = tblKhachHang.sSDTKH And
			tblCTXuat.sMaHDX = tblHDXuat.sMaHDX And
			tblCTXuat.sMaSP = tblSanPham.sMaSP And
			MONTH(dNgayLap) = @thang and YEAR(dNgayLap) = @nam
	Group By sTenKH, tblSanPham.sTenSP, tblCTXuat.iSoLuong , dNgayLap
END

EXEC prKH_Thangnam 3,2021

--2.Tạo thủ tục cho phép thêm bản ghi sản phẩm -- 
CREATE Proc prInsertSP(
	@masp VARCHAR(10),
	@tensp NVARCHAR(25),
	@hangsx NVARCHAR(25),
	@namsx INT,
	@dongianhapSP FLOAT,
	@dongiaxuatSP FLOAT
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblSanPham WHERE sMaSP = @masp)
		BEGIN
			PRINT N'Mã sản phẩm ' + @masp+ N' đã tồn tại'  RETURN
		END 
	IF(@dongiaxuatSP < 1.1 *@dongianhapSP OR @dongiaxuatSP<0 OR @dongianhapSP<0 )
		BEGIN
			PRINT N'Đơn giá không đúng ràng buộc' RETURN
		END
	IF (@namsx - YEAR(GETDATE())>0) 
		BEGIN
			PRINT N'Năm sản xuất nhập sai!' RETURN
		END

	INSERT INTO [dbo].[tblSanPham] (sMaSP,sTenSP,sHangSX,iNamSX,fDonGiaNhap,fDonGiaXuat)
		VALUES(@masp,@tensp,@hangsx,@namsx,@dongianhapSP,@dongiaxuatSP)
END 

EXEC prInsertSP 'ac800',N'tai nghe acer','Acer',2021,100000,300000
SELECT * FROM tblSanPham

--3.Tạo thủ tục tăng 1.5 lương cho nhân viên làm việc trên 1 năm
CREATE  PROC  prNV_Luong
AS 
BEGIN 
	update tblNhanVien
	set fLCB =1.5* fLCB
	where  datediff(day, dNgayVaoLam, getdate())/365 >= 1
  
END  

EXEC  prNV_Luong
SELECT  * FROM  tblNhanVien

--4.Tạo thủ tục thêm khách hàng
CREATE PROC prInsertKH( 
		@tenkh nvarchar(25),
		@sdtkh varchar(10),
		@email nvarchar(50),
		@diachi nvarchar(50))
AS
BEGIN 
	If exists (select * from dbo.tblKhachHang where sSDTKH = @sdtkh) 
			Print N'Đã có khách hàng có số điện thoại '+ @sdtkh
	ELSE
		INSERT INTO tblKhachHang(sTenKH,sSDTKH,sEmail,sDiaChi)
		VALUES (@tenkh,@sdtkh,@email,@diachi)
	END
	
EXEC prInsertKH N'long dragon','0987765548','longdragon@gmail.com',N'Hà Nội'

SELECT * FROM tblKhachHang
--5.Tạo thủ tục cho biết số khách hàng đã mua máy tính với hãng sản xuất do sv nhập 
CREATE PROC prKHMua (@dem int OUTPUT, @hangsx nvarchar(25))
AS
BEGIN 
	SELECT @dem = COUNT(dbo.tblHDXuat.sSDTKH)
	FROM tblHDXuat INNER join dbo.tblCTXuat ON tblHDXuat.sMaHDX = tblCTXuat.sMaHDX 
					 INNER JOIN dbo.tblSanPham ON tblSanPham.sMaSP = tblCTXuat.sMaSP
	WHERE sHangSX = @hangsx
	GROUP BY dbo.tblHDXuat.sSDTKH
	SELECT @dem AS [Số khách hàng đã mua], @hangsx AS [Hãng sản xuất]
END

DECLARE @tongkh int
EXEC prKHMua @dem=@tongkh OUTPUT, @hangsx = 'Dell'
--6.tạo thủ tục trả về lương nhân viên vs mã nv nhập
CREATE PROC prLuongNV_Ma(@manv nvarchar(10) , @luongnv float out)
AS 
BEGIN
	IF NOT EXISTS (SELECT*
		FROM dbo.tblNhanVien 
		WHERE sMaNV = @manv )
			BEGIN 
				PRINT N'Mã nhân viên nhập không hợp lệ' RETURN 
			END
	SELECT @luongnv = (fHSL * fLCB)  
	FROM tblNhanVien
	WHERE sMaNV = @manv
	SELECT @manv AS [Mã nhân viên] , @luongnv [Lương] 
END

DECLARE @a FLOAT
EXEC prLuongNV_Ma  '20a100' , @a OUT
--7.Tạo thủ tục trả về là sô hóa đơn nhân viên đã lập với mã nhân viên do sinh viên truyền vào 
CREATE proc prSHD_NV
@sohoadon int output, 
@maNV varchar(10)
as
begin
	select @sohoadon = count(tblCTXuat.sMaHDX)
	from tblnhanvien inner join tblHDXuat on tblnhanvien.sMaNV = tblHDXuat.sMaNV
	inner join tblCTXuat on tblCTXuat.sMaHDX = tblHDXuat.sMaHDX 
	where @maNV = tblnhanvien.smanv
END
go
declare @a int 
exec prSHD_NV @sohoadon = @a output, @maNV = '20a109'
select @a as [Số hoá đơn]

--8.tạo thủ tục tính tổng tiền hóa đơn đã nhập với năm nhập vào 
CREATE proc prTTHD_Nam(@tongtienHD float output, @nam int)
as
BEGIN
	IF(@nam - YEAR(GETDATE()) >0)
		BEGIN	
			 PRINT N'Chưa có hoá đơn nào được lập !' RETURN 
		END
	select @tongtienHD =sum (tblCTNhap.iSoLuong * tblsanpham.fdongianhap)
	from tblsanpham inner join tblCTNhap on tblsanpham.smasp= tblCTNhap.smasp
					INNER join tblHDNhap on tblCTnhap.sMaHDN =  tblHDNhap.sMaHDN
	where year (dngaynhap)=@nam
	select @tongtienHD as [Tổng tiền]
end
	declare @a float
	exec prTTHD_Nam @tongtienHD = @a output, @nam='2021'


--9.Tạo thủ tục lấy thông tin khách hàng đã thanh toán hoá đơn lớn hơn hoặc bằng số tiền truyền vào tương ứng trong năm tương ứng

ALTER  PROC  prKH_HD @tien int , @nam int
as 
begin
	if ( @nam - year(GETDATE()) > 0 ) 
		begin 
			print N'Năm nhập vào không thoả mãn ' return 
		end
	if ( @tien < 0 ) 
		begin 
			print N'Số tiền nhập vào phải lớn hơn 0 ' return  
		end
	IF exists (
			SELECT  *
			FROM  tblSanPham inner join tblCTXuat on tblSanPham.sMaSP =tblCTXuat.sMaSP
							inner join tblHDXuat on tblCTXuat.sMaHDX =tblHDXuat.sMaHDX 
			group BY  tblCTXuat.sMaHDX
			HAVING  sum(iSoLuong*tblSanPham.fDonGiaXuat)>= @tien )
		BEGIN
			SELECT  sTenKH AS [Tên KH], tblKhachHang.sSDTKH AS [SĐT]  , sum(iSoLuong*tblSanPham.fDonGiaXuat) as [ Giá trị hoá đơn ] , dNgayLap as [ Ngày lập ]
			FROM tblKhachHang inner join tblHDXuat on tblKhachHang.sSDTKH =tblHDXuat.sSDTKH
								inner join tblCTXuat on tblHDXuat.sMaHDX = tblCTXuat.sMaHDX
								inner join tblSanPham on tblCTXuat.sMaSP = tblSanPham.sMaSP
			WHERE  year(dNgayLap) - @nam = 0 and tblKhachHang.sSDTKH In (select tblHDXuat.sSDTKH
				from tblSanPham inner join tblCTXuat on tblSanPham.sMaSP =tblCTXuat.sMaSP
								inner join tblHDXuat on tblCTXuat.sMaHDX =tblHDXuat.sMaHDX 
				where year(dNgayLap) - @nam = 0
				group by tblCTXuat.sMaHDX , tblHDXuat.sSDTKH
				having sum(iSoLuong*tblSanPham.fDonGiaXuat)>= @tien )
			GROUP BY  tblKhachHang.sTenKH ,tblKhachHang.sSDTKH ,tblHDXuat.sSDTKH ,tblHDXuat.sMaHDX , tblCTXuat.sMaHDX , dNgayLap
			HAVING sum(iSoLuong*tblSanPham.fDonGiaXuat)>= @tien
			ORDER BY sum(iSoLuong*tblSanPham.fDonGiaXuat) desc
		END
	ELSE PRINT N'Không có hoá đơn nào có giá trị cao hơn số tiền vừa nhập'
END

exec prKH_HD 20000000 , 2019

--10. PROC HIEN NHAN VIEN THEO ID
CREATE PROC prMathang
@id int
AS
BEGIN
	SELECT * FROM tblMathang WHERE tblMathang.PK_iMathang = @id
END


------------------------------Trigger -----------------------------------
--1.Thêm cột tổng tiền vào bảng hoá đơn , kiểm tra CT xuất hoá đơn và tự động cập nhật tổng tiền hoá đơn
ALTER TABLE dbo.tblHDXuat
ADD fTongTien FLOAT 
UPDATE dbo.tblHDXuat
SET fTongTien =0


CREATE TRIGGER CTXuat
ON tblCTXuat 
for insert
AS
BEGIN 
	DECLARE @sln INT , @slx INT , @sldaxuat int ,@masp varchar(10) , @dongiaxuat FLOAT ,@maHD VARCHAR(10)
	SELECT @masp = sMaSP , @slx = isoluong , @dongiaxuat = fdongiaxuat , @maHD = smahdx FROM  inserted
	SELECT @sln = SUM(isoluong) FROM dbo.tblCTNhap WHERE sMaSP = @masp GROUP BY sMaSP
	SELECT @sldaxuat = SUM(isoluong) FROM dbo.tblCTXuat WHERE sMaSP = @masp GROUP BY sMaSP
	IF NOT EXISTS ( SELECT * FROM dbo.tblHDXuat WHERE sMaHDX = @maHD )
	BEGIN 
		PRINT N'Hoá đơn chưa tồn tại'
		ROLLBACK TRAN
		RETURN
	END
	
	IF NOT EXISTS ( SELECT * FROM dbo.tblSanPham WHERE sMaSP = @masp )
	BEGIN 
		PRINT N'Sản phẩm không tồn tại'
		ROLLBACK TRAN
		RETURN
	END
	ELSE 
		BEGIN
			IF ( @sln - @sldaxuat -@slx <0 ) 
				BEGIN
					PRINT N'Trong kho không đủ số lượng'
					ROLLBACK TRAN
					RETURN
				END
			IF(@dongiaxuat> (SELECT fDonGiaXuat FROM dbo.tblSanPham WHERE sMaSP = @masp ) OR @dongiaxuat < (SELECT fDonGiaNhap FROM dbo.tblSanPham WHERE smasp = @masp ))
			BEGIN	
				PRINT N'Giá sản phẩm phải nằm trong khoảng từ đơn giá nhập đến đơn giá xuất.'
				ROLLBACK TRAN 
				RETURN
			END
		END  
	UPDATE dbo.tblHDXuat
	SET fTongTien = ftongtien + iSoluong*fdongiaxuat 
	FROM inserted
	WHERE dbo.tblHDXuat.sMaHDX = @mahd	
END
INSERT INTO dbo.tblCTXuat
VALUES
(   'HD8', -- sMaHDX - varchar(10)
    'ss100', -- sMaSP - varchar(10)
    1,  -- iSoLuong - int
    21900000.0 -- fDonGiaXuat - float
    )
--2. Các thay đổi trên bảng chi tiết nhập
CREATE TRIGGER CTNhap
ON tblCTNhap 
FOR  insert
AS
BEGIN 
	DECLARE @ma varchar(10) , @dongianhap FLOAT
	SELECT @ma = sMaSP  , @dongianhap = fdongianhap FROM  inserted
	IF NOT EXISTS ( SELECT * FROM dbo.tblSanPham WHERE sMaSP = @ma )
	BEGIN 
		PRINT N'Không phải sản phẩm cửa hàng kinh doanh.'
		ROLLBACK TRAN
		RETURN
	END 
	IF ( @dongianhap > (SELECT fdongianhap FROM dbo.tblSanPham WHERE sMaSP = @ma)) 
		BEGIN
			PRINT N' Giá nhập không được vượt giá cho phép .'
			ROLLBACK TRAN
			RETURN
		END
END

INSERT INTO dbo.tblCTNhap
(
    sMaHDN,
    sMaSP,
    iSoLuong,
    fDonGiaNhap
)
VALUES
(   'a110', -- sMaHDN - varchar(10)
    'ss100', -- sMaSP - varchar(10)
    10,  -- iSoLuong - int
    3000000.0 -- fDonGiaNhap - float
    )
	select * from tblctnhap
	DELETE dbo.tblCTNhap
	WHERE sMaHDN = 'a105' AND sMaSP='ss100'

--3.Không cho thay đổi ngày sinh , giới tính , ngày vào làm của nhân viên
CREATE TRIGGER Ko_doi_NV
ON tblNhanVien
FOR UPDATE
AS
BEGIN
	
	IF UPDATE (sGioiTinh)
		BEGIN
			PRINT N'Không được thay đổi giới tính của nhân viên'
			ROLLBACK TRAN
		END
	
	IF UPDATE (dNgaysinh)
		BEGIN
			PRINT N'Không được thay đổi ngày sinh của nhân viên'
			ROLLBACK TRAN
		END

	IF UPDATE (dNgayVaoLam)
		BEGIN
			PRINT N'Không được thay đổi ngày vào làm của nhân viên'
			ROLLBACK TRAN
		END
END

update tblNhanVien
set dngayvaolam = '01/01/2021'
where smanv = '20a100'


--4.Kiểm tra số điện thoại khách hàng--
CREATE  TRIGGER  SDTKH
ON  tblKhachHang
FOR  INSERT  , UPDATE  
AS 
BEGIN 
	 DECLARE @sdt VARCHAR(10) 
	 SELECT @sdt = sSDTKH FROM inserted 
	 
	 
	 IF(LEN(@sdt)!=10 ) 
		BEGIN  
			PRINT  N'Số điện thoại phải đủ 10 số !'
			ROLLBACK  TRAN  
			RETURN 
		END 
	IF (SUBSTRING(@sdt ,1,1)!='0') 
		BEGIN 
			PRINT  N'Số điện thoại phải bắt đầu =0 !'
			ROLLBACK  TRAN 
			RETURN
		END 
	DECLARE  @i INT  =2
	WHILE(@i<=LEN(@sdt))
		BEGIN
			IF(SUBSTRING(@sdt,@i,1)<'0' OR SUBSTRING(@sdt,@i,1)>'9' )
			BEGIN
				print N'Số điện thoại không đúng định dạng !'
				ROLLBACK TRAN
                RETURN
			END 
        SET @i = @i +1
		END	 
END

INSERT INTO dbo.tblKhachHang
(
    sTenKH,
    sSDTKH,
    sEmail,
    sDiaChi
)
VALUES
(   N'A', -- sTenKH - nvarchar(25)
    '012345678a',  -- sSDTKH - varchar(10)
    'abc',  -- sEmail - varchar(50)
    N'Thai Binh'  -- sDiaChi - nvarchar(50)
    )
	UPDATE dbo.tblKhachHang
	SET sSDTKH = '02345678aa'
	WHERE sSDTKH ='0867966612'
SELECT*FROM dbo.tblKhachHang

SELECT * FROM dbo.tblHDNhap
------------------------ CẤP QUYỀN VÀ PHÂN QUYỀN -----------------------
--Tạo tài khoản người dùng cho mỗi thành viên trong nhóm

CREATE LOGIN QuanPham WITH PASSWORD = '15122002',
 DEFAULT_DATABASE = KinhDoanhMayTinh;
go
CREATE USER Quan FOR LOGIN QuanPham

GO

CREATE LOGIN ThanhVien1 WITH PASSWORD = '123456',
DEFAULT_DATABASE = KinhDoanhMayTinh;
CREATE LOGIN ThanhVien2 WITH PASSWORD = '123456',
DEFAULT_DATABASE = KinhDoanhMayTinh;
CREATE LOGIN ThanhVien3 WITH PASSWORD = '123456',
DEFAULT_DATABASE = KinhDoanhMayTinh;
go
CREATE USER Khai FOR LOGIN ThanhVien1
CREATE USER Manh FOR LOGIN ThanhVien2
CREATE USER Thao FOR LOGIN ThanhVien3

GO


------------------------ PHÂN QUYỀN CƠ SỞ DỮ LIỆU -----------------------
/* Cấp phát cho người dùng có tên Quan quyền select, update, delete, insert, create table ,
alter, execute, create view, create proc trên DATABASES KinhDoanhMayTinh
và có thể trao lại quyền cho người khác
*/
GRANT select, update, delete, insert, create table ,
alter, execute, create view, create proc
TO Quan
WITH GRANT OPTION
GO

-- Cấp phát cho người dùng có tên Khai , Manh , Thao select, insert trên DATABASES

GRANT select, insert 
TO  Khai , Manh , Thao
-- Cấp phát cho người dùng có tên Thao delete , alter trên DATABASES
GRANT delete , alter 
TO   Thao

-- Cấm INSERT trên bảng NhanVien của người dùng Khai , Manh

DENY INSERT 
ON dbo.tblNhanVien
TO Manh , Khai

-- Cấm người dùng Thao không được CREATE TABLE, CREATE VIEW trên DATABASES

DENY create table, create view
TO Thao

-- Cấm người dùng Thao không được ALTER , delete trên bảng tblHDXuat

DENY Alter , delete
ON tblHDXuat
TO Thao

------------------------Phân tán CSDL---------------------------------
-- Tạo login HTKN với pass = '123456' ở cả 2 trạm.
--Tạo Linked server LINKBTL ở cả 2 trạm  .
--------------------Trạm 1------------------------
--Tạo database 
create database KinhDoanhMayTinh_1
go
-- Tạo bảng Nhân viên--
CREATE TABLE tblNhanVien (
	sMaNV VARCHAR(10) PRIMARY KEY ,
	sTenNV NVARCHAR(25) NOT NULL ,
	);
-- Tạo bảng Sản phẩm
CREATE TABLE tblSanPham(
	sMaSP VARCHAR(10) PRIMARY KEY ,
	sTenSP NVARCHAR(25) NOT NULL,
	sHangSX NVARCHAR(25) NOT NULL,
	iNamSX INT NOT NULL,
	fDonGiaNhap FLOAT CHECK(fDonGiaNhap>0) NOT NULL,
	fDonGiaXuat FLOAT NOT NULL check (fdongiaxuat>10000000) ,
	CONSTRAINT dongia CHECK(fDonGiaXuat>1.1*fDonGiaNhap)
	);
-- Nhập bản ghi cho nhân viên
insert into tblNhanVien
	values 
	('20a100',N'Phạm Hồng Quân'),
	('20a101',N'Trần Văn Cương'),
	('20a102',N'Nguyễn Thị Hòa'),
	('20a103',N'Võ Thị Hải'),
	('20a104',N'Đào Văn Tư'),
	('20a105',N'Vui Như Tết'),
	('20a106',N'Mãi Phấn Khởi'),
	('20a107',N'Trương Vĩnh Phúc'),
	('20a108',N'Hoàng Vĩnh Lộc'),
	('20a109',N'Thượng Văn Thọ')
--Nhập bản ghi cho sản phẩm
INSERT  INTO  tblSanPham
	VALUES 
	('ap300',N'Macbook air M1','Apple',2020,23000000,27000000),
	('ac600',N'Laptop Acer Nitro 5','Acer',2021,18000000,21000000),
	('lg000',N'Laptop LG Gram 14 inch','LG',2021,30000000,35100000),
	('hw400',N'Laptop Huawei D14','Huawei',2020,15000000,18000000)

create synonym HSNhanVien 
for LINKBTL.KinhDoanhMayTinh_2.dbo.tblNhanVien 
create synonym HSSanPham 
for LINKBTL.KinhDoanhMayTinh_2.dbo.tblSanPham 

-- Tạo view lấy dữ liệu của Sản phẩm
create view vvNhanVien
as
	select HSNhanVien.* ,sTenNV 
	from tblNhanVien inner join HSNhanVien on tblNhanVien.sMaNV = HSNhanVien.smaNV

select * from vvNhanVien
--Tạo thủ tục cho phép thêm bản ghi sản phẩm -- 
CREATE Proc prInsertSP(
	@masp VARCHAR(10),
	@tensp NVARCHAR(25),
	@hangsx NVARCHAR(25),
	@namsx INT,
	@dongianhapSP FLOAT,
	@dongiaxuatSP FLOAT
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblSanPham WHERE sMaSP = @masp)
		BEGIN
			PRINT N'Mã sản phẩm ' + @masp+ N' đã tồn tại'  RETURN
		END 
	IF(@dongiaxuatSP < 1.1 *@dongianhapSP OR @dongiaxuatSP<0 OR @dongianhapSP<0 )
		BEGIN
			PRINT N'Đơn giá không đúng ràng buộc' RETURN
		END
	IF (@namsx - YEAR(GETDATE())>0) 
		BEGIN
			PRINT N'Năm sản xuất nhập sai!' RETURN
		END
	if ( @dongiaxuatSP>10000000)
	begin
		INSERT INTO [dbo].[tblSanPham] 
		VALUES(@masp,@tensp,@hangsx,@namsx,@dongianhapSP,@dongiaxuatSP)
	end
	else 
	begin
		INSERT INTO HSSanPham 
		VALUES(@masp,@tensp,@hangsx,@namsx,@dongianhapSP,@dongiaxuatSP)
	end
END 

EXEC prInsertSP 'ac800',N'tai nghe acer','Acer',2021,1000000,3000000


------------------------Trạm 2------------------------------
-- Tạo database
create database KinhDoanhMayTinh_2
go 

--Tạo bảng Nhân Viên
CREATE TABLE tblNhanVien (
	sMaNV VARCHAR(10) PRIMARY KEY ,
	dNgaySinh DATE NOT NULL,
	sGioiTinh NVARCHAR(5) CHECK ( sGioiTinh IN ('Nam',N'Nữ')) ,
	sDiaChi NVARCHAR(50) NOT NULL ,
	sSDT VARCHAR(10) NOT NULL ,
	fHSL FLOAT CHECK(fHSL>=2 AND fHSL<=10) NOT NULL,
	fLCB FLOAT NOT NULL CHECK(fLCB>0),
	dNgayVaoLam DATE NOT NULL ,
	CONSTRAINT [Ngày vào làm đủ 18 tuổi] CHECK(DATEDIFF(DAY,dNgaySinh,dNgayVaoLam)/365>=18)
	);

--Tạo bảng Sản phẩm
CREATE TABLE tblSanPham(
	sMaSP VARCHAR(10) PRIMARY KEY ,
	sTenSP NVARCHAR(25) NOT NULL,
	sHangSX NVARCHAR(25) NOT NULL,
	iNamSX INT NOT NULL,
	fDonGiaNhap FLOAT CHECK(fDonGiaNhap>0) NOT NULL,
	fDonGiaXuat FLOAT check(fdongiaxuat<10000000) NOT NULL,
	CONSTRAINT dongia CHECK(fDonGiaXuat>1.1*fDonGiaNhap)
	);

--Thêm dữ liệu
insert into tblNhanVien
	values 
	('20a100','1/1/2002',N'Nam',N'Thái Bình','0984524831',9,6000000,'5/20/2021'),
	('20a101','8/1/2000',N'Nam',N'Lai Châu','0968597131',8,5000000,'12/1/2020'),
	('20a102','4/11/1998',N'Nữ',N'Quảng Ninh','0305986843',7,4000000,'3/18/2020'),
	('20a103','3/22/1996',N'Nữ',N'Phú Thọ','0983475013',6,3000000,'1/1/2021'),
	('20a104','8/21/2000',N'Nam',N'Tuyên Quang','0982762300',7.5,5500000,'11/21/2020'),
	('20a105','2/18/1999',N'Nữ',N'Hà Nội','0987654321',6,4000000,'2/3/2020'),
	('20a106','8/12/1995',N'Nam',N'Hà Nội','037628401',7,4000000,'6/21/2019'),
	('20a107','9/13/1999',N'Nam',N'Bắc Ninh','0986275337',6,6100000,'1/23/2020'),
	('20a108','2/13/1998',N'Nam',N'Hòa Bình','0314567899',8,4000000,'5/27/2019'),
	('20a109','4/22/1997',N'Nam',N'Hà Nội','0985123123',7,4800000,'9/15/2019')

insert into tblSanPham
values 
('xm200',N'Webcam máy tính Xiaomi','Xiaomi',2020,300000,600000),
('ss100',N'Màn hình Samsung 24 inch','Samsung',2019,2000000,3000000),	
('d500',N'Bàn Phím Dell KB216','Dell',2018,100000,319000),
('ra700',N'Chuột Razer V2 Pro','Razer',2019,2500000,3500000),
('as800',N'Main PC Asus ROG','Asus',2020,2800000,3200000),
('ms900',N'Ram PC G.SKILL 16GB','MSI',2021,2500000,3000000)

-- Tạo nhãn
create synonym HSNhanVien 
for LINKBTL.KinhDoanhMayTinh_1.dbo.tblNhanVien 
create synonym HSSanPham 
for LINKBTL.KinhDoanhMayTinh_1.dbo.tblSanPham 

-- Tạo view lấy dữ liệu của Sản phẩm
create view vvSanPham
as
	select * from tblSanPham
	union 
	select * from HSSanPham
select * from vvSanPham

--Tạo thủ tục cho phép thêm bản ghi sản phẩm -- 
CREATE Proc prInsertSP(
	@masp VARCHAR(10),
	@tensp NVARCHAR(25),
	@hangsx NVARCHAR(25),
	@namsx INT,
	@dongianhapSP FLOAT,
	@dongiaxuatSP FLOAT
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblSanPham WHERE sMaSP = @masp)
		BEGIN
			PRINT N'Mã sản phẩm ' + @masp+ N' đã tồn tại'  RETURN
		END 
	IF(@dongiaxuatSP < 1.1 *@dongianhapSP OR @dongiaxuatSP<0 OR @dongianhapSP<0 )
		BEGIN
			PRINT N'Đơn giá không đúng ràng buộc' RETURN
		END
	IF (@namsx - YEAR(GETDATE())>0) 
		BEGIN
			PRINT N'Năm sản xuất nhập sai!' RETURN
		END
	if ( @dongiaxuatSP<10000000)
	begin
		INSERT INTO [dbo].[tblSanPham] 
		VALUES(@masp,@tensp,@hangsx,@namsx,@dongianhapSP,@dongiaxuatSP)
	end
	else 
	begin
		INSERT INTO HSSanPham 
		VALUES(@masp,@tensp,@hangsx,@namsx,@dongianhapSP,@dongiaxuatSP)
	end
END 

EXEC prInsertSP 'ac800',N'tai nghe acer','Acer',2021,1000000,3000000
SELECT * FROM HSSanPham	


EXEC  prNV_Luong
SELECT  * FROM  tblNhanVien

--Tạo thủ tục tăng 1.5 lương cho nhân viên làm việc trên 1 năm
CREATE  PROC  prNV_Luong
AS 
BEGIN 
	update tblNhanVien
	set fLCB =1.5* fLCB
	where  datediff(day, dNgayVaoLam, getdate())/365 >= 1
  
END  

EXEC  prNV_Luong
SELECT  * FROM  tblNhanVien
