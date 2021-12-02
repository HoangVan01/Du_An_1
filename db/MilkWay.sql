USE [master]
GO
/****** Object:  Database [MilkyWay]    Script Date: 02/12/2021 5:56:52 CH ******/
CREATE DATABASE [MilkyWay]
GO
ALTER DATABASE [MilkyWay] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MilkyWay].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MilkyWay] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MilkyWay] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MilkyWay] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MilkyWay] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MilkyWay] SET ARITHABORT OFF 
GO
ALTER DATABASE [MilkyWay] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MilkyWay] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MilkyWay] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MilkyWay] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MilkyWay] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MilkyWay] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MilkyWay] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MilkyWay] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MilkyWay] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MilkyWay] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MilkyWay] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MilkyWay] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MilkyWay] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MilkyWay] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MilkyWay] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MilkyWay] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MilkyWay] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MilkyWay] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MilkyWay] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MilkyWay] SET  MULTI_USER 
GO
ALTER DATABASE [MilkyWay] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MilkyWay] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MilkyWay] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MilkyWay] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [MilkyWay]
GO
/****** Object:  StoredProcedure [dbo].[ADD_CTHD]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ADD_CTHD]
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
/****** Object:  StoredProcedure [dbo].[ADD_CTSP]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ADD_CTSP]
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
/****** Object:  StoredProcedure [dbo].[ADD_DONGSP]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ADD_DONGSP]
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
/****** Object:  StoredProcedure [dbo].[ADD_HOADON]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ADD_HOADON]
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
/****** Object:  StoredProcedure [dbo].[ADD_LOAIHANG]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ADD_LOAIHANG]
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
/****** Object:  StoredProcedure [dbo].[ADD_SANPHAM]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ADD_SANPHAM]
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
/****** Object:  StoredProcedure [dbo].[SP_DangNhap]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DangNhap]
	@TaiKhoan varchar(50),
    @MatKhau varchar(50),
	@ok bit OUTPUT,
    @responseMessage NVARCHAR(250)='' OUTPUT
AS
BEGIN

    SET NOCOUNT ON

    IF EXISTS (SELECT TOP 1 TaiKhoan FROM NhanVien WHERE TaiKhoan=@TaiKhoan)
    BEGIN
       IF((SELECT TaiKhoan FROM NhanVien WHERE TaiKhoan=@TaiKhoan AND MatKhau=HASHBYTES('SHA2_512', @MatKhau+CAST(Salt AS NVARCHAR(36)))) IS NULL)
			BEGIN
			   SET @responseMessage=N'Mật khẩu không hợp lệ'
			   SET @ok = 0
			END
       ELSE 
		   BEGIN
			   SET @responseMessage=N'Đăng nhập thành công'
			   SET @ok = 1
			END
    END
    ELSE
		BEGIN
		   SET @responseMessage=N'Tài khoản không hợp lệ'
		   SET @ok = 0
	   END

END

GO
/****** Object:  StoredProcedure [dbo].[SP_DoiMatKhau]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DoiMatKhau]
	@MaNV varchar(20),
	@TaiKhoan varchar(50),
    @MatKhau varchar(50),
	@MatKhauMoi varchar(50),
	@XacNhanMKMoi varchar(50),
	@ok bit OUTPUT,
    @responseMessage NVARCHAR(250)='' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

       IF((SELECT MaNV FROM NhanVien WHERE MaNV=@MaNV AND TaiKhoan=@TaiKhoan AND MatKhau=HASHBYTES('SHA2_512', @MatKhau+CAST(Salt AS NVARCHAR(36)))) IS NULL)
			BEGIN
			   SET @responseMessage=N'Mật khẩu hiện tại không hợp lệ'
			   SET @ok = 0
			END
       ELSE 
			IF(@MatKhauMoi = @XacNhanMKMoi)
		   BEGIN
				DECLARE @Salt UNIQUEIDENTIFIER = NEWID()
				UPDATE NhanVien
				SET MatKhau=HASHBYTES('SHA2_512', @MatKhauMoi+CAST(@Salt AS NVARCHAR(36))), Salt = @Salt
				WHERE MaNV=@MaNV
			   SET @responseMessage=N'Đổi mật khẩu thành công'
			   SET @ok = 1
			END
			ELSE
				BEGIN
					SET @responseMessage=N'Xác nhận mật khẩu không hợp lệ'
					SET @ok = 0
				END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Forgot]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_Forgot]


	@TaiKhoan varchar(50),
    @Email varchar(50),
	@ok bit OUTPUT,
    @responseMessage NVARCHAR(250)='' OUTPUT
    
AS

BEGIN
	SET NOCOUNT ON;
       IF((SELECT TaiKhoan FROM NhanVien WHERE TaiKhoan=@TaiKhoan and Email=@Email) IS NULL)
			BEGIN
			   SET @responseMessage=N'Không tồn tại tài khoản này'
			   SET @ok = 0
			END
       ELSE 
		   BEGIN
			   SET @responseMessage=N'Xác Thực Thành Công'
			   SET @ok = 1
			END
		End		

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertAllSanPham]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertAllSanPham]
@MaSP varchar(50)
,@IDLoaiSP int
,@IDDongSP int
,@TenSP nvarchar(100)
,@GhiChu nvarchar(500)
,@IDSanPham int
,@HanSD date
,@SoLuongTon int
,@DonGia decimal(18,2)
,@IDXuatXu int
,@IDKhoiLuong int
,@IDDonViTinh int
,@IDAnhSP int
,@BarCode varchar(100)
AS
BEGIN
	INSERT INTO [dbo].[SanPham]([MaSP],[IDLoaiSP],[IDDongSP],[TenSP],[GhiChu])
    VALUES(@MaSP,@IDLoaiSP,@IDDongSP,@TenSP,@GhiChu)

	select @IDSanPham = IDSanPham from SanPham where MaSP = @MaSP

	INSERT INTO [dbo].[ChiTietSanPham]([IDSanPham],[HanSD],[SoLuongTon],[DonGia],[IDXuatXu],[IDKhoiLuong],[IDDonViTinh],[IDAnhSP],[BarCode])
    VALUES (@IDSanPham,@HanSD,@SoLuongTon,@DonGia,@IDXuatXu,@IDKhoiLuong,@IDDonViTinh,@IDAnhSP,@BarCode)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ResetPass]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_ResetPass]
	
	@TaiKhoan varchar(50),
	@MatKhauMoi varchar(50),
	@XacNhanMKMoi varchar(50),
	@ok bit OUTPUT,
    @responseMessage NVARCHAR(250)='' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

      
			IF(@MatKhauMoi = @XacNhanMKMoi)
		   BEGIN
				DECLARE @Salt UNIQUEIDENTIFIER = NEWID()
				UPDATE NhanVien
				SET MatKhau=HASHBYTES('SHA2_512', @MatKhauMoi+CAST(@Salt AS NVARCHAR(36))), Salt = @Salt
				WHERE TaiKhoan=@TaiKhoan
			   SET @responseMessage=N'Đổi mật khẩu thành công'
			   SET @ok = 1
			END
			ELSE
				BEGIN
					SET @responseMessage=N'Xác nhận mật khẩu không hợp lệ'
					SET @ok = 0
				END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectAllSanPham]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SelectAllSanPham]
@status bit
AS
BEGIN
	select MaSP, TenSP, TenLoai, TenDongSP, NgayXK, a.GhiChu, a.TrangThai, HanSD, SoLuongTon, DonGia, TenQG, GiaTri, TenDVT, TenAnhSP, BarCode
	from SanPham a join ChiTietSanPham b on a.IDSanPham = b.IDSanPham
	join LoaiHang c on c.IDLoaiHang = a.IDLoaiSP
	join DongSP d on d.IDDongSP = a.IDDongSP
	join XuatXu e on e.IDXuatXu = b.IDXuatXu
	join DonViTinh f on f.IDDonViTinh = b.IDDonViTinh
	join AnhSP g on g.IDAnhSP = b.IDAnhSP
	join KhoiLuong h on h.IDKhoiLuong = b.IDKhoiLuong
	where a.TrangThai = @status
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectAllSanPhamByBarCode]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_SelectAllSanPhamByBarCode]
@status bit, @barcode varchar(100)
AS
BEGIN
	select MaSP, TenSP, TenLoai, TenDongSP, NgayXK, a.GhiChu, a.TrangThai, HanSD, SoLuongTon, DonGia, TenQG, GiaTri, TenDVT, TenAnhSP, BarCode
	from SanPham a join ChiTietSanPham b on a.IDSanPham = b.IDSanPham
	join LoaiHang c on c.IDLoaiHang = a.IDLoaiSP
	join DongSP d on d.IDDongSP = a.IDDongSP
	join XuatXu e on e.IDXuatXu = b.IDXuatXu
	join DonViTinh f on f.IDDonViTinh = b.IDDonViTinh
	join AnhSP g on g.IDAnhSP = b.IDAnhSP
	join KhoiLuong h on h.IDKhoiLuong = b.IDKhoiLuong
	where a.TrangThai = @status and BarCode = @barcode
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectAllSanPhamByID]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SelectAllSanPhamByID]
@status bit, @MaSP varchar(50)
AS
BEGIN
	select MaSP, TenSP, TenLoai, TenDongSP, NgayXK, a.GhiChu, a.TrangThai, HanSD, SoLuongTon, DonGia, TenQG, GiaTri, TenDVT, TenAnhSP, BarCode
	from SanPham a join ChiTietSanPham b on a.IDSanPham = b.IDSanPham
	join LoaiHang c on c.IDLoaiHang = a.IDLoaiSP
	join DongSP d on d.IDDongSP = a.IDDongSP
	join XuatXu e on e.IDXuatXu = b.IDXuatXu
	join DonViTinh f on f.IDDonViTinh = b.IDDonViTinh
	join AnhSP g on g.IDAnhSP = b.IDAnhSP
	join KhoiLuong h on h.IDKhoiLuong = b.IDKhoiLuong
	where a.TrangThai = @status and MaSP = @MaSP
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectAllSanPhamSapHetHan]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_SelectAllSanPhamSapHetHan]
AS
BEGIN
	select MaSP, TenSP, TenLoai, TenDongSP, NgayXK, a.GhiChu, a.TrangThai, HanSD, SoLuongTon, DonGia, TenQG, GiaTri, TenDVT, TenAnhSP, BarCode
	from SanPham a join ChiTietSanPham b on a.IDSanPham = b.IDSanPham
	join LoaiHang c on c.IDLoaiHang = a.IDLoaiSP
	join DongSP d on d.IDDongSP = a.IDDongSP
	join XuatXu e on e.IDXuatXu = b.IDXuatXu
	join DonViTinh f on f.IDDonViTinh = b.IDDonViTinh
	join AnhSP g on g.IDAnhSP = b.IDAnhSP
	join KhoiLuong h on h.IDKhoiLuong = b.IDKhoiLuong
	where a.TrangThai = 1 and DATEDIFF(MONTH,GETDATE(),HanSD) <= 3
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectAllSanPhamSapHetHang]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_SelectAllSanPhamSapHetHang]
@start int, @end int
AS
BEGIN
	select MaSP, TenSP, TenLoai, TenDongSP, NgayXK, a.GhiChu, a.TrangThai, HanSD, SoLuongTon, DonGia, TenQG, GiaTri, TenDVT, TenAnhSP, BarCode
	from SanPham a join ChiTietSanPham b on a.IDSanPham = b.IDSanPham
	join LoaiHang c on c.IDLoaiHang = a.IDLoaiSP
	join DongSP d on d.IDDongSP = a.IDDongSP
	join XuatXu e on e.IDXuatXu = b.IDXuatXu
	join DonViTinh f on f.IDDonViTinh = b.IDDonViTinh
	join AnhSP g on g.IDAnhSP = b.IDAnhSP
	join KhoiLuong h on h.IDKhoiLuong = b.IDKhoiLuong
	where a.TrangThai = 1 and (SoLuongTon between @start and @end)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ThemNhanVien]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ThemNhanVien]
	@MaNV varchar(50)
    ,@TaiKhoan varchar(50)
    ,@MatKhau varchar(50)
    ,@HoTen nvarchar(50)
    ,@GioiTinh bit
    ,@NgaySinh date
    ,@SDT varchar(20)
    ,@CMND varchar(20)
    ,@Email varchar(50)
    ,@HinhAnh nvarchar(50)
    ,@VaiTro bit
    ,@GhiChu nvarchar(500)
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @Salt UNIQUEIDENTIFIER = NEWID()

	INSERT INTO NhanVien (MaNV,TaiKhoan,MatKhau,HoTen,GioiTinh,NgaySinh,SDT,CMND,Email,HinhAnh,VaiTro,GhiChu,Salt)
	values (@MaNV, @TaiKhoan, HASHBYTES('SHA2_512', @MatKhau+CAST(@Salt as nvarchar(36))), @HoTen,@GioiTinh,@NgaySinh,@SDT,@CMND,@Email,@HinhAnh,@VaiTro,@GhiChu,@Salt)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateSanPham]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateSanPham]
    @HanSD date
    ,@SoLuongTon int
    ,@DonGia decimal(18,2)
    ,@IDXuatXu int
    ,@IDKhoiLuong int
    ,@IDDonViTinh int
    ,@IDAnhSP int
    ,@BarCode varchar(100)
	
	,@MaSP varchar(50)
    ,@IDLoaiSP int
    ,@IDDongSP int
    ,@TenSP nvarchar(100)
    ,@GhiChu nvarchar(500)
AS
BEGIN
	declare @IDChiTietSP int
	select @IDChiTietSP = IDChiTietSP from ChiTietSanPham where IDSanPham = (select IDSanPham from SanPham where MaSP = @MaSP)

	UPDATE [dbo].[ChiTietSanPham]
	SET [HanSD] = @HanSD,[SoLuongTon] = @SoLuongTon,[DonGia] = @DonGia,[IDXuatXu] = @IDXuatXu,[IDKhoiLuong] = @IDKhoiLuong,[IDDonViTinh] = @IDDonViTinh,[IDAnhSP] = @IDAnhSP,[BarCode] = @BarCode
	WHERE [IDChiTietSP] = @IDChiTietSP
	UPDATE [dbo].[SanPham]
	SET [IDLoaiSP] = @IDLoaiSP
      ,[IDDongSP] = @IDDongSP
      ,[TenSP] = @TenSP
      ,[GhiChu] = @GhiChu
	WHERE [MaSP] = @MaSP
END

GO
/****** Object:  Table [dbo].[AnhSP]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AnhSP](
	[IDAnhSP] [int] IDENTITY(1,1) NOT NULL,
	[MaAnhSP] [varchar](50) NOT NULL,
	[TenAnhSP] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_AnhSP] PRIMARY KEY CLUSTERED 
(
	[IDAnhSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChiTietComboSP]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietComboSP](
	[IDChiTietComboSP] [int] IDENTITY(1,1) NOT NULL,
	[IDComboSP] [int] NOT NULL,
	[IDChiTietSP] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietComboSP] PRIMARY KEY CLUSTERED 
(
	[IDChiTietComboSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[IDChiTietHD] [int] IDENTITY(1,1000) NOT NULL,
	[IDHoaDon] [int] NOT NULL,
	[IDChiTietSP] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [money] NOT NULL,
 CONSTRAINT [PK_ChiTietHoaDon_1] PRIMARY KEY CLUSTERED 
(
	[IDChiTietHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietSanPham]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChiTietSanPham](
	[IDChiTietSP] [int] IDENTITY(1,1) NOT NULL,
	[IDSanPham] [int] NOT NULL,
	[HanSD] [date] NOT NULL,
	[SoLuongTon] [int] NOT NULL,
	[DonGia] [decimal](18, 2) NOT NULL,
	[IDXuatXu] [int] NOT NULL,
	[IDKhoiLuong] [int] NOT NULL,
	[IDDonViTinh] [int] NOT NULL,
	[IDAnhSP] [int] NOT NULL,
	[BarCode] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ChiTietSanPham] PRIMARY KEY CLUSTERED 
(
	[IDChiTietSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ComBoSP]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ComBoSP](
	[IDComboSP] [int] IDENTITY(1,1) NOT NULL,
	[MaComboSP] [varchar](200) NOT NULL,
	[TenComboSP] [nvarchar](200) NOT NULL,
	[SoLuongSP] [int] NOT NULL,
	[TongGia] [money] NOT NULL,
	[NgayTao] [date] NOT NULL CONSTRAINT [DF_ComBoSP_NgayTao]  DEFAULT (getdate()),
	[NgayHetHan] [date] NOT NULL,
	[Barcode] [varchar](100) NULL,
	[GhiChu] [nvarchar](500) NULL,
	[AnhComBoSP] [nvarchar](500) NULL,
 CONSTRAINT [PK_ComBoSP] PRIMARY KEY CLUSTERED 
(
	[IDComboSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DongSP]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DongSP](
	[IDDongSP] [int] IDENTITY(1,1) NOT NULL,
	[MaDongSP] [varchar](50) NOT NULL,
	[IDThuongHieu] [int] NOT NULL,
	[TenDongSP] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[TrangThai] [bit] NOT NULL CONSTRAINT [DF_DongSP_TrangThai]  DEFAULT ((1)),
 CONSTRAINT [PK_DongSP] PRIMARY KEY CLUSTERED 
(
	[IDDongSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DonViTinh]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DonViTinh](
	[IDDonViTinh] [int] IDENTITY(1,1) NOT NULL,
	[MaDVT] [varchar](50) NOT NULL,
	[TenDVT] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DonViTinh] PRIMARY KEY CLUSTERED 
(
	[IDDonViTinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HinhThucThanhToan]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HinhThucThanhToan](
	[IDHinhThucThanhToan] [int] IDENTITY(1,1) NOT NULL,
	[MaHinhThucThanhToan] [varchar](20) NOT NULL,
	[TenHinhThucThanhToan] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_HinhThucThanhToan] PRIMARY KEY CLUSTERED 
(
	[IDHinhThucThanhToan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HoaDon](
	[IDHoaDon] [int] IDENTITY(1,1000) NOT NULL,
	[MaHD] [varchar](50) NOT NULL,
	[IDNhanVien] [int] NOT NULL,
	[IDTheTV] [int] NULL,
	[IDHinhThucThanhToan] [int] NOT NULL,
	[NgayLap] [datetime] NOT NULL CONSTRAINT [DF_HoaDon_NgayLap]  DEFAULT (getdate()),
	[TongTien] [money] NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[TrangThai] [nvarchar](50) NOT NULL CONSTRAINT [DF_HoaDon_TrangThai]  DEFAULT ((1)),
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[IDHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoiLuong]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoiLuong](
	[IDKhoiLuong] [int] IDENTITY(1,1) NOT NULL,
	[MaKhoiLuong] [varchar](50) NOT NULL,
	[GiaTri] [varchar](50) NOT NULL,
 CONSTRAINT [PK_KhoiLuong] PRIMARY KEY CLUSTERED 
(
	[IDKhoiLuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[IDKhuyenMai] [int] IDENTITY(1,1) NOT NULL,
	[MaKM] [varchar](50) NOT NULL,
	[TenKM] [nvarchar](50) NOT NULL,
	[IDSanPham] [int] NULL,
	[IDDongSP] [int] NULL,
	[ThoiGianBatDau] [date] NOT NULL,
	[ThoiGianKetThuc] [date] NOT NULL,
	[GiamGia] [int] NOT NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_KhuyenMai] PRIMARY KEY CLUSTERED 
(
	[IDKhuyenMai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiHang]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiHang](
	[IDLoaiHang] [int] IDENTITY(1,1) NOT NULL,
	[MaLoai] [varchar](50) NOT NULL,
	[IDNhomHang] [int] NOT NULL,
	[TenLoai] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_LoaiSua] PRIMARY KEY CLUSTERED 
(
	[IDLoaiHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhanVien](
	[IDNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[MaNV] [varchar](50) NOT NULL,
	[TaiKhoan] [varchar](50) NOT NULL,
	[MatKhau] [binary](64) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[GioiTinh] [bit] NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[SDT] [varchar](20) NOT NULL,
	[CMND] [varchar](20) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[HinhAnh] [nvarchar](50) NULL,
	[VaiTro] [bit] NOT NULL CONSTRAINT [DF_NhanVien_VaiTro]  DEFAULT ((0)),
	[GhiChu] [nvarchar](500) NULL,
	[TrangThai] [bit] NOT NULL CONSTRAINT [DF_NhanVien_TrangThai]  DEFAULT ((1)),
	[Salt] [uniqueidentifier] NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[IDNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhomHang]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhomHang](
	[IDNhomHang] [int] IDENTITY(1,1) NOT NULL,
	[MaNhom] [varchar](50) NOT NULL,
	[TenNhom] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_NhomHang] PRIMARY KEY CLUSTERED 
(
	[IDNhomHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SanPham](
	[IDSanPham] [int] IDENTITY(1,1000) NOT NULL,
	[MaSP] [varchar](50) NOT NULL,
	[IDLoaiSP] [int] NOT NULL,
	[IDDongSP] [int] NOT NULL,
	[TenSP] [nvarchar](100) NOT NULL,
	[NgayXK] [date] NOT NULL CONSTRAINT [DF_SanPham_NgayNK]  DEFAULT (getdate()),
	[GhiChu] [nvarchar](500) NULL,
	[TrangThai] [bit] NOT NULL CONSTRAINT [DF_SanPham_TrangThai]  DEFAULT ((1)),
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[IDSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TheThanhVien]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TheThanhVien](
	[IDTheTV] [int] IDENTITY(1,100) NOT NULL,
	[MaTheTV] [varchar](50) NOT NULL,
	[TenKH] [nvarchar](50) NOT NULL,
	[GioiTinh] [bit] NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[SDT] [varchar](20) NOT NULL,
	[CMND] [varchar](20) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[HinhAnh] [nvarchar](50) NULL,
	[Diem] [int] NOT NULL CONSTRAINT [DF_TheThanhVien_Diem]  DEFAULT ((0)),
	[NgayTao] [date] NOT NULL CONSTRAINT [DF_TheThanhVien_NgayTao]  DEFAULT (getdate()),
	[NgayHetHan] [date] NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_TheThanhVien] PRIMARY KEY CLUSTERED 
(
	[IDTheTV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ThuongHieu]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ThuongHieu](
	[IDThuongHieu] [int] IDENTITY(1,1) NOT NULL,
	[MaTH] [varchar](50) NOT NULL,
	[TenTH] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[TrangThai] [bit] NOT NULL CONSTRAINT [DF_ThuongHieu_TrangThai]  DEFAULT ((1)),
 CONSTRAINT [PK_ThuongHieu] PRIMARY KEY CLUSTERED 
(
	[IDThuongHieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[XuatXu]    Script Date: 02/12/2021 5:56:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XuatXu](
	[IDXuatXu] [int] IDENTITY(1,1) NOT NULL,
	[MaQG] [varchar](50) NOT NULL,
	[TenQG] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_XuatXu] PRIMARY KEY CLUSTERED 
(
	[IDXuatXu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AnhSP] ON 

GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (15, N'ASP00001', N'meiji0800g.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (16, N'ASP00002', N'similac5g4900.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (17, N'ASP00003', N'vinamilk_organic_khongduong_hopgiay_1L.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (18, N'ASP00004', N'sua1.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (19, N'ASP00005', N'ongthodo380g.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (20, N'ASP00006', N'sua2.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (21, N'MILO', N'milo.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (22, N'HIKID', N'sua-bo-hikid-nhap-khau-han-quoc-hop-600g-vi-vani-5.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (23, N'PEDIASURE', N'sua-pediasure-ba-huong-vani-850gr-1_2.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (24, N'ABBOT_GROW3', N'sua-abbott-grow-gold-3-huong-vani-900g-4.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (25, N'_MG_0503', N'_mg_0503.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (26, N'STTT-TO-YEN-110ML-HOP-1', N'sttt-to-yen-110ml-hop-1.png')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (28, N'SUA-TUOI-TIET-TRUNG-CHUA-TO-YEN-VINAMILK-110ML-4', N'thung-24-hop-sua-tuoi-tiet-trung-chua-to-yen-vinamilk-110ml-4.png')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (29, N'SUA-VINAMILK-100%-CO-DUONG', N'sua-vinamilk-100%-co-duong.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (30, N'SUA-NUOC-ABBOTT-GROW-GOLD-HUONG-VANI-4X180ML-10', N'sua-nuoc-abbott-grow-gold-huong-vani-4x180ml-10.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (32, N'SUA-BOT-ENFAGROW-A-NEUROPRO-SO-4-830G', N'sua-bot-enfagrow-a-neuropro-so-4-830g-cho-be-tu-2-6-tuoi-1.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (34, N'VINAMILK-100%-IT-DUONG-1L', N'vinamilk-100%-it-duong-1L.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (35, N'VINAMILK-100%-KHONG-DUONG-1L', N'vinamilk-100%-khong-duong-1L.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (36, N'VINAMILK-GREEN-FARM-110ML-IT-DUONG', N'vinamilk-green-farm-110ml-it-duong.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (37, N'VINAMILK-GREEN-FARM-180ML-CO-DUONG', N'vinamilk-green-farm-180ml-co-duong.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (38, N'SUA-BOT-NUTREN-JUNIOR-NEW-850G-CHO-BE-1-12-TUOI-1', N'sua-bot-nutren-junior-new-850g-cho-be-1-12-tuoi-1.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (39, N'SIMILAC-5G-SO-1', N'similac-5g-so-1.jpg')
GO
SET IDENTITY_INSERT [dbo].[AnhSP] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietComboSP] ON 

GO
INSERT [dbo].[ChiTietComboSP] ([IDChiTietComboSP], [IDComboSP], [IDChiTietSP]) VALUES (4, 8, 24)
GO
INSERT [dbo].[ChiTietComboSP] ([IDChiTietComboSP], [IDComboSP], [IDChiTietSP]) VALUES (5, 9, 15)
GO
INSERT [dbo].[ChiTietComboSP] ([IDChiTietComboSP], [IDComboSP], [IDChiTietSP]) VALUES (6, 9, 18)
GO
INSERT [dbo].[ChiTietComboSP] ([IDChiTietComboSP], [IDComboSP], [IDChiTietSP]) VALUES (7, 9, 24)
GO
INSERT [dbo].[ChiTietComboSP] ([IDChiTietComboSP], [IDComboSP], [IDChiTietSP]) VALUES (8, 10, 19)
GO
INSERT [dbo].[ChiTietComboSP] ([IDChiTietComboSP], [IDComboSP], [IDChiTietSP]) VALUES (9, 10, 21)
GO
SET IDENTITY_INSERT [dbo].[ChiTietComboSP] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietHoaDon] ON 

GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (48001, 35001, 15, 1, 500000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (49001, 36001, 14, 1, 400000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (50001, 36001, 20, 2, 300000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (51001, 36001, 15, 1, 500000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (52001, 37001, 16, 3, 200000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (53001, 38001, 20, 2, 300000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (54001, 38001, 16, 1, 200000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (55001, 39001, 21, 1, 1200000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (56001, 40001, 15, 5, 500000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (57001, 40001, 17, 2, 600000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (58001, 40001, 19, 2, 800000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (59001, 51001, 14, 1, 400000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (60001, 57001, 16, 1, 200000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (61001, 58001, 18, 1, 100000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (62001, 59001, 24, 3, 8000.0000)
GO
INSERT [dbo].[ChiTietHoaDon] ([IDChiTietHD], [IDHoaDon], [IDChiTietSP], [SoLuong], [DonGia]) VALUES (63001, 59001, 16, 1, 200000.0000)
GO
SET IDENTITY_INSERT [dbo].[ChiTietHoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietSanPham] ON 

GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (14, 18001, CAST(N'2025-12-25' AS Date), 58, CAST(549000.00 AS Decimal(18, 2)), 17, 22, 10, 15, N'4902705116542')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (15, 19001, CAST(N'2026-10-25' AS Date), 49, CAST(480000.00 AS Decimal(18, 2)), 23, 24, 10, 16, N'5391523059534')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (16, 20001, CAST(N'2025-12-25' AS Date), 40, CAST(428000.00 AS Decimal(18, 2)), 21, 17, 10, 20, N'7613032405700')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (17, 21001, CAST(N'2025-12-25' AS Date), 60, CAST(53000.00 AS Decimal(18, 2)), 15, 25, 10, 17, N'8937284758554')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (18, 22001, CAST(N'2025-12-25' AS Date), 34, CAST(15000.00 AS Decimal(18, 2)), 18, 15, 10, 30, N'8889385625763')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (19, 23001, CAST(N'2025-12-25' AS Date), 22, CAST(345000.00 AS Decimal(18, 2)), 17, 20, 10, 25, N'4902705122918')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (20, 24001, CAST(N'2025-12-25' AS Date), 60, CAST(560000.00 AS Decimal(18, 2)), 24, 19, 10, 22, N'3801157117984')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (21, 25001, CAST(N'2025-12-25' AS Date), 63, CAST(8000.00 AS Decimal(18, 2)), 15, 23, 10, 26, N'8938582658456')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (22, 17001, CAST(N'2025-12-25' AS Date), 55, CAST(28000.00 AS Decimal(18, 2)), 15, 25, 10, 29, N'8937284610475')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (23, 16001, CAST(N'2025-12-25' AS Date), 58, CAST(619000.00 AS Decimal(18, 2)), 20, 26, 10, 23, N'8886451071323')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (24, 26001, CAST(N'2022-11-30' AS Date), 93, CAST(8000.00 AS Decimal(18, 2)), 15, 15, 10, 21, N'8934804034058')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (25, 27001, CAST(N'2025-11-30' AS Date), 10, CAST(490000.00 AS Decimal(18, 2)), 25, 27, 10, 32, N'7927465439274')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (26, 28001, CAST(N'2025-12-02' AS Date), 50, CAST(28000.00 AS Decimal(18, 2)), 15, 25, 10, 34, N'8936896542456')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (27, 29001, CAST(N'2025-12-02' AS Date), 50, CAST(28000.00 AS Decimal(18, 2)), 15, 25, 10, 35, N'8927465284524')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (28, 30001, CAST(N'2025-12-02' AS Date), 100, CAST(6000.00 AS Decimal(18, 2)), 15, 23, 10, 36, N'8927465820174')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (29, 31001, CAST(N'2025-12-02' AS Date), 35, CAST(8000.00 AS Decimal(18, 2)), 15, 15, 10, 37, N'8974638465743')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (30, 32001, CAST(N'2025-12-02' AS Date), 20, CAST(609000.00 AS Decimal(18, 2)), 20, 26, 10, 38, N'8886472106165')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (31, 33001, CAST(N'2025-12-17' AS Date), 20, CAST(297000.00 AS Decimal(18, 2)), 23, 20, 10, 39, N'539152305459')
GO
SET IDENTITY_INSERT [dbo].[ChiTietSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[ComBoSP] ON 

GO
INSERT [dbo].[ComBoSP] ([IDComboSP], [MaComboSP], [TenComboSP], [SoLuongSP], [TongGia], [NgayTao], [NgayHetHan], [Barcode], [GhiChu], [AnhComBoSP]) VALUES (8, N'Combo_4_MILO', N'Combo 4 hộp sữa Milo', 4, 28000.0000, CAST(N'2021-11-29' AS Date), CAST(N'2021-11-30' AS Date), N'Combo_4_MILO', N'', N'loc-4-hop-milo.jpg')
GO
INSERT [dbo].[ComBoSP] ([IDComboSP], [MaComboSP], [TenComboSP], [SoLuongSP], [TongGia], [NgayTao], [NgayHetHan], [Barcode], [GhiChu], [AnhComBoSP]) VALUES (9, N'Combo_SP10003_SP10006_MILO', N'Combo 5 sản phẩm - Junior New + Abbot_grow + Milo', 5, 550000.0000, CAST(N'2021-11-29' AS Date), CAST(N'2026-10-25' AS Date), N'Combo_SP10003_SP10006_MILO', N'', N'')
GO
INSERT [dbo].[ComBoSP] ([IDComboSP], [MaComboSP], [TenComboSP], [SoLuongSP], [TongGia], [NgayTao], [NgayHetHan], [Barcode], [GhiChu], [AnhComBoSP]) VALUES (10, N'Combo_SP10007_SP10009', N'Combo 3 sản phẩm - 2 Infant Formula EZcube + 1 5G số 1', 3, 2400000.0000, CAST(N'2021-11-29' AS Date), CAST(N'2025-12-25' AS Date), N'Combo_SP10007_SP10009', N'', N'')
GO
SET IDENTITY_INSERT [dbo].[ComBoSP] OFF
GO
SET IDENTITY_INSERT [dbo].[DongSP] ON 

GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (20, N'DSP0001', 21, N'Sữa bột Similac', N'KHÔNG', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (21, N'DSP0002', 24, N'Sữa bột Nutren', N'KHÔNG', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (22, N'DSP0003', 25, N'Trà cốm hoa quả Burine', N'KHÔNG', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (23, N'DSP0004', 22, N'Sữa Hikid ', N'KHÔNG', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (24, N'DSP0005', 23, N'Sữa Frisomum Gold', N'KHÔNG', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (25, N'DSP0006', 21, N'Dielac Grow', N'KHÔNG', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (26, N'MILO', 24, N'Milo', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (27, N'GROW', 26, N'Abbott_Grow', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (28, N'FAMI', 27, N'Fami', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (29, N'MEIJI', 28, N'Meiji', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (30, N'NAN_OPTI_PRO', 24, N'Nan Opti Pro', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (31, N'ORGANIC', 21, N'Organic', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (32, N'INFANT_FORMULA_EZCUBE', 28, N'Infant Formula EZcube', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (33, N'TO_YEN', 21, N'Sữa tươi tiệt trùng tổ yến', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (34, N'TIET_TRUNG_100%', 21, N'Sữa tươi tiệt trùng 100%', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (35, N'PEDIASURE', 26, N'PediaSure', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (36, N'ENFAGROW_A+', 29, N'Enfagrow A+', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (37, N'GREEN_FARM', 21, N'Green Farm', N'', 1)
GO
SET IDENTITY_INSERT [dbo].[DongSP] OFF
GO
SET IDENTITY_INSERT [dbo].[DonViTinh] ON 

GO
INSERT [dbo].[DonViTinh] ([IDDonViTinh], [MaDVT], [TenDVT]) VALUES (10, N'DVT0001', N'HỘP')
GO
INSERT [dbo].[DonViTinh] ([IDDonViTinh], [MaDVT], [TenDVT]) VALUES (11, N'DVT0002', N'LỐC')
GO
INSERT [dbo].[DonViTinh] ([IDDonViTinh], [MaDVT], [TenDVT]) VALUES (12, N'DVT0003', N'THÙNG')
GO
INSERT [dbo].[DonViTinh] ([IDDonViTinh], [MaDVT], [TenDVT]) VALUES (13, N'DVT0004', N'DÂY')
GO
INSERT [dbo].[DonViTinh] ([IDDonViTinh], [MaDVT], [TenDVT]) VALUES (14, N'DVT0005', N'COMBO')
GO
SET IDENTITY_INSERT [dbo].[DonViTinh] OFF
GO
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] ON 

GO
INSERT [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan], [MaHinhThucThanhToan], [TenHinhThucThanhToan], [GhiChu]) VALUES (7, N'HT0001', N'Tiền mặt', N'KHÔNG')
GO
INSERT [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan], [MaHinhThucThanhToan], [TenHinhThucThanhToan], [GhiChu]) VALUES (8, N'HT0002', N'Thẻ ngân hàng', N'KHÔNG')
GO
INSERT [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan], [MaHinhThucThanhToan], [TenHinhThucThanhToan], [GhiChu]) VALUES (9, N'HT0003', N'Ví điện tử', NULL)
GO
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (35001, N'HD00001', 17, 2101, 7, CAST(N'2021-11-25 20:30:00.000' AS DateTime), 500000.0000, N'không', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (36001, N'HD00002', 16, NULL, 8, CAST(N'2021-11-25 00:00:00.000' AS DateTime), 1500000.0000, N'không', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (37001, N'HD00003', 17, 1501, 7, CAST(N'2021-11-25 00:00:00.000' AS DateTime), 600000.0000, N'không', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (38001, N'HD00004', 18, 1701, 7, CAST(N'2021-11-25 00:00:00.000' AS DateTime), 800000.0000, N'không', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (39001, N'HD00005', 19, 1801, 7, CAST(N'2021-11-25 00:00:00.000' AS DateTime), 1200000.0000, N'không', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (40001, N'HD6', 16, 1501, 7, CAST(N'2021-11-25 00:00:00.000' AS DateTime), 5300000.0000, N'', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (51001, N'HD7', 16, 1501, 7, CAST(N'2021-11-26 23:09:10.730' AS DateTime), 400000.0000, N'', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (57001, N'HD8', 16, NULL, 7, CAST(N'2021-11-26 23:30:21.767' AS DateTime), 200000.0000, N'', N'Chờ thanh toán')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (58001, N'HD9', 16, NULL, 7, CAST(N'2021-11-27 22:06:51.253' AS DateTime), 100000.0000, N'', N'Hóa đơn hủy khi chờ')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (59001, N'HD10', 16, NULL, 7, CAST(N'2021-11-29 16:41:01.717' AS DateTime), 224000.0000, N'', N'Hóa đơn hủy khi chờ')
GO
INSERT [dbo].[HoaDon] ([IDHoaDon], [MaHD], [IDNhanVien], [IDTheTV], [IDHinhThucThanhToan], [NgayLap], [TongTien], [GhiChu], [TrangThai]) VALUES (60001, N'HD11', 16, NULL, 7, CAST(N'2021-11-29 21:15:13.537' AS DateTime), 2100000.0000, N'', N'Chờ thanh toán')
GO
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[KhoiLuong] ON 

GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (15, N'KL0001', N'180ML')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (16, N'KL0002', N'150ML')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (17, N'KL0003', N'300G')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (18, N'KL0004', N'960ML')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (19, N'KL0005', N'600G')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (20, N'KL0006', N'400G')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (21, N'KL0007', N'1,2KG')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (22, N'KL0008', N'800G')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (23, N'ML110', N'110ml')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (24, N'G900', N'900g')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (25, N'L1', N'1L')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (26, N'G850', N'850g')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (27, N'G830', N'830g')
GO
SET IDENTITY_INSERT [dbo].[KhoiLuong] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiHang] ON 

GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (18, N'LH001', 13, N'Sữa cho bà bầu', N'KHÔNG')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (19, N'LH002', 14, N'Sữa tươi cho mọi lứa tuổi', N'KHÔNG')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (20, N'LH003', 13, N'Sữa cho trẻ sơ sinh', N'KHÔNG')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (21, N'LH004', 13, N'Sữa cho người cao tuổi', N'KHÔNG')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (22, N'LH005', 15, N'Thực phẩm cho trẻ suy dinh dưỡng', N'KHÔNG')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (23, N'LH006', 13, N'Sữa bột cho trẻ em', N'')
GO
SET IDENTITY_INSERT [dbo].[LoaiHang] OFF
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (16, N'NV0001', N'dainnph13993', 0xAB43F95455355E70471490A408C71D8B65860FB4AF608A4188F7B3A191BA12224F6F57F8E80121D0E7807726963D23DBD700036B35B0BB1C4F5D39E8FEC8BC07, N'Nguyễn Ngọc Đại', 1, CAST(N'2002-06-11' AS Date), N'0986280623', N'125932074', N'dainnph13993@fpt.edu.vn', N'default.png', 1, N'1', 1, N'ef034674-e369-4887-911f-3cf409584f95')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (17, N'NV0002', N'thongvhph13968', 0x4309EB237B14B66EC44CBAB9540622F26F85F289F757D161677F4A46D76D8073EB14B3E0E17983677BF453C149D00B9484E57885D50959FEE5D184F5BDF5CBA5, N'Võ Hữu Thông', 1, CAST(N'1999-10-12' AS Date), N'0368443774', N'125932074', N'thongvhph13968@fpt.edu.vn', N'default.jpg', 1, N'1', 1, N'0686d306-eedb-4857-aa8c-5cf891a907df')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (18, N'NV0003', N'quochung13972', 0xDB0F37D63F70A5FA5FC8D52390995C6003A063E7429450DD4AADD75B6CE28F42B92EA2554D618C34746AAEA4A761715950C876A0302944A4D23E1A130CCC4437, N'Nguyễn Quốc Hùng', 1, CAST(N'2002-07-10' AS Date), N'0328452319', N'125932074', N'hungnqph13922@fpt.edu.vn', N'default.png', 0, N'0', 1, N'f2c88f53-e690-439a-90d3-831c3939365b')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (19, N'NV0004', N'thuthaott13942', 0x078F01A3824AAEE8B79A69972C1B0DB6D19CC3B6C9D0F9369F41412C5ED6B30A1D646FBE7B245239B070D65AA0C264BE4F3FF9CFFBFB71D6693369E9EBD46D48, N'Trần Thị Thu Thảo', 0, CAST(N'1999-08-08' AS Date), N'0986280144', N'125932074', N'Thaotttph13959@fpt.edu.vn', N'default.jpg', 0, N'Founder', 1, N'a9d70f31-3941-4419-93a8-950ef1aded1f')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (20, N'NV0005', N'vanvh13957', 0x15E06A3DB378500DE17501D7EDDA23B7AE7C2BF4BBDAE074E76378DD16295DF3A79632771AB4079C49CC01B478C77253ABE665B2F65562DFD6B9A75D773621E9, N'Vi Hoàng Vân', 1, CAST(N'2002-03-03' AS Date), N'0986283525', N'125932074', N'vanvhph13971@fpt.edu.vn', N'default.jpg', 0, N'Founder', 1, N'b45eb6ae-abfc-4ed0-b328-55a88fb46f5c')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (21, N'anhnt00005', N'anhnt00005', 0xB5960F329AC33740F151E30497630AA08511B67AF5506A831C3F2EE48F7918296C12DA21BE62811A7B54815B0061891A2080E41A9C26B27213AD75100D433805, N'Ngô Tú Anh', 0, CAST(N'2002-11-07' AS Date), N'0123456789', N'123456789', N'anhnt@gmail.com', NULL, 0, N'', 1, N'290bcc07-63c9-49f7-8fd3-6f7d278b178c')
GO
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[NhomHang] ON 

GO
INSERT [dbo].[NhomHang] ([IDNhomHang], [MaNhom], [TenNhom], [GhiChu]) VALUES (13, N'NH001', N'Sữa bột', N'KHÔNG')
GO
INSERT [dbo].[NhomHang] ([IDNhomHang], [MaNhom], [TenNhom], [GhiChu]) VALUES (14, N'NH002', N'Sữa tươi', N'KHÔNG')
GO
INSERT [dbo].[NhomHang] ([IDNhomHang], [MaNhom], [TenNhom], [GhiChu]) VALUES (15, N'NH003', N'Thực phẩm chức năng', N'KHÔNG')
GO
SET IDENTITY_INSERT [dbo].[NhomHang] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (16001, N'SP10000', 23, 35, N'Sữa bột PediaSure BA', CAST(N'2021-10-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (17001, N'SP10001', 19, 34, N'Sữa Vinamilk 100% Có đường', CAST(N'2021-10-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (18001, N'SP10002', 20, 29, N'Sữa bột Meiji số 0', CAST(N'2021-10-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (19001, N'SP10003', 23, 21, N'Similac 5G số 4', CAST(N'2021-10-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (20001, N'SP10004', 20, 30, N'Sữa Nan Opti Pro số 1', CAST(N'2021-10-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (21001, N'SP10005', 19, 31, N'Sữa tươi 100% Organic', CAST(N'2021-10-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (22001, N'SP10006', 19, 27, N'Abbot_grow', CAST(N'2021-10-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (23001, N'SP10007', 20, 32, N'Infant Formula EZcube', CAST(N'2021-09-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (24001, N'SP10008', 23, 23, N'Sữa Hikid vị Vani 600g', CAST(N'2021-09-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (25001, N'SP10009', 19, 33, N'Sữa tươi tiệt trùng tổ yến', CAST(N'2021-09-15' AS Date), N'KHÔNG', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (26001, N'MILO', 19, 26, N'Milo ActiveGo', CAST(N'2021-11-23' AS Date), N'', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (27001, N'Enfagrow_A+_NeuroPro', 23, 36, N'Sữa Enfagrow A+ NeuroPro', CAST(N'2021-11-30' AS Date), N'', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (28001, N'SP10010', 19, 34, N'Vinamilk 100% Ít Đường', CAST(N'2021-12-02' AS Date), N'', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (29001, N'SP10011', 19, 34, N'Vinamilk 100% Không đường ', CAST(N'2021-12-02' AS Date), N'', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (30001, N'SP10012', 19, 37, N'Green Farm ít đường', CAST(N'2021-12-02' AS Date), N'', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (31001, N'SP10013', 19, 37, N'Green Farm có đường', CAST(N'2021-12-02' AS Date), N'', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (32001, N'SP10014', 23, 21, N'Sữa bột Nutren Junior New', CAST(N'2021-12-02' AS Date), N'', 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (33001, N'SP10015', 20, 20, N'Similac 5G số 1', CAST(N'2021-12-02' AS Date), N'', 1)
GO
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[TheThanhVien] ON 

GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (1501, N'MTV00001', N'Trần Huyền Trang', 1, CAST(N'2000-10-10' AS Date), N'0324562541', N'187823366', N'hohangxa@gmail.com', N'default.png', 0, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), NULL)
GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (1601, N'MTV00002', N'Hoàng Trung Hải', 1, CAST(N'1998-08-11' AS Date), N'0324569327', N'187824257', N'matcachan@gmail.com', N'none', 0, CAST(N'2021-06-10' AS Date), CAST(N'2022-06-10' AS Date), N'Không')
GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (1701, N'MTV00003', N'Nam Thiên Môn', 1, CAST(N'1995-11-03' AS Date), N'0324565735', N'187827921', N'ngogiatu@gmail.com', N'none', 0, CAST(N'2020-02-12' AS Date), CAST(N'2022-02-12' AS Date), N'Không')
GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (1801, N'MTV00004', N'Hoàng Dược Sư', 1, CAST(N'1997-09-12' AS Date), N'0324562494', N'187824113', N'chimmoi@gmail.com', N'default.png', 0, CAST(N'2019-03-03' AS Date), CAST(N'2022-03-03' AS Date), NULL)
GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (1901, N'MTV00005', N'Trịnh Khắc Phục', 1, CAST(N'2001-12-12' AS Date), N'0324563579', N'187822594', N'quadeongang@gmail.com', N'none', 0, CAST(N'2020-05-05' AS Date), CAST(N'2022-05-05' AS Date), N'Không')
GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (2001, N'MTV00006', N'Ngô hoàng Nam', 1, CAST(N'2000-04-06' AS Date), N'0324560261', N'187823113', N'nhatkytrongtu@gmail.com', N'none', 0, CAST(N'2021-03-12' AS Date), CAST(N'2022-03-12' AS Date), N'Không')
GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (2101, N'MTV00007', N'Trần thị Hải Yến', 0, CAST(N'1994-05-06' AS Date), N'0324563519', N'187822792', N'chieutoi@gmail.com', N'none', 0, CAST(N'2021-10-10' AS Date), CAST(N'2022-10-10' AS Date), N'Không')
GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [Diem], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (2301, N'MTV00008', N'hihi', 1, CAST(N'1994-05-06' AS Date), N'0324563519', N'187822792', N'chieutoi@gmail.com', N'HinhAnh', 0, CAST(N'2021-10-10' AS Date), CAST(N'2022-10-31' AS Date), NULL)
GO
SET IDENTITY_INSERT [dbo].[TheThanhVien] OFF
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] ON 

GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (21, N'TH10000', N'Vinamilk', N'KHÔNG', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (22, N'TH10001', N'TH true milk', N'KHÔNG', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (23, N'TH10002', N'Dutch Lady', N'KHÔNG', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (24, N'TH10003', N'Nestle', N'KHÔNG', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (25, N'TH10004', N'Nutifood', N'KHÔNG', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (26, N'Abbott', N'Abbott', N'', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (27, N'Fami', N'Fami', N'', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (28, N'Meiji', N'Meji', N'', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (29, N'Mead_Johnson ', N'Mead Johnson ', N'', 1)
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF
GO
SET IDENTITY_INSERT [dbo].[XuatXu] ON 

GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (15, N'QG001', N'Việt Nam')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (16, N'QG002', N'New Zealand')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (17, N'QG003', N'Nhật Bản')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (18, N'QG004', N'Mỹ')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (19, N'QG005', N'Úc')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (20, N'QG006', N'Singapore')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (21, N'QG007', N'Hà Lan')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (22, N'QG008', N'Đức')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (23, N'QG009', N'Ireland')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (24, N'QG010', N'Hàn Quốc')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (25, N'THAILAND', N'Thái Lan')
GO
SET IDENTITY_INSERT [dbo].[XuatXu] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_MaAnhSP_AnhSP]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[AnhSP] ADD  CONSTRAINT [UK_MaAnhSP_AnhSP] UNIQUE NONCLUSTERED 
(
	[MaAnhSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ChiTietSanPham]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[ChiTietSanPham] ADD  CONSTRAINT [IX_ChiTietSanPham] UNIQUE NONCLUSTERED 
(
	[BarCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DongSP]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[DongSP] ADD  CONSTRAINT [IX_DongSP] UNIQUE NONCLUSTERED 
(
	[MaDongSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DonViTinh]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[DonViTinh] ADD  CONSTRAINT [IX_DonViTinh] UNIQUE NONCLUSTERED 
(
	[MaDVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_HoaDon]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [IX_HoaDon] UNIQUE NONCLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_KhoiLuong]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[KhoiLuong] ADD  CONSTRAINT [IX_KhoiLuong] UNIQUE NONCLUSTERED 
(
	[MaKhoiLuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_KhuyenMai]    Script Date: 02/12/2021 5:56:52 CH ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_KhuyenMai] ON [dbo].[KhuyenMai]
(
	[MaKM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_LoaiHang]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[LoaiHang] ADD  CONSTRAINT [IX_LoaiHang] UNIQUE NONCLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NhanVien]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [IX_NhanVien] UNIQUE NONCLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NhanVien_1]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [IX_NhanVien_1] UNIQUE NONCLUSTERED 
(
	[TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NhomHang]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[NhomHang] ADD  CONSTRAINT [IX_NhomHang] UNIQUE NONCLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SanPham]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[SanPham] ADD  CONSTRAINT [IX_SanPham] UNIQUE NONCLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_TheThanhVien]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[TheThanhVien] ADD  CONSTRAINT [IX_TheThanhVien] UNIQUE NONCLUSTERED 
(
	[MaTheTV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ThuongHieu]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[ThuongHieu] ADD  CONSTRAINT [IX_ThuongHieu] UNIQUE NONCLUSTERED 
(
	[MaTH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_XuatXu]    Script Date: 02/12/2021 5:56:52 CH ******/
