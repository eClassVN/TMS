USE [TMS]
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Attachment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](200) NOT NULL,
	[FolderName] [varchar](50) NOT NULL,
	[FilePath] [varchar](200) NOT NULL,
	[FileType] [varchar](5) NOT NULL,
	[FileSize] [bigint] NOT NULL,
 CONSTRAINT [PK_Attachment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BangGia]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BangGia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaHopDong] [varchar](10) NOT NULL,
	[MaPTVC] [varchar](10) NOT NULL,
	[MaCungDuong] [varchar](10) NOT NULL,
	[MaLoaiPhuongTien] [varchar](10) NOT NULL,
	[DonGia] [decimal](18, 2) NOT NULL,
	[MaDVT] [varchar](10) NOT NULL,
	[MaLoaiHangHoa] [varchar](10) NOT NULL,
	[MaLoaiHopDong] [varchar](10) NOT NULL,
	[NgayApDung] [datetime2](7) NOT NULL,
	[TrangThai] [int] NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_BangGia] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BangGiaDacBiet]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BangGiaDacBiet](
	[MaBangGiaDB] [varchar](10) NOT NULL,
	[TenBangGiaDB] [nvarchar](50) NOT NULL,
	[Tan] [float] NULL,
	[Khoi] [float] NULL,
	[SoLuong] [float] NULL,
	[KM] [float] NULL,
	[HeSo] [float] NULL,
 CONSTRAINT [PK_ThongTin_BangGiaDacBiet] PRIMARY KEY CLUSTERED 
(
	[MaBangGiaDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BangQuyDoi]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BangQuyDoi](
	[MaQuyDoi] [int] NOT NULL,
	[LoaiHangCanQuyDOi] [varchar](50) NOT NULL,
	[MaDTV] [varchar](50) NOT NULL,
	[CongThucQuyDoi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ThongTin_BangQuyDoi] PRIMARY KEY CLUSTERED 
(
	[MaQuyDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CungDuong]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CungDuong](
	[MaCungDuong] [varchar](10) NOT NULL,
	[TenCungDuong] [nvarchar](50) NOT NULL,
	[MaHopDong] [varchar](10) NOT NULL,
	[Km] [float] NOT NULL,
	[DiemDau] [int] NOT NULL,
	[DiemCuoi] [int] NOT NULL,
	[DiemLayRong] [int] NULL,
	[GhiChu] [nvarchar](500) NOT NULL,
	[TrangThai] [int] NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_CungDuong] PRIMARY KEY CLUSTERED 
(
	[MaCungDuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DiaDiem]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DiaDiem](
	[MaDiaDiem] [int] IDENTITY(1,1) NOT NULL,
	[TenDiaDiem] [nvarchar](50) NOT NULL,
	[MaQuocGia] [int] NULL,
	[MaTinh] [int] NOT NULL,
	[MaHuyen] [int] NOT NULL,
	[MaPhuong] [int] NOT NULL,
	[SoNha] [nvarchar](100) NOT NULL,
	[DiaChiDayDu] [nvarchar](250) NOT NULL,
	[MaGPS] [varchar](50) NULL,
	[MaLoaiDiaDiem] [varchar](50) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DanhMucDiaDiem] PRIMARY KEY CLUSTERED 
(
	[MaDiaDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DonViTinh]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DonViTinh](
	[MaDVT] [varchar](10) NOT NULL,
	[TenDVT] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_DVT] PRIMARY KEY CLUSTERED 
(
	[MaDVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DonViVanTai]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DonViVanTai](
	[MaDonViVanTai] [varchar](10) NOT NULL,
	[TenDonViVanTai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_DonViVanTai] PRIMARY KEY CLUSTERED 
(
	[MaDonViVanTai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HopDongVaPhuLuc]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HopDongVaPhuLuc](
	[MaHopDong] [varchar](10) NOT NULL,
	[SoHopDongCha] [varchar](10) NULL,
	[TenHienThi] [nvarchar](50) NOT NULL,
	[MaKH] [varchar](8) NOT NULL,
	[MaPTVC] [varchar](10) NOT NULL,
	[MaLoaiHopDong] [varchar](10) NOT NULL,
	[ThoiGianBatDau] [date] NOT NULL,
	[ThoiGianKetThuc] [date] NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[PhuPhi] [decimal](18, 2) NULL,
	[TrangThai] [int] NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_HopDongVaPhuLuc] PRIMARY KEY CLUSTERED 
(
	[MaHopDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [varchar](8) NOT NULL,
	[TenKH] [nvarchar](50) NOT NULL,
	[MaSoThue] [varchar](50) NOT NULL,
	[SDT] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[MaNhomKH] [varchar](10) NOT NULL,
	[MaLoaiKH] [varchar](10) NOT NULL,
	[MaDiaDiem] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTinNguoiBan] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiDiaDiem]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiDiaDiem](
	[MaLoaiDiaDiem] [varchar](50) NOT NULL,
	[TenPhanLoaiDiaDiem] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DanhMuc_LoaiDiaDiem] PRIMARY KEY CLUSTERED 
(
	[MaLoaiDiaDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiHangHoa]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiHangHoa](
	[MaLoaiHangHoa] [varchar](10) NOT NULL,
	[TenLoaiHangHoa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_HangHoa] PRIMARY KEY CLUSTERED 
(
	[MaLoaiHangHoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiHopDong]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiHopDong](
	[MaLoaiHopDong] [varchar](10) NOT NULL,
	[TenLoaiHopDong] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LoaiHopDong] PRIMARY KEY CLUSTERED 
(
	[MaLoaiHopDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiKhachHang]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiKhachHang](
	[MaLoaiKH] [varchar](10) NOT NULL,
	[TenLoaiKH] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LoaiKhachHang] PRIMARY KEY CLUSTERED 
(
	[MaLoaiKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiPhuongTien]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiPhuongTien](
	[MaLoaiPhuongTien] [varchar](10) NOT NULL,
	[TenLoaiPhuongTien] [nvarchar](50) NOT NULL,
	[PhanLoai] [varchar](10) NOT NULL,
 CONSTRAINT [PK_PhanLoai_PhuongTien] PRIMARY KEY CLUSTERED 
(
	[MaLoaiPhuongTien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiPhuPhi]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiPhuPhi](
	[MaLoaiPhuPhi] [varchar](10) NOT NULL,
	[TenLoaiPhuPhi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_PhuPhi] PRIMARY KEY CLUSTERED 
(
	[MaLoaiPhuPhi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiRomooc]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiRomooc](
	[MaLoaiRomooc] [varchar](50) NOT NULL,
	[TenLoaiRomooc] [nvarchar](50) NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PhanLoai_Romooc] PRIMARY KEY CLUSTERED 
(
	[MaLoaiRomooc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiThungHang]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiThungHang](
	[MaLoaiThungHang] [varchar](10) NOT NULL,
	[TenLoaiThungHang] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_Container] PRIMARY KEY CLUSTERED 
(
	[MaLoaiThungHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiTrangThai]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiTrangThai](
	[MaTrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TenTrangThai] [nvarchar](50) NOT NULL,
	[PhanLoai] [varchar](10) NOT NULL,
 CONSTRAINT [PK_LoaiTrangThai] PRIMARY KEY CLUSTERED 
(
	[MaTrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [varchar](50) NOT NULL,
	[Message] [text] NOT NULL,
	[LogTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhomKhachHang]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhomKhachHang](
	[MaNhomKH] [varchar](10) NOT NULL,
	[TenNhomKH] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NhomKhachHang] PRIMARY KEY CLUSTERED 
(
	[MaNhomKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhuongThucVanChuyen]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhuongThucVanChuyen](
	[MaPTVC] [varchar](10) NOT NULL,
	[TenPTVC] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HinhThucVanChuyen] PRIMARY KEY CLUSTERED 
(
	[MaPTVC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhuPhi]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhuPhi](
	[MaPhuPhi] [varchar](10) NOT NULL,
	[MaLoaiPhuPhi] [varchar](10) NOT NULL,
	[NgayHieuLuc] [datetime2](7) NOT NULL,
	[NgayHetHan] [datetime2](7) NOT NULL,
	[GiaUSD] [decimal](18, 2) NOT NULL,
	[GiaVND] [decimal](18, 2) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[MaCungDuong] [varchar](10) NOT NULL,
	[MaLoaiHangHoa] [varchar](10) NOT NULL,
	[MaPTVC] [varchar](10) NOT NULL,
	[TrangThai] [int] NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_PhuPhi] PRIMARY KEY CLUSTERED 
(
	[MaPhuPhi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuanHuyen]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanHuyen](
	[MaHuyen] [int] NOT NULL,
	[TenHuyen] [nvarchar](50) NOT NULL,
	[PhanLoai] [nvarchar](50) NOT NULL,
	[ParentCode] [int] NOT NULL,
 CONSTRAINT [PK_DiaChi_QuanHuyen] PRIMARY KEY CLUSTERED 
(
	[MaHuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuocGia]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuocGia](
	[MaQuocGia] [int] NOT NULL,
	[TenQuocGia] [nvarchar](50) NOT NULL,
	[Code] [varchar](50) NULL,
 CONSTRAINT [PK_DiaChi_QuocGia] PRIMARY KEY CLUSTERED 
(
	[MaQuocGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Romooc]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Romooc](
	[MaRomooc] [varchar](50) NOT NULL,
	[KetCauSan] [nvarchar](50) NOT NULL,
	[SoGuRomooc] [varchar](50) NOT NULL,
	[ThongSoKyThuat] [nvarchar](50) NOT NULL,
	[MaLoaiRomooc] [varchar](50) NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_Romooc] PRIMARY KEY CLUSTERED 
(
	[MaRomooc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaiXe]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaiXe](
	[MaTaiXe] [varchar](12) NOT NULL,
	[CCCD] [varchar](12) NOT NULL,
	[HoVaTen] [nvarchar](50) NOT NULL,
	[SoDienThoai] [varchar](12) NOT NULL,
	[NgaySinh] [date] NULL,
	[GhiChu] [text] NULL,
	[MaKH] [varchar](8) NULL,
	[LoaiXe] [varchar](50) NULL,
	[TaiXeTBS] [bit] NOT NULL,
	[TrangThai] [int] NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_TaiXe] PRIMARY KEY CLUSTERED 
(
	[MaTaiXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ThongBao]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ThongBao](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LangID] [varchar](3) NOT NULL,
	[TextID] [int] NOT NULL,
	[TextContent] [nvarchar](100) NOT NULL,
	[TextType] [varchar](15) NOT NULL,
	[FunctionID] [varchar](30) NOT NULL,
 CONSTRAINT [PK_ThongBao] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TinhThanh]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhThanh](
	[MaTinh] [int] NOT NULL,
	[TenTinh] [nvarchar](50) NOT NULL,
	[PhanLoai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DiaChi_TinhThanh] PRIMARY KEY CLUSTERED 
(
	[MaTinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VanDon]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VanDon](
	[MaVanDon] [varchar](10) NOT NULL,
	[MaKH] [varchar](8) NOT NULL,
	[MaSoXe] [varchar](10) NOT NULL,
	[MaTaiXe] [varchar](12) NOT NULL,
	[MaRomooc] [varchar](50) NULL,
	[MaPTVC] [varchar](10) NOT NULL,
	[Booking] [varchar](50) NULL,
	[CLP_No] [varchar](50) NULL,
	[Cont_No] [varchar](50) NULL,
	[SEAL_HT] [varchar](50) NULL,
	[SEAL_HQ] [varchar](50) NULL,
	[MaLoaiThungHang] [varchar](10) NOT NULL,
	[MaDonViVanTai] [varchar](10) NOT NULL,
	[MaLoaiHangHoa] [varchar](10) NOT NULL,
	[TrongLuong] [float] NOT NULL,
	[TheTich] [float] NOT NULL,
	[MaDVT] [int] NOT NULL,
	[DiemLayRong] [int] NOT NULL,
	[DiemLayHang] [int] NOT NULL,
	[DiemNhapHang] [int] NOT NULL,
	[DiemGioHang] [int] NOT NULL,
	[DiemTraRong] [int] NOT NULL,
	[ThoiGianLayRong] [datetime2](7) NULL,
	[ThoiGianHaCong] [datetime2](7) NULL,
	[ThoiGianHanLech] [int] NOT NULL,
	[ThoiGianCoMat] [datetime2](7) NOT NULL,
	[ThoiGianCatMang] [datetime2](7) NULL,
	[ThoiGianTraRong] [datetime2](7) NOT NULL,
	[HangTau] [nvarchar](50) NULL,
	[Tau] [nvarchar](50) NULL,
	[CangChuyenTai] [nvarchar](50) NULL,
	[CangDich] [nvarchar](50) NULL,
	[TrangThai] [int] NOT NULL,
	[NgayTaoDon] [datetime2](7) NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_VanDon] PRIMARY KEY CLUSTERED 
(
	[MaVanDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[XaPhuong]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XaPhuong](
	[MaPhuong] [int] NOT NULL,
	[TenPhuong] [nvarchar](50) NOT NULL,
	[PhanLoai] [nvarchar](50) NOT NULL,
	[ParentCode] [int] NOT NULL,
 CONSTRAINT [PK_DiaChi_XaPhuong] PRIMARY KEY CLUSTERED 
(
	[MaPhuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[XeVanChuyen]    Script Date: 22/09/2022 2:02:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XeVanChuyen](
	[MaSoXe] [varchar](10) NOT NULL,
	[MaNhaCungCap] [varchar](10) NULL,
	[MaLoaiPhuongTien] [varchar](10) NOT NULL,
	[MaTaiXeMacDinh] [varchar](12) NOT NULL,
	[TrongTaiToiThieu] [float] NOT NULL,
	[TrongTaiToiDa] [float] NOT NULL,
	[MaGPS] [varchar](50) NOT NULL,
	[MaGPSMobile] [varchar](50) NOT NULL,
	[LoaiVanHanh] [nvarchar](50) NOT NULL,
	[MaTaiSan] [varchar](50) NULL,
	[ThoiGianKhauHao] [int] NULL,
	[NgayHoatDong] [date] NULL,
	[TrangThai] [int] NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_XeVanChuyen] PRIMARY KEY CLUSTERED 
(
	[MaSoXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[BangGia]  WITH CHECK ADD  CONSTRAINT [FK_BangGia_CungDuong] FOREIGN KEY([MaCungDuong])
REFERENCES [dbo].[CungDuong] ([MaCungDuong])
GO
ALTER TABLE [dbo].[BangGia] CHECK CONSTRAINT [FK_BangGia_CungDuong]
GO
ALTER TABLE [dbo].[BangGia]  WITH CHECK ADD  CONSTRAINT [FK_BangGia_HopDongVaPhuLuc] FOREIGN KEY([MaHopDong])
REFERENCES [dbo].[HopDongVaPhuLuc] ([MaHopDong])
GO
ALTER TABLE [dbo].[BangGia] CHECK CONSTRAINT [FK_BangGia_HopDongVaPhuLuc]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DanhMuc_DiaDiem_DanhMuc_LoaiDiaDiem] FOREIGN KEY([MaLoaiDiaDiem])
REFERENCES [dbo].[LoaiDiaDiem] ([MaLoaiDiaDiem])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DanhMuc_DiaDiem_DanhMuc_LoaiDiaDiem]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_QuanHuyen] FOREIGN KEY([MaHuyen])
REFERENCES [dbo].[QuanHuyen] ([MaHuyen])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_QuanHuyen]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_QuocGia] FOREIGN KEY([MaQuocGia])
REFERENCES [dbo].[QuocGia] ([MaQuocGia])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_QuocGia]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_TinhThanh] FOREIGN KEY([MaTinh])
REFERENCES [dbo].[TinhThanh] ([MaTinh])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_TinhThanh]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_XaPhuong] FOREIGN KEY([MaPhuong])
REFERENCES [dbo].[XaPhuong] ([MaPhuong])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaChi_DanhMucDiaDiem_DiaChi_XaPhuong]
GO
ALTER TABLE [dbo].[HopDongVaPhuLuc]  WITH CHECK ADD  CONSTRAINT [FK_HopDongVaPhuLuc_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HopDongVaPhuLuc] CHECK CONSTRAINT [FK_HopDongVaPhuLuc_KhachHang]
GO
ALTER TABLE [dbo].[PhuPhi]  WITH CHECK ADD  CONSTRAINT [FK_PhuPhi_CungDuong] FOREIGN KEY([MaCungDuong])
REFERENCES [dbo].[CungDuong] ([MaCungDuong])
GO
ALTER TABLE [dbo].[PhuPhi] CHECK CONSTRAINT [FK_PhuPhi_CungDuong]
GO
ALTER TABLE [dbo].[Romooc]  WITH CHECK ADD  CONSTRAINT [FK_ThongTin_Romooc_PhanLoai_Romooc] FOREIGN KEY([MaLoaiRomooc])
REFERENCES [dbo].[LoaiRomooc] ([MaLoaiRomooc])
GO
ALTER TABLE [dbo].[Romooc] CHECK CONSTRAINT [FK_ThongTin_Romooc_PhanLoai_Romooc]
GO
ALTER TABLE [dbo].[TaiXe]  WITH CHECK ADD  CONSTRAINT [FK_TaiXe_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[TaiXe] CHECK CONSTRAINT [FK_TaiXe_KhachHang]
GO
ALTER TABLE [dbo].[VanDon]  WITH CHECK ADD  CONSTRAINT [FK_ThongTin_VanDonXuatNhap_ThongTin_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[VanDon] CHECK CONSTRAINT [FK_ThongTin_VanDonXuatNhap_ThongTin_KhachHang]
GO
ALTER TABLE [dbo].[VanDon]  WITH CHECK ADD  CONSTRAINT [FK_VanDon_Romooc] FOREIGN KEY([MaRomooc])
REFERENCES [dbo].[Romooc] ([MaRomooc])
GO
ALTER TABLE [dbo].[VanDon] CHECK CONSTRAINT [FK_VanDon_Romooc]
GO
ALTER TABLE [dbo].[VanDon]  WITH CHECK ADD  CONSTRAINT [FK_VanDon_TaiXe] FOREIGN KEY([MaTaiXe])
REFERENCES [dbo].[TaiXe] ([MaTaiXe])
GO
ALTER TABLE [dbo].[VanDon] CHECK CONSTRAINT [FK_VanDon_TaiXe]
GO
ALTER TABLE [dbo].[VanDon]  WITH CHECK ADD  CONSTRAINT [FK_VanDon_XeVanChuyen] FOREIGN KEY([MaSoXe])
REFERENCES [dbo].[XeVanChuyen] ([MaSoXe])
GO
ALTER TABLE [dbo].[VanDon] CHECK CONSTRAINT [FK_VanDon_XeVanChuyen]
GO
ALTER TABLE [dbo].[XeVanChuyen]  WITH CHECK ADD  CONSTRAINT [FK_ThongTin_XeVanChuyen_ThongTin_TaiXe] FOREIGN KEY([MaTaiXeMacDinh])
REFERENCES [dbo].[TaiXe] ([MaTaiXe])
GO
ALTER TABLE [dbo].[XeVanChuyen] CHECK CONSTRAINT [FK_ThongTin_XeVanChuyen_ThongTin_TaiXe]
GO
