create database PE_PRN_Sum25B5_WA
go
use PE_PRN_Sum25B5_WA
go
-- Tạo bảng Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(255) NOT NULL,
    ManagerID INT NULL
);
go
-- Tạo bảng Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    DOB DATE,
    DepartmentID INT,
    Position NVARCHAR(255),
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
go
-- Cập nhật bảng Departments để thêm khóa ngoại cho ManagerID sau khi tạo bảng Employees
ALTER TABLE Departments ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID);
go
-- Tạo bảng Projects
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(255) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(18, 2)
);
go
-- Tạo bảng Skills
CREATE TABLE Skills (
    SkillID INT PRIMARY KEY IDENTITY(1,1),
    SkillName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX)
);
go
-- Tạo bảng Employee_Projects để lưu trữ mối quan hệ N-N giữa Employees và Projects
CREATE TABLE Employee_Projects (
    EmployeeID INT,
    ProjectID INT,
    Role NVARCHAR(255),
    JoinDate DATE,
    LeaveDate DATE,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
go
-- Tạo bảng Employee_Skills để lưu trữ mối quan hệ N-N giữa Employees và Skills
CREATE TABLE Employee_Skills (
    EmployeeID INT,
    SkillID INT,
    ProficiencyLevel NVARCHAR(255),
    AcquiredDate DATE,
    PRIMARY KEY (EmployeeID, SkillID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);
go
INSERT INTO Departments (DepartmentName) VALUES ('Software Development');
INSERT INTO Departments (DepartmentName) VALUES ('Human Resources');
INSERT INTO Departments (DepartmentName) VALUES ('Quality Assurance');
INSERT INTO Departments (DepartmentName) VALUES ('IT Support');
INSERT INTO Departments (DepartmentName) VALUES ('Sales');

INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('John Doe', '1985-02-15', 1, 'Senior Developer', '2010-03-01');
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Jane Smith', '1990-04-22', 2, 'HR Manager', '2012-07-15');
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Emily Johnson', '1988-09-05', 3, 'QA Engineer', '2015-01-20');
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Michael Brown', '1975-08-12', 4, 'IT Support Specialist', '2005-05-30');
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Sarah Miller', '1982-12-03', 5, 'Sales Representative', '2013-09-01');
UPDATE Departments SET ManagerID = 2 WHERE DepartmentName = 'Human Resources';
UPDATE Departments SET ManagerID = 1 WHERE DepartmentName = 'Software Development';
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Alice Johnson', '1992-11-05', 1, 'Developer', '2020-04-01');
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Bob Williams', '1989-03-15', 2, 'HR Specialist', '2021-05-01');
UPDATE Departments SET ManagerID = 3 WHERE DepartmentName = 'Quality Assurance';
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Charlie Davis', '1993-07-22', 3, 'QA Tester', '2022-01-15');
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Diana Evans', '1985-02-18', 4, 'IT Support Engineer', '2019-08-25');
INSERT INTO Employees (Name, DOB, DepartmentID, Position, HireDate) VALUES ('Evan Smith', '1991-10-09', 5, 'Sales Associate', '2021-02-20');

-- Chèn dữ liệu vào bảng Projects
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES ('Project Alpha', '2021-01-01', '2021-12-31', 50000);
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES ('Project Beta', '2021-03-15', '2022-03-14', 75000);
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES ('Project Gamma', '2021-06-01', '2021-11-30', 60000);
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES ('Project Delta', '2021-09-01', '2022-08-31', 85000);
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES ('Project Epsilon', '2021-11-15', '2022-05-15', 45000);

-- Chèn dữ liệu vào bảng Skills
INSERT INTO Skills (SkillName, Description) VALUES ('Java', 'Java programming language');
INSERT INTO Skills (SkillName, Description) VALUES ('Python', 'Python programming language');
INSERT INTO Skills (SkillName, Description) VALUES ('SQL', 'Database query language');
INSERT INTO Skills (SkillName, Description) VALUES ('Project Management', 'Managing and leading projects');
INSERT INTO Skills (SkillName, Description) VALUES ('Communication', 'Effective communication skills');

-- Project Alpha (ProjectID = 1) có 3 nhân viên
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (1, 1, 'Developer', '2021-01-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (3, 1, 'QA Analyst', '2021-01-15');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (5, 1, 'Sales Analyst', '2021-02-01');

-- Project Beta (ProjectID = 2) có 2 nhân viên
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (1, 2, 'Lead Developer', '2021-03-15');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (2, 2, 'HR Consultant', '2021-03-20');

-- Project Gamma (ProjectID = 3) có 4 nhân viên
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (3, 3, 'QA Lead', '2021-06-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (4, 3, 'Support Engineer', '2021-06-10');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (1, 3, 'Developer', '2021-07-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (2, 3, 'HR Support', '2021-07-15');

-- Project Delta (ProjectID = 4) có 2 nhân viên
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (4, 4, 'Support Lead', '2021-09-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (5, 4, 'Sales Lead', '2021-10-01');

-- Project Epsilon (ProjectID = 5) có 3 nhân viên
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (5, 5, 'Sales Lead', '2021-11-15');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (3, 5, 'QA Specialist', '2021-12-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (2, 5, 'HR Advisor', '2022-01-01');

INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (6, 1, 'Developer', '2020-04-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (6, 2, 'Developer', '2020-05-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (7, 3, 'HR Support', '2021-06-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (8, 4, 'QA Tester', '2022-02-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (8, 5, 'QA Tester', '2022-03-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (9, 2, 'IT Support', '2019-09-01');
INSERT INTO Employee_Projects (EmployeeID, ProjectID, Role, JoinDate) VALUES (10, 3, 'Sales Support', '2021-03-01');

-- Nhân viên 1 có 3 kỹ năng
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (1, 1, 'Expert', '2010-03-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (1, 2, 'Intermediate', '2012-07-15');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (1, 3, 'Advanced', '2013-01-20');

-- Nhân viên 2 có 2 kỹ năng
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (2, 4, 'Expert', '2012-08-10');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (2, 5, 'Advanced', '2014-05-15');

-- Nhân viên 3 có 4 kỹ năng
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (3, 1, 'Beginner', '2015-02-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (3, 2, 'Intermediate', '2016-03-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (3, 3, 'Expert', '2017-04-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (3, 4, 'Advanced', '2018-05-01');

-- Nhân viên 4 có 2 kỹ năng
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (4, 3, 'Intermediate', '2006-06-15');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (4, 4, 'Expert', '2007-07-20');

-- Nhân viên 5 có 3 kỹ năng
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (5, 2, 'Beginner', '2013-08-25');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (5, 4, 'Intermediate', '2014-09-30');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (5, 5, 'Advanced', '2015-10-05');
-- Alice Johnson
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (6, 1, 'Intermediate', '2020-04-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (6, 2, 'Beginner', '2020-05-01');

-- Bob Williams
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (7, 4, 'Advanced', '2021-06-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (7, 5, 'Intermediate', '2021-07-01');

-- Charlie Davis
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (8, 3, 'Expert', '2022-02-01');

-- Diana Evans
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (9, 3, 'Intermediate', '2019-09-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (9, 5, 'Beginner', '2019-10-01');

-- Evan Smith
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (10, 4, 'Intermediate', '2021-03-01');
INSERT INTO Employee_Skills (EmployeeID, SkillID, ProficiencyLevel, AcquiredDate) VALUES (10, 5, 'Advanced', '2021-04-01');