
USE abhi_bus;

-- User Table
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

-- Bus Table
CREATE TABLE Bus (
    BusID INT AUTO_INCREMENT PRIMARY KEY,
    BusNumber VARCHAR(20) NOT NULL,
    Type VARCHAR(50),
    Capacity INT,
    Status VARCHAR(20)
);

-- Route Table
CREATE TABLE Route (
    RouteID INT AUTO_INCREMENT PRIMARY KEY,
    DepartureLocation VARCHAR(100) NOT NULL,
    ArrivalLocation VARCHAR(100) NOT NULL,
    Distance DECIMAL(10,2),
    Duration TIME,
    Fare DECIMAL(10,2)
);

-- Booking Table
CREATE TABLE Booking (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    BusID INT,
    RouteID INT,
    Date DATE,
    Time TIME,
    Status VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (BusID) REFERENCES Bus(BusID),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);

-- Seat Table
CREATE TABLE Seat (
    SeatID INT AUTO_INCREMENT PRIMARY KEY,
    BusID INT,
    BookingID INT,
    SeatNumber VARCHAR(10),
    Availability BOOLEAN,
    FOREIGN KEY (BusID) REFERENCES Bus(BusID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);
-- Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    BookingID INT,
    Rating INT,
    Comments TEXT,
    Date DATE,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
    );

-- Admin Table
CREATE TABLE Admin (
    AdminID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATETIME,
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) );
-- BusSchedule Table
CREATE TABLE BusSchedule (
    ScheduleID INT AUTO_INCREMENT PRIMARY KEY,
    BusID INT,
    RouteID INT,
    DepartureTime TIME,
    ArrivalTime TIME,
    Status VARCHAR(20),
    FOREIGN KEY (BusID) REFERENCES Bus(BusID),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);

-- Promotion Table
CREATE TABLE Promotion (
    PromotionID INT AUTO_INCREMENT PRIMARY KEY,
    PromoCode VARCHAR(20) UNIQUE,
    DiscountPercentage DECIMAL(5,2),
    ExpiryDate DATE,
    Status VARCHAR(20)
);

-- Ticket Table
CREATE TABLE Ticket (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    SeatID INT,
    Price DECIMAL(10,2),
    TicketType VARCHAR(50),
    Status VARCHAR(20),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID)
);

-- RouteStop Table
CREATE TABLE RouteStop (
    RouteStopID INT AUTO_INCREMENT PRIMARY KEY,
    RouteID INT,
    StopName VARCHAR(100),
    ArrivalTime TIME,
    DepartureTime TIME,
    DistanceFromPreviousStop DECIMAL(10,2),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);

-- Driver Table
CREATE TABLE Driver (
    DriverID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    LicenseNumber VARCHAR(50) UNIQUE,
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255)
);


-- BusMaintenance Table
CREATE TABLE BusMaintenance (
    MaintenanceID INT AUTO_INCREMENT PRIMARY KEY,
    BusID INT,
    MaintenanceDate DATE,
    Description TEXT,
    Cost DECIMAL(10,2),
    Status VARCHAR(20),
    FOREIGN KEY (BusID) REFERENCES Bus(BusID)
);

-- AdminActivity Table
CREATE TABLE AdminActivity (
    ActivityID INT AUTO_INCREMENT PRIMARY KEY,
    AdminID INT,
    ActivityType VARCHAR(50),
    ActivityDate DATETIME,
    Description TEXT,
    IP_Address VARCHAR(50),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);

-- CancellationReason Table
CREATE TABLE CancellationReason (
    ReasonID INT AUTO_INCREMENT PRIMARY KEY,
    ReasonDescription VARCHAR(255) NOT NULL,
    BookingID INT,
    UserID INT,
    CancellationDate DATE,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);


-- Inserting data into the User table
INSERT INTO User (Username, Password, Email, Phone, Address) 
VALUES 
('Arjun', 'password123', 'arjun@example.com', '1234567890', '12A, MG Road, Bangalore'),
('Shivani', 'securepass', 'shivani@example.com', '0987654321', '45, Beach Road, Chennai'),
('Siddharth', 'siddharthpass', 'siddharth@example.com', '5551234567', '78, Kochi Street, Kochi'),
('Ananya', 'ananyapass', 'ananya@example.com', '9876543210', '23, Temple Road, Thanjavur'),
('Niharika', 'niharikapass', 'niharika@example.com', '1239876543', '56, Tea Estate Road, Ooty'),
('Vijay', 'vijaypass', 'vijay@example.com', '7778889999', '89, Marina Beach Road, Puducherry'),
('Sneha', 'snehapass', 'sneha@example.com', '1112223333', '34, Hill View Apartments, Coimbatore');

