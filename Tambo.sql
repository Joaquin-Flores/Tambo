CREATE DATABASE Tambo;
GO

USE Tambo;
GO

CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name NVARCHAR(15) UNIQUE NOT NULL
);
INSERT INTO Roles (role_name) VALUES ('Admin'), ('Guest'), ('Editor');
GO

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    email NVARCHAR(80) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    role_id INT NOT NULL,
    last_login DATETIME2(0) NULL,
    reset_token NVARCHAR(10) NULL,
    reset_token_expiry DATETIME2(0) NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
GO

CREATE TABLE AnimalTypes (
    type_id INT PRIMARY KEY IDENTITY(1,1),
    type_name NVARCHAR(25) UNIQUE NOT NULL
);
INSERT INTO AnimalTypes (type_name) VALUES ('Calf'), ('Cow'), ('Bull');
GO

CREATE TABLE AnimalSpecies (
    species_id INT PRIMARY KEY IDENTITY(1,1),
    species_name NVARCHAR(15) UNIQUE NOT NULL
);
INSERT INTO AnimalSpecies (species_name) VALUES ('Angus'), ('Brangus'), ('Jersey'), ('Orlando'), ('Brahman'), ('Hereford'), ('Braford'), ('Charolais'), ('Limousin'), ('Shorthorn'), ('Pardo Suizo');
GO

