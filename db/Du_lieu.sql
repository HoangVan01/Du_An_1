﻿
DELETE ChiTietSanPham
DELETE ChiTietHoaDon
DELETE HoaDon
DELETE SanPham
DELETE LoaiHang
DELETE NhomHang
DELETE DongSP
DELETE ThuongHieu
DELETE AnhSP
DELETE DonViTinh
DELETE HinhThucThanhToan
DELETE NhanVien
DELETE TheThanhVien
DELETE KhoiLuong
DELETE XuatXu

INSERT INTO AnhSP(MaAnhSP,TenAnhSP) VALUES('ASP00001','meiji0800g.jpg'),
                                          ('ASP00002','similac5g4900.jpg'),
										  ('ASP00003','vinamilk_organic_khongduong_hopgiay_1L.jpg'),
										  ('ASP00004','sua1.jpg'),
										  ('ASP00005','ongthodo380g.jpg'),
										  ('ASP00006','sua2.jpg')
INSERT INTO ThuongHieu(MaTH,TenTH,GhiChu,TrangThai)VALUES('TH10000',N'Vinamilk',N'KHÔNG',0),
                                                         ('TH10001',N'TH true milk',N'KHÔNG',0),
														 ('TH10002',N'Dutch Lady',N'KHÔNG',0),
														 ('TH10003',N'Nestle',N'KHÔNG',0),
														 ('TH10004',N'Nutifood',N'KHÔNG',0)
INSERT INTO DonViTinh(MaDVT,TenDVT) VALUES('DVT0001',N'HỘP'),
                                          ('DVT0002',N'LỐC'),
										  ('DVT0003',N'THÙNG'),
										  ('DVT0004',N'DÂY'),
										  ('DVT0005',N'COMBO')
INSERT INTO HinhThucThanhToan(MaHinhThucThanhToan,TenHinhThucThanhToan,GhiChu) VALUES('HT0001',N'TIỀN MẶT',N'KHÔNG'),
                                                                                     ('HT0002',N'QUA THẺ TÍN DỤNG',N'KHÔNG')

exec SP_ThemNhanVien 'NV0001','dainnph13993','123',N'Nguyễn Ngọc Đại',1,'2002-06-11','0986280623','125932074','dainnph13993@fpt.edu.vn','default.jpg',1,'Founder'
exec SP_ThemNhanVien 'NV0002','thongvhph13968','123',N'Võ Hữu Thông',1,'1999-10-12','0368443774','125932074','thongvhph13968@fpt.edu.vn','default.jpg',1,'Founder'
exec SP_ThemNhanVien 'NV0003','quochung13972','123',N'Nguyễn Quốc Hùng',1,'2002-07-10','0328452319','125932074','hungnqph13922@fpt.edu.vn','default.jpg',0,'Founder'
exec SP_ThemNhanVien 'NV0004','thuthaott13942','123',N'Trần Thị Thu Thảo',0,'1999-08-08','0986280144','125932074','Thaotttph13959@fpt.edu.vn','default.jpg',0,'Founder'
exec SP_ThemNhanVien 'NV0005','vanvh13957','123',N'Vi Hoàng Vân',1,'2002-03-03','0986283525','125932074','vanvhph13971@fpt.edu.vn','default.jpg',0,'Founder'


INSERT INTO TheThanhVien(MaTheTV,TenKH,GioiTinh,NgaySinh,SDT,CMND,Email,HinhAnh,NgayTao,NgayHetHan,GhiChu) VALUES('MTV00001',N'Trần huyền trang',0,'2000-10-10','0324562541','187823366',N'hohangxa@gmail.com','none','2021-08-12','2021-08-12',N'Không'),
                                                                                                                 ('MTV00002',N'Hoàng Trung Hải',1,'1998-08-11','0324569327','187824257',N'matcachan@gmail.com','none','2021-06-10','2021-06-10',N'Không'),
																												 ('MTV00003',N'Nam Thiên Môn',1,'1995-11-03','0324565735','187827921',N'ngogiatu@gmail.com','none','2020-02-12','2020-02-12',N'Không'),
																												 ('MTV00004',N'Hoàng Dược Sư',1,'1997-09-12','0324562494','187824113',N'chimmoi@gmail.com','none','2019-03-03','2019-03-03',N'Không'),
																												 ('MTV00005',N'Trịnh Khắc Phục',1,'2001-12-12','0324563579','187822594',N'quadeongang@gmail.com','none','2020-05-05','2020-05-05',N'Không'),
																												 ('MTV00006',N'Ngô hoàng Nam',1,'2000-04-06','0324560261','187823113',N'nhatkytrongtu@gmail.com','none','2021-03-12','2021-03-12',N'Không'),
																												 ('MTV00007',N'Trần thị Hải Yến',0,'1994-05-06','0324563519','187822792',N'chieutoi@gmail.com','none','2021-10-10','2021-10-10',N'Không')