-- Inserting data into the Bus table
INSERT INTO Bus (BusNumber, Type, Capacity, Status) 
VALUES 
('BUS001', 'AC', 50, 'Active'),
('BUS002', 'Non-AC', 40, 'Active'),
('BUS003', 'Sleeper', 30, 'Inactive'),
('BUS004', 'AC', 45, 'Active'),
('BUS005', 'Non-AC', 35, 'Active'),
('BUS006', 'Sleeper', 25, 'Inactive'),
('BUS007', 'AC', 50, 'Active');


-- Inserting data into the Route table
INSERT INTO Route (DepartureLocation, ArrivalLocation, Distance, Duration, Fare) 
VALUES 
('Bangalore', 'Chennai', 300.5, '06:30:00', 30.00),
('Chennai', 'Kochi', 250.2, '05:00:00', 25.00),
('Bangalore', 'Kochi', 500.0, '09:00:00', 40.00),
('Thanjavur', 'Ooty', 350.0, '07:30:00', 35.00),
('Ooty', 'Puducherry', 280.5, '05:45:00', 30.00),
('Thanjavur', 'Puducherry', 600.0, '11:30:00', 50.00),
('Coimbatore', 'Kochi', 150.0, '03:00:00', 20.00);

-- Inserting data into the Booking table
INSERT INTO Booking (UserID, BusID, RouteID, Date, Time, Status) 
VALUES 
(1, 1, 1, '2024-04-10', '08:00:00', 'Confirmed'),
(2, 2, 2, '2024-04-12', '09:00:00', 'Pending'),
(3, 3, 3, '2024-04-15', '10:00:00', 'Cancelled'),
(4, 4, 4, '2024-04-18', '11:00:00', 'Confirmed'),
(5, 5, 5, '2024-04-20', '12:00:00', 'Confirmed'),
(6, 6, 6, '2024-04-22', '13:00:00', 'Pending'),
(7, 7, 7, '2024-04-25', '14:00:00', 'Confirmed');

-- Inserting data into the Seat table
INSERT INTO Seat (BusID, BookingID, SeatNumber, Availability) 
VALUES 
(1, 1, 'A1', 0),
(1, 1, 'A2', 1),
(2, 2, 'B1', 1),
(2, 2, 'B2', 0),
(3, 3, 'C1', 1),
(3, 3, 'C2', 1),
(4, 4, 'D1', 0);

-- Inserting data into the Feedback table
INSERT INTO Feedback (UserID, BookingID, Rating, Comments, Date) 
VALUES 
(1, 1, 4, 'Good service', '2024-04-11'),
(2, 2, 3, 'Average experience', '2024-04-13'),
(3, 3, 2, 'Bad experience', '2024-04-16'),
(4, 4, 5, 'Excellent service', '2024-04-19'),
(5, 5, 4, 'Comfortable journey', '2024-04-21'),
(6, 6, 2, 'Poor service', '2024-04-23'),
(7, 7, 3, 'Average journey', '2024-04-26');

-- Inserting data into the Admin table
INSERT INTO Admin (Username, Password, Email, Phone) 
VALUES 
('admin1', 'adminpass', 'admin1@example.com', '9876543210'),
('admin2', 'adminpass', 'admin2@example.com', '9876543211'),
('admin3', 'adminpass', 'admin3@example.com', '9876543212'),
('admin4', 'adminpass', 'admin4@example.com', '9876543213'),
('admin5', 'adminpass', 'admin5@example.com', '9876543214');

-- Inserting data into the Payment table
INSERT INTO Payment (BookingID, Amount, PaymentDate, PaymentStatus) 
VALUES 
(1, 25.00, '2024-04-10 10:30:00', 'Paid'),
(2, 20.00, '2024-04-12 11:45:00', 'Paid'),
(3, 30.00, '2024-04-15 09:20:00', 'Pending'),
(4, 35.00, '2024-04-18 12:00:00', 'Paid'),
(5, 30.00, '2024-04-20 13:15:00', 'Pending'),
(6, 40.00, '2024-04-22 14:30:00', 'Paid'),
(7, 15.00, '2024-04-25 15:45:00', 'Paid');

