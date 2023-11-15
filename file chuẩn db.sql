
create database KinhDoanhTBMayTinh
USE KinhDoanhTBMayTinh
GO

--Tạo bảng Phòng ban
	CREATE TABLE tblPhongBan (
		sMaPB VARCHAR(10) PRIMARY KEY ,
		sTenPB NVARCHAR(25) NOT NULL ,
	)
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
		CONSTRAINT [Ngày vào làm đủ 18 tuổi] CHECK(DATEDIFF(DAY,dNgaySinh,dNgayVaoLam)/365>=18),
		sMaPB VARCHAR(10) CONSTRAINT FK_tblPhongBan FOREIGN KEY (sMaPB) REFERENCES tblPhongBan
		)

	-- Tạo bảng khách hàng--
	CREATE TABLE tblKhachHang(
		sMaKH VARCHAR(10) PRIMARY KEY NOT NULL,
		sTenKH NVARCHAR(25)  NOT NULL,
		sSDTKH VARCHAR(10),
		sEmail VARCHAR(50) ,
		sDiaChi NVARCHAR(50)
		)
		
	-- Tạo bảng nhà cung cấp--
	CREATE TABLE tblNhaCC(
		sMaNCC VARCHAR(10) PRIMARY KEY,
		sTenNCC VARCHAR(MAX),
		sDiaChiNCC NVARCHAR(4000),
	)


	--Tạo bảng loại sản phẩm
	CREATE TABLE tblLoaiSP(
		sMaLoai VARCHAR(10) PRIMARY KEY NOT NULL,
		sTenLoai NVARCHAR(50) NOT NULL
	)

	-- Tạo bảng sản phẩm--
	CREATE TABLE tblSanPham(
		sMaSP VARCHAR(10) PRIMARY KEY NOT NULL,
		sMaLoai VARCHAR(10) CONSTRAINT FK_tblLoaiSP FOREIGN KEY (sMaLoai) REFERENCES tblLoaiSP,
		sTenSP NVARCHAR(4000) NOT NULL,
		sHangSX NVARCHAR(25) NOT NULL,
		iNamSX INT NOT NULL,
		fDonGiaNhap FLOAT CHECK(fDonGiaNhap>0) NOT NULL,
		fDonGiaXuat FLOAT NOT NULL,
		CONSTRAINT dongia CHECK(fDonGiaXuat>fDonGiaNhap),
		iSoLuong INT NOT NULL DEFAULT 0,
		iHanBH INT CHECK (iHanBH >0)
		);

	-- Tạo bảng Kho 
	CREATE TABLE tblKho
	(
		sSeri VARCHAR(10) PRIMARY KEY NOT NULL,
		sMaSP VARCHAR(10) REFERENCES tblSanPham (sMaSP) ON UPDATE CASCADE ON DELETE CASCADE
	)


	-- Tạo bảng hoá đơn nhập --
	CREATE TABLE tblHDNhap(
	sMaHDN VARCHAR(10) PRIMARY KEY,
	sMaNV VARCHAR(10) REFERENCES dbo.tblNhanVien(sMaNV) ON UPDATE CASCADE ON DELETE CASCADE ,
	dNgayNhap DATE CHECK(dNgayNhap<=GETDATE()) NOT NULL,
	sMaNCC VARCHAR(10) CONSTRAINT FK_tblNhaCC FOREIGN KEY (sMaNCC) REFERENCES tblNhaCC ON UPDATE CASCADE ON DELETE CASCADE,
	iSoLuong INT NOT NULL DEFAULT 0
	)


	-- Tạo bảng chi tiết hoá đơn nhập--
	CREATE TABLE tblCTNhap(
	sMaCTN VARCHAR(10) PRIMARY KEY NOT NULL,
	sMaHDN VARCHAR(10) REFERENCES tblHDNhap(sMaHDN) ON UPDATE CASCADE ON DELETE CASCADE  ,
	sMaSP VARCHAR(10)  REFERENCES tblSanPham(sMaSP) ON UPDATE CASCADE ON DELETE CASCADE,
	sSeri VARCHAR(10) REFERENCES tblKho(sSeri) 
	)

	-- Tạo bảng Hoá đơn xuất--
	CREATE TABLE tblHDXuat(
	sMaHDX VARCHAR(10) PRIMARY KEY,
	sMaNV VARCHAR(10) REFERENCES tblNhanVien(sMaNV) ON UPDATE CASCADE ON DELETE CASCADE,
	dNgayLap DATE CHECK(dNgayLap<=GETDATE()) NOT NULL ,
	sMaKH VARCHAR(10) REFERENCES tblKhachHang(sMaKH) ON UPDATE CASCADE ON DELETE CASCADE ,
	sHinhThucTT NVARCHAR(20) NOT NULL CHECK(sHinhThucTT IN(N'Tiền mặt',N'Thẻ ngân hàng')),
	fTongtien FLOAT CHECK (fTongtien>0),
	iSoLuong INT NOT NULL DEFAULT 0
	)



	--DELETE FROM tblHDXuat;
	--DBCC CHECKIDENT ('[tblHDXuat]', RESEED, 0);

	--Tạo bảng Bảo hành
	CREATE TABLE tblBaoHanh(
		sMaBH VARCHAR(10) PRIMARY KEY NOT NULL,
		sMaSP VARCHAR(10) REFERENCES tblSanPham(sMaSP) ON UPDATE CASCADE ON DELETE CASCADE,
		sMaHDX VARCHAR(10) REFERENCES tblHDXuat(sMaHDX) ON UPDATE CASCADE ON DELETE CASCADE,
		sMaNV VARCHAR(10) REFERENCES tblNhanVien(sMaNV),
		sGhichu NVARCHAR(2000)
	)

