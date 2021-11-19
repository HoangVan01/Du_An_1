USE [master]
GO
/****** Object:  Database [MilkyWay]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DangNhap]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DoiMatKhau]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_InsertAllSanPham]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectAllSanPham]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectAllSanPhamByID]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ThemNhanVien]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[AnhSP]    Script Date: 20/11/2021 2:22:47 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AnhSP](
	[IDAnhSP] [int] IDENTITY(1,1) NOT NULL,
	[MaAnhSP] [varchar](50) NOT NULL,
	[TenAnhSP] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AnhSP] PRIMARY KEY CLUSTERED 
(
	[IDAnhSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[ChiTietSanPham]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[DongSP]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[DonViTinh]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[HinhThucThanhToan]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[HoaDon]    Script Date: 20/11/2021 2:22:47 SA ******/
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
	[NgayLap] [date] NOT NULL,
	[TongTien] [money] NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[TrangThai] [bit] NOT NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[IDHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoiLuong]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[LoaiHang]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[NhanVien]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[NhomHang]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[SanPham]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[TheThanhVien]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[ThuongHieu]    Script Date: 20/11/2021 2:22:47 SA ******/
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
/****** Object:  Table [dbo].[XuatXu]    Script Date: 20/11/2021 2:22:47 SA ******/
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
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (2, N'SIMILAC5G4900', N'similac5g4900.jpg')
GO
INSERT [dbo].[AnhSP] ([IDAnhSP], [MaAnhSP], [TenAnhSP]) VALUES (3, N'MEIJI0800G', N'meiji0800g.jpg')
GO
SET IDENTITY_INSERT [dbo].[AnhSP] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietSanPham] ON 

GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (1, 2001, CAST(N'2025-11-18' AS Date), 15, CAST(480000.00 AS Decimal(18, 2)), 5, 4, 2, 2, N'5391523059534')
GO
INSERT [dbo].[ChiTietSanPham] ([IDChiTietSP], [IDSanPham], [HanSD], [SoLuongTon], [DonGia], [IDXuatXu], [IDKhoiLuong], [IDDonViTinh], [IDAnhSP], [BarCode]) VALUES (2, 4001, CAST(N'2025-11-20' AS Date), 5, CAST(549000.00 AS Decimal(18, 2)), 2, 5, 2, 3, N'4902705116542')
GO
SET IDENTITY_INSERT [dbo].[ChiTietSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[DongSP] ON 

GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (1, N'MILO', 4, N'Milo', N'Good', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (2, N'SIMILAC', 8, N'Similac', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (3, N'PEDIASURE', 8, N'Pediasure', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (5, N'NANOPTIPRO', 4, N'Nan Optipro', N'', 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (7, N'DIELAC', 1, N'Dielac', NULL, 1)
GO
INSERT [dbo].[DongSP] ([IDDongSP], [MaDongSP], [IDThuongHieu], [TenDongSP], [GhiChu], [TrangThai]) VALUES (8, N'MEIJI', 15, N'Meiji', N'', 1)
GO
SET IDENTITY_INSERT [dbo].[DongSP] OFF
GO
SET IDENTITY_INSERT [dbo].[DonViTinh] ON 

GO
INSERT [dbo].[DonViTinh] ([IDDonViTinh], [MaDVT], [TenDVT]) VALUES (1, N'PAPER_BOX', N'Hộp')
GO
INSERT [dbo].[DonViTinh] ([IDDonViTinh], [MaDVT], [TenDVT]) VALUES (2, N'CAN', N'Lon')
GO
SET IDENTITY_INSERT [dbo].[DonViTinh] OFF
GO
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] ON 

GO
INSERT [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan], [MaHinhThucThanhToan], [TenHinhThucThanhToan], [GhiChu]) VALUES (1, N'CASH', N'Tiền mặt', NULL)
GO
INSERT [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan], [MaHinhThucThanhToan], [TenHinhThucThanhToan], [GhiChu]) VALUES (2, N'MOMO', N'Ví điện tử', NULL)
GO
INSERT [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan], [MaHinhThucThanhToan], [TenHinhThucThanhToan], [GhiChu]) VALUES (3, N'ATM', N'Thẻ ngân hàng', NULL)
GO
INSERT [dbo].[HinhThucThanhToan] ([IDHinhThucThanhToan], [MaHinhThucThanhToan], [TenHinhThucThanhToan], [GhiChu]) VALUES (4, N'VISA', N'Thẻ Visa/Mastercard', NULL)
GO
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] OFF
GO
SET IDENTITY_INSERT [dbo].[KhoiLuong] ON 

GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (1, N'ML200', N'200ml')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (2, N'ML180', N'180ml')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (3, N'ML100', N'100ml')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (4, N'G900', N'900g')
GO
INSERT [dbo].[KhoiLuong] ([IDKhoiLuong], [MaKhoiLuong], [GiaTri]) VALUES (5, N'G800', N'800g')
GO
SET IDENTITY_INSERT [dbo].[KhoiLuong] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiHang] ON 

GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (1, N'INFANT', 1, N'Sữa cho trẻ sơ sinh', N'Sữa dạng bột')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (2, N'CHILD_POWDER', 1, N'Sữa bột cho trẻ', N'Từ 5 tuổi trở xuống')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (3, N'CHILD_WATER', 2, N'Sữa nước cho trẻ', N'Từ 5 tuổi trở xuống')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (4, N'OLD_POWDER', 1, N'Sữa bột cho tuổi già', N'Từ 60 tuổi trở lên')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (5, N'OLD_WATER', 2, N'Sữa nước cho tuổi già', N'Từ 60 tuổi trở lên')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (6, N'COMMON_WATER', 2, N'Sữa nước bình dân', N'Từ 1 tuổi trở lên')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (7, N'hihi', 2, N'hihi', N'hihi')
GO
INSERT [dbo].[LoaiHang] ([IDLoaiHang], [MaLoai], [IDNhomHang], [TenLoai], [GhiChu]) VALUES (8, N'haha', 1, N'haha', N'lala')
GO
SET IDENTITY_INSERT [dbo].[LoaiHang] OFF
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (1, N'NV01', N'dainnph13993', 0xF9B6000F9D750D78521C77888E5D53C6AF8A807A45463385379D7E6E02F792C0EF76CC344666A666C705D491D9C3332B1563163A20468EB97C8500DD84C614CD, N'Nguyễn Ngọc Đại', 1, CAST(N'2002-06-13' AS Date), N'0986280623', N'125932074', N'dainnph13993@gmail.com', N'NV01.jpg', 1, N'1', 1, N'e9f5b049-dcd6-4626-ad83-e518534cf494')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (2, N'NV02', N'thongboss', 0x4B2E244331534ED1D4E0C0FCA1C9DF26F000F6C52D6DB349B17B5FB228B72882E7A4E7DCA5C8015B4AC1CFCF63052E77913F1658C15795E58A219DE96075DAC1, N'Võ Hữu Thông', 1, CAST(N'2002-06-13' AS Date), N'0986280623', N'125932074', N'dainnph13993@gmail.com', N'default.png', 1, N'1', 1, N'acefa9ad-a57d-437c-bb7a-2c787e4d9b2c')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (3, N'NV03', N'vanvh', 0x1A48BD3930E7968A94C5B49888D10057AFD8695A12E2713BE6E826E0B3B339B3D807FAFBEF4AF736B057B15A4D49545F695113E1381C5F21AE51FFC4106750CD, N'Van', 1, CAST(N'2021-11-01' AS Date), N'123', N'123', N'van@gnail.com', NULL, 0, N'', 1, N'0e4596ce-7cdb-4a35-b5d8-2cfc0b142f73')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (4, N'NV04', N'thaottt', 0xA7C4A1E00D40EA4D0CECFAEF1FF0AD88659C28F6AEEE80C8589EBB95C6700F96D4B031DE77528ED8F228BFD65975825512F91372E648CF9E7BE17759D08EFACC, N'Van', 1, CAST(N'2021-11-01' AS Date), N'123', N'123', N'van@gnail.com', NULL, 0, N'1', 1, N'1ac9c763-fd3d-4d73-8536-7d65ed0e7108')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [MaNV], [TaiKhoan], [MatKhau], [HoTen], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [VaiTro], [GhiChu], [TrangThai], [Salt]) VALUES (5, N'NV05', N'thaottt2', 0x9135A6494BFB8B3B196A5C9E0B7A4921BC1EEF6185971E99EFF099543C1042F4A6BCE18F748FAB77BA3BD8BFCD2E96FC846244FDCC27402F58FF673FB481ADF7, N'Thao', 0, CAST(N'2021-11-01' AS Date), N'0123456789', N'0123456789', N'thao@gmail.com', NULL, 0, N'', 1, N'e474150a-c299-46b6-9887-3fa655da1ed4')
GO
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[NhomHang] ON 

