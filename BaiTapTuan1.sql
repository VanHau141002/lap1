CREATE DATABASE BAITAPTUAN1
GO
USE BAITAPTUAN1
Exec sp_addtype 'Mota', 'nvarchar(40)','not null';
Exec sp_addtype 'IDKH', 'char(10)','not null';
Exec sp_addtype 'DT', 'char(12)','not null';

-- 2. Tạo table
CREATE TABLE SanPham (
	MaSP CHAR(6) NOT NULL,
	TenSP VARCHAR(20),
	NgayNhap Date,
	DVT CHAR(10),
	SoLuongTon INT,
	DonGiaNhap money,
)
CREATE TABLE HoaDon (
	MaHD CHAR(10) NOT NULL,
	NgayLap Date,
	NgayGiao Date,
	MaKH IDKH,
	DienGiai Mota,
)
CREATE TABLE KhachHang (
	MaKH IDKH,
	TenKH NVARCHAR(30),
	DiaCHi NVARCHAR(40),
	DienThoai DT,
)
CREATE TABLE ChiTietHD (
	MaHD CHAR(10) NOT NULL,
	MaSP CHAR(6) NOT NULL,
	SoLuong INT
)

-- 3. Trong Table HoaDon, sửa cột DienGiai thành nvarchar(100).
ALTER TABLE HoaDon
	ALTER COLUMN DienGiai NVARCHAR(100)

-- 4. Thêm vào bảng SanPham cột TyLeHoaHong float
ALTER TABLE SanPham
	ADD TyLeHoaHong float

-- 5. Xóa cột NgayNhap trong bảng SanPham
ALTER TABLE SanPham
	DROP COLUMN NgayNhap

-- 6. Tạo các ràng buộc khóa chính và khóa ngoại cho các bảng trên
ALTER TABLE SanPham
ADD
CONSTRAINT pk_sp primary key(MASP)

ALTER TABLE HoaDon
ADD
CONSTRAINT pk_hd primary key(MaHD)

ALTER TABLE KhachHang
ADD
CONSTRAINT pk_khanghang primary key(MaKH)

ALTER TABLE HoaDon
ADD
CONSTRAINT fk_khachhang_hoadon FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_hoadon_chitiethd FOREIGN KEY(MaHD) REFERENCES HoaDon(MaHD)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_sanpham_chitiethd FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP)

-- 7.Thêm vào bảng HoaDon các ràng buộc
ALTER TABLE HoaDon
ADD CHECK (NgayGiao > NgayLap)

ALTER TABLE HoaDon
ADD CHECK (MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]')

ALTER TABLE HoaDon
ADD CONSTRAINT df_ngaylap DEFAULT GETDATE() FOR NgayLap

-- 8.Thêm vào bảng Sản phẩm các ràng buộc
ALTER TABLE SanPham
ADD CHECK (SoLuongTon > 0 and SoLuongTon < 50)

ALTER TABLE SanPham
ADD CHECK (DonGiaNhap > 0)

ALTER TABLE SanPham
ADD CONSTRAINT df_ngaynhap DEFAULT GETDATE() FOR NgayNhap

ALTER TABLE SanPham
ADD CHECK (DVT like 'KG''Thùng''Hộp''Cái')

-- 9.Dùng lệnh T-SQL nhập dữ liệu vào 4 table trên, dữ liệu tùy ý, chú ý các ràng buộc của mỗi Table
INSERT INTO SanPham (MaSP, TenSp, NgayNhap, DVT, SoLuongTon, DonGiaNhap) values ('001', 'maý tính', '2022-01-20', 'Thùng', '23', '2000000')
INSERT INTO SanPham values ('002', 'lap', '2022-01-20', 'Thùng', '23', '2000000')
INSERT INTO SanPham values ('003', 'chuột', '2022-01-20', 'Thùng', '23', '2000000')
INSERT INTO SanPham values ('004', 'phím', '2022-01-20', 'Thùng', '23', '2000000')

INSERT INTO HoaDon (MaHD, NgayLap, NgayGiao, MaKH, DienGiai) values ('H01','2022-02-02','2022-02-02','000004','kk')
INSERT INTO HoaDon values ('H02 ','2022-02-02','2022-02-02','000001','kk')
INSERT INTO HoaDon values ('H03','2022-02-02','2022-02-02','000002','kk')
INSERT INTO HoaDon values ('H04','2022-02-02','2022-02-02','000003','kk')

INSERT INTO KhachHang (MaKH, TenKH, DiaCHi, DienThoai) values ('000001','NVH','236 LVS','0987654321')
INSERT INTO KhachHang values ('000002','NVH','236 LVS','0987654321')
INSERT INTO KhachHang values ('000003','NVH','236 LVS','0987654321')
INSERT INTO KhachHang values ('000004','NVH','236 LVS','0987654321')

INSERT INTO ChiTietHD (MaHD, MaSP, SoLuong) values ('100','001',1)
INSERT INTO ChiTietHD values ('200','002',1)
INSERT INTO ChiTietHD values ('300','003',1)
INSERT INTO ChiTietHD values ('400','004',1)

--12.Đổi tên CSDL Sales thành BanHang
ALTER DATABASE BanHang MODIFY NAME = BAITAPTUAN1;
--14.Tạo bản BackUp cho CSDL BanHang
Backup database BanHang to disk = 'C:\backup'