-- Tạo bảng Chi tiết xuất--
CREATE TABLE tblCTXuat(
	sMaCTX VARCHAR(10) PRIMARY KEY NOT NULL,
	sMaHDX VARCHAR(10) REFERENCES tblHDXuat(sMaHDX) ON UPDATE CASCADE ON DELETE CASCADE ,
	sSeri VARCHAR(10) REFERENCES tblKho(sSeri) ON UPDATE CASCADE ON DELETE CASCADE ,
	)





--Thêm dữ liệu bảng phòng ban 
INSERT INTO tblPhongBan (sMaPB, sTenPB) VALUES ('PB01', N'Phòng ban IT');
INSERT INTO tblPhongBan (sMaPB, sTenPB) VALUES ('PB02', N'Phòng ban Marketing');
INSERT INTO tblPhongBan (sMaPB, sTenPB) VALUES ('PB03', N'Phòng ban Kế toán');
--Thêm dữ liệu bảng nhân viên
INSERT INTO tblNhanVien (sMaNV, sTenNV, dNgaySinh, sGioiTinh, sDiaChi, sSDT, fHSL, fLCB, dNgayVaoLam, sMaPB)
VALUES ('NV01', N'Lê Mạnh Cường', '2002-01-01', N'Nam', N'Hà Nội', '0123456789', 5, 10000000, '2023-11-11', 'PB01');
INSERT INTO tblNhanVien (sMaNV, sTenNV, dNgaySinh, sGioiTinh, sDiaChi, sSDT, fHSL, fLCB, dNgayVaoLam, sMaPB)
VALUES ('NV02', N'Đinh Văn Hảo', '2002-02-02', N'Nữ', N'Ninh Bình', '0987654321', 6, 11000000, '2023-11-11', 'PB02');
INSERT INTO tblNhanVien (sMaNV, sTenNV, dNgaySinh, sGioiTinh, sDiaChi, sSDT, fHSL, fLCB, dNgayVaoLam, sMaPB)
VALUES ('NV03', N'Đinh Quang Khải', '2001-03-03', N'Nam', N'Hà Nội', '0123456789', 7, 12000000, '2023-11-11', 'PB03');
--Thêm dữ liệu bảng khách hàng
INSERT INTO tblKhachHang (sMaKH, sTenKH, sSDTKH, sEmail, sDiaChi)
VALUES ('KH01', N'Nguyễn Văn A', '0123456789', 'abc@gmail.com', N'Hà Nội');
INSERT INTO tblKhachHang (sMaKH, sTenKH, sSDTKH, sEmail, sDiaChi)
VALUES ('KH02', N'Nguyễn Văn B', '0987654321', 'xyz@gmail.com', N'Đà Nẵng');
INSERT INTO tblKhachHang (sMaKH, sTenKH, sSDTKH, sEmail, sDiaChi)
VALUES ('KH03', N'Nguyễn Văn C', '0123456789', 'def@gmail.com', N'Hồ Chí Minh');
--Thêm dữ liệu bảng Nhà cung cấp 
INSERT INTO tblNhaCC (sMaNCC, sTenNCC, sDiaChiNCC)
VALUES ('NCC01', N'Công Ty TNHH Thương Mại Trần Đức', N'Hà Nội');
INSERT INTO tblNhaCC (sMaNCC, sTenNCC, sDiaChiNCC)
VALUES ('NCC02', N'Công Ty Cổ Phần Nguyễn Quân', N'Đà Nẵng');
INSERT INTO tblNhaCC (sMaNCC, sTenNCC, sDiaChiNCC)
VALUES ('NCC03', N'Công Ty Cổ Phần Thương Mại & Tin Học Việt Cường', N'Hồ Chí Minh');
--Thêm dữ liệu bảng loại sản phẩm 
INSERT INTO tblLoaiSP (sMaLoai, sTenLoai)
VALUES ('LSP01', N'Máy tính');
INSERT INTO tblLoaiSP (sMaLoai, sTenLoai)
VALUES ('LSP02', N'Sạc máy tính');
INSERT INTO tblLoaiSP (sMaLoai, sTenLoai)
VALUES ('LSP03', N'Tai nghe');
--Thêm dữ liệu bảng sản phẩm
INSERT INTO tblSanPham VALUES ('SP01', 'LSP01', N'Laptop Dell Precision 9750', N'Dell', 2023, 10000000, 11000000,2, 6);
INSERT INTO tblSanPham VALUES ('SP02', 'LSP02', N'Sạc Asus 165W', N'Asus', 2023, 12000000, 13000000,1, 12);
INSERT INTO tblSanPham VALUES ('SP03', 'LSP03', N'Tai nghe Bluetooth Airpod Gen 3', N'Apple', 2023, 15000000, 16000000,2, 12);
INSERT INTO tblSanPham VALUES ('SP04', 'LSP01', N'Laptop Dell Vostro 3510', N'Dell', 2023, 10000000, 11000000,3,12);

