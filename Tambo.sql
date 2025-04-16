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
    StockQuantity INT NOT NULL,
    ProductCategory NVARCHAR(50) NOT NULL,
    ProductShape NVARCHAR(50) NOT NULL
);
GO

INSERT INTO dbo.Products (Name, Description, UnitPrice, StockQuantity, ProductCategory, ProductShape) VALUES
('Whole Milk', 'Fresh whole milk 1L', 1.50, 120, 'Dairy', 'Bottle'),
('Yogurt', 'Plain yogurt 500ml', 2.00, 150, 'Dairy', 'Cup'),
('Chicken Breast', 'Boneless, skinless chicken breast', 6.50, 100, 'Meat', 'Grain'),
('Beef Steaks', 'Premium beef steaks', 12.00, 70, 'Meat', 'Grain'),
('Ground Beef', 'Lean ground beef 500g', 6.20, 100, 'Meat', 'Grain'),
('Pork Sausages', 'Pork sausages 500g', 5.00, 120, 'Meat', 'Grain'),
('Pickles', 'Crispy dill pickles 500g', 3.00, 90, 'Pickles', 'Jar'),
('BBQ Sauce', 'Sweet and smoky BBQ sauce 500ml', 3.50, 80, 'Sauce', 'Bottle'),
('Olive Oil', 'Cold-pressed olive oil 500ml', 5.50, 120, 'Sauce', 'Bottle'),
('Ketchup', 'Tomato ketchup 500ml', 2.00, 200, 'Sauce', 'Bottle'),
('Tomato Sauce', 'Classic tomato sauce 500ml', 2.20, 130, 'Sauce', 'Bottle'),
('Mayonnaise', 'Creamy mayonnaise 250ml', 2.00, 140, 'Sauce', 'Bottle'),
('Pickled Onions', 'Pickled red onions 500g', 3.20, 100, 'Pickles', 'Jar'),
('Eggs', 'Large eggs, dozen', 2.00, 150, 'Dairy', 'Carton'),
('Honey Mustard', 'Honey mustard sauce 250ml', 3.00, 110, 'Sauce', 'Bottle');


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

INSERT INTO dbo.Users (Email, PasswordHash)
VALUES ('admin@example.com', '$2a$10$Q9zVsvDZ38PHK65gQuje7OYT2RbD2VLqBj67DOXM4CqOyWuvSlZva');
