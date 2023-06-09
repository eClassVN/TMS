USE [TMS]
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BangGia]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BangGia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaHopDong] [varchar](20) NOT NULL,
	[MaPTVC] [varchar](10) NOT NULL,
	[MaCungDuong] [varchar](10) NOT NULL,
	[MaLoaiPhuongTien] [varchar](10) NOT NULL,
	[DonGia] [decimal](18, 2) NOT NULL,
	[MaDVT] [varchar](10) NOT NULL,
	[MaLoaiHangHoa] [varchar](10) NOT NULL,
	[MaLoaiDoiTac] [varchar](10) NOT NULL,
	[NgayApDung] [datetime2](7) NOT NULL,
	[NgayHetHieuLuc] [datetime2](7) NOT NULL,
	[TrangThai] [int] NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[DeletedTime] [datetime2](7) NULL,
 CONSTRAINT [PK_BangGia] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BangGiaDacBiet]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BangQuyDoi]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BangQuyDoi](
	[MaQuyDoi] [int] NOT NULL,
	[LoaiHangCanQuyDOi] [varchar](50) NOT NULL,
	[MaDTV] [varchar](50) NOT NULL,
	[CongThucQuyDoi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ThongTin_BangQuyDoi] PRIMARY KEY CLUSTERED 
(
	[MaQuyDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CungDuong]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaDiem]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaDiem](
	[MaDiaDiem] [int] IDENTITY(1,1) NOT NULL,
	[TenDiaDiem] [nvarchar](50) NOT NULL,
	[MaQuocGia] [int] NULL,
	[MaTinh] [int] NOT NULL,
	[MaHuyen] [int] NOT NULL,
	[MaPhuong] [int] NOT NULL,
	[SoNha] [nvarchar](100) NULL,
	[DiaChiDayDu] [nvarchar](250) NOT NULL,
	[MaGPS] [varchar](50) NULL,
	[MaLoaiDiaDiem] [varchar](50) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DanhMucDiaDiem] PRIMARY KEY CLUSTERED 
(
	[MaDiaDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DieuPhoi]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DieuPhoi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaVanDon] [varchar](10) NOT NULL,
	[MaSoXe] [varchar](10) NOT NULL,
	[MaTaiXe] [varchar](12) NOT NULL,
	[IDBangGia] [int] NOT NULL,
	[MaRomooc] [varchar](50) NULL,
	[SEAL_NP] [varchar](50) NULL,
	[Cont_No] [varchar](50) NULL,
	[SEAL_HQ] [varchar](50) NULL,
	[TrongLuong] [float] NULL,
	[TheTich] [float] NULL,
 CONSTRAINT [PK_DieuPhoi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonViTinh]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonViTinh](
	[MaDVT] [varchar](10) NOT NULL,
	[TenDVT] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_DVT] PRIMARY KEY CLUSTERED 
(
	[MaDVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HopDongVaPhuLuc]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDongVaPhuLuc](
	[MaHopDong] [varchar](20) NOT NULL,
	[MaHopDongCha] [varchar](20) NULL,
	[TenHienThi] [nvarchar](50) NOT NULL,
	[MaKH] [varchar](8) NOT NULL,
	[MaLoaiHopDong] [varchar](10) NOT NULL,
	[ThoiGianBatDau] [date] NOT NULL,
	[ThoiGianKetThuc] [date] NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[MaPhuPhi] [varchar](10) NULL,
	[TrangThai] [int] NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ThongTin_HopDongVaPhuLuc] PRIMARY KEY CLUSTERED 
(
	[MaHopDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiDiaDiem]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiDiaDiem](
	[MaLoaiDiaDiem] [varchar](50) NOT NULL,
	[TenPhanLoaiDiaDiem] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DanhMuc_LoaiDiaDiem] PRIMARY KEY CLUSTERED 