INSERT INTO KhoiLuong(MaKhoiLuong,GiaTri) VALUES('KL0001','180ML'),
                                                ('KL0002','150ML'),
												('KL0003','300G'),
												('KL0004','960ML'),
												('KL0005','600G'),
												('KL0006','400G'),
												('KL0007','1,2KG'),
												('KL0008','800G')

INSERT INTO XuatXu(MaQG,TenQG) VALUES('QG001',N'Việt Nam'),
                                     ('QG002',N'New Zealand'),
									 ('QG003',N'Nhật Bản'),
									 ('QG004',N'Mỹ'),
									 ('QG005',N'Úc'),
									 ('QG006',N'Singapore'),
									 ('QG007',N'Hà Lan'),
									 ('QG008',N'Đức')

IF OBJECT_ID('ADD_DONGSP') IS NOT NULL
  DROP PROC ADD_DONGSP
GO
CREATE PROC ADD_DONGSP
              @MADONGSP VARCHAR(50),
			  @MATH VARCHAR(50),
			  @TENDONGSP NVARCHAR(50),
			  @GHICHU NVARCHAR(500),
			  @TRANGTHAI BIT
AS
  BEGIN
      DECLARE @ID INT
	  SELECT @ID = IDTHUONGHIEU FROM ThuongHieu  WHERE  @MATH = MaTH
	  INSERT INTO DongSP(MaDongSP,IDThuongHieu,TenDongSP,GhiChu,TrangThai) VALUES(@MADONGSP,@ID,@TENDONGSP,@GHICHU,@TRANGTHAI)
  END
GO
EXEC ADD_DONGSP 'DSP0001','TH10000',N'Sữa bột Similac',N'KHÔNG',0
EXEC ADD_DONGSP 'DSP0002','TH10003',N'Sữa bột Nutren',N'KHÔNG',0
EXEC ADD_DONGSP 'DSP0003','TH10004',N'Trà cốm hoa quả Burine',N'KHÔNG',0
EXEC ADD_DONGSP 'DSP0004','TH10001',N'Sữa Hikid ',N'KHÔNG',0
EXEC ADD_DONGSP 'DSP0005','TH10002',N'Sữa Frisomum Gold',N'KHÔNG',0
EXEC ADD_DONGSP 'DSP0006','TH10000',N'Dielac Grow',N'KHÔNG',0

INSERT INTO NhomHang(MaNhom,TenNhom,GhiChu) VALUES('NH001',N'Sữa bột',N'KHÔNG'),
                                                  ('NH002',N'Sữa tươi',N'KHÔNG'),
												  ('NH003',N'Thực phẩm chức năng',N'KHÔNG')


IF OBJECT_ID('ADD_LOAIHANG') IS NOT NULL
  DROP PROC ADD_LOAIHANG
GO
CREATE PROC ADD_LOAIHANG
              @MALH VARCHAR(50),
			  @MANH VARCHAR(50),
			  @TEN NVARCHAR(50),
			  @GHICHU NVARCHAR(500)
AS
  BEGIN
      DECLARE @ID INT
	  SELECT @ID = IDNHOMHANG FROM NhomHang  WHERE  @MANH = MaNhom
	  INSERT INTO LoaiHang(MaLoai,IDNhomHang,TenLoai,GhiChu) VALUES(@MALH,@ID,@TEN,@GHICHU)
  END
GO
EXEC ADD_LOAIHANG 'LH001','NH001',N'mẹ mang thai và cho con bú',N'KHÔNG'
EXEC ADD_LOAIHANG 'LH002','NH002',N'trẻ trên 6 tháng tuổi',N'KHÔNG'
EXEC ADD_LOAIHANG 'LH003','NH001',N'trẻ sơ sinh dưới 6 tháng tuổi',N'KHÔNG'
EXEC ADD_LOAIHANG 'LH004','NH001',N'cho người cao tuổi',N'KHÔNG'
EXEC ADD_LOAIHANG 'LH005','NH003',N'cho trẻ suy dinh dưỡng',N'KHÔNG'


IF OBJECT_ID('ADD_SANPHAM') IS NOT NULL
  DROP PROC ADD_SANPHAM
GO
CREATE PROC ADD_SANPHAM
       @MASP VARCHAR(50),
	   @MALOAISP VARCHAR(50),
	   @MADONGSP VARCHAR(50),
	   @TEN NVARCHAR(100),
	   @NGAYNK DATE,
	   @GHICHU NVARCHAR(500),
	   @TT BIT
