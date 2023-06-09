USE [master]
GO
/****** Object:  Database [payroll_system]    Script Date: 5/1/2023 10:14:42 PM ******/
CREATE DATABASE [payroll_system]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'payroll_system', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\payroll_system.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'payroll_system_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\payroll_system_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [payroll_system] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [payroll_system].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [payroll_system] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [payroll_system] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [payroll_system] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [payroll_system] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [payroll_system] SET ARITHABORT OFF 
GO
ALTER DATABASE [payroll_system] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [payroll_system] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [payroll_system] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [payroll_system] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [payroll_system] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [payroll_system] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [payroll_system] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [payroll_system] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [payroll_system] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [payroll_system] SET  DISABLE_BROKER 
GO
ALTER DATABASE [payroll_system] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [payroll_system] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [payroll_system] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [payroll_system] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [payroll_system] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [payroll_system] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [payroll_system] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [payroll_system] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [payroll_system] SET  MULTI_USER 
GO
ALTER DATABASE [payroll_system] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [payroll_system] SET DB_CHAINING OFF 
GO
ALTER DATABASE [payroll_system] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [payroll_system] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [payroll_system] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [payroll_system] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [payroll_system] SET QUERY_STORE = OFF
GO
USE [payroll_system]
GO
/****** Object:  Table [dbo].[department]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[department_name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](50) NULL,
	[firstname] [varchar](50) NULL,
	[lastname] [varchar](50) NULL,
	[dateofbirth] [date] NULL,
	[age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee_position]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee_position](
	[employee_id] [int] NULL,
	[position_id] [int] NULL,
	[salary] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payroll]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payroll](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NULL,
	[payroll_amount] [int] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[position]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[position](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[position_name] [varchar](50) NULL,
	[department_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [idx_position_employee_position_id]    Script Date: 5/1/2023 10:14:42 PM ******/
CREATE NONCLUSTERED INDEX [idx_position_employee_position_id] ON [dbo].[employee_position]
(
	[position_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_employee_payroll_id]    Script Date: 5/1/2023 10:14:42 PM ******/
CREATE NONCLUSTERED INDEX [idx_employee_payroll_id] ON [dbo].[payroll]
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[employee] ADD  DEFAULT ((0)) FOR [age]
GO
ALTER TABLE [dbo].[employee_position]  WITH CHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[employee] ([id])
GO
ALTER TABLE [dbo].[employee_position]  WITH CHECK ADD FOREIGN KEY([position_id])
REFERENCES [dbo].[position] ([id])
GO
ALTER TABLE [dbo].[payroll]  WITH CHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[employee] ([id])
GO
ALTER TABLE [dbo].[position]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [dbo].[department] ([id])
GO
/****** Object:  StoredProcedure [dbo].[generatePayrollForAllEmployees]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[generatePayrollForAllEmployees] (@date_start date, @date_end date)
AS
BEGIN
    INSERT INTO payroll (employee_id, payroll_amount, start_date, end_date)
    SELECT employee_id, SUM(salary), @date_start, @date_end
    FROM employee_position
    GROUP BY employee_id
END
GO
/****** Object:  StoredProcedure [dbo].[generatePayrollForAllEmployees2]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[generatePayrollForAllEmployees2] (@date_start date, @date_end date)
AS
BEGIN
    IF @date_end < @date_start
    BEGIN
        RAISERROR('End date cannot be earlier than start date', 16, 1)
        RETURN
    END

    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO payroll (employee_id, payroll_amount, start_date, end_date)
        SELECT employee_id, SUM(salary), @date_start, @date_end
        FROM employee_position
        GROUP BY employee_id

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        RAISERROR('An error occurred while inserting data into the payroll table', 16, 1)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[generatePayRollForEmployee]    Script Date: 5/1/2023 10:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[generatePayRollForEmployee] (@employee_id INT, @date_start date, @date_end date)
AS
BEGIN
    INSERT INTO payroll VALUES (@employee_id, (SELECT SUM(salary) AS total_salary FROM employee_position WHERE employee_id = @employee_id GROUP BY employee_id), @date_start , @date_end)
END
GO
USE [master]
GO
ALTER DATABASE [payroll_system] SET  READ_WRITE 
GO
