USE [master]
GO
/****** Object:  Database [FASE1]    Script Date: 10/3/2024 4:42:34 PM ******/
CREATE DATABASE [FASE1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FASE1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER_VEGA\MSSQL\DATA\FASE1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FASE1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER_VEGA\MSSQL\DATA\FASE1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FASE1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FASE1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FASE1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FASE1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FASE1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FASE1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FASE1] SET ARITHABORT OFF 
GO
ALTER DATABASE [FASE1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FASE1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FASE1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FASE1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FASE1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FASE1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FASE1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FASE1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FASE1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FASE1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FASE1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FASE1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FASE1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FASE1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FASE1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FASE1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FASE1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FASE1] SET RECOVERY FULL 
GO
ALTER DATABASE [FASE1] SET  MULTI_USER 
GO
ALTER DATABASE [FASE1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FASE1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FASE1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FASE1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FASE1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FASE1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FASE1', N'ON'
GO
ALTER DATABASE [FASE1] SET QUERY_STORE = ON
GO
ALTER DATABASE [FASE1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FASE1]
GO
/****** Object:  Table [dbo].[dim_discount_band]    Script Date: 10/3/2024 4:42:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_discount_band](
	[id_discount_band] [int] IDENTITY(1,1) NOT NULL,
	[discount_band] [varchar](255) NOT NULL,
 CONSTRAINT [dim_discount_band_id_discount_band_primary] PRIMARY KEY CLUSTERED 
(
	[id_discount_band] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_pais]    Script Date: 10/3/2024 4:42:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_pais](
	[id_pais] [int] IDENTITY(1,1) NOT NULL,
	[nombre_pais] [varchar](255) NOT NULL,
 CONSTRAINT [dim_pais_id_pais_primary] PRIMARY KEY CLUSTERED 
(
	[id_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_producto]    Script Date: 10/3/2024 4:42:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_producto](
	[id_producto] [int] IDENTITY(1,1) NOT NULL,
	[nombre_producto] [varchar](255) NOT NULL,
 CONSTRAINT [dim_producto_id_producto_primary] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_segmento]    Script Date: 10/3/2024 4:42:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_segmento](
	[id_segmento] [int] IDENTITY(1,1) NOT NULL,
	[segmento] [varchar](255) NOT NULL,
 CONSTRAINT [dim_segmento_id_segmento_primary] PRIMARY KEY CLUSTERED 
(
	[id_segmento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_tiempo]    Script Date: 10/3/2024 4:42:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_tiempo](
	[id_fecha] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [date] NOT NULL,
	[numero_mes] [float] NOT NULL,
	[nombre_mes] [varchar](255) NOT NULL,
	[anio] [varchar](255) NOT NULL,
 CONSTRAINT [dim_tiempo_id_fecha_primary] PRIMARY KEY CLUSTERED 
(
	[id_fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_precios]    Script Date: 10/3/2024 4:42:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_precios](
	[id_producto] [int] NOT NULL,
	[id_tiempo] [int] NOT NULL,
	[precio_manofactura] [float] NOT NULL,
	[precio_venta] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hecho_ventas]    Script Date: 10/3/2024 4:42:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hecho_ventas](
	[unidades_vendidas] [float] NOT NULL,
	[ventas_brutas] [float] NOT NULL,
	[descuento] [float] NOT NULL,
	[ventas_netas] [float] NOT NULL,
	[costos] [float] NOT NULL,
	[beneficio] [float] NOT NULL,
	[id_producto] [int] NULL,
	[id_pais] [int] NULL,
	[id_tiempo] [int] NULL,
	[id_discount_band] [int] NULL,
	[id_segmento] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[fact_precios]  WITH CHECK ADD  CONSTRAINT [fact_precios_id_producto_foreign] FOREIGN KEY([id_producto])
REFERENCES [dbo].[dim_producto] ([id_producto])
GO
ALTER TABLE [dbo].[fact_precios] CHECK CONSTRAINT [fact_precios_id_producto_foreign]
GO
ALTER TABLE [dbo].[fact_precios]  WITH CHECK ADD  CONSTRAINT [fact_precios_id_tiempo_foreign] FOREIGN KEY([id_tiempo])
REFERENCES [dbo].[dim_tiempo] ([id_fecha])
GO
ALTER TABLE [dbo].[fact_precios] CHECK CONSTRAINT [fact_precios_id_tiempo_foreign]
GO
ALTER TABLE [dbo].[hecho_ventas]  WITH CHECK ADD  CONSTRAINT [hecho_ventas_id_discount_band_foreign] FOREIGN KEY([id_discount_band])
REFERENCES [dbo].[dim_discount_band] ([id_discount_band])
GO
ALTER TABLE [dbo].[hecho_ventas] CHECK CONSTRAINT [hecho_ventas_id_discount_band_foreign]
GO
ALTER TABLE [dbo].[hecho_ventas]  WITH CHECK ADD  CONSTRAINT [hecho_ventas_id_pais_foreign] FOREIGN KEY([id_pais])
REFERENCES [dbo].[dim_pais] ([id_pais])
GO
ALTER TABLE [dbo].[hecho_ventas] CHECK CONSTRAINT [hecho_ventas_id_pais_foreign]
GO
ALTER TABLE [dbo].[hecho_ventas]  WITH CHECK ADD  CONSTRAINT [hecho_ventas_id_producto_foreign] FOREIGN KEY([id_producto])
REFERENCES [dbo].[dim_producto] ([id_producto])
GO
ALTER TABLE [dbo].[hecho_ventas] CHECK CONSTRAINT [hecho_ventas_id_producto_foreign]
GO
ALTER TABLE [dbo].[hecho_ventas]  WITH CHECK ADD  CONSTRAINT [hecho_ventas_id_segmento_foreign] FOREIGN KEY([id_segmento])
REFERENCES [dbo].[dim_segmento] ([id_segmento])
GO
ALTER TABLE [dbo].[hecho_ventas] CHECK CONSTRAINT [hecho_ventas_id_segmento_foreign]
GO
ALTER TABLE [dbo].[hecho_ventas]  WITH CHECK ADD  CONSTRAINT [hecho_ventas_id_tiempo_foreign] FOREIGN KEY([id_tiempo])
REFERENCES [dbo].[dim_tiempo] ([id_fecha])
GO
ALTER TABLE [dbo].[hecho_ventas] CHECK CONSTRAINT [hecho_ventas_id_tiempo_foreign]
GO
USE [master]
GO
ALTER DATABASE [FASE1] SET  READ_WRITE 
GO