AS
  BEGIN
       DECLARE @IDLSP INT
	   SELECT @IDLSP = IDLOAIHANG FROM LoaiHang WHERE @MALOAISP = MaLoai
	   DECLARE @IDDSP INT
	   SELECT @IDDSP = IDDONGSP FROM DongSP WHERE @MADONGSP = MaDongSP
	   INSERT INTO SanPham(MaSP,IDLoaiSP,IDDongSP,TenSP,NgayXK,GhiChu,TrangThai) VALUES(@MASP,@IDLSP,@IDDSP,@TEN,@NGAYNK,@GHICHU,@TT)
  END
GO
EXEC ADD_SANPHAM 'SP10000','LH001','DSP0005',N'Số 0','2021-10-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10001','LH002','DSP0004',N' HMO Số 3','2021-10-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10002','LH003','DSP0001',N'5G số 4','2021-10-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10003','LH004','DSP0002',N'Junior New','2021-10-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10004','LH005','DSP0003',N'Vị dâu','2021-10-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10005','LH004','DSP0006',N'Plus 1+','2021-10-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10006','LH002','DSP0004',N'vị Vani','2021-10-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10007','LH003','DSP0005',N'Infant Formula EZcube','2021-09-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10008','LH002','DSP0004',N'hương vani','2021-09-15',N'KHÔNG',0
EXEC ADD_SANPHAM 'SP10009','LH001','DSP0001',N'5G số 1','2021-09-15',N'KHÔNG',0


IF OBJECT_ID('ADD_HOADON') IS NOT NULL
  DROP PROC ADD_HOADON
GO
CREATE PROC ADD_HOADON
       @MAHD VARCHAR(50),
	   @MANV VARCHAR(50),
	   @MATHETV VARCHAR(50),
	   @MAHTTT VARCHAR(50),
	   @NGAYLAP DATE,
	   @TONGT MONEY,
	   @GHICHU NVARCHAR(500),
	   @TT BIT
AS
  BEGIN
       DECLARE @IDMANV INT
	   SELECT @IDMANV = IDNHANVIEN FROM NhanVien WHERE @MANV = MaNV
	   DECLARE @IDTHETV INT
	   SELECT @IDTHETV = IDTHETV FROM TheThanhVien WHERE @MATHETV = MaTheTV
	   DECLARE @IDHT INT
	   SELECT @IDHT = IDHINHTHUCTHANHTOAN FROM HinhThucThanhToan WHERE @MAHTTT = MaHinhThucThanhToan
	   INSERT INTO HoaDon(MaHD,IDNhanVien,IDTheTV,IDHinhThucThanhToan,NgayLap,TongTien,GhiChu,TrangThai) VALUES(@MAHD,@IDMANV,@IDTHETV,@IDHT,@NGAYLAP,@TONGT,@GHICHU,@TT)
  END
GO
EXEC ADD_HOADON 'HD00001','NV0002','MTV00007','HT0001','2021-11-10',500000,N'không',0
EXEC ADD_HOADON 'HD00002','NV0001','MTV00003','HT0002','2021-11-12',1500000,N'không',0
EXEC ADD_HOADON 'HD00003','NV0002','MTV00001','HT0001','2021-11-10',600000,N'không',0
EXEC ADD_HOADON 'HD00004','NV0003','MTV00003','HT0001','2021-11-16',800000,N'không',1
EXEC ADD_HOADON 'HD00005','NV0004','MTV00004','HT0001','2021-11-15',1200000,N'không',1

IF OBJECT_ID('ADD_CTSP') IS NOT NULL
  DROP PROC ADD_CTSP
GO
CREATE PROC ADD_CTSP
       @MASP VARCHAR(50),
	   @HANSD DATE,
	   @SLTON INT,
	   @DONGIA MONEY,
	   @MAXX VARCHAR(50),
	   @MAKL VARCHAR(50),
	   @MADVT VARCHAR(50),
	   @MAANHSP VARCHAR(50),
	   @BARCODE VARCHAR(100)
AS
  BEGIN
       DECLARE @IDSP INT
	   SELECT @IDSP = IDSANPHAM FROM SanPham WHERE @MASP = MaSP
	   DECLARE @IDXX INT
	   SELECT @IDXX = IDXuatXu FROM XuatXu WHERE @MAXX = MaQG
	   DECLARE @IDKL INT
	   SELECT @IDKL = IDKhoiLuong FROM KhoiLuong WHERE @MAKL = MaKhoiLuong
	   DECLARE @IDDVT INT
	   SELECT @IDDVT = IDDonViTinh FROM DonViTinh WHERE @MADVT = MaDVT
	   DECLARE @IDASP INT
	   SELECT @IDASP = IDAnhSP FROM AnhSP WHERE @MAANHSP = MaAnhSP
	   INSERT INTO ChiTietSanPham(IDSanPham,HanSD,SoLuongTon,DonGia,IDXuatXu,IDKhoiLuong,IDDonViTinh,IDAnhSP,BarCode) VALUES(@IDSP,@HANSD,@SLTON,@DONGIA,@IDXX,@IDKL,@IDDVT,@IDASP,@BARCODE)
  END