--Thêm dữ liệu bảng kho
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR01','SP01');
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR02','SP01');
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR03','SP02');
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR04','SP03');
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR05','SP03');
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR06','SP04');
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR07','SP04');
INSERT INTO tblKho(sSeri, sMaSP) VALUES ('SR08','SP04');

--Thêm dữ liệu bảng hóa đơn nhập
INSERT INTO tblHDNhap (sMaHDN, sMaNV, dNgayNhap, sMaNCC)  VALUES   ('HDN01', 'NV01', '2023-11-9', 'NCC03');
INSERT INTO tblHDNhap (sMaHDN, sMaNV, dNgayNhap, sMaNCC)	VALUES   ('HDN02', 'NV02', '2023-11-8', 'NCC02');
INSERT INTO tblHDNhap (sMaHDN, sMaNV, dNgayNhap, sMaNCC)	VALUES   ('HDN03', 'NV03', '2023-11-7', 'NCC01');

--Thêm dữ liệu bảng chi tiết hóa đơn nhập
INSERT INTO tblCTNhap (sMaCTN, sMaHDN, sMaSP,sSeri) VALUES ('CTN01', 'HDN01', 'SP01','SR01');
INSERT INTO tblCTNhap (sMaCTN, sMaHDN, sMaSP,sSeri) VALUES ('CTN02', 'HDN01', 'SP02','SR02');
INSERT INTO tblCTNhap (sMaCTN, sMaHDN, sMaSP,sSeri) VALUES ('CTN03', 'HDN02', 'SP01','SR03');
INSERT INTO tblCTNhap (sMaCTN, sMaHDN, sMaSP,sSeri) VALUES ('CTN04', 'HDN02', 'SP03','SR04');
INSERT INTO tblCTNhap (sMaCTN, sMaHDN, sMaSP,sSeri) VALUES ('CTN05', 'HDN03', 'SP02','SR05');
	

--Thêm dữ liệu bảng hóa đơn xuất 
INSERT INTO tblHDXuat (sMaHDX, sMaNV, dNgayLap, sMaKH, sHinhThucTT, fTongtien) VALUES ('HDX01', 'NV01', '2023-11-10', 'KH01', N'Tiền mặt', 100000000);
INSERT INTO tblHDXuat (sMaHDX, sMaNV, dNgayLap, sMaKH, sHinhThucTT, fTongtien) VALUES ('HDX02', 'NV02', '2023-11-9', 'KH02', N'Thẻ ngân hàng', 120000000);
INSERT INTO tblHDXuat (sMaHDX, sMaNV, dNgayLap, sMaKH, sHinhThucTT, fTongtien) VALUES ('HDX03', 'NV03', '2023-11-9', 'KH03', N'Tiền mặt', 150000000);



--Thêm dữ liệu bảng bảo hành
INSERT INTO tblBaoHanh (sMaBH, sMaSP, sMaHDX, sMaNV, sGhichu) VALUES ('BH01', 'SP01', 'HDX01', 'NV01', 'Lỗi hở sáng màn');
INSERT INTO tblBaoHanh (sMaBH, sMaSP, sMaHDX, sMaNV, sGhichu) VALUES ('BH03', 'SP03', 'HDX03', 'NV03', 'Lỗi không sạc được');
INSERT INTO tblBaoHanh (sMaBH, sMaSP, sMaHDX, sMaNV, sGhichu) VALUES ('BH02', 'SP02', 'HDX02', 'NV02', 'Lỗi không mở nguồn được')

--Thêm dữ liệu bảng chi tiết hóa đơn xuất 
INSERT INTO tblCTXuat (sMaCTX, sMaHDX, sSeri ) VALUES ('CTX01', 'HDX01', 'SR01');
INSERT INTO tblCTXuat (sMaCTX, sMaHDX, sSeri ) VALUES ('CTX02', 'HDX01', 'SR02');
INSERT INTO tblCTXuat (sMaCTX, sMaHDX, sSeri ) VALUES ('CTX03', 'HDX02', 'SR03');
INSERT INTO tblCTXuat (sMaCTX, sMaHDX, sSeri ) VALUES ('CTX04', 'HDX02', 'SR04');
INSERT INTO tblCTXuat (sMaCTX, sMaHDX, sSeri ) VALUES ('CTX05', 'HDX03', 'SR05');
	

	
	

	
