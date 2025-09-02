CREATE DATABASE Tambo;
GO

USE Tambo;
GO

CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name NVARCHAR(15) UNIQUE NOT NULL
);
INSERT INTO Roles (role_name) VALUES ('Admin'), ('Invitado'), ('Editor');
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
    active BIT DEFAULT 1,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
GO

CREATE TABLE AnimalTypes (
    type_id INT PRIMARY KEY IDENTITY(1,1),
    type_name NVARCHAR(25) UNIQUE NOT NULL
);
INSERT INTO AnimalTypes (type_name) VALUES ('Ternero'), ('Vaca'), ('Toro');
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
INSERT INTO AnimalStatuses (animal_status_name) VALUES ('Vivo'), ('Muerto'), ('Enfermo'), ('Pariendo'), ('Vendido');
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
INSERT INTO Origins (origin_name) VALUES ('Propio'), ('Comprado');
GO

CREATE TABLE Animals (
    animal_id NVARCHAR(5) PRIMARY KEY,
    species_id INT,
    type_id INT,
    sex_id INT,
    birth_date DATE,
    mother_id NVARCHAR(5) NULL,
    father_id NVARCHAR(5) NULL,
    origin_id INT,
    animal_status_id INT,
    notes NVARCHAR(500),
    active BIT DEFAULT 1,
    FOREIGN KEY (type_id) REFERENCES AnimalTypes(type_id),
    FOREIGN KEY (species_id) REFERENCES AnimalSpecies(species_id),
    FOREIGN KEY (animal_status_id) REFERENCES AnimalStatuses(animal_status_id),
    FOREIGN KEY (sex_id) REFERENCES Sexes(sex_id),
    FOREIGN KEY (origin_id) REFERENCES Origins(origin_id),
    FOREIGN KEY (mother_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (father_id) REFERENCES Animals(animal_id)
);
GO

INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES ('TO001', 1, 3, 1, '2019-03-12', NULL, NULL, 1, 1, 'Adan');
INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES ('VA001', 1, 2, 2, '2018-11-05', NULL, NULL, 1, 1, 'Eva');
INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES ('VA002', 1, 2, 2, '2020-03-12', 'VA001', 'TO001', 1, 1, 'Cain');
INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES ('TO002', 2, 3, 1, '2020-05-20', 'VA002', 'TO001', 1, 1, 'Abel');
INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES ('VA003', 2, 2, 2, '2020-07-11', 'VA002', 'TO002', 1, 1, 'Set');
INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES ('VA004', 1, 2, 2, '2022-04-10', 'VA003', 'TO002', 1, 1, 'Nieto 1');
INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES ('TO003', 1, 3, 1, '2022-06-15', 'VA004', 'TO002', 1, 1, 'Nieta 2');

CREATE TABLE AnimalEventTypes (
    animal_event_type_id INT PRIMARY KEY IDENTITY(1,1),
    animal_event_name NVARCHAR(15) UNIQUE NOT NULL
);
INSERT INTO AnimalEventTypes (animal_event_name) VALUES ('Vacuna'), ('Enfermedad'), ('Nacimiento'), ('Inseminación'), ('Destete'), ('Castración'), ('Venta'), ('Faena');
GO

CREATE TABLE AnimalEvents (
    event_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id NVARCHAR(5),
    animal_event_type_id INT,
    event_date DATE,
    description NVARCHAR(500),
    active BIT DEFAULT 1,
    FOREIGN KEY (animal_event_type_id) REFERENCES AnimalEventTypes(animal_event_type_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE VaccineTypes (
    vaccine_type_id INT PRIMARY KEY IDENTITY(1,1),
    vaccine_type_name NVARCHAR(40) UNIQUE NOT NULL
);
INSERT INTO VaccineTypes (vaccine_type_name) VALUES ('Antiparasitica'), ('Viral'), ('Fiebre'), ('Rabia');
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
INSERT INTO FeedingTypes (feeding_type_name) VALUES ('FeedLot'), ('Pastura'), ('Mixto');
GO

CREATE TABLE FatteningLots (
    lot_id INT PRIMARY KEY IDENTITY(1,1),
    entry_date DATE,
    exit_date DATE,
    feeding_type_id INT,
    active BIT DEFAULT 1,
    FOREIGN KEY (feeding_type_id) REFERENCES FeedingTypes(feeding_type_id)
);
GO

CREATE TABLE AnimalFattening (
    record_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id NVARCHAR(5) NULL,
    lot_id INT NULL,
    initial_weight DECIMAL(10,2),
    final_weight DECIMAL(10,2),
    entry_date DATE,
    exit_date DATE,
    active BIT DEFAULT 1,
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
INSERT INTO CropTypes (crop_type_name) VALUES ('Verdeo'), ('Alfalfa'), ('Trigo');
GO

CREATE TABLE Crops (
    crop_id INT PRIMARY KEY IDENTITY(1,1),
    plot_id INT NULL,
    crop_type_id INT,
    planting_date DATE,
    harvest_date DATE,
    active BIT DEFAULT 1,
    FOREIGN KEY (plot_id) REFERENCES Plots(plot_id),
    FOREIGN KEY (crop_type_id) REFERENCES CropTypes(crop_type_id)
);
GO

CREATE TABLE Recurrence (
    recurrence_id INT PRIMARY KEY IDENTITY(1,1),
    recurrence_name NVARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO Recurrence (recurrence_name) VALUES ('Una vez'), ('Diaria'), ('Semanal'), ('Mensual'), ('Anual');
GO

CREATE TABLE ReminderStatuses (
    reminder_status_id INT PRIMARY KEY IDENTITY(1,1),
    reminder_status_name NVARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO ReminderStatuses (reminder_status_name) VALUES ('Pendiente'), ('Completado'), ('En proceso');
GO

CREATE TABLE Reminders (
    task_id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(200),
    description NVARCHAR(500),
    scheduled_date DATE,
    recurrence_id INT,
    reminder_status_id INT,
    active BIT DEFAULT 1,
    FOREIGN KEY (recurrence_id) REFERENCES Recurrence(recurrence_id),
    FOREIGN KEY (reminder_status_id) REFERENCES ReminderStatuses(reminder_status_id)
);
GO

CREATE TABLE ExpenseCategories (
    expense_category_id INT PRIMARY KEY IDENTITY(1,1),
    expense_category_name NVARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO ExpenseCategories (expense_category_name) VALUES ('Compra vacas'), ('Compra terneros'), ('Comida'), ('Sanidad'), ('Personal'), ('Transporte');
GO

CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY IDENTITY(1,1),
    expense_category_id INT,
    expense_date DATE,
    description NVARCHAR(500),
    amount DECIMAL(10,2),
    active BIT DEFAULT 1,
    FOREIGN KEY (expense_category_id) REFERENCES ExpenseCategories(expense_category_id)
);
GO

CREATE TABLE BackupTypes (
    backup_type_id INT PRIMARY KEY IDENTITY(1,1),
    backup_type_name NVARCHAR(10) UNIQUE NOT NULL
);
INSERT INTO BackupTypes (backup_type_name) VALUES ('Manual'), ('Automatico');
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
    animal_id NVARCHAR(5) NULL,
    measurement_date DATE NULL,
    weight_kg DECIMAL(10,2) NULL,
    notes NVARCHAR(500),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE CropProductionHistory (
    production_id INT PRIMARY KEY IDENTITY(1,1),
    crop_id INT NULL,
    harvest_date DATE NULL,
    quantity_kg DECIMAL(10,2) NULL,
    quality DECIMAL (5,2) CHECK (quality >= 0 AND quality <= 100), -- un valor entre 0.00 y 100.00
    notes NVARCHAR(500),
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id)
);
GO

CREATE TABLE BreedingAttempts (
    attempt_id INT PRIMARY KEY IDENTITY(1,1),
    female_id NVARCHAR(5) NULL,
    male_id NVARCHAR(5) NULL, -- Opcional. Si tiene un toro asociado, ínseminación natural, si no, inseminación artificial.
    attempt_date DATE NULL,
    success BIT NULL, -- NULL = desconocido, 1 = exito, 0 = fallido
    pregnancy_confirmed_date DATE NULL,
    notes NVARCHAR(500) NULL,
    FOREIGN KEY (female_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (male_id) REFERENCES Animals(animal_id)
);
GO

CREATE TABLE FeedingHistory (
    feeding_record_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id NVARCHAR(5) NULL,
    lot_id INT NULL,
    feeding_date DATE NULL,
    feeding_type_id INT,
    quantity_kg DECIMAL(8,2) NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (feeding_type_id) REFERENCES FeedingTypes(feeding_type_id),
    FOREIGN KEY (lot_id) REFERENCES FatteningLots(lot_id)
);
GO