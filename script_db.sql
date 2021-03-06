USE [master]
GO
/****** Object:  Database [QLNVQTS]    Script Date: 12/06/2022 20:39:25 ******/
CREATE DATABASE [QLNVQTS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLNVQTS', FILENAME = N'D:\SQL2019\MSSQL15.MSSQLSERVER\MSSQL\DATA\QLNVQTS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLNVQTS_log', FILENAME = N'D:\SQL2019\MSSQL15.MSSQLSERVER\MSSQL\DATA\QLNVQTS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QLNVQTS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLNVQTS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLNVQTS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLNVQTS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLNVQTS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLNVQTS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLNVQTS] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLNVQTS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLNVQTS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLNVQTS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLNVQTS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLNVQTS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLNVQTS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLNVQTS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLNVQTS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLNVQTS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLNVQTS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLNVQTS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLNVQTS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLNVQTS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLNVQTS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLNVQTS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLNVQTS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLNVQTS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLNVQTS] SET RECOVERY FULL 
GO
ALTER DATABASE [QLNVQTS] SET  MULTI_USER 
GO
ALTER DATABASE [QLNVQTS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLNVQTS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLNVQTS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLNVQTS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLNVQTS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLNVQTS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLNVQTS', N'ON'
GO
ALTER DATABASE [QLNVQTS] SET QUERY_STORE = OFF
GO
USE [QLNVQTS]
GO
/****** Object:  Table [dbo].[TimeTable]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeTable](
	[id_time_table] [int] IDENTITY(1,1) NOT NULL,
	[id_shift] [int] NOT NULL,
	[date] [date] NOT NULL,
	[id_emp] [nchar](10) NOT NULL,
	[id_emp_alter] [nchar](10) NULL,
	[description] [text] NULL,
 CONSTRAINT [PK__TimeTabl__6FF851074ADE6613] PRIMARY KEY CLUSTERED 
(
	[id_shift] ASC,
	[date] ASC,
	[id_emp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_get_emp_of_shift]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[udf_get_emp_of_shift] (@date date, @id_shift int)
returns table
as
return (select * from TimeTable
	where date=@date AND id_shift=@id_shift)
GO
/****** Object:  Table [dbo].[Salary]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salary](
	[id_salary] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
	[id_emp] [nchar](10) NOT NULL,
	[salary] [money] NOT NULL,
	[note] [nvarchar](500) NULL,
 CONSTRAINT [PK__Salary__B595575E412D0DDE] PRIMARY KEY CLUSTERED 
(
	[date] ASC,
	[id_emp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_get_year_start]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_get_year_start]
as
select year_start=min(year(date))
from Salary
GO
/****** Object:  Table [dbo].[Shift]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift](
	[id_shift] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](15) NOT NULL,
	[time_start] [time](7) NOT NULL,
	[time_end] [time](7) NOT NULL,
	[basic_salary] [money] NOT NULL,
	[num_of_emp] [int] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK__Shift__E6B9EDA63A45C5E6] PRIMARY KEY CLUSTERED 
(
	[id_shift] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_get_shift_now]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[v_get_shift_now]
as
select *
from Shift where deleted='false' AND convert(time, getdate()) >= time_start and convert(time, getdate()) <= time_end
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[id] [nchar](10) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[enable] [bit] NULL,
	[id_role] [int] NULL,
 CONSTRAINT [PK__Account__3213E83FDCF9DF9E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Constants]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Constants](
	[date_start] [date] NOT NULL,
 CONSTRAINT [PK_constant] PRIMARY KEY CLUSTERED 
(
	[date_start] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id_emp] [nchar](10) NOT NULL,
	[first_name] [nvarchar](30) NOT NULL,
	[last_name] [nvarchar](10) NOT NULL,
	[active] [bit] NULL,
	[id_position] [int] NOT NULL,
	[phone] [varchar](12) NULL,
	[address] [nvarchar](50) NULL,
	[birthday] [date] NULL,
	[gender] [smallint] NOT NULL,
 CONSTRAINT [PK__Employee__D52A94EFEF2554A8] PRIMARY KEY CLUSTERED 
(
	[id_emp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Evaluate]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evaluate](
	[id_evaluate] [int] IDENTITY(1,1) NOT NULL,
	[id_time_table] [int] NOT NULL,
	[id_fault] [int] NOT NULL,
	[id_manager] [nchar](10) NOT NULL,
	[num] [int] NOT NULL,
 CONSTRAINT [PK__Evaluate__212FC68A389B5CBF] PRIMARY KEY CLUSTERED 
(
	[id_time_table] ASC,
	[id_fault] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fault]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fault](
	[id_fault] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](50) NULL,
	[percent_of_salary] [float] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK__Fault__6268C48E2B9B0CC0] PRIMARY KEY CLUSTERED 
(
	[id_fault] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[id_position] [int] IDENTITY(1,1) NOT NULL,
	[position_name] [nvarchar](20) NULL,
	[coefficient] [float] NOT NULL,
	[deleted] [bit] NOT NULL,
	[description] [text] NULL,
	[is_fulltime] [bit] NOT NULL,
 CONSTRAINT [PK__Role__3D48441D46060A2E] PRIMARY KEY CLUSTERED 
(
	[id_position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id_role] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[id_task] [int] IDENTITY(1,1) NOT NULL,
	[job] [nvarchar](50) NOT NULL,
	[description] [nvarchar](200) NULL,
	[id_manager] [nchar](10) NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK__Task__C1D2C61768BF915E] PRIMARY KEY CLUSTERED 
(
	[id_task] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UpTasks]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UpTasks](
	[id_up_task] [int] IDENTITY(1,1) NOT NULL,
	[id_shift] [int] NOT NULL,
	[date] [date] NOT NULL,
	[id_task] [int] NOT NULL,
	[id_manager] [nchar](10) NOT NULL,
 CONSTRAINT [PK__UpTasks__62CEAA34654F53A6] PRIMARY KEY CLUSTERED 
(
	[id_shift] ASC,
	[date] ASC,
	[id_task] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Work]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Work](
	[id_work] [int] IDENTITY(1,1) NOT NULL,
	[id_time_table] [int] NOT NULL,
	[id_up_task] [int] NOT NULL,
 CONSTRAINT [PK_Work] PRIMARY KEY CLUSTERED 
(
	[id_time_table] ASC,
	[id_up_task] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'Admin     ', N'$2a$10$NX7azHOsiOMrOFcWU9UlNu2k50M4z.W.1AG2bMvuXDzi/l4xTDWHK', 1, 1)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV01      ', N'$2a$10$hBK7SjfX5PeXUGk3RfejjuZTR445eYNmxZg1sumq0Odk/BzIpWR9m', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV02      ', N'$2a$10$k66dWs2PopjlRZWwSd7HU.PNQIxJqbY9sZ2mp88VbWCjOjJmRFT76', 1, 2)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV03      ', N'$2a$10$k66dWs2PopjlRZWwSd7HU.PNQIxJqbY9sZ2mp88VbWCjOjJmRFT76', 0, 2)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV04      ', N'$2a$10$k66dWs2PopjlRZWwSd7HU.PNQIxJqbY9sZ2mp88VbWCjOjJmRFT76', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV05      ', N'$2a$10$VtChjnVSMOptdxWQrLvhXeDbOWVE6UfmF/eTZIWQfRhotXJkkT/5.', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV06      ', N'$2a$10$nrXA37MZQ2JmGN9gJYOF7eofGE8jVNb5ODLWH/r95/HDSGoqFZp3K', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV07      ', N'$2a$10$pHki2oSBmMl5eNn6dBgAEOD/gt7.TnFVWHw5K0duljRezlyjGMvMm', 0, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV08      ', N'$2a$10$qQPCXQO9LEiqusyYUZLs8u7eeobsECDpTUu.AmxdMv5xaP4YvnUHy', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV09      ', N'$2a$10$rbbKFyh6/P34hATYPb6VseFOk0wx9lqjOhOnuuVo7SPKdTj38WIHW', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV10      ', N'$2a$10$wcBsrx4NIrqcaOLQAUxZG.Q5P4GncT0z9h9zIACnpYMnDxCWZhocK', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV11      ', N'$2a$10$ADYnZJtpAx8cOB0Wnooj9.Fl4ddFX3lw7OR144v/5dMshIwEd.wBS', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV12      ', N'$2a$10$35MTWr6QnFFRjnDbgoVapeHAsn.1b4t8WTL2G0b6KqtG1DLkAV6cW', 1, 3)
INSERT [dbo].[Account] ([id], [password], [enable], [id_role]) VALUES (N'NV13      ', N'$2a$10$p21IY/Xpsi9kKvLxmPUg/eEVb8.zy8AVBf2JCj6hOgCglXqo5Uctq', 1, 3)
GO
INSERT [dbo].[Constants] ([date_start]) VALUES (CAST(N'2022-04-04' AS Date))
INSERT [dbo].[Constants] ([date_start]) VALUES (CAST(N'2022-05-16' AS Date))
GO
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'Admin     ', N'Admin', N'Admin', 1, 6, N'0365338185', N'TP Thủ Đức, TP. HCM', CAST(N'2004-04-26' AS Date), 0)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV01      ', N'Phạm Văn', N'Thuận', 1, 4, N'0365338185', N'Tỉnh Bình Thuận', CAST(N'2004-06-01' AS Date), 1)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV02      ', N'Nguyễn Phạm Nhật', N'Minh', 1, 1, N'0123456789', NULL, CAST(N'1999-02-26' AS Date), 1)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV03      ', N'Lê Mậu Anh', N'Đức', 0, 1, N'0123456789', NULL, CAST(N'2004-05-03' AS Date), 1)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV04      ', N'Nguyen Van', N'A', 1, 3, N'0365338185', NULL, CAST(N'2001-09-13' AS Date), 1)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV05      ', N'Trần Thị', N'Dung', 1, 10, NULL, NULL, CAST(N'2004-05-04' AS Date), 0)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV06      ', N'Lê Mậu Anh', N'Đức', 1, 3, NULL, NULL, CAST(N'2004-05-08' AS Date), 1)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV07      ', N'Nguyen Van', N'C', 0, 4, NULL, NULL, CAST(N'2004-05-18' AS Date), 1)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV08      ', N'A', N'A', 1, 4, NULL, NULL, CAST(N'2004-06-09' AS Date), 0)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV09      ', N'B', N'B', 1, 4, NULL, NULL, CAST(N'2004-06-09' AS Date), 0)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV10      ', N'C', N'C', 1, 4, NULL, NULL, CAST(N'2004-06-09' AS Date), 0)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV11      ', N'D', N'D', 1, 4, NULL, NULL, CAST(N'2004-06-09' AS Date), 0)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV12      ', N'E', N'E', 1, 4, NULL, NULL, CAST(N'2004-06-09' AS Date), 0)
INSERT [dbo].[Employee] ([id_emp], [first_name], [last_name], [active], [id_position], [phone], [address], [birthday], [gender]) VALUES (N'NV13      ', N'F', N'F', 1, 4, NULL, NULL, CAST(N'2004-06-09' AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[Evaluate] ON 

INSERT [dbo].[Evaluate] ([id_evaluate], [id_time_table], [id_fault], [id_manager], [num]) VALUES (31, 3679, 9, N'Admin     ', 1)
INSERT [dbo].[Evaluate] ([id_evaluate], [id_time_table], [id_fault], [id_manager], [num]) VALUES (1031, 5903, 9, N'Admin     ', 1)
SET IDENTITY_INSERT [dbo].[Evaluate] OFF
GO
SET IDENTITY_INSERT [dbo].[Fault] ON 

INSERT [dbo].[Fault] ([id_fault], [description], [percent_of_salary], [deleted]) VALUES (9, N'Hút thuốc trong giờ làm 1', -50, 0)
SET IDENTITY_INSERT [dbo].[Fault] OFF
GO
SET IDENTITY_INSERT [dbo].[Position] ON 

INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (1, N'Leader', 1.5, 0, N'123', 1)
INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (3, N'Cashier', 1.2, 0, N'Cashier part-time', 0)
INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (4, N'Barista', 1.2, 0, NULL, 0)
INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (6, N'Manager', 2, 0, NULL, 1)
INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (8, N'Super Manager', 3, 0, NULL, 1)
INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (9, N'Waiter', 1, 0, NULL, 0)
INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (10, N'Barista', 1.5, 0, NULL, 1)
INSERT [dbo].[Position] ([id_position], [position_name], [coefficient], [deleted], [description], [is_fulltime]) VALUES (11, N'Cashier', 1.5, 0, NULL, 1)
SET IDENTITY_INSERT [dbo].[Position] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id_role], [role_name]) VALUES (3, N'Employee')
INSERT [dbo].[Role] ([id_role], [role_name]) VALUES (2, N'Leader')
INSERT [dbo].[Role] ([id_role], [role_name]) VALUES (1, N'Manager')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Salary] ON 

INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (53, CAST(N'2022-04-01' AS Date), N'Admin     ', 2736000.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (41, CAST(N'2022-04-01' AS Date), N'NV01      ', 1742400.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (42, CAST(N'2022-04-01' AS Date), N'NV02      ', 3168000.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (43, CAST(N'2022-04-01' AS Date), N'NV03      ', 774000.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (44, CAST(N'2022-04-01' AS Date), N'NV04      ', 172800.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (64, CAST(N'2022-05-01' AS Date), N'Admin     ', 7328000.0000, N'')
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (65, CAST(N'2022-05-01' AS Date), N'NV01      ', 525600.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (62, CAST(N'2022-05-01' AS Date), N'NV02      ', 5459500.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (61, CAST(N'2022-05-01' AS Date), N'NV03      ', 108000.0000, NULL)
INSERT [dbo].[Salary] ([id_salary], [date], [id_emp], [salary], [note]) VALUES (63, CAST(N'2022-05-01' AS Date), N'NV05      ', 5496000.0000, NULL)
SET IDENTITY_INSERT [dbo].[Salary] OFF
GO
SET IDENTITY_INSERT [dbo].[Shift] ON 

INSERT [dbo].[Shift] ([id_shift], [name], [time_start], [time_end], [basic_salary], [num_of_emp], [deleted]) VALUES (5, N'Shift 1', CAST(N'06:00:00' AS Time), CAST(N'12:00:00' AS Time), 73000.0000, 3, 0)
INSERT [dbo].[Shift] ([id_shift], [name], [time_start], [time_end], [basic_salary], [num_of_emp], [deleted]) VALUES (6, N'Shift 2', CAST(N'12:00:00' AS Time), CAST(N'18:00:00' AS Time), 72000.0000, 4, 0)
INSERT [dbo].[Shift] ([id_shift], [name], [time_start], [time_end], [basic_salary], [num_of_emp], [deleted]) VALUES (7, N'Shift 3', CAST(N'18:00:00' AS Time), CAST(N'23:00:00' AS Time), 84000.0000, 3, 0)
SET IDENTITY_INSERT [dbo].[Shift] OFF
GO
SET IDENTITY_INSERT [dbo].[Task] ON 

INSERT [dbo].[Task] ([id_task], [job], [description], [id_manager], [deleted]) VALUES (7, N'Pha Chế Kem Sữa', N'Pha kem sữa với dung tích 1 lít', N'Admin     ', 0)
INSERT [dbo].[Task] ([id_task], [job], [description], [id_manager], [deleted]) VALUES (9, N'Nhận Nguyên Liệu 1', N'Nhập Nguyên liệu từ shipper 1', N'Admin     ', 0)
SET IDENTITY_INSERT [dbo].[Task] OFF
GO
SET IDENTITY_INSERT [dbo].[TimeTable] ON 

INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (55, 5, CAST(N'2022-04-01' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2, 5, CAST(N'2022-04-01' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (13, 5, CAST(N'2022-04-01' AS Date), N'NV03      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (56, 5, CAST(N'2022-04-02' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (11, 5, CAST(N'2022-04-02' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (73, 5, CAST(N'2022-04-04' AS Date), N'NV02      ', N'NV01      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (72, 5, CAST(N'2022-04-04' AS Date), N'NV03      ', N'NV04      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (67, 5, CAST(N'2022-04-05' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (59, 5, CAST(N'2022-04-05' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1125, 5, CAST(N'2022-04-05' AS Date), N'NV04      ', N'NV03      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (60, 5, CAST(N'2022-04-06' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (68, 5, CAST(N'2022-04-06' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1104, 5, CAST(N'2022-04-07' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (71, 5, CAST(N'2022-04-07' AS Date), N'NV03      ', N'NV01      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1083, 5, CAST(N'2022-04-08' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1090, 5, CAST(N'2022-04-08' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1153, 5, CAST(N'2022-04-09' AS Date), N'NV03      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (61, 5, CAST(N'2022-04-11' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (70, 5, CAST(N'2022-04-11' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (62, 5, CAST(N'2022-04-12' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1088, 5, CAST(N'2022-04-12' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (63, 5, CAST(N'2022-04-13' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1089, 5, CAST(N'2022-04-13' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1099, 5, CAST(N'2022-04-14' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1100, 5, CAST(N'2022-04-15' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (64, 5, CAST(N'2022-04-20' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1127, 5, CAST(N'2022-04-20' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (65, 5, CAST(N'2022-04-21' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (66, 5, CAST(N'2022-04-22' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1137, 5, CAST(N'2022-04-23' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1139, 5, CAST(N'2022-04-24' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2180, 5, CAST(N'2022-04-25' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2183, 5, CAST(N'2022-04-26' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2186, 5, CAST(N'2022-04-27' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1164, 5, CAST(N'2022-04-27' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2189, 5, CAST(N'2022-04-28' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1147, 5, CAST(N'2022-04-28' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2192, 5, CAST(N'2022-04-29' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1148, 5, CAST(N'2022-04-29' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1155, 5, CAST(N'2022-04-29' AS Date), N'NV04      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2195, 5, CAST(N'2022-04-30' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3567, 5, CAST(N'2022-05-16' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3571, 5, CAST(N'2022-05-16' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3575, 5, CAST(N'2022-05-16' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3579, 5, CAST(N'2022-05-17' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3583, 5, CAST(N'2022-05-17' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3587, 5, CAST(N'2022-05-17' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3591, 5, CAST(N'2022-05-18' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3595, 5, CAST(N'2022-05-18' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3599, 5, CAST(N'2022-05-18' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3603, 5, CAST(N'2022-05-19' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3607, 5, CAST(N'2022-05-19' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3611, 5, CAST(N'2022-05-19' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3615, 5, CAST(N'2022-05-20' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3619, 5, CAST(N'2022-05-20' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3623, 5, CAST(N'2022-05-20' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3627, 5, CAST(N'2022-05-21' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3631, 5, CAST(N'2022-05-21' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3635, 5, CAST(N'2022-05-21' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3639, 5, CAST(N'2022-05-22' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3643, 5, CAST(N'2022-05-22' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3647, 5, CAST(N'2022-05-22' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3651, 5, CAST(N'2022-05-23' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3655, 5, CAST(N'2022-05-23' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3659, 5, CAST(N'2022-05-23' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3663, 5, CAST(N'2022-05-24' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3667, 5, CAST(N'2022-05-24' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3671, 5, CAST(N'2022-05-24' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3675, 5, CAST(N'2022-05-25' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3679, 5, CAST(N'2022-05-25' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3683, 5, CAST(N'2022-05-25' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3687, 5, CAST(N'2022-05-26' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3953, 5, CAST(N'2022-05-26' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3691, 5, CAST(N'2022-05-26' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3695, 5, CAST(N'2022-05-26' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3699, 5, CAST(N'2022-05-27' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3954, 5, CAST(N'2022-05-27' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3703, 5, CAST(N'2022-05-27' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3707, 5, CAST(N'2022-05-27' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3711, 5, CAST(N'2022-05-28' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3955, 5, CAST(N'2022-05-28' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3715, 5, CAST(N'2022-05-28' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3719, 5, CAST(N'2022-05-28' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3723, 5, CAST(N'2022-05-29' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3956, 5, CAST(N'2022-05-29' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3727, 5, CAST(N'2022-05-29' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3731, 5, CAST(N'2022-05-29' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3735, 5, CAST(N'2022-05-30' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (4953, 5, CAST(N'2022-05-30' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3739, 5, CAST(N'2022-05-30' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3743, 5, CAST(N'2022-05-30' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3747, 5, CAST(N'2022-05-31' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (4954, 5, CAST(N'2022-05-31' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3751, 5, CAST(N'2022-05-31' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3755, 5, CAST(N'2022-05-31' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3759, 5, CAST(N'2022-06-01' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3763, 5, CAST(N'2022-06-01' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3767, 5, CAST(N'2022-06-01' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3771, 5, CAST(N'2022-06-02' AS Date), N'Admin     ', NULL, NULL)
GO
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5894, 5, CAST(N'2022-06-02' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3775, 5, CAST(N'2022-06-02' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5897, 5, CAST(N'2022-06-02' AS Date), N'NV04      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3779, 5, CAST(N'2022-06-02' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5900, 5, CAST(N'2022-06-02' AS Date), N'NV06      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3783, 5, CAST(N'2022-06-03' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5895, 5, CAST(N'2022-06-03' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3787, 5, CAST(N'2022-06-03' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5898, 5, CAST(N'2022-06-03' AS Date), N'NV04      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3791, 5, CAST(N'2022-06-03' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5901, 5, CAST(N'2022-06-03' AS Date), N'NV06      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3795, 5, CAST(N'2022-06-04' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5896, 5, CAST(N'2022-06-04' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3799, 5, CAST(N'2022-06-04' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5899, 5, CAST(N'2022-06-04' AS Date), N'NV04      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3803, 5, CAST(N'2022-06-04' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5902, 5, CAST(N'2022-06-04' AS Date), N'NV06      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3807, 5, CAST(N'2022-06-05' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3811, 5, CAST(N'2022-06-05' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3815, 5, CAST(N'2022-06-05' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5558, 5, CAST(N'2022-06-06' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5561, 5, CAST(N'2022-06-06' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5567, 5, CAST(N'2022-06-06' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5570, 5, CAST(N'2022-06-07' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5573, 5, CAST(N'2022-06-07' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5579, 5, CAST(N'2022-06-07' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5582, 5, CAST(N'2022-06-08' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5903, 5, CAST(N'2022-06-08' AS Date), N'NV01      ', N'NV01      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5585, 5, CAST(N'2022-06-08' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5594, 5, CAST(N'2022-06-09' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5904, 5, CAST(N'2022-06-09' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5597, 5, CAST(N'2022-06-09' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5606, 5, CAST(N'2022-06-10' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5609, 5, CAST(N'2022-06-10' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5909, 5, CAST(N'2022-06-10' AS Date), N'NV08      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5911, 5, CAST(N'2022-06-10' AS Date), N'NV09      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5618, 5, CAST(N'2022-06-11' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5621, 5, CAST(N'2022-06-11' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5910, 5, CAST(N'2022-06-11' AS Date), N'NV08      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5912, 5, CAST(N'2022-06-11' AS Date), N'NV09      ', N'NV12      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5630, 5, CAST(N'2022-06-12' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5633, 5, CAST(N'2022-06-12' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (57, 6, CAST(N'2022-04-01' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5, 6, CAST(N'2022-04-01' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (15, 6, CAST(N'2022-04-01' AS Date), N'NV03      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1095, 6, CAST(N'2022-04-04' AS Date), N'NV02      ', N'NV01      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1073, 6, CAST(N'2022-04-04' AS Date), N'NV03      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1097, 6, CAST(N'2022-04-05' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1076, 6, CAST(N'2022-04-05' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1078, 6, CAST(N'2022-04-06' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1098, 6, CAST(N'2022-04-06' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1092, 6, CAST(N'2022-04-07' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1093, 6, CAST(N'2022-04-08' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1079, 6, CAST(N'2022-04-13' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1102, 6, CAST(N'2022-04-13' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1103, 6, CAST(N'2022-04-14' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1080, 6, CAST(N'2022-04-20' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1140, 6, CAST(N'2022-04-20' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2181, 6, CAST(N'2022-04-25' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2184, 6, CAST(N'2022-04-26' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2187, 6, CAST(N'2022-04-27' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1081, 6, CAST(N'2022-04-27' AS Date), N'NV01      ', N'NV02      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1162, 6, CAST(N'2022-04-27' AS Date), N'NV03      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2190, 6, CAST(N'2022-04-28' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2193, 6, CAST(N'2022-04-29' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2196, 6, CAST(N'2022-04-30' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1156, 6, CAST(N'2022-04-30' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3568, 6, CAST(N'2022-05-16' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3572, 6, CAST(N'2022-05-16' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3576, 6, CAST(N'2022-05-16' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3580, 6, CAST(N'2022-05-17' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3584, 6, CAST(N'2022-05-17' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3588, 6, CAST(N'2022-05-17' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3592, 6, CAST(N'2022-05-18' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3596, 6, CAST(N'2022-05-18' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3600, 6, CAST(N'2022-05-18' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3604, 6, CAST(N'2022-05-19' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3608, 6, CAST(N'2022-05-19' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3612, 6, CAST(N'2022-05-19' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3616, 6, CAST(N'2022-05-20' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3620, 6, CAST(N'2022-05-20' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3624, 6, CAST(N'2022-05-20' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3628, 6, CAST(N'2022-05-21' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3632, 6, CAST(N'2022-05-21' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3636, 6, CAST(N'2022-05-21' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3640, 6, CAST(N'2022-05-22' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3644, 6, CAST(N'2022-05-22' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3648, 6, CAST(N'2022-05-22' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3652, 6, CAST(N'2022-05-23' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3656, 6, CAST(N'2022-05-23' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3660, 6, CAST(N'2022-05-23' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3664, 6, CAST(N'2022-05-24' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3668, 6, CAST(N'2022-05-24' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3672, 6, CAST(N'2022-05-24' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3676, 6, CAST(N'2022-05-25' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3680, 6, CAST(N'2022-05-25' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3684, 6, CAST(N'2022-05-25' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3688, 6, CAST(N'2022-05-26' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3692, 6, CAST(N'2022-05-26' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3696, 6, CAST(N'2022-05-26' AS Date), N'NV05      ', NULL, NULL)
GO
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3700, 6, CAST(N'2022-05-27' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3704, 6, CAST(N'2022-05-27' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3708, 6, CAST(N'2022-05-27' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3712, 6, CAST(N'2022-05-28' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3716, 6, CAST(N'2022-05-28' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3720, 6, CAST(N'2022-05-28' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3724, 6, CAST(N'2022-05-29' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3728, 6, CAST(N'2022-05-29' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3732, 6, CAST(N'2022-05-29' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3736, 6, CAST(N'2022-05-30' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3740, 6, CAST(N'2022-05-30' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3744, 6, CAST(N'2022-05-30' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3748, 6, CAST(N'2022-05-31' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3752, 6, CAST(N'2022-05-31' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3756, 6, CAST(N'2022-05-31' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3760, 6, CAST(N'2022-06-01' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3764, 6, CAST(N'2022-06-01' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3768, 6, CAST(N'2022-06-01' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3772, 6, CAST(N'2022-06-02' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3776, 6, CAST(N'2022-06-02' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3780, 6, CAST(N'2022-06-02' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3784, 6, CAST(N'2022-06-03' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3788, 6, CAST(N'2022-06-03' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3792, 6, CAST(N'2022-06-03' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3796, 6, CAST(N'2022-06-04' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3800, 6, CAST(N'2022-06-04' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3804, 6, CAST(N'2022-06-04' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3808, 6, CAST(N'2022-06-05' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3812, 6, CAST(N'2022-06-05' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3816, 6, CAST(N'2022-06-05' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5559, 6, CAST(N'2022-06-06' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5562, 6, CAST(N'2022-06-06' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5568, 6, CAST(N'2022-06-06' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5571, 6, CAST(N'2022-06-07' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5574, 6, CAST(N'2022-06-07' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5583, 6, CAST(N'2022-06-08' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5905, 6, CAST(N'2022-06-08' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5586, 6, CAST(N'2022-06-08' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5595, 6, CAST(N'2022-06-09' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5906, 6, CAST(N'2022-06-09' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5598, 6, CAST(N'2022-06-09' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5607, 6, CAST(N'2022-06-10' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5610, 6, CAST(N'2022-06-10' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5619, 6, CAST(N'2022-06-11' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5622, 6, CAST(N'2022-06-11' AS Date), N'NV02      ', N'NV02      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5631, 6, CAST(N'2022-06-12' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5634, 6, CAST(N'2022-06-12' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (8, 7, CAST(N'2022-04-01' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (14, 7, CAST(N'2022-04-01' AS Date), N'NV03      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1128, 7, CAST(N'2022-04-04' AS Date), N'NV02      ', N'NV01      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (1101, 7, CAST(N'2022-04-08' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2182, 7, CAST(N'2022-04-25' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2185, 7, CAST(N'2022-04-26' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2188, 7, CAST(N'2022-04-27' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2191, 7, CAST(N'2022-04-28' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2194, 7, CAST(N'2022-04-29' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (2197, 7, CAST(N'2022-04-30' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3569, 7, CAST(N'2022-05-16' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3573, 7, CAST(N'2022-05-16' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3577, 7, CAST(N'2022-05-16' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3581, 7, CAST(N'2022-05-17' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3585, 7, CAST(N'2022-05-17' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3589, 7, CAST(N'2022-05-17' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3593, 7, CAST(N'2022-05-18' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3597, 7, CAST(N'2022-05-18' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3601, 7, CAST(N'2022-05-18' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3605, 7, CAST(N'2022-05-19' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3609, 7, CAST(N'2022-05-19' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3613, 7, CAST(N'2022-05-19' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3617, 7, CAST(N'2022-05-20' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3621, 7, CAST(N'2022-05-20' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3625, 7, CAST(N'2022-05-20' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3629, 7, CAST(N'2022-05-21' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3633, 7, CAST(N'2022-05-21' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3637, 7, CAST(N'2022-05-21' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3641, 7, CAST(N'2022-05-22' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3645, 7, CAST(N'2022-05-22' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3649, 7, CAST(N'2022-05-22' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3653, 7, CAST(N'2022-05-23' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3657, 7, CAST(N'2022-05-23' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3661, 7, CAST(N'2022-05-23' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3665, 7, CAST(N'2022-05-24' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3669, 7, CAST(N'2022-05-24' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3673, 7, CAST(N'2022-05-24' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3677, 7, CAST(N'2022-05-25' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3681, 7, CAST(N'2022-05-25' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3685, 7, CAST(N'2022-05-25' AS Date), N'NV05      ', N'NV05      ', NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3689, 7, CAST(N'2022-05-26' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3693, 7, CAST(N'2022-05-26' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3697, 7, CAST(N'2022-05-26' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3701, 7, CAST(N'2022-05-27' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3705, 7, CAST(N'2022-05-27' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3709, 7, CAST(N'2022-05-27' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3713, 7, CAST(N'2022-05-28' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3717, 7, CAST(N'2022-05-28' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3721, 7, CAST(N'2022-05-28' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3725, 7, CAST(N'2022-05-29' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3729, 7, CAST(N'2022-05-29' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3733, 7, CAST(N'2022-05-29' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3737, 7, CAST(N'2022-05-30' AS Date), N'Admin     ', NULL, NULL)
GO
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3741, 7, CAST(N'2022-05-30' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3745, 7, CAST(N'2022-05-30' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3749, 7, CAST(N'2022-05-31' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3753, 7, CAST(N'2022-05-31' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3757, 7, CAST(N'2022-05-31' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3761, 7, CAST(N'2022-06-01' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3765, 7, CAST(N'2022-06-01' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3769, 7, CAST(N'2022-06-01' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3773, 7, CAST(N'2022-06-02' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3777, 7, CAST(N'2022-06-02' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3781, 7, CAST(N'2022-06-02' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3785, 7, CAST(N'2022-06-03' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3789, 7, CAST(N'2022-06-03' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3793, 7, CAST(N'2022-06-03' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3797, 7, CAST(N'2022-06-04' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3801, 7, CAST(N'2022-06-04' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3805, 7, CAST(N'2022-06-04' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3809, 7, CAST(N'2022-06-05' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3813, 7, CAST(N'2022-06-05' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (3817, 7, CAST(N'2022-06-05' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5560, 7, CAST(N'2022-06-06' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5563, 7, CAST(N'2022-06-06' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5569, 7, CAST(N'2022-06-06' AS Date), N'NV05      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5572, 7, CAST(N'2022-06-07' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5575, 7, CAST(N'2022-06-07' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5584, 7, CAST(N'2022-06-08' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5907, 7, CAST(N'2022-06-08' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5587, 7, CAST(N'2022-06-08' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5596, 7, CAST(N'2022-06-09' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5908, 7, CAST(N'2022-06-09' AS Date), N'NV01      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5599, 7, CAST(N'2022-06-09' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5608, 7, CAST(N'2022-06-10' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5611, 7, CAST(N'2022-06-10' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5620, 7, CAST(N'2022-06-11' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5623, 7, CAST(N'2022-06-11' AS Date), N'NV02      ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5632, 7, CAST(N'2022-06-12' AS Date), N'Admin     ', NULL, NULL)
INSERT [dbo].[TimeTable] ([id_time_table], [id_shift], [date], [id_emp], [id_emp_alter], [description]) VALUES (5635, 7, CAST(N'2022-06-12' AS Date), N'NV02      ', NULL, NULL)
SET IDENTITY_INSERT [dbo].[TimeTable] OFF
GO
SET IDENTITY_INSERT [dbo].[UpTasks] ON 

INSERT [dbo].[UpTasks] ([id_up_task], [id_shift], [date], [id_task], [id_manager]) VALUES (66, 5, CAST(N'2022-05-19' AS Date), 7, N'Admin     ')
INSERT [dbo].[UpTasks] ([id_up_task], [id_shift], [date], [id_task], [id_manager]) VALUES (1069, 5, CAST(N'2022-06-08' AS Date), 9, N'Admin     ')
INSERT [dbo].[UpTasks] ([id_up_task], [id_shift], [date], [id_task], [id_manager]) VALUES (68, 6, CAST(N'2022-05-25' AS Date), 7, N'Admin     ')
INSERT [dbo].[UpTasks] ([id_up_task], [id_shift], [date], [id_task], [id_manager]) VALUES (67, 6, CAST(N'2022-05-25' AS Date), 9, N'Admin     ')
INSERT [dbo].[UpTasks] ([id_up_task], [id_shift], [date], [id_task], [id_manager]) VALUES (1067, 7, CAST(N'2022-05-25' AS Date), 9, N'Admin     ')
INSERT [dbo].[UpTasks] ([id_up_task], [id_shift], [date], [id_task], [id_manager]) VALUES (1068, 7, CAST(N'2022-05-31' AS Date), 7, N'Admin     ')
INSERT [dbo].[UpTasks] ([id_up_task], [id_shift], [date], [id_task], [id_manager]) VALUES (1070, 7, CAST(N'2022-06-09' AS Date), 9, N'Admin     ')
SET IDENTITY_INSERT [dbo].[UpTasks] OFF
GO
SET IDENTITY_INSERT [dbo].[Work] ON 

INSERT [dbo].[Work] ([id_work], [id_time_table], [id_up_task]) VALUES (72, 3607, 66)
INSERT [dbo].[Work] ([id_work], [id_time_table], [id_up_task]) VALUES (73, 3680, 67)
INSERT [dbo].[Work] ([id_work], [id_time_table], [id_up_task]) VALUES (74, 3680, 68)
INSERT [dbo].[Work] ([id_work], [id_time_table], [id_up_task]) VALUES (75, 3684, 67)
INSERT [dbo].[Work] ([id_work], [id_time_table], [id_up_task]) VALUES (1073, 3684, 68)
INSERT [dbo].[Work] ([id_work], [id_time_table], [id_up_task]) VALUES (1074, 3681, 1067)
INSERT [dbo].[Work] ([id_work], [id_time_table], [id_up_task]) VALUES (1075, 5908, 1070)
SET IDENTITY_INSERT [dbo].[Work] OFF
GO
/****** Object:  Index [UK_Evaluate]    Script Date: 12/06/2022 20:39:25 ******/
ALTER TABLE [dbo].[Evaluate] ADD  CONSTRAINT [UK_Evaluate] UNIQUE NONCLUSTERED 
(
	[id_evaluate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_RoleName]    Script Date: 12/06/2022 20:39:25 ******/
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [UK_RoleName] UNIQUE NONCLUSTERED 
(
	[role_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_Id_Salary]    Script Date: 12/06/2022 20:39:25 ******/
ALTER TABLE [dbo].[Salary] ADD  CONSTRAINT [UK_Id_Salary] UNIQUE NONCLUSTERED 
(
	[id_salary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Shift-name]    Script Date: 12/06/2022 20:39:25 ******/
ALTER TABLE [dbo].[Shift] ADD  CONSTRAINT [UK_Shift-name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_TimeTable]    Script Date: 12/06/2022 20:39:25 ******/
ALTER TABLE [dbo].[TimeTable] ADD  CONSTRAINT [UK_TimeTable] UNIQUE NONCLUSTERED 
(
	[id_time_table] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_UpTasks]    Script Date: 12/06/2022 20:39:25 ******/
ALTER TABLE [dbo].[UpTasks] ADD  CONSTRAINT [UK_UpTasks] UNIQUE NONCLUSTERED 
(
	[id_up_task] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_Work]    Script Date: 12/06/2022 20:39:25 ******/
ALTER TABLE [dbo].[Work] ADD  CONSTRAINT [UK_Work] UNIQUE NONCLUSTERED 
(
	[id_work] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF__Account__enable__2C3393D0]  DEFAULT ('TRUE') FOR [enable]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF__Employee__is_lea__24927208]  DEFAULT ('TRUE') FOR [active]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_gender]  DEFAULT ((0)) FOR [gender]
GO
ALTER TABLE [dbo].[Evaluate] ADD  CONSTRAINT [default_num]  DEFAULT ((1)) FOR [num]
GO
ALTER TABLE [dbo].[Fault] ADD  CONSTRAINT [DF_Fault_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[Position] ADD  CONSTRAINT [DF_Position_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[Position] ADD  CONSTRAINT [DF_Position_is_fulltime]  DEFAULT ((0)) FOR [is_fulltime]
GO
ALTER TABLE [dbo].[Shift] ADD  CONSTRAINT [DF_Shift_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([id_role])
REFERENCES [dbo].[Role] ([id_role])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Account] FOREIGN KEY([id])
REFERENCES [dbo].[Employee] ([id_emp])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Employee_Account]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Position1] FOREIGN KEY([id_position])
REFERENCES [dbo].[Position] ([id_position])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Position1]
GO
ALTER TABLE [dbo].[Evaluate]  WITH CHECK ADD  CONSTRAINT [FK_Evaluate_Employee] FOREIGN KEY([id_manager])
REFERENCES [dbo].[Employee] ([id_emp])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Evaluate] CHECK CONSTRAINT [FK_Evaluate_Employee]
GO
ALTER TABLE [dbo].[Evaluate]  WITH CHECK ADD  CONSTRAINT [FK_Evaluate_Fault] FOREIGN KEY([id_fault])
REFERENCES [dbo].[Fault] ([id_fault])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Evaluate] CHECK CONSTRAINT [FK_Evaluate_Fault]
GO
ALTER TABLE [dbo].[Salary]  WITH CHECK ADD  CONSTRAINT [FK_Salary_Employee] FOREIGN KEY([id_emp])
REFERENCES [dbo].[Employee] ([id_emp])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Salary] CHECK CONSTRAINT [FK_Salary_Employee]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Employee] FOREIGN KEY([id_manager])
REFERENCES [dbo].[Employee] ([id_emp])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Employee]
GO
ALTER TABLE [dbo].[TimeTable]  WITH CHECK ADD  CONSTRAINT [FK_TimeTable_Employee] FOREIGN KEY([id_emp])
REFERENCES [dbo].[Employee] ([id_emp])
GO
ALTER TABLE [dbo].[TimeTable] CHECK CONSTRAINT [FK_TimeTable_Employee]
GO
ALTER TABLE [dbo].[TimeTable]  WITH CHECK ADD  CONSTRAINT [FK_TimeTable_Employee1] FOREIGN KEY([id_emp_alter])
REFERENCES [dbo].[Employee] ([id_emp])
GO
ALTER TABLE [dbo].[TimeTable] CHECK CONSTRAINT [FK_TimeTable_Employee1]
GO
ALTER TABLE [dbo].[TimeTable]  WITH CHECK ADD  CONSTRAINT [FK_TimeTable_Shift] FOREIGN KEY([id_shift])
REFERENCES [dbo].[Shift] ([id_shift])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[TimeTable] CHECK CONSTRAINT [FK_TimeTable_Shift]
GO
ALTER TABLE [dbo].[UpTasks]  WITH CHECK ADD  CONSTRAINT [FK_UpTasks_Employee] FOREIGN KEY([id_manager])
REFERENCES [dbo].[Employee] ([id_emp])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[UpTasks] CHECK CONSTRAINT [FK_UpTasks_Employee]
GO
ALTER TABLE [dbo].[UpTasks]  WITH CHECK ADD  CONSTRAINT [FK_UpTasks_Shift] FOREIGN KEY([id_shift])
REFERENCES [dbo].[Shift] ([id_shift])
GO
ALTER TABLE [dbo].[UpTasks] CHECK CONSTRAINT [FK_UpTasks_Shift]
GO
ALTER TABLE [dbo].[UpTasks]  WITH CHECK ADD  CONSTRAINT [FK_UpTasks_Task] FOREIGN KEY([id_task])
REFERENCES [dbo].[Task] ([id_task])
GO
ALTER TABLE [dbo].[UpTasks] CHECK CONSTRAINT [FK_UpTasks_Task]
GO
ALTER TABLE [dbo].[Work]  WITH CHECK ADD  CONSTRAINT [FK_Work_TimeTable] FOREIGN KEY([id_time_table])
REFERENCES [dbo].[TimeTable] ([id_time_table])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Work] CHECK CONSTRAINT [FK_Work_TimeTable]
GO
ALTER TABLE [dbo].[Work]  WITH CHECK ADD  CONSTRAINT [FK_Work_UpTasks] FOREIGN KEY([id_up_task])
REFERENCES [dbo].[UpTasks] ([id_up_task])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Work] CHECK CONSTRAINT [FK_Work_UpTasks]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_gender] CHECK  (([gender]=(2) OR [gender]=(1) OR [gender]=(0)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CK_gender]
GO
ALTER TABLE [dbo].[Evaluate]  WITH CHECK ADD  CONSTRAINT [CK_Evaluate_Num] CHECK  (([num]>(0)))
GO
ALTER TABLE [dbo].[Evaluate] CHECK CONSTRAINT [CK_Evaluate_Num]
GO
/****** Object:  StoredProcedure [dbo].[sp_compute_salary]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_compute_salary] @month int, @year int
as
begin

select id_emp, fix_salary = sum(amount)
into #TMP_FIX_SALARY
from (
	select T.id_emp, amount=count(id_time_table)*basic_salary*coefficient
	from ( 
			select id_emp=iif(id_emp_alter is not null, id_emp_alter, id_emp), id_shift, id_time_table 
			from TimeTable 
			where month(date) = @month AND year(date) = @year
		) T
	inner join Shift S on S.id_shift = T.id_shift
	inner join (select id_emp, id_position from Employee) E on E.id_emp = T.id_emp
	inner join Position P on P.id_position = E.id_position
	
	group by  T.id_shift, basic_salary, T.id_emp, coefficient
) TMP 
group by id_emp

merge into Salary as target
using (
		select FS.id_emp, date=convert(date, concat(@year,'-', @month, '-01')), 
		salary=FS.fix_salary + isnull(sum(num*basic_salary*percent_of_salary/100),0)
	from (
			select id_emp=iif(id_emp_alter is null, id_emp, id_emp_alter), id_shift, id_time_table 
			from TimeTable
			where month(date) = @month AND year(date) = @year
		) T
	inner join Shift S on S.id_shift = T.id_shift -- basic_salary
	inner join Evaluate E on E.id_time_table = T.id_time_table -- num
	inner join Fault F on F.id_fault = E.id_fault -- percent of salary
	right join #TMP_FIX_SALARY FS on FS.id_emp = T.id_emp
	group by FS.id_emp, fix_salary
) as source
on year(target.date) = year(source.date) AND month(target.date) = month(source.date) AND target.id_emp = source.id_emp
when matched then
	update set target.salary = source.salary
when not matched then
	insert (id_emp, date, salary) values (source.id_emp, source.date, source.salary);
drop table #TMP_FIX_SALARY

end

GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_time_table]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_all_time_table]
as
begin

DECLARE @from_date datetime;
exec sp_get_date_start @from_date out;
WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)

-- Liet ke tat ca cac ca lam trong ngay
select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date))
into #TMP
from (select * from months) L, (select * from Shift where deleted='false') S

select TT.* from TimeTable TT inner join #TMP TMP 
	on TT.id_shift = TMP.id_shift and TT.date = TMP.date 
	order by date DESC, id_shift ASC

drop table #TMP
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_time_table_filter_by_date]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_get_all_time_table_filter_by_date] @filter nvarchar(10)
as
begin


	select TT.*
		from TimeTable TT
		inner join (select id_shift from Shift where deleted='false') S
		on S.id_shift = TT.id_shift
		where date LIKE @filter 
		order by date DESC, id_shift ASC

end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_time_table_filter_by_name]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_get_all_time_table_filter_by_name] @filter nvarchar(100)
as
begin
DECLARE @from_date date
exec sp_get_date_start @from_date out;
WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)

select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date)), num_of_emp
into #TMP
from (select * from months) L, (select * from Shift where deleted='false') S

select TT.* from TimeTable TT
		inner join #TMP TMP on TMP.date = TT.date and TMP.id_shift = TT.id_shift
		inner join (
			select id_shift, date
					from (select id_shift, date, id_emp=iif(id_emp_alter is null, id_emp, id_emp_alter) from TimeTable) T
					inner join (select id_emp from Employee where active='true' and last_name like N'Thuận') E on E.id_emp = T.id_emp
		) T on T.date = TT.date and T.id_shift = TT.id_shift
order by id_shift, date

drop table #TMP
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_time_table_filter_by_shift]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_get_all_time_table_filter_by_shift] @filter nvarchar(50)
as
begin
DECLARE @from_date date
exec sp_get_date_start @from_date out;
WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)

select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date)), num_of_emp
into #TMP
from (select * from months) L, (select * from Shift where deleted='false') S

set dateformat dmy;

	select TT.* from TimeTable TT
		inner join #TMP TMP on TMP.date = TT.date and TMP.id_shift = TT.id_shift
		where TT.id_shift in (select id_shift from Shift where name LIKE @filter)
		order by TT.id_shift, TT.date

drop table #TMP
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_date_start]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_date_start] @date_start date out
as
begin
	--delete from Constants where dateadd(day, 28, date_start) < getdate()
	declare @date_tmp date
	 select @date_tmp=max(date_start) from Constants
	select @date_start= isnull(min(date_start), @date_tmp)
	from Constants where dateadd(day, 21, date_start) >= getdate()
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_emp_cooperate_with_leader]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_get_emp_cooperate_with_leader] 
@id_shift int, @date nvarchar(10), @id_leader nvarchar(10), @id_up_task int
as
begin
	select id_time_table, TT.id_emp, date
	from (
				select id_time_table, id_emp=iif(id_emp_alter is null, id_emp, id_emp_alter), date
				from TimeTable
				where date = @date AND id_shift = @id_shift AND 
					id_time_table not in (select id_time_table from Work where id_up_task = @id_up_task)
			) TT
	inner join (
					select id_emp
					from Employee where active = 'true'
				) E on TT.id_emp = E.id_emp
	
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_emp_of_shift_now]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_get_emp_of_shift_now] @id_shift int
as
begin
select id_time_table, id_shift, date, 
	id_emp=iif(id_emp_alter is null, id_emp, id_emp_alter), id_emp_alter=null, 
	description 
from udf_get_emp_of_shift(getdate(), @id_shift)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_evaluation]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_evaluation] @id_emp nvarchar(10), @is_all bit
as begin
DECLARE @from_date datetime;
exec sp_get_date_start @from_date out;
WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)

select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date))
into #TMP
from (select * from months) L, 
		(
		select * from Shift 
		where deleted='false' AND id_shift in (
			select distinct id_shift
			from TimeTable where date >= @from_date
			)
		) S

select id_date_shift=convert(nvarchar, date) + convert(nvarchar, id_shift),id_shift, date, num
, id_emp, description=ISNULL(EE.description,'')--, id_manager=ISNULL(id_manager,'')
into #TMP2
from (
	select *
	from TimeTable where date >= @from_date AND id_emp=@id_emp
	) TT LEFT JOIN (
		select id_time_table, description, id_manager, num 
		from  (
				select id_time_table, id_manager, id_fault, num 
				from Evaluate
			) E INNER JOIN (select id_fault, description from Fault) F ON F.id_fault = E.id_fault
		) EE
	ON EE.id_time_table = TT.id_time_table 

select id=TMP.id_date_shift+ISNULL(description,''), TMP.id_shift, TMP.date, description, num=ISNULL(num,1)
into #TMP3
from #TMP2 TMP2 RIGHT JOIN (
			select id_date_shift=convert(nvarchar, date) + convert(nvarchar, id_shift), date, id_shift 
			from #TMP
		) TMP
ON TMP.id_date_shift = TMP2.id_date_shift 
order by id_shift, date

if @is_all = 'false'
	begin
		if GETDATE() >= @from_date AND GETDATE() < @from_date + 7
			select * From #TMP3 WHERE date between @from_date and @from_date + 6 ORDER BY id_shift, date
		else if GETDATE() >= @from_date + 7 AND GETDATE() < @from_date + 14
			select * From #TMP3 WHERE date between @from_date + 7 and @from_date + 13 ORDER BY id_shift, date
		else if GETDATE() >= @from_date + 14 AND GETDATE() < @from_date + 21
			select * From #TMP3 WHERE date between @from_date + 14 and @from_date + 20 ORDER BY id_shift, date
		else 
			select * From #TMP3 WHERE date between @from_date + 21 and @from_date + 27 ORDER BY id_shift, date
			 -- @from_date and @from_date + 6
			 -- @from_date + 7 and @from_date + 13
			 -- @from_date + 14 and @from_date + 20
			 -- @from_date + 21 and @from_date + 27
	end
else 
	select * from #TMP3 ORDER BY id_shift, date

DROP TABLE #TMP
DROP TABLE #TMP2
DROP TABLE #TMP3
end

GO
/****** Object:  StoredProcedure [dbo].[sp_get_job_for_leader]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_job_for_leader] @id_leader nvarchar(10), @is_all bit
as
begin
DECLARE @from_date datetime
exec sp_get_date_start @from_date out;
WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)

-- Liet ke tat ca cac ca lam trong ngay

select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date))
into #TMP
from (select * from months) L, 
		(
		select * from Shift 
		where deleted='false' AND id_shift in (
			select distinct id_shift
			from TimeTable where date >= @from_date
			)
		) S

SELECT id_shift, date, id_emp
into #TMP_TIMETABLE
FROM (select id_emp=iif(id_emp_alter is null, id_emp, id_emp_alter), date, id_shift from TimeTable) TT 
WHERE id_emp = @id_leader AND date in (select date from #TMP)

select id_job_for_leader = convert(nvarchar, TMP.date) + convert(nvarchar, TMP.id_shift) + isnull( convert(nvarchar, id_up_task), '')
	, TMP.date, TMP.id_shift, job, id_up_task
into #TMP2
from  
(
	select TMP_TT.date, TMP_TT.id_shift, job=isnull(job, ''), id_up_task
	from UpTasks UT 
	inner join task T on T.id_task = UT.id_task
	right join #TMP_TIMETABLE TMP_TT on TMP_TT.id_shift = UT.id_shift AND TMP_TT.date = UT.date
) UT
right join #TMP TMP on TMP.date = UT.date AND TMP.id_shift = UT.id_shift
order by id_shift, date

if @is_all = 'false'
	begin
		if GETDATE() >= @from_date AND GETDATE() < @from_date + 7
			select * From #TMP2 WHERE date between @from_date and @from_date + 6 ORDER BY id_shift, date
		else if GETDATE() >= @from_date + 7 AND GETDATE() < @from_date + 14
			select * From #TMP2 WHERE date between @from_date + 7 and @from_date + 13 ORDER BY id_shift, date
		else if GETDATE() >= @from_date + 14 AND GETDATE() < @from_date + 21
			select * From #TMP2 WHERE date between @from_date + 14 and @from_date + 20 ORDER BY id_shift, date
		else 
			select * From #TMP2 WHERE date between @from_date + 21 and @from_date + 27 ORDER BY id_shift, date
			 -- @from_date and @from_date + 6
			 -- @from_date + 7 and @from_date + 13
			 -- @from_date + 14 and @from_date + 20
			 -- @from_date + 21 and @from_date + 27
	end
else 
	select * from #TMP2 ORDER BY id_shift, date


DROP TABLE #TMP
DROP TABLE #TMP2
DROP TABLE #TMP_TIMETABLE

end

GO
/****** Object:  StoredProcedure [dbo].[sp_get_job_of_emp_to_manager]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_job_of_emp_to_manager] @date date, @id_shift int
as
select id=convert(char(10), T.id_time_table)+convert(char(10),UT.id_up_task),
id_emp=IIF(id_emp_alter IS NULL, id_emp, id_emp_alter), job from udf_get_emp_of_shift(@date, @id_shift) T
inner join (select id_time_table, id_up_task from Work) W on W.id_time_table = T.id_time_table
inner join (select id_up_task, id_task from UpTasks) UT on UT.id_up_task = W.id_up_task
inner join (select id_task, job from Task) Task on Task.id_task = UT.id_task
order by id_emp

GO
/****** Object:  StoredProcedure [dbo].[sp_get_lack_of_emp]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_lack_of_emp] @filter nvarchar(10)
as
begin

DECLARE @from_date datetime;
exec sp_get_date_start @from_date out;
;WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)

select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date)), num_of_emp, name
into #TMP
from (select * from months) L, 
		(
		select * from Shift 
		where deleted='false' AND id_shift in (
			select distinct id_shift
			from TimeTable where date >= @from_date
			)
		) S

	declare @num_of_ft_emp int
	select @num_of_ft_emp=count(*)
	from (
		select id_position
		from Employee where active='true'
	) E inner join (
		select id_position
		from Position
		where is_fulltime = 1
	) P on E.id_position = P.id_position

select id_lack_of_emp=convert(nvarchar, #TMP.id_shift)+convert(nvarchar, #TMP.date), 
		name, #TMP.date, amount = num_of_emp - (count(id_time_table) - @num_of_ft_emp)
into #TMP2
from #TMP
left join TimeTable T on T.id_shift = #TMP.id_shift AND T.date = #TMP.date
group by #TMP.id_shift, #TMP.date, num_of_emp, name , name having num_of_emp - (count(id_time_table) - @num_of_ft_emp) > 0
order by #TMP.id_shift, #TMP.date


if @filter = ''
	select * from #TMP2
else
	select * from #TMP2 where date like @filter

drop table #TMP
drop table #TMP2
end

GO
/****** Object:  StoredProcedure [dbo].[sp_get_num_of_shift_of_all_emp_part_time]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_get_num_of_shift_of_all_emp_part_time]
as

begin
DECLARE @from_date date
	exec sp_get_date_start @from_date out
	;WITH months(MonthNumber) AS
	(
		SELECT 0
		UNION ALL
		SELECT MonthNumber+1
		FROM months
		WHERE MonthNumber < 27
	)

	select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date)), num_of_emp
	into #TMP
	from (select * from months) L, 
		(
		select * from Shift 
		where deleted='false' AND id_shift in (
			select distinct id_shift
			from TimeTable where date >= @from_date
			)
		) S

select E.id_emp, first_name, last_name, num_of_shift=isnull(num_of_shift,0)
into #TT_TMP
from (
	select id_emp, first_name, last_name, id_position
	from Employee
	where active = 'true'
) E join (
	select id_position, position_name
	from Position
	where is_fulltime = 'false'
) P on E.id_position = P.id_position
left join (
	select id_emp=isnull(id_emp_alter, id_emp), num_of_shift=isnull(count(id_emp),0)
	from TimeTable T inner join #TMP Tmp
	on T.date = Tmp.date and T.id_shift = Tmp.id_shift
	group by id_emp, id_emp_alter
) TT on TT.id_emp = E.id_emp
group by E.id_emp, first_name, last_name, num_of_shift

select id_emp, first_name, last_name, num_of_shift=sum(#TT_TMP.num_of_shift)
from #TT_TMP
group by id_emp, first_name, last_name
order by id_emp

drop table #TMP
drop table #TT_TMP

end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_shift_now]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_get_shift_now] @id_shift int out
as
begin
	declare @from_date datetime
	exec sp_get_date_start @from_date out
	
select @id_shift=id_shift
from Shift where deleted='false' 
	AND convert(time, getdate()) >= time_start 
	AND convert(time, getdate()) <= time_end 
	AND id_shift in (select id_shift from TimeTable where date >= @from_date)
end
return 
GO
/****** Object:  StoredProcedure [dbo].[sp_get_shifts_of_time_table]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_shifts_of_time_table]
as
begin
DECLARE @from_date datetime;
exec sp_get_date_start @from_date out;
WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)


select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date))
into #TMP
from (select * from months) L, (select * from Shift where deleted='false') S

select distinct S.id_shift, name, time_start, time_end, basic_salary, num_of_emp, deleted
from TimeTable TT inner join #TMP TMP on TT.id_shift=TMP.id_shift AND TT.date=TMP.date
inner join (select * from shift where deleted='false') S on S.id_shift=TT.id_shift
drop table #TMP
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_status_time_table]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_get_status_time_table] @id_emp nvarchar(10)
as
begin


	DECLARE @from_date date
	exec sp_get_date_start @from_date out
	;WITH months(MonthNumber) AS
	(
		SELECT 0
		UNION ALL
		SELECT MonthNumber+1
		FROM months
		WHERE MonthNumber < 27
	)

	select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date)), num_of_emp
	into #TMP
	from (select * from months) L, 
		(
		select * from Shift 
		where deleted='false' AND id_shift in (
			select distinct id_shift
			from TimeTable where date >= @from_date
			)
		) S

	declare @num_of_ft_emp int
	select @num_of_ft_emp=count(*)
	from (
		select id_position
		from Employee where active='true'
	) E inner join (
		select id_position
		from Position
		where is_fulltime = 1
	) P on E.id_position = P.id_position

	select date, T.id_shift
	into #TMP2
	from (
		select  id_shift, date, contain= CASE 
			WHEN @id_emp in (select id_emp=iif(id_emp_alter is null, id_emp, id_emp_alter) 
				from TimeTable TT
				where TT.id_shift=TMP.id_shift AND TT.date=TMP.date) 
			THEN 'true' ELSE 'false' END,
			num_add=count(*)
		from (
				select T.date, T.id_shift, id_emp=iif(id_emp_alter is null, id_emp, id_emp_alter)
				from TimeTable TT
				inner join #TMP T on T.date = TT.date and T.id_shift = TT.id_shift
			) TMP 
		group by id_shift, date
	) T inner join (select id_shift, num_of_emp from shift) S on S.id_shift = T.id_shift
	where  num_add-@num_of_ft_emp >= num_of_emp  OR contain='true'

	select id_status_shift=CONVERT(nvarchar, date)+CONVERT(nvarchar, id_shift)
		, id_shift
		, date
		, status = CASE 
			WHEN CONVERT(nvarchar, date)+CONVERT(nvarchar, id_shift) 
				in (select CONVERT(nvarchar, date)+CONVERT(nvarchar, id_shift) from #TMP2)  
				OR date < getdate() 
			THEN 'true' 
			ELSE 'false' 
			END
	from #TMP order by id_shift, date
	drop table #TMP2
	drop table #TMP
end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_time_table_of_emp]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_get_time_table_of_emp] @id_emp nvarchar(10), @is_all bit
as
begin
DECLARE @from_date datetime;
exec sp_get_date_start @from_date out;
WITH months(MonthNumber) AS
(
    SELECT 0
    UNION ALL
    SELECT MonthNumber+1
    FROM months
    WHERE MonthNumber < 27
)

-- Liet ke tat ca cac ca lam trong ngay

select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date))
into #TMP
from (select * from months) L, 
		(
		select * from Shift 
		where deleted='false' AND id_shift in (
			select distinct id_shift
			from TimeTable where date >= @from_date
			)
		) S

-- Liet ke lich lam cua nhan vien co ma @id_emp

SELECT id_shift, date, id_emp=@id_emp, job=ISNULL(job,'')
INTO #TMP2
FROM work
INNER JOIN (SELECT id_up_task, id_task FROM UpTasks) UT
ON UT.id_up_task = Work.id_up_task
INNER JOIN (SELECT id_task, job FROM Task) T
ON T.id_task = UT.id_task
RIGHT JOIN (
		SELECT id_time_table, id_shift, date 
		FROM TimeTable 
		WHERE id_emp = @id_emp AND date in (select date from #TMP)
	) TT
ON TT.id_time_table = Work.id_time_table

-- Liet ke tat ca lich lam (neu lam -> job IS NOT NULL, khong lam -> job IS NULL, khong co job -> job = '')

SELECT id_status_shift=tmp.id_status_shift+ISNULL(job,''), id_shift, date, job
INTO #TMP3
FROM (
		SELECT id_status_shift=CONVERT(nvarchar, date)+CONVERT(nvarchar,id_shift), id_shift, date from #TMP 
	) tmp LEFT JOIN (
		SELECT id_status_shift=CONVERT(nvarchar, date)+CONVERT(nvarchar,id_shift), job FROM #TMP2
	) Tmp2 ON tmp2.id_status_shift = tmp.id_status_shift

if @is_all = 'false'
	begin
		if GETDATE() >= @from_date AND GETDATE() < @from_date + 7
			select * From #TMP3 WHERE date between @from_date and @from_date + 6 ORDER BY id_shift, date
		else if GETDATE() >= @from_date + 7 AND GETDATE() < @from_date + 14
			select * From #TMP3 WHERE date between @from_date + 7 and @from_date + 13 ORDER BY id_shift, date
		else if GETDATE() >= @from_date + 14 AND GETDATE() < @from_date + 21
			select * From #TMP3 WHERE date between @from_date + 14 and @from_date + 20 ORDER BY id_shift, date
		else
			select * From #TMP3 WHERE date between @from_date + 21 and @from_date + 27 ORDER BY id_shift, date
			 -- @from_date and @from_date + 6
			 -- @from_date + 7 and @from_date + 13
			 -- @from_date + 14 and @from_date + 20
			 -- @from_date + 21 and @from_date + 27
	end
else 
	select * from #TMP3 ORDER BY id_shift, date

DROP TABLE #TMP
DROP TABLE #TMP2
DROP TABLE #TMP3
end

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_fulltime_emp]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_insert_fulltime_emp] @from_date date
as
begin
	;WITH months(MonthNumber) AS
	(
		SELECT 0
		UNION ALL
		SELECT MonthNumber+1
		FROM months
		WHERE MonthNumber < 27
	)

	select id_shift, date=CONVERT(Date, dateadd(day,MonthNumber, @from_date)), id_emp
	into #TMP
	from (select * from months) L, (select * from Shift where deleted='false') S, 
		(	select id_emp
			from (select id_position from Position where is_fulltime = 1) P
			inner join (select id_emp, id_position from Employee where active='true')
			E on E.id_position = P.id_position
		) E

	set xact_abort on
	begin tran
	begin try
	
	delete from TimeTable 
	where id_emp in (
			select id_emp
			from (
				select id_emp, id_position
				from Employee
				where active='true'
			) E inner join (
				select id_position
				from Position
				where is_fulltime = 1
			) P on E.id_position = P.id_position
		) AND date >= @from_date

	insert into TimeTable (id_shift, date, id_emp)
	select id_shift, date, id_emp
	from #TMP
	commit
	end try
	begin catch
	rollback
	end catch

	--merge into TimeTable as target
	--using #TMP as source
	--on target.date = source.date and target.id_shift = source.id_shift
	--when not matched then
	--insert (id_shift, date, id_emp) values (source.id_shift, source.date, source.id_emp);
	
	drop table #TMP
end

GO
/****** Object:  StoredProcedure [dbo].[sp_loadmore_employees]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_loadmore_employees] @loadmore int, @offset int
as
select * from Employee 
where active='true'
order by id_emp DESC
offset @loadmore row fetch next @offset row only

GO
/****** Object:  StoredProcedure [dbo].[sp_search_employee]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_search_employee]	 @filter nvarchar(100)
as
begin
	select *
	from Employee
	where active='true' AND 
		first_name + ' ' + last_name like '%'+@filter+'%'
	
	
end
GO
/****** Object:  StoredProcedure [dbo].[sp_statist_evaluation_of_emp]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_statist_evaluation_of_emp] @month int, @year int
as
begin

select id_emp=isnull(id_emp_alter, id_emp), id_time_table, id_shift, date
into #TT_TMP
from TimeTable 
where month(date) = @month AND year(date)=@year

select id_statist_evaluation_of_emp=id_evaluate, E.id_emp, num, description, name, date
from (
		select *
		from Employee
		where active = 1
) E inner join #TT_TMP TT_TMP on TT_TMP.id_emp = E.id_emp
inner join (
	select id_evaluate, id_time_table, num, f.description
	from Evaluate Eval inner join Fault F on F.id_fault = Eval.id_fault
) Eval on Eval.id_time_table = TT_TMP.id_time_table
inner join (select id_shift, name from Shift where deleted='false') S
on S.id_shift = TT_TMP.id_shift
order by id_emp, date DESC, name ASC

drop table #TT_TMP
end
GO
/****** Object:  StoredProcedure [dbo].[sp_statist_num_of_shift]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_statist_num_of_shift] @month int, @year int
as
begin
	
select id_emp=isnull(id_emp_alter, id_emp), id_time_table, id_shift
into #TT_TMP
from TimeTable 
where month(date) = @month AND year(date)=@year

select id_statist_num_of_shift=E.id_emp+name, E.id_emp, first_name, last_name, num_of_shift=count(E.id_emp), name
from (
		select *
		from Employee
		where active = 1
) E inner join #TT_TMP TT_TMP on TT_TMP.id_emp = E.id_emp
inner join 
(select id_shift, name from Shift where deleted='false') S on s.id_shift = TT_TMP.id_shift

group by E.id_emp, first_name, last_name, S.name
order by id_emp


drop table #TT_TMP

end
GO
/****** Object:  Trigger [dbo].[tr_insert_work]    Script Date: 12/06/2022 20:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_insert_work] on [dbo].[Work]
for insert
as
begin
	declare @id_up_task int, @id_time_table int, @date_ut date,
		@date_tt date, @id_shift_ut int, @id_shift_tt int

	select @date_tt = date, @id_shift_tt = id_shift
	from inserted I
	inner join TimeTable T on T.id_time_table = I.id_time_table

	select @date_ut = date, @id_shift_ut = id_shift
	from inserted I
	inner join UpTasks UT on UT.id_up_task = I.id_up_task

	if @date_tt <> @date_ut OR @id_shift_tt <> @id_shift_ut
	begin
		delete from Work where id_time_table = (select id_time_table from inserted)
			AND id_up_task = (select id_up_task from inserted)
		raiserror('Invalid date and shift for insert in table work', 16, 1)
	end
end
GO
ALTER TABLE [dbo].[Work] ENABLE TRIGGER [tr_insert_work]
GO
USE [master]
GO
ALTER DATABASE [QLNVQTS] SET  READ_WRITE 
GO
