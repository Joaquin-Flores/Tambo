CREATE DATABASE Tambo;
GO

USE TAMBO;
GO

CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role VARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO Roles (role_id) VALUES ('Admin'), ('Guest'), ('Editor');
GO

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    email NVARCHAR(80) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL,
    created_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    role_id INT,
    last_login DATETIME2(0) NULL,
    reset_token NVARCHAR(10) NULL,
    reset_token_expiry DATETIME2(0) NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
GO

CREATE TABLE AnimalTypes (
    type_id INT PRIMARY KEY IDENTITY(1,1),
    type_name VARCHAR(25) UNIQUE NOT NULL
);
INSERT INTO AnimalTypes (type_name) VALUES ('Calf'), ('Cow'), ('Bull');
GO

CREATE TABLE AnimalSpecies (
    species_id INT PRIMARY KEY IDENTITY(1,1),
    species_name VARCHAR(15) UNIQUE NOT NULL
);
INSERT INTO AnimalSpecies (species_id) VALUES ('Angus'), ('Brangus'), ('Jersey'), ('Orlando'), ('Brahman'), ('Hereford'), ('Braford'), ('Charolais'), ('Limousin'), ('Shorthorn'), ('Pardo Suizo');
GO

CREATE TABLE AnimalStatuses (
    status_id INT PRIMARY KEY IDENTITY(1,1),
    status_name VARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO AnimalStatuses (status_id) VALUES ('Alive'), ('Dead'), ('Sick'), ('Birthing');
GO

CREATE TABLE Sexes (
    sex_id INT PRIMARY KEY IDENTITY(1,1),
    sex_code VARCHAR(1) UNIQUE NOT NULL,
);
INSERT INTO Sexes (sex_id) VALUES ('M'), ('F');
GO

CREATE TABLE Origins (
    origin_id INT PRIMARY KEY IDENTITY(1,1),
    origin_name VARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO Origins (origin_id) VALUES ('Born'), ('Purchased');
GO

CREATE TABLE Animals (
    animal_id INT PRIMARY KEY IDENTITY(1,1),
    species_id INT,
    type_id INT,
    sex_id INT,
    birth_date DATE,
    mother_id INT,
    father_id INT,
    origin_id INT,
    status_id INT,
    notes TEXT,
    FOREIGN KEY (type_id) REFERENCES AnimalTypes(type_id),
    FOREIGN KEY (species_id) REFERENCES AnimalSpecies(species_id),
    FOREIGN KEY (status_id) REFERENCES AnimalStatuses(status_id),
    FOREIGN KEY (sex_id) REFERENCES Sexes(sex_id),
    FOREIGN KEY (origin_id) REFERENCES Origins(origin_id),
    FOREIGN KEY (mother_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (father_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE EventTypes (
    event_type_id INT PRIMARY KEY IDENTITY(1,1),
    event_name VARCHAR(15) UNIQUE NOT NULL
);
INSERT INTO EventTypes (event_type_id) VALUES ('Vaccine'), ('Disease'), ('Birth'), ('Disease');
GO

CREATE TABLE AnimalEvents (
    event_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT NOT NULL,
    event_type_id INT,
    event_date DATE,
    description TEXT,
    FOREIGN KEY (event_type_id) REFERENCES EventTypes(event_type_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE VaccineTypes (
    vaccine_type_id INT PRIMARY KEY IDENTITY(1,1),
    vaccine_type VARCHAR(40) UNIQUE NOT NULL
);
INSERT INTO VaccineTypes (vaccine_type_id) VALUES ('Antiparasitic'), ('Viral'), ('Flu'), ('Rabies');
GO

CREATE TABLE Vaccines (
    vaccine_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(80),
    vaccine_type_id INT,
    supplier VARCHAR(70),
    batch VARCHAR(50),
    expiration_date DATE,
    FOREIGN KEY (vaccine_type_id) REFERENCES VaccineTypes(vaccine_type_id)
);
GO

CREATE TABLE FeedingTypes (
    feeding_type_id INT PRIMARY KEY IDENTITY(1,1),
    feeding_type VARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO FeedingTypes (feeding_type_id) VALUES ('FeedLot'), ('Pasture'), ('Mixed');
GO

CREATE TABLE FatteningLots (
    lot_id INT PRIMARY KEY IDENTITY(1,1),
    entry_date DATE,
    exit_date DATE,
    feeding_type_id INT,
    FOREIGN KEY (feeding_type_id) REFERENCES FeedingTypes(feeding_type_id)
);
GO

CREATE TABLE AnimalFattening (
    record_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT NOT NULL,
    lot_id INT NOT NULL,
    initial_weight DECIMAL(10,2),
    final_weight DECIMAL(10,2),
    entry_date DATE,
    exit_date DATE,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (lot_id) REFERENCES FatteningLots(lot_id)
);
GO

CREATE TABLE Plots (
    plot_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    area_m2 INT,
    notes TEXT
);
GO

CREATE TABLE CropTypes (
    crop_type_id INT PRIMARY KEY IDENTITY(1,1),
    crop_type VARCHAR(20) UNIQUE NOT NULL
);
INSERT INTO CropTypes (crop_type_id) VALUES ('Verdeum'), ('Alfalfus'), ('Trigum');
GO

CREATE TABLE Crops (
    crop_id INT PRIMARY KEY IDENTITY(1,1),
    plot_id INT NOT NULL,
    crop_type_id INT,
    planting_date DATE,
    harvest_date DATE,
    inputs_used TEXT, -- seeds, compost, etc.
    FOREIGN KEY (plot_id) REFERENCES Plots(plot_id),
    FOREIGN KEY (crop_type_id) REFERENCES CropTypes(crop_type_id)
);
GO

CREATE TABLE Reminders (
    task_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(200),
    description TEXT,
    scheduled_date DATE,
    recurrence VARCHAR(50), -- Daily / Weekly / Monthly / None
    alert BIT,
    status VARCHAR(50) -- Pending / Completed
);
GO

CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY IDENTITY(1,1),
    category VARCHAR(100), -- Feeding / Health / Transport
    expense_date DATE,
    description TEXT,
    amount DECIMAL(10,2),
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

CREATE TABLE Backups (
    backup_id INT PRIMARY KEY IDENTITY(1,1),
    backup_date DATETIME DEFAULT GETDATE(),
    file_path VARCHAR(255),
    backup_type VARCHAR(50) -- Manual / Automatic
);
GO

CREATE TABLE ExportedReports (
    report_id INT PRIMARY KEY IDENTITY(1,1),
    report_type VARCHAR(100), -- Profitability, Production, etc.
    generated_at DATETIME DEFAULT GETDATE(),
    generated_by INT,
    pdf_path VARCHAR(255),
    FOREIGN KEY (generated_by) REFERENCES Users(user_id)
);
GO

CREATE TABLE AnimalWeightHistory (
    id_record INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT NOT NULL,
    measurement_date DATE NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL,
    notes TEXT,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE MilkProductionHistory (
    id_record INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT NOT NULL,
    milked_on DATE NOT NULL,
    liters_produced DECIMAL(10,2) NOT NULL,
    notes TEXT,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE EggLayingHistory (
    id_laying INT PRIMARY KEY IDENTITY(1,1),
    laying_date DATE NOT NULL,
    total_eggs INT NOT NULL,
    total_hens INT NOT NULL,
    laying_efficiency DECIMAL(5,2), -- (total_eggs / total_hens) * 100
    notes TEXT
);
GO

CREATE TABLE CropProductionHistory (
    id_production INT PRIMARY KEY IDENTITY(1,1),
    crop_id INT NOT NULL,
    harvest_date DATE NOT NULL,
    quantity_kg DECIMAL(10,2) NOT NULL,
    quality VARCHAR(50), -- Good / Regular / Poor
    notes TEXT,
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id)
);
GO

CREATE TABLE InputPriceHistory (
    id_input_price INT PRIMARY KEY IDENTITY(1,1),
    input_name VARCHAR(100) NOT NULL,
    supplier VARCHAR(100) NOT NULL,
    purchase_date DATE NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE ExpenseHistoryDetail (
    id_expense_history INT PRIMARY KEY IDENTITY(1,1),
    category VARCHAR(100) NOT NULL,
    subcategory VARCHAR(100) NOT NULL, -- E.g. "food → corn"
    expense_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    notes TEXT
);
GO
