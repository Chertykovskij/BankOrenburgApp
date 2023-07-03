-- �������� ���� ������
CREATE DATABASE BankDB;
GO

-- ������������� ���� ������
USE BankDB;
GO

-- �������� ������� "���������"
CREATE TABLE Positions (
    ID INT PRIMARY KEY IDENTITY,
    NamePosition NVARCHAR(100)
);
GO

-- �������� ������� "������"
CREATE TABLE Departments (
    ID INT PRIMARY KEY IDENTITY,
    NameDepartment NVARCHAR(100)
);
GO

-- �������� ������� "�����������"
CREATE TABLE Organizations (
    ID INT PRIMARY KEY IDENTITY,
    NameOrganization NVARCHAR(100)
);
GO

-- �������� ������� "����������"
CREATE TABLE Employees  (
    ID INT PRIMARY KEY IDENTITY,
    LastName NVARCHAR(100),
    FirstName NVARCHAR(100),
    PatronymicName NVARCHAR(100),
    ServiceNumber NVARCHAR(10) UNIQUE,
    E_mail NVARCHAR(100) UNIQUE,
    DateStart DATE,
    DateEnd DATE
);
GO

-- �������� ������� "���������-���������" (������� �������)
CREATE TABLE EmployeePosition (
	ID INT PRIMARY KEY IDENTITY,
	Employee INT,
	Position INT,	
	StartDate DATE,
	FOREIGN KEY (Employee) REFERENCES Employees(ID),
	FOREIGN KEY (Position) REFERENCES Positions(ID),
);
GO

-- �������� ������� "���������-�����" (������� �������)
CREATE TABLE EmployeeDepartment (
	ID INT PRIMARY KEY IDENTITY,
	Employee INT,
	Department INT,
	StartDate DATE,
	FOREIGN KEY (Employee) REFERENCES Employees(ID),
	FOREIGN KEY (Department) REFERENCES Departments(ID),
);
GO

-- �������� ������� "�������� � �������������"
CREATE TABLE ContractsWithOrganizations (
    ID INT PRIMARY KEY IDENTITY,
    DateStart DATE,
    DateEnd DATE,
    ContractNumber NVARCHAR(100) UNIQUE,
    Price DECIMAL(18, 2),
    Organization INT,
    ResponsibleForExecution INT,
    Accountant INT,
    FOREIGN KEY (Organization) REFERENCES Organizations(ID),
    FOREIGN KEY (ResponsibleForExecution) REFERENCES Employees(ID),
    FOREIGN KEY (Accountant) REFERENCES Employees(ID)
);
GO

-- ���������� ������ ��������� �������

-- ������� "���������"
INSERT INTO Positions (NamePosition)
VALUES
    ('��������'),
    ('���������'),
    ('��������');
GO

-- ������� "������"
INSERT INTO Departments(NameDepartment)
VALUES
    ('����� ������'),
    ('�����������'),
    ('����� ���������');
GO

-- ������� "�����������"
INSERT INTO Organizations(NameOrganization)
VALUES
    ('����������� �'),
    ('����������� �'),
    ('����������� �');
GO

-- ������� "����������"
INSERT INTO Employees
VALUES
    ('������', '����', '��������', '001', 'ivanov@example.com', '2022-01-01', NULL),
    ('������', '����', '��������', '002', 'petrov@example.com', '2022-02-01', NULL),
    ('�������', '�����', '���������', '003', 'sidorov@example.com', '2021-03-01', NULL),
	('�������', '�������', '������������', '005', 'smirnov@example.com', '2022-04-01', NULL),
    ('��������', '�������', '��������', '006', 'nikolaev@example.com', '2022-05-01', NULL);
GO


INSERT INTO EmployeePosition
VALUES
	(1,1),
	(2,1),
	(3,2),
	(4,2),
	(5,3);
GO

INSERT INTO EmployeeDepartment
VALUES
	(1,1),
	(2,1),
	(3,2),
	(4,2),
	(5,3);
GO


-- ������� "�������� � �������������"
INSERT INTO ContractsWithOrganizations 
VALUES
    ('2023-01-01', '2023-12-31', '001/2022', 50000.00, 1, 1, 3),
    ('2023-02-01', '2023-11-30', '002/2022', 75000.00, 2, 2, 3),
    ('2023-03-01', '2023-10-31', '003/2022', 100000.00, 3, 2, 4);
GO


SELECT e.LastName, p.NamePosition, d.NameDepartment
FROM Employees e
INNER JOIN EmployeePosition ep ON ep.Employee = e.ID
INNER JOIN Positions p ON p.ID = ep.Position
INNER JOIN EmployeeDepartment ed ON ed.Employee = e.ID
INNER JOIN Departments d ON d.ID = ed.Department