(
	[MaLoaiDiaDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHangHoa]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHangHoa](
	[MaLoaiHangHoa] [varchar](10) NOT NULL,
	[TenLoaiHangHoa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_HangHoa] PRIMARY KEY CLUSTERED 
(
	[MaLoaiHangHoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHopDong]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHopDong](
	[MaLoaiHopDong] [varchar](10) NOT NULL,
	[TenLoaiHopDong] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LoaiHopDong] PRIMARY KEY CLUSTERED 
(
	[MaLoaiHopDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiKhachHang]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiKhachHang](
	[MaLoaiKH] [varchar](10) NOT NULL,
	[TenLoaiKH] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LoaiKhachHang] PRIMARY KEY CLUSTERED 
(
	[MaLoaiKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPhuongTien]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPhuongTien](
	[MaLoaiPhuongTien] [varchar](10) NOT NULL,
	[TenLoaiPhuongTien] [nvarchar](50) NOT NULL,
	[PhanLoai] [varchar](10) NOT NULL,
 CONSTRAINT [PK_PhanLoai_PhuongTien] PRIMARY KEY CLUSTERED 
(
	[MaLoaiPhuongTien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPhuPhi]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPhuPhi](
	[MaLoaiPhuPhi] [varchar](10) NOT NULL,
	[TenLoaiPhuPhi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoai_PhuPhi] PRIMARY KEY CLUSTERED 
(
	[MaLoaiPhuPhi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiRomooc]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiRomooc](
	[MaLoaiRomooc] [varchar](50) NOT NULL,
	[TenLoaiRomooc] [nvarchar](50) NOT NULL,
	[UpdatedTime] [datetime2](7) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PhanLoai_Romooc] PRIMARY KEY CLUSTERED 
(
	[MaLoaiRomooc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [varchar](50) NOT NULL,
	[Message] [text] NOT NULL,
	[LogTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhomKhachHang]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomKhachHang](
	[MaNhomKH] [varchar](10) NOT NULL,
	[TenNhomKH] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NhomKhachHang] PRIMARY KEY CLUSTERED 
(
	[MaNhomKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhuongThucVanChuyen]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhuongThucVanChuyen](
	[MaPTVC] [varchar](10) NOT NULL,
	[TenPTVC] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HinhThucVanChuyen] PRIMARY KEY CLUSTERED 
(
	[MaPTVC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuanHuyen]    Script Date: 08/10/2022 4:44:38 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuocGia]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuocGia](
	[MaQuocGia] [int] NOT NULL,
	[TenQuocGia] [nvarchar](50) NOT NULL,
	[Code] [varchar](50) NULL,
 CONSTRAINT [PK_DiaChi_QuocGia] PRIMARY KEY CLUSTERED 
(
	[MaQuocGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Romooc]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusText]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusText](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LangID] [varchar](3) NOT NULL,
	[StatusID] [varchar](10) NOT NULL,
	[StatusContent] [nvarchar](30) NOT NULL,
	[FunctionID] [varchar](30) NOT NULL,
 CONSTRAINT [PK_LoaiTrangThai] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubFee]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubFee](
	[subFeeID] [bigint] IDENTITY(1,1) NOT NULL,
	[sfName] [nvarchar](50) NOT NULL,
	[sfType] [tinyint] NOT NULL,
	[sfState] [tinyint] NOT NULL,
	[creator] [varchar](20) NOT NULL,
	[sfDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_SubFee] PRIMARY KEY CLUSTERED 
(
	[subFeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubFeePrice]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubFeePrice](
	[priceID] [bigint] IDENTITY(1,1) NOT NULL,
	[contractID] [varchar](20) NULL,
	[sfID] [bigint] NOT NULL,
	[goodsType] [tinyint] NULL,
	[firstPlace] [int] NULL,
	[secondPlace] [int] NULL,
	[unitPrice] [float] NOT NULL,
	[sfStateByContract] [tinyint] NOT NULL,
	[description] [nvarchar](max) NULL,
	[approver] [varchar](20) NULL,
	[creator] [varchar](20) NOT NULL,
	[approvedDate] [datetime2](7) NULL,
	[deactiveDate] [datetime2](7) NULL,
 CONSTRAINT [PK_SubFeePrice] PRIMARY KEY CLUSTERED 
(
	[priceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiXe]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongBao]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TinhThanh]    Script Date: 08/10/2022 4:44:38 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VanDon]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VanDon](
	[MaVanDon] [varchar](10) NOT NULL,
	[MaKH] [varchar](8) NOT NULL,
	[DiemLayHang] [int] NOT NULL,
	[DiemNhapHang] [int] NOT NULL,
	[DiemGioHang] [int] NOT NULL,
	[DiemTraRong] [int] NOT NULL,
	[ThoiGianLayRong] [datetime2](7) NULL,
	[ThoiGianHaCong] [datetime2](7) NOT NULL,
	[ThoiGianKeoCong] [datetime2](7) NULL,
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XaPhuong]    Script Date: 08/10/2022 4:44:38 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XeVanChuyen]    Script Date: 08/10/2022 4:44:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SubFee] ADD  CONSTRAINT [DF_SubFee_sfState]  DEFAULT ((1)) FOR [sfState]
GO
ALTER TABLE [dbo].[SubFeePrice] ADD  CONSTRAINT [DF_SubFeePrice_sfStateByContract]  DEFAULT ((1)) FOR [sfStateByContract]
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
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaDiem_QuanHuyen] FOREIGN KEY([MaHuyen])
REFERENCES [dbo].[QuanHuyen] ([MaHuyen])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaDiem_QuanHuyen]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaDiem_QuocGia] FOREIGN KEY([MaQuocGia])
REFERENCES [dbo].[QuocGia] ([MaQuocGia])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaDiem_QuocGia]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaDiem_TinhThanh] FOREIGN KEY([MaTinh])
REFERENCES [dbo].[TinhThanh] ([MaTinh])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaDiem_TinhThanh]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaDiem_XaPhuong] FOREIGN KEY([MaPhuong])
REFERENCES [dbo].[XaPhuong] ([MaPhuong])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaDiem_XaPhuong]
GO
ALTER TABLE [dbo].[DieuPhoi]  WITH CHECK ADD  CONSTRAINT [FK_DieuPhoi_BangGia] FOREIGN KEY([IDBangGia])
REFERENCES [dbo].[BangGia] ([ID])
GO
ALTER TABLE [dbo].[DieuPhoi] CHECK CONSTRAINT [FK_DieuPhoi_BangGia]
GO
ALTER TABLE [dbo].[DieuPhoi]  WITH CHECK ADD  CONSTRAINT [FK_DieuPhoi_Romooc] FOREIGN KEY([MaRomooc])
REFERENCES [dbo].[Romooc] ([MaRomooc])
GO
ALTER TABLE [dbo].[DieuPhoi] CHECK CONSTRAINT [FK_DieuPhoi_Romooc]
GO
ALTER TABLE [dbo].[DieuPhoi]  WITH CHECK ADD  CONSTRAINT [FK_DieuPhoi_TaiXe] FOREIGN KEY([MaTaiXe])
REFERENCES [dbo].[TaiXe] ([MaTaiXe])
GO
ALTER TABLE [dbo].[DieuPhoi] CHECK CONSTRAINT [FK_DieuPhoi_TaiXe]
GO
ALTER TABLE [dbo].[DieuPhoi]  WITH CHECK ADD  CONSTRAINT [FK_DieuPhoi_VanDon] FOREIGN KEY([MaVanDon])
REFERENCES [dbo].[VanDon] ([MaVanDon])
GO
ALTER TABLE [dbo].[DieuPhoi] CHECK CONSTRAINT [FK_DieuPhoi_VanDon]
GO
ALTER TABLE [dbo].[DieuPhoi]  WITH CHECK ADD  CONSTRAINT [FK_DieuPhoi_XeVanChuyen] FOREIGN KEY([MaSoXe])
REFERENCES [dbo].[XeVanChuyen] ([MaSoXe])
GO
ALTER TABLE [dbo].[DieuPhoi] CHECK CONSTRAINT [FK_DieuPhoi_XeVanChuyen]
GO
ALTER TABLE [dbo].[HopDongVaPhuLuc]  WITH CHECK ADD  CONSTRAINT [FK_HopDongVaPhuLuc_HopDongVaPhuLuc] FOREIGN KEY([MaHopDongCha])
REFERENCES [dbo].[HopDongVaPhuLuc] ([MaHopDong])
GO
ALTER TABLE [dbo].[HopDongVaPhuLuc] CHECK CONSTRAINT [FK_HopDongVaPhuLuc_HopDongVaPhuLuc]
GO
ALTER TABLE [dbo].[HopDongVaPhuLuc]  WITH CHECK ADD  CONSTRAINT [FK_HopDongVaPhuLuc_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HopDongVaPhuLuc] CHECK CONSTRAINT [FK_HopDongVaPhuLuc_KhachHang]
GO
ALTER TABLE [dbo].[Romooc]  WITH CHECK ADD  CONSTRAINT [FK_ThongTin_Romooc_PhanLoai_Romooc] FOREIGN KEY([MaLoaiRomooc])
REFERENCES [dbo].[LoaiRomooc] ([MaLoaiRomooc])
GO
ALTER TABLE [dbo].[Romooc] CHECK CONSTRAINT [FK_ThongTin_Romooc_PhanLoai_Romooc]
GO
ALTER TABLE [dbo].[SubFeePrice]  WITH CHECK ADD  CONSTRAINT [FK_SubFeePrice_SubFee] FOREIGN KEY([sfID])
REFERENCES [dbo].[SubFee] ([subFeeID])
GO
ALTER TABLE [dbo].[SubFeePrice] CHECK CONSTRAINT [FK_SubFeePrice_SubFee]
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
ALTER TABLE [dbo].[XeVanChuyen]  WITH CHECK ADD  CONSTRAINT [FK_ThongTin_XeVanChuyen_ThongTin_TaiXe] FOREIGN KEY([MaTaiXeMacDinh])
REFERENCES [dbo].[TaiXe] ([MaTaiXe])
GO
ALTER TABLE [dbo].[XeVanChuyen] CHECK CONSTRAINT [FK_ThongTin_XeVanChuyen_ThongTin_TaiXe]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: deactivated, 1: create new, 2: approved, 3: deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SubFee', @level2type=N'COLUMN',@level2name=N'sfState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'if the sub-fee is collected on road, need two place; is collected at a place need one place; independent to place  then 2 place-fields are null ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SubFeePrice', @level2type=N'COLUMN',@level2name=N'firstPlace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: deactivated, 1: create new, 2: approved, 3: deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SubFeePrice', @level2type=N'COLUMN',@level2name=N'sfStateByContract'
GO