ALTER TABLE [dbo].[XuatXu] ADD  CONSTRAINT [IX_XuatXu] UNIQUE NONCLUSTERED 
(
	[MaQG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietComboSP]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietComboSP_ChiTietSanPham] FOREIGN KEY([IDChiTietSP])
REFERENCES [dbo].[ChiTietSanPham] ([IDChiTietSP])
GO
ALTER TABLE [dbo].[ChiTietComboSP] CHECK CONSTRAINT [FK_ChiTietComboSP_ChiTietSanPham]
GO
ALTER TABLE [dbo].[ChiTietComboSP]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietComboSP_ComBoSP] FOREIGN KEY([IDComboSP])
REFERENCES [dbo].[ComBoSP] ([IDComboSP])
GO
ALTER TABLE [dbo].[ChiTietComboSP] CHECK CONSTRAINT [FK_ChiTietComboSP_ComBoSP]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_ChiTietSanPham] FOREIGN KEY([IDChiTietSP])
REFERENCES [dbo].[ChiTietSanPham] ([IDChiTietSP])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_ChiTietSanPham]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_HoaDon] FOREIGN KEY([IDHoaDon])
REFERENCES [dbo].[HoaDon] ([IDHoaDon])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_HoaDon]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_AnhSP] FOREIGN KEY([IDAnhSP])
REFERENCES [dbo].[AnhSP] ([IDAnhSP])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_AnhSP]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_DonViTinh] FOREIGN KEY([IDDonViTinh])
REFERENCES [dbo].[DonViTinh] ([IDDonViTinh])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_DonViTinh]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_KhoiLuong] FOREIGN KEY([IDKhoiLuong])
REFERENCES [dbo].[KhoiLuong] ([IDKhoiLuong])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_KhoiLuong]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_SanPham] FOREIGN KEY([IDSanPham])
REFERENCES [dbo].[SanPham] ([IDSanPham])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_SanPham]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_XuatXu] FOREIGN KEY([IDXuatXu])
REFERENCES [dbo].[XuatXu] ([IDXuatXu])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_XuatXu]
GO
ALTER TABLE [dbo].[DongSP]  WITH CHECK ADD  CONSTRAINT [FK_DongSP_ThuongHieu] FOREIGN KEY([IDThuongHieu])
REFERENCES [dbo].[ThuongHieu] ([IDThuongHieu])
GO
ALTER TABLE [dbo].[DongSP] CHECK CONSTRAINT [FK_DongSP_ThuongHieu]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_HinhThucThanhToan] FOREIGN KEY([IDHinhThucThanhToan])
REFERENCES [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_HinhThucThanhToan]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([IDNhanVien])
REFERENCES [dbo].[NhanVien] ([IDNhanVien])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_TheThanhVien] FOREIGN KEY([IDTheTV])
REFERENCES [dbo].[TheThanhVien] ([IDTheTV])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_TheThanhVien]
GO
ALTER TABLE [dbo].[KhuyenMai]  WITH CHECK ADD  CONSTRAINT [FK_KhuyenMai_DongSP] FOREIGN KEY([IDDongSP])
REFERENCES [dbo].[DongSP] ([IDDongSP])
GO
ALTER TABLE [dbo].[KhuyenMai] CHECK CONSTRAINT [FK_KhuyenMai_DongSP]
GO
ALTER TABLE [dbo].[KhuyenMai]  WITH CHECK ADD  CONSTRAINT [FK_KhuyenMai_SanPham] FOREIGN KEY([IDSanPham])
REFERENCES [dbo].[SanPham] ([IDSanPham])
GO
ALTER TABLE [dbo].[KhuyenMai] CHECK CONSTRAINT [FK_KhuyenMai_SanPham]
GO
ALTER TABLE [dbo].[LoaiHang]  WITH CHECK ADD  CONSTRAINT [FK_LoaiHang_NhomHang] FOREIGN KEY([IDNhomHang])
REFERENCES [dbo].[NhomHang] ([IDNhomHang])
GO
ALTER TABLE [dbo].[LoaiHang] CHECK CONSTRAINT [FK_LoaiHang_NhomHang]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_DongSP] FOREIGN KEY([IDDongSP])
REFERENCES [dbo].[DongSP] ([IDDongSP])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_DongSP]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_LoaiHang] FOREIGN KEY([IDLoaiSP])
REFERENCES [dbo].[LoaiHang] ([IDLoaiHang])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_LoaiHang]
GO
USE [master]
GO
ALTER DATABASE [MilkyWay] SET  READ_WRITE 
GO