-- Inserting data into the BusSchedule table
INSERT INTO BusSchedule (BusID, RouteID, DepartureTime, ArrivalTime, Status) 
VALUES 
(1, 1, '08:00:00', '14:30:00', 'Active'),
(2, 2, '09:00:00', '14:00:00', 'Active'),
(3, 3, '10:00:00', '19:00:00', 'Inactive'),
(4, 4, '11:00:00', '16:30:00', 'Active'),
(5, 5, '12:00:00', '17:45:00', 'Active'),
(6, 6, '13:00:00', '21:00:00', 'Inactive'),
(7, 7, '14:00:00', '16:30:00', 'Active');

-- Inserting data into the Promotion table
INSERT INTO Promotion (PromoCode, DiscountPercentage, ExpiryDate, Status) 
VALUES 
('PROMO001', 10.00, '2024-05-01', 'Active'),
('PROMO002', 15.00, '2024-06-01', 'Active'),
('PROMO003', 20.00, '2024-07-01', 'Inactive'),
('PROMO004', 25.00, '2024-08-01', 'Active'),
('PROMO005', 30.00, '2024-09-01', 'Active');




-- Inserting data into the Ticket table
INSERT INTO Ticket (BookingID, SeatID, Price, TicketType, Status) 
VALUES 
(1, 1, 25.00, 'Regular', 'Confirmed'),
(2, 2, 20.00, 'Regular', 'Confirmed'),
(3, 3, 30.00, 'Regular', 'Pending'),
(4, 4, 35.00, 'Regular', 'Confirmed'),
(5, 5, 30.00, 'Regular', 'Pending'),
(6, 6, 40.00, 'Regular', 'Confirmed'),
(7, 7, 15.00, 'Regular', 'Confirmed');

-- Inserting data into the RouteStop table
INSERT INTO RouteStop (RouteID, StopName, ArrivalTime, DepartureTime, DistanceFromPreviousStop) 
VALUES 
(1, 'Stop A', '09:30:00', '09:45:00', 50.0),
(1, 'Stop B', '10:30:00', '10:45:00', 100.0),
(2, 'Stop C', '11:30:00', '11:45:00', 75.0),
(2, 'Stop D', '12:30:00', '12:45:00', 120.0),
(3, 'Stop E', '13:30:00', '13:45:00', 90.0),
(3, 'Stop F', '14:30:00', '14:45:00', 150.0),
(4, 'Stop G', '15:30:00', '15:45:00', 110.0);

-- Inserting data into the Driver table
INSERT INTO Driver (FullName, LicenseNumber, ContactNumber, Email, Address) 
VALUES 
('Ramesh', 'DL123456', '9876543210', 'ramesh@example.com', '22, MGR Nagar, Chennai'),
('Suresh', 'DL654321', '9876543211', 'suresh@example.com', '33, MG Road, Bangalore'),
('Ganesh', 'DL789012', '9876543212', 'ganesh@example.com', '44, Beach Road, Puducherry'),
('Mahesh', 'DL210987', '9876543213', 'mahesh@example.com', '55, Cochin Street, Kochi'),
('Vignesh', 'DL345678', '9876543214', 'vignesh@example.com', '66, Marina Beach Road, Thanjavur');

-- Inserting data into the BusMaintenance table
INSERT INTO BusMaintenance (BusID, MaintenanceDate, Description, Cost, Status) 
VALUES 
(1, '2024-04-10', 'Routine checkup', 100.00, 'Completed'),
(2, '2024-04-12', 'AC repair', 150.00, 'Completed'),
(3, '2024-04-15', 'Engine overhaul', 300.00, 'Pending'),
(4, '2024-04-18', 'Oil change', 80.00, 'Completed'),
(5, '2024-04-20', 'Brake pad replacement', 200.00, 'Pending'),
(6, '2024-04-22', 'Suspension repair', 250.00, 'Completed'),
(7, '2024-04-25', 'Battery replacement', 120.00, 'Completed');