CREATE TABLE AnimalStatuses (
    animal_status_id INT PRIMARY KEY IDENTITY(1,1),
    animal_status_name NVARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO AnimalStatuses (animal_status_name) VALUES ('Alive'), ('Dead'), ('Sick'), ('Birthing');
GO

CREATE TABLE Sexes (
    sex_id INT PRIMARY KEY IDENTITY(1,1),
    sex_name NVARCHAR(1) UNIQUE NOT NULL
);
INSERT INTO Sexes (sex_name) VALUES ('M'), ('F');
GO

CREATE TABLE Origins (
    origin_id INT PRIMARY KEY IDENTITY(1,1),
    origin_name NVARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO Origins (origin_name) VALUES ('Born'), ('Purchased');
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
    animal_status_id INT,
    notes NVARCHAR(500),
    FOREIGN KEY (type_id) REFERENCES AnimalTypes(type_id),
    FOREIGN KEY (species_id) REFERENCES AnimalSpecies(species_id),
    FOREIGN KEY (animal_status_id) REFERENCES AnimalStatuses(animal_status_id),
    FOREIGN KEY (sex_id) REFERENCES Sexes(sex_id),
    FOREIGN KEY (origin_id) REFERENCES Origins(origin_id),
    FOREIGN KEY (mother_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (father_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE AnimalEventTypes (
    animal_event_type_id INT PRIMARY KEY IDENTITY(1,1),
    animal_event_name NVARCHAR(15) UNIQUE NOT NULL
);
INSERT INTO AnimalEventTypes (animal_event_name) VALUES ('Vaccine'), ('Disease'), ('Birth'), ('Insemination'), ('Weaning'), ('Castration');
GO

CREATE TABLE AnimalEvents (
    event_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT NOT NULL,
    animal_event_type_id INT,
    event_date DATE,
    description NVARCHAR(500),
    FOREIGN KEY (animal_event_type_id) REFERENCES AnimalEventTypes(animal_event_type_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE VaccineTypes (
    vaccine_type_id INT PRIMARY KEY IDENTITY(1,1),
    vaccine_type_name NVARCHAR(40) UNIQUE NOT NULL
);
INSERT INTO VaccineTypes (vaccine_type_name) VALUES ('Antiparasitic'), ('Viral'), ('Flu'), ('Rabies');
GO

CREATE TABLE Vaccines (
    vaccine_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(80) NOT NULL,
    vaccine_type_id INT NOT NULL,
    supplier NVARCHAR(70),
    batch NVARCHAR(50),
    expiration_date DATE NOT NULL,
    FOREIGN KEY (vaccine_type_id) REFERENCES VaccineTypes(vaccine_type_id)
);
GO

CREATE TABLE FeedingTypes (
    feeding_type_id INT PRIMARY KEY IDENTITY(1,1),
    feeding_type_name NVARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO FeedingTypes (feeding_type_name) VALUES ('FeedLot'), ('Pasture'), ('Mixed');
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
    name NVARCHAR(100),
    area_m2 INT,
    notes NVARCHAR(500)
);
GO

CREATE TABLE CropTypes (
    crop_type_id INT PRIMARY KEY IDENTITY(1,1),
    crop_type_name NVARCHAR(20) UNIQUE NOT NULL
);
INSERT INTO CropTypes (crop_type_name) VALUES ('Verdeum'), ('Alfalfus'), ('Trigum');
GO

CREATE TABLE Crops (
    crop_id INT PRIMARY KEY IDENTITY(1,1),
    plot_id INT NOT NULL,
    crop_type_id INT,
    planting_date DATE,
    harvest_date DATE,
    FOREIGN KEY (plot_id) REFERENCES Plots(plot_id),
    FOREIGN KEY (crop_type_id) REFERENCES CropTypes(crop_type_id)
);
GO

CREATE TABLE Recurrence (
    recurrence_id INT PRIMARY KEY IDENTITY(1,1),
    recurrence_name NVARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO Recurrence (recurrence_name) VALUES ('Daily'), ('Weekly'), ('Monthly'), ('Yearly');
GO

CREATE TABLE ReminderStatuses (
    reminder_status_id INT PRIMARY KEY IDENTITY(1,1),
    reminder_status_name NVARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO ReminderStatuses (reminder_status_name) VALUES ('Pending'), ('Completed'), ('In Process');
GO

CREATE TABLE Reminders (
    task_id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(200),
    description NVARCHAR(500),
    scheduled_date DATE,
    recurrence_id INT,
    alert BIT,
    reminder_status_id INT,
    FOREIGN KEY (recurrence_id) REFERENCES Recurrence(recurrence_id),
    FOREIGN KEY (reminder_status_id) REFERENCES ReminderStatuses(reminder_status_id)
);
GO

CREATE TABLE ExpenseCategories (
    expense_category_id INT PRIMARY KEY IDENTITY(1,1),
    expense_category_name NVARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO ExpenseCategories (expense_category_name) VALUES ('Buy Cows'), ('Buy Calves'), ('Food'), ('Sanity'), ('Staff'), ('Transport');
GO

CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY IDENTITY(1,1),
    expense_category_id INT,
    expense_date DATE,
    description NVARCHAR(500),
    amount DECIMAL(10,2),
    FOREIGN KEY (expense_category_id) REFERENCES ExpenseCategories(expense_category_id)
);
GO

CREATE TABLE BackupTypes (
    backup_type_id INT PRIMARY KEY IDENTITY(1,1),
    backup_type_name NVARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO BackupTypes (backup_type_name) VALUES ('Manual'), ('Automatic');
GO

CREATE TABLE Backups (
    backup_id INT PRIMARY KEY IDENTITY(1,1),
    backup_date DATETIME2(0) DEFAULT GETDATE(),
    file_path NVARCHAR(255),
    backup_type_id INT,
    FOREIGN KEY (backup_type_id) REFERENCES BackupTypes(backup_type_id)
);
GO

CREATE TABLE ExportedReports (
    report_id INT PRIMARY KEY IDENTITY(1,1),
    generated_at DATETIME2(0) DEFAULT GETDATE(),
    pdf_path NVARCHAR(255)
);
GO

CREATE TABLE AnimalWeightHistory (
    record_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT NOT NULL,
    measurement_date DATE NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL,
    notes NVARCHAR(500),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE CropProductionHistory (
    production_id INT PRIMARY KEY IDENTITY(1,1),
    crop_id INT NOT NULL,
    harvest_date DATE NOT NULL,
    quantity_kg DECIMAL(10,2) NOT NULL,
    quality DECIMAL (5,2) CHECK (quality >= 0 AND quality <= 100), -- un valor entre 0.00 y 100.00
    notes NVARCHAR(500),
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id)
);
GO

CREATE TABLE BreedingAttempts (
    attempt_id INT PRIMARY KEY IDENTITY(1,1),
    female_id INT NOT NULL,
    male_id INT NULL, -- Opcional. Si tiene un toro asociado, ínseminación natural, si no, inseminación artificial.
    attempt_date DATE NOT NULL,
    success BIT NULL, -- NULL = desconocido, 1 = exito, 0 = fallido
    pregnancy_confirmed_date DATE NULL,
    notes NVARCHAR(500) NULL,
    FOREIGN KEY (female_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (male_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE FeedingHistory (
    feeding_record_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT NULL,
    lot_id INT NULL,
    feeding_date DATE NOT NULL,
    feeding_type_id INT,
    quantity_kg DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (feeding_type_id) REFERENCES FeedingTypes(feeding_type_id),
    FOREIGN KEY (lot_id) REFERENCES FatteningLots(lot_id)
);
GO