GO
INSERT [dbo].[NhomHang] ([IDNhomHang], [MaNhom], [TenNhom], [GhiChu]) VALUES (1, N'POWDERED', N'Sữa bột', N'None')
GO
INSERT [dbo].[NhomHang] ([IDNhomHang], [MaNhom], [TenNhom], [GhiChu]) VALUES (2, N'LIQUID', N'Sữa nước', N'None')
GO
INSERT [dbo].[NhomHang] ([IDNhomHang], [MaNhom], [TenNhom], [GhiChu]) VALUES (3, N'CONDENSED', N'Sữa đặc', N'None')
GO
INSERT [dbo].[NhomHang] ([IDNhomHang], [MaNhom], [TenNhom], [GhiChu]) VALUES (4, N'YOGURT', N'Sữa chua', N'None')
GO
SET IDENTITY_INSERT [dbo].[NhomHang] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (2001, N'SIMILAC4', 2, 2, N'Sữa bột Similac 5G số 4 900g (cho bé 2-6 tuổi)', CAST(N'2021-11-17' AS Date), NULL, 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (3001, N'GROWPLUS', 6, 7, N'Sữa Uống Dinh Dưỡng Dielac Grow Plus', CAST(N'2021-11-17' AS Date), NULL, 1)
GO
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [IDLoaiSP], [IDDongSP], [TenSP], [NgayXK], [GhiChu], [TrangThai]) VALUES (4001, N'MEIJI0', 1, 8, N'Sữa bột Meiji số 0 nội địa Nhật 800g cho bé 0-12M', CAST(N'2021-11-20' AS Date), N'', 1)
GO
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[TheThanhVien] ON 

GO
INSERT [dbo].[TheThanhVien] ([IDTheTV], [MaTheTV], [TenKH], [GioiTinh], [NgaySinh], [SDT], [CMND], [Email], [HinhAnh], [NgayTao], [NgayHetHan], [GhiChu]) VALUES (1, N'KH01', N'abc', 1, CAST(N'2021-11-01' AS Date), N'1231', N'123', N'hihi', NULL, CAST(N'2021-11-15' AS Date), CAST(N'2022-11-15' AS Date), NULL)
GO
SET IDENTITY_INSERT [dbo].[TheThanhVien] OFF
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] ON 

GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (1, N'VNM', N'Vinamilk', N'Good', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (2, N'THM', N'TH True Milk', N'Well', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (3, N'DL', N'Dutch Lady', NULL, 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (4, N'NSL', N'Nestle', N'Great', 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (5, N'NTF', N'Nutifood', NULL, 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (6, N'FM', N'Fami', NULL, 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (7, N'MC', N'Mộc Châu', NULL, 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (8, N'AB', N'Abbort', NULL, 1)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (9, N'hihi', N'hihi', N'hii', 0)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (11, N'hihi1', N'hihi', N'lala', 0)
GO
INSERT [dbo].[ThuongHieu] ([IDThuongHieu], [MaTH], [TenTH], [GhiChu], [TrangThai]) VALUES (15, N'MJ', N'Meiji', N'', 1)
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF
GO
SET IDENTITY_INSERT [dbo].[XuatXu] ON 

GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (1, N'VN', N'Việt Nam')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (2, N'JP', N'Nhật Bản')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (3, N'SZ', N'Thụy Sĩ')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (4, N'US', N'Hoa Kỳ')
GO
INSERT [dbo].[XuatXu] ([IDXuatXu], [MaQG], [TenQG]) VALUES (5, N'IC', N'Iceland')
GO
SET IDENTITY_INSERT [dbo].[XuatXu] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_MaAnhSP_AnhSP]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[AnhSP] ADD  CONSTRAINT [UK_MaAnhSP_AnhSP] UNIQUE NONCLUSTERED 
(
	[MaAnhSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DongSP]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[DongSP] ADD  CONSTRAINT [IX_DongSP] UNIQUE NONCLUSTERED 
(
	[MaDongSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DonViTinh]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[DonViTinh] ADD  CONSTRAINT [IX_DonViTinh] UNIQUE NONCLUSTERED 
(
	[MaDVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_HoaDon]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [IX_HoaDon] UNIQUE NONCLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_KhoiLuong]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[KhoiLuong] ADD  CONSTRAINT [IX_KhoiLuong] UNIQUE NONCLUSTERED 
(
	[MaKhoiLuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_LoaiHang]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[LoaiHang] ADD  CONSTRAINT [IX_LoaiHang] UNIQUE NONCLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NhanVien]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [IX_NhanVien] UNIQUE NONCLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NhanVien_1]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [IX_NhanVien_1] UNIQUE NONCLUSTERED 
(
	[TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NhomHang]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[NhomHang] ADD  CONSTRAINT [IX_NhomHang] UNIQUE NONCLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SanPham]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[SanPham] ADD  CONSTRAINT [IX_SanPham] UNIQUE NONCLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_TheThanhVien]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[TheThanhVien] ADD  CONSTRAINT [IX_TheThanhVien] UNIQUE NONCLUSTERED 
(
	[MaTheTV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ThuongHieu]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[ThuongHieu] ADD  CONSTRAINT [IX_ThuongHieu] UNIQUE NONCLUSTERED 
(
	[MaTH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_XuatXu]    Script Date: 20/11/2021 2:22:47 SA ******/
ALTER TABLE [dbo].[XuatXu] ADD  CONSTRAINT [IX_XuatXu] UNIQUE NONCLUSTERED 
(
	[MaQG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_NgayLap]  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_TrangThai]  DEFAULT ((1)) FOR [TrangThai]
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