-- Inserting data into the AdminActivity table
INSERT INTO AdminActivity (AdminID, ActivityType, ActivityDate, Description, IP_Address) 
VALUES 
(1, 'Login', '2024-04-10 08:00:00', 'Admin logged in', '192.168.1.100'),
(2, 'Logout', '2024-04-12 10:00:00', 'Admin logged out', '192.168.1.101'),
(3, 'Login', '2024-04-15 12:00:00', 'Admin logged in', '192.168.1.102'),
(4, 'Logout', '2024-04-18 14:00:00', 'Admin logged out', '192.168.1.103'),
(5, 'Login', '2024-04-20 16:00:00', 'Admin logged in', '192.168.1.104'),
(1, 'Logout', '2024-04-22 18:00:00', 'Admin logged out', '192.168.1.105'),
(2, 'Login', '2024-04-25 20:00:00', 'Admin logged in', '192.168.1.106');

-- To display Tables
SELECT * FROM User;
SELECT * FROM Bus;
SELECT * FROM Route;
SELECT * FROM Booking;
SELECT * FROM Seat;
SELECT * FROM Feedback;
SELECT * FROM Admin;
SELECT * FROM Payment;
SELECT * FROM BusSchedule;
SELECT * FROM Promotion;
SELECT * FROM Ticket;
SELECT * FROM RouteStop;
SELECT * FROM Driver;
SELECT * FROM BusMaintenance;
SELECT * FROM AdminActivity;

-- Simple Queries
SELECT * FROM Bus WHERE Status = 'Active';
SELECT * FROM Route WHERE Fare < 25.00;
SELECT * FROM Booking WHERE Status = 'Pending';
SELECT * FROM Feedback WHERE Rating >= 4;
SELECT * FROM Promotion WHERE Status = 'Active';

-- Aggregate Functions
SELECT UPPER(Status) AS UppercaseStatus, COUNT(*) AS StatusCount
FROM Booking
GROUP BY UppercaseStatus;
SELECT SUM(ABS(Amount)) AS TotalAmountPaid
FROM Payment
WHERE PaymentStatus = 'Paid';
SELECT YEAR(Booking.Date) AS Year, AVG(Ticket.Price) AS AveragePrice
FROM Ticket
JOIN Booking ON Ticket.BookingID = Booking.BookingID
GROUP BY Year;
SELECT UserID, CONCAT(Username, ' - ', Email) AS UserDetails
FROM User
WHERE UserID = (SELECT UserID FROM Feedback WHERE Rating = (SELECT MAX(Rating) FROM Feedback));
SELECT MIN(Cost) AS MinCost, Power(MIN(Cost), 2) AS MinCostSquared
FROM BusMaintenance
JOIN Bus ON BusMaintenance.BusID = Bus.BusID
WHERE Bus.Type = 'AC';

-- Joins
SELECT Booking.BookingID, Booking.Date, User.Username, User.Email
FROM Booking
INNER JOIN User ON Booking.UserID = User.UserID;
SELECT Bus.BusID, Bus.BusNumber, BusMaintenance.Description, BusMaintenance.Cost
FROM Bus
LEFT JOIN BusMaintenance ON Bus.BusID = BusMaintenance.BusID;
SELECT Feedback.FeedbackID, User.Username, Feedback.Rating, Feedback.Comments
FROM Feedback
RIGHT JOIN User ON Feedback.UserID = User.UserID;

-- Subqueries
SELECT Username,
       (SELECT COUNT(*) FROM Booking WHERE UserID = User.UserID) AS TotalBookings,
       (SELECT AVG(Price) FROM Ticket WHERE BookingID IN (SELECT BookingID FROM Booking WHERE UserID = User.UserID)) AS AverageTicketPrice
FROM User;
SELECT Username
FROM User
WHERE UserID IN (
    SELECT UserID 
    FROM Booking 
    WHERE Status = 'Confirmed' 
      AND Date BETWEEN '2024-01-01' AND '2024-12-31'
);
SELECT Username
FROM User
WHERE UserID IN (
    SELECT UserID 
    FROM Feedback 
    ORDER BY Rating DESC
    LIMIT 5
);
SELECT Username,
       (SELECT COUNT(*) FROM Booking WHERE UserID = User.UserID) AS TotalBookings,
       (SELECT AVG(Rating) FROM Feedback WHERE UserID = User.UserID) AS AvgRating
FROM User;
SELECT Username
FROM User u
WHERE EXISTS (
    SELECT * FROM Booking WHERE UserID = u.UserID AND Status = 'Confirmed'
)
AND NOT EXISTS (
    SELECT * FROM Booking WHERE UserID = u.UserID AND Status = 'Cancelled'
);