GO
EXEC ADD_CTSP 'SP10002','2025-12-25',58,400000,'QG002','KL0006','DVT0001','ASP00001','ABCDXYZ123'
EXEC ADD_CTSP 'SP10003','2026-10-25',50,500000,'QG005','KL0005','DVT0001','ASP00002','ABCDXYZ124'
EXEC ADD_CTSP 'SP10004','2025-12-25',40,200000,'QG003','KL0001','DVT0004','ASP00006','ABCDXYZ125'
EXEC ADD_CTSP 'SP10005','2025-12-25',60,600000,'QG007','KL0004','DVT0002','ASP00003','ABCDXYZ126'
EXEC ADD_CTSP 'SP10006','2025-12-25',35,100000,'QG006','KL0002','DVT0004','ASP00001','ABCDXYZ127'
EXEC ADD_CTSP 'SP10007','2025-12-25',23,800000,'QG008','KL0008','DVT0001','ASP00004','ABCDXYZ128'
EXEC ADD_CTSP 'SP10008','2025-12-25',60,300000,'QG002','KL0004','DVT0002','ASP00006','ABCDXYZ129'
EXEC ADD_CTSP 'SP10009','2025-12-25',65,1200000,'QG001','KL0007','DVT0001','ASP00005','ABCDXYZ120'
EXEC ADD_CTSP 'SP10001','2025-12-25',55,600000,'QG004','KL0006','DVT0001','ASP00002','ABCDXYZ135'
EXEC ADD_CTSP 'SP10000','2025-12-25',58,500000,'QG007','KL0006','DVT0001','ASP00005','ABCDXYZ141'

IF OBJECT_ID('ADD_CTHD') IS NOT NULL
  DROP PROC ADD_CTHD
GO
CREATE PROC ADD_CTHD
       @MAHD VARCHAR(50),
	   @BARCODE VARCHAR(100),
	   @SL INT,
	   @DONGIA MONEY
AS
  BEGIN
       DECLARE @IDHD INT
	   SELECT @IDHD = IDHOADON FROM HoaDon WHERE @MAHD = MaHD
	   DECLARE @IDCTSP INT
	   SELECT @IDCTSP = IDCHITIETSP FROM ChiTietSanPham WHERE @BARCODE = BarCode
	   INSERT INTO ChiTietHoaDon(IDHoaDon,IDChiTietSP,SoLuong,DonGia) VALUES(@IDHD,@IDCTSP,@SL,@DONGIA)
  END
GO
EXEC ADD_CTHD 'HD00001','ABCDXYZ124',1,500000
EXEC ADD_CTHD 'HD00002','ABCDXYZ123',1,400000
EXEC ADD_CTHD 'HD00002','ABCDXYZ129',2,300000
EXEC ADD_CTHD 'HD00002','ABCDXYZ124',1,500000
EXEC ADD_CTHD 'HD00003','ABCDXYZ125',3,200000
EXEC ADD_CTHD 'HD00004','ABCDXYZ129',2,300000
EXEC ADD_CTHD 'HD00004','ABCDXYZ125',1,200000
EXEC ADD_CTHD 'HD00005','ABCDXYZ120',1,1200000


SELECT MaSP,TenDongSP,TenSP,GiaTri,SoLuongTon,DONGIA,TenAnhSP
FROM SANPHAM JOIN CHITIETSANPHAM ON SANPHAM.IDSANPHAM = CHITIETSANPHAM.IDSANPHAM
             JOIN DONVITINH ON CHITIETSANPHAM.IDDONVITINH = DONVITINH.IDDONVITINH
			 JOIN KHOILUONG ON CHITIETSANPHAM.IDKHOILUONG = KHOILUONG.IDKHOILUONG
			 JOIN XUATXU ON CHITIETSANPHAM.IDXUATXU = XUATXU.IDXUATXU
			 JOIN DONGSP ON SANPHAM.IDDONGSP = DONGSP.IDDONGSP
			 JOIN THUONGHIEU ON DONGSP.IDTHUONGHIEU = THUONGHIEU.IDTHUONGHIEU
			 JOIN AnhSP ON AnhSP.IDAnhSP = CHITIETSANPHAM.IDAnhSP




SELECT*FROM AnhSP
SELECT*FROM ThuongHieu
SELECT*FROM DonViTinh
SELECT*FROM HinhThucThanhToan
SELECT*FROM NhanVien
SELECT*FROM TheThanhVien
SELECT*FROM KhoiLuong
SELECT*FROM XuatXu
SELECT*FROM DongSP
SELECT*FROM NhomHang
SELECT*FROM LoaiHang
SELECT*FROM SanPham
SELECT*FROM HoaDon
SELECT*FROM ChiTietSanPham
SELECT*FROM ChiTietHoaDon