-- ========================================
-- Movie Store Database Script (Microsoft SQL Server)
-- ========================================

-- 1. Create the database
--DROP database MovieStoreDB;
IF DB_ID(N'MovieStoreDB') IS NOT NULL
BEGIN
    ALTER DATABASE MovieStoreDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MovieStoreDB;
END
GO


CREATE DATABASE MovieStoreDB;
GO

-- 2. Use the database
USE MovieStoreDB;
GO

-- ========================================
-- TABLES
-- ========================================

-- Directors table
CREATE TABLE Directors (
    DirectorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE
);

-- Stars (Actors/Actresses) table
CREATE TABLE Stars (
    StarID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    Gender NVARCHAR(10)
);

-- Movies table
CREATE TABLE Movies (
    MovieID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    ReleaseYear INT,
    Genre NVARCHAR(50),
    AvailableCopies INT DEFAULT 0,
    DirectorID INT FOREIGN KEY REFERENCES Directors(DirectorID)
);

-- Junction table for Many-to-Many relationship between Movies and Stars
CREATE TABLE MovieStars (
    MovieID INT FOREIGN KEY REFERENCES Movies(MovieID),
    StarID INT FOREIGN KEY REFERENCES Stars(StarID),
    RoleName NVARCHAR(100),
    PRIMARY KEY (MovieID, StarID)
);

-- Reviews table
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    MovieID INT FOREIGN KEY REFERENCES Movies(MovieID),
    ReviewerName NVARCHAR(100),
    Rating DECIMAL(2,1) CHECK (Rating BETWEEN 0 AND 10),
    Comment NVARCHAR(500),
    ReviewDate DATE DEFAULT GETDATE()
);

-- ========================================
-- INSERT SAMPLE DATA
-- ========================================

-- Directors
INSERT INTO Directors (FirstName, LastName, BirthDate)
VALUES
('Christopher', 'Nolan', '1970-07-30'),
('Steven', 'Spielberg', '1946-12-18'),
('Quentin', 'Tarantino', '1963-03-27');

-- Stars
INSERT INTO Stars (FirstName, LastName, BirthDate, Gender)
VALUES
('Leonardo', 'DiCaprio', '1974-11-11', 'Male'),
('Joseph', 'Gordon-Levitt', '1981-02-17', 'Male'),
('Elliot', 'Page', '1987-02-21', 'Non-binary'),
('Tom', 'Hanks', '1956-07-09', 'Male'),
('Samuel L.', 'Jackson', '1948-12-21', 'Male'),
('Uma', 'Thurman', '1970-04-29', 'Female');

-- Movies
INSERT INTO Movies (Title, ReleaseYear, Genre, AvailableCopies, DirectorID)
VALUES
('Inception', 2010, 'Sci-Fi', 5, 1),
('Saving Private Ryan', 1998, 'War', 3, 2),
('Pulp Fiction', 1994, 'Crime', 4, 3);

-- MovieStars (actors in movies)
INSERT INTO MovieStars (MovieID, StarID, RoleName)
VALUES
(1, 1, 'Dom Cobb'),
(1, 2, 'Arthur'),
(1, 3, 'Ariadne'),
(2, 4, 'Captain John H. Miller'),
(3, 5, 'Jules Winnfield'),
(3, 6, 'Mia Wallace');

-- Reviews
INSERT INTO Reviews (MovieID, ReviewerName, Rating, Comment)
VALUES
(1, 'Alice Nguyen', 9.5, 'Mind-bending and visually stunning!'),
(1, 'John Smith', 9.0, 'Brilliant concept and direction by Nolan.'),
(2, 'Chris Lee', 8.7, 'Emotional and powerful depiction of war.'),
(3, 'Sarah Tran', 9.3, 'Iconic dialogue and storytelling from Tarantino.');
