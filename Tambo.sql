-- Create database
CREATE DATABASE Tambo;
GO

-- Use the new database
USE TAMBO;
GO

-- Create Products table
CREATE TABLE dbo.Products (
    ProductID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);
GO

-- Create Deliveries table
CREATE TABLE dbo.Deliveries (
    DeliveryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DeliveryDate DATE NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    Notes NVARCHAR(255)
);
GO

-- Create ProductDelivery (junction) table
CREATE TABLE dbo.ProductDelivery (
    ProductID INT NOT NULL,
    DeliveryID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (ProductID, DeliveryID),
    FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID),
    FOREIGN KEY (DeliveryID) REFERENCES dbo.Deliveries(DeliveryID)
);
GO

-- USERS table
CREATE TABLE dbo.Users (
    UserID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    LastLogin DATETIME2(0) NULL,
    ResetToken NVARCHAR(10) NULL,
    ResetTokenExpiry DATETIME2(0) NULL
);
GO