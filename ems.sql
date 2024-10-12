CREATE SCHEMA EMS;
USE EMS;

CREATE TABLE Venues (
    VenueID INT PRIMARY KEY,
    VenueName VARCHAR(255) NOT NULL,
    Capacity INT,
    Location VARCHAR(255),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20)
);

CREATE TABLE Organizers (
    OrganizerID INT PRIMARY KEY,
    OrganizerName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255)
);

CREATE TABLE Events (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATE,
    StartTime TIME,
    EndTime TIME,
    Description TEXT,
    Status VARCHAR(50),
    Budget DECIMAL(10, 2),
    VenueID INT,
    OrganizerID INT,
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID),
    FOREIGN KEY (OrganizerID) REFERENCES Organizers(OrganizerID)
);

CREATE TABLE Attendees (
    AttendeeID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255),
    ContactNumber VARCHAR(20)
);

CREATE TABLE Registrations (
    RegistrationID INT PRIMARY KEY,
    EventID INT,
    AttendeeID INT,
    RegistrationDate DATE,
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

CREATE TABLE EventCategories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE Speakers (
    SpeakerID INT PRIMARY KEY,
    SpeakerName VARCHAR(255) NOT NULL,
    Bio TEXT,
    ContactInformation VARCHAR(255)
);

CREATE TABLE Sponsors (
    SponsorID INT PRIMARY KEY,
    SponsorName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20)
);

CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY,
    EventID INT,
    StartTime TIME,
    EndTime TIME,
    Title VARCHAR(255),
    SpeakerID INT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (SpeakerID) REFERENCES Speakers(SpeakerID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    EventID INT,
    AttendeeID INT,
    Rating INT,
    Comments TEXT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    EventID INT,
    Description TEXT,
    Deadline DATE,
    Status VARCHAR(50),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    AttendeeID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

CREATE TABLE Transportation (
    TransportID INT PRIMARY KEY,
    EventID INT,
    Mode VARCHAR(50),
    DeparturePoint VARCHAR(255),
    ArrivalPoint VARCHAR(255),
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    Cost DECIMAL(10, 2),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE Accommodations (
    AccommodationID INT PRIMARY KEY,
    EventID INT,
    Name VARCHAR(255),
    Location VARCHAR(255),
    CheckInDate DATE,
    CheckOutDate DATE,
    CostPerNight DECIMAL(10, 2),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE Exhibitors (
    ExhibitorID INT PRIMARY KEY,
    EventID INT,
    ExhibitorName VARCHAR(255),
    BoothNumber VARCHAR(50),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE SocialMediaPromotion (
    PromotionID INT PRIMARY KEY,
    EventID INT,
    Platform VARCHAR(50),
    Content TEXT,
    DatePosted DATE,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE Security (
    SecurityID INT PRIMARY KEY,
    EventID INT,
    SecurityCompany VARCHAR(255),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20),
    AccessControlDetails TEXT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE Catering (
    CateringID INT PRIMARY KEY,
    EventID INT,
    CateringCompany VARCHAR(255),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20),
    MenuDetails TEXT,
    Cost DECIMAL(10, 2),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE EventCategoriesMapping 
(
    EventID INT,
    CategoryID INT,
    PRIMARY KEY (EventID, CategoryID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (CategoryID) REFERENCES EventCategories(CategoryID)
);

CREATE TABLE AttendeeSessions
(
    AttendeeID INT,
    SessionID INT,
    PRIMARY KEY (AttendeeID, SessionID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID)
);

CREATE TABLE EventExhibitors
(
    EventID INT,
    ExhibitorID INT,
    PRIMARY KEY (EventID, ExhibitorID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (ExhibitorID) REFERENCES Exhibitors(ExhibitorID)
);

CREATE TABLE EventSecurity
 (
    EventID INT,
    SecurityID INT,
    PRIMARY KEY (EventID, SecurityID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (SecurityID) REFERENCES Security(SecurityID)
);

CREATE TABLE EventSpeakers
(
    EventID INT,
    SpeakerID INT,
    PRIMARY KEY (EventID, SpeakerID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (SpeakerID) REFERENCES Speakers(SpeakerID)
);

CREATE TABLE EventPayments 
(
    EventID INT,
    PaymentID INT,
    PRIMARY KEY (EventID, PaymentID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID)
);

CREATE TABLE EventCatering
(
    EventID INT,
    CateringID INT,
    PRIMARY KEY (EventID, CateringID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (CateringID) REFERENCES Catering(CateringID)
);

INSERT INTO Venues (VenueID, VenueName, Capacity, Location, ContactPerson, ContactNumber)
VALUES
    (1, 'Lahore Convention Center', 1000, 'Johar Town, Lahore', 'Ali Khan', '+92 300 1234567'),
    (2, 'Pearl Continental Hotel', 500, 'Mall Road, Lahore', 'Sara Ahmed', '+92 321 9876543'),
    (3, 'Royal Palm Golf & Country Club', 300, 'Canal Bank Road, Lahore', 'Ahmed Raza', '+92 333 5558888'),
    (4, 'Alhamra Arts Council', 200, 'Mall Road, Lahore', 'Nida Fatima', '+92 345 6789123'),
    (5, 'Liberty Castle', 150, 'Liberty Market, Lahore', 'Bilal Khan', '+92 302 1112233');
    
INSERT INTO Organizers (OrganizerID, OrganizerName, ContactPerson, ContactNumber, Email)
VALUES
    (1, 'EventPro Solutions', 'Ali Khan', '+92 300 1234567', 'ali@example.com'),
    (2, 'Grand Events', 'Sara Ahmed', '+92 321 9876543', 'sara@example.com'),
    (3, 'Royal Events', 'Ahmed Raza', '+92 333 5558888', 'ahmed@example.com'),
    (4, 'Star Planners', 'Nida Fatima', '+92 345 6789123', 'nida@example.com'),
    (5, 'Elite Organizers', 'Bilal Khan', '+92 302 1112233', 'bilal@example.com');

INSERT INTO Events (EventID, EventName, EventDate, StartTime, EndTime, Description, Status, Budget, VenueID, OrganizerID)
VALUES
    (1, 'Tech Expo', '2024-01-15', '09:00:00', '18:00:00', 'Technology exhibition showcasing latest innovations.', 'Active', 50000.00, 1, 1),
    (2, 'Finance Seminar', '2024-02-01', '10:00:00', '16:00:00', 'Seminar on financial strategies and market trends.', 'Active', 30000.00, 2, 2),
    (3, 'GreenTech Workshop', '2024-02-10', '14:00:00', '17:00:00', 'Workshop promoting sustainable and green technologies.', 'Active', 20000.00, 3, 3),
    (4, 'Digital Marketing Showcase', '2024-02-20', '11:00:00', '15:00:00', 'Showcasing the latest trends in digital marketing.', 'Active', 25000.00, 4, 4),
    (5, 'AI Innovation Event', '2024-03-01', '13:00:00', '19:00:00', 'Event focusing on artificial intelligence and its applications.', 'Active', 35000.00, 5, 5);

INSERT INTO Attendees (AttendeeID, FirstName, LastName, Email, ContactNumber)
VALUES
    (1, 'John', 'Doe', 'john@example.com', '+92 300 1112233'),
    (2, 'Emma', 'Smith', 'emma@example.com', '+92 321 4445566'),
    (3, 'James', 'Johnson', 'james@example.com', '+92 333 7778899'),
    (4, 'Sophia', 'Brown', 'sophia@example.com', '+92 345 9991122'),
    (5, 'Michael', 'Davis', 'michael@example.com', '+92 302 1113344');

INSERT INTO Registrations (RegistrationID, EventID, AttendeeID, RegistrationDate)
VALUES
    (1, 1, 1, '2024-01-01'),
    (2, 1, 2, '2024-01-02'),
    (3, 2, 3, '2024-01-03'),
    (4, 3, 4, '2024-01-04'),
    (5, 4, 5, '2024-01-05');

INSERT INTO EventCategories (CategoryID, CategoryName)
VALUES
    (1, 'Conference'),
    (2, 'Seminar'),
    (3, 'Workshop'),
    (4, 'Exhibition'),
    (5, 'Networking Event');

INSERT INTO Speakers (SpeakerID, SpeakerName, Bio, ContactInformation)
VALUES
    (1, 'Dr. Ayesha Khan', 'Renowned researcher in technology', '+92 300 1112222'),
    (2, 'Mr. Fahad Ahmed', 'Expert in business strategy', '+92 321 3334444'),
    (3, 'Prof. Sarah Malik', 'Academician and author', '+92 333 5556666'),
    (4, 'Ms. Aliya Khan', 'Digital marketing specialist', '+92 345 7778888'),
    (5, 'Mr. Ahmed Shah', 'Innovator in artificial intelligence', '+92 302 9990000');

INSERT INTO Sponsors (SponsorID, SponsorName, ContactPerson, ContactNumber)
VALUES
    (1, 'Tech Solutions', 'Ali Khan', '+92 300 1110000'),
    (2, 'Finance Innovations', 'Sara Ahmed', '+92 321 2221111'),
    (3, 'Green Energy Ltd.', 'Ahmed Raza', '+92 333 3334444'),
    (4, 'Digital Marketing Experts', 'Nida Fatima', '+92 345 5556666'),
    (5, 'AI Innovations', 'Bilal Khan', '+92 302 7778888');

INSERT INTO Sessions (SessionID, EventID, StartTime, EndTime, Title, SpeakerID)
VALUES
    (1, 1, '09:00:00', '10:30:00', 'Keynote Address', 1),
    (2, 1, '11:00:00', '12:30:00', 'Panel Discussion on Future Trends', 2),
    (3, 2, '10:00:00', '11:30:00', 'Workshop: Digital Marketing Strategies', 4),
    (4, 3, '14:00:00', '15:30:00', 'Seminar: Sustainable Business Practices', 3),
    (5, 4, '13:00:00', '14:30:00', 'Innovation Showcase', 5);

INSERT INTO Feedback (FeedbackID, EventID, AttendeeID, Rating, Comments)
VALUES
    (1, 1, 1, 4, 'Great event, informative sessions'),
    (2, 1, 2, 5, 'Excellent organization and speakers'),
    (3, 2, 3, 3, 'Good workshop but room for improvement'),
    (4, 3, 4, 4, 'Loved the seminar, insightful content'),
    (5, 4, 5, 5, 'Innovation showcase was amazing');

INSERT INTO Tasks (TaskID, EventID, Description, Deadline, Status)
VALUES
    (1, 1, 'Prepare event materials', '2024-01-10', 'In Progress'),
    (2, 2, 'Coordinate panel discussion logistics', '2024-01-15', 'Not Started'),
    (3, 3, 'Set up workshop venue', '2024-01-12', 'Completed'),
    (4, 4, 'Organize seminar sessions', '2024-01-18', 'In Progress'),
    (5, 5, 'Plan innovation showcase', '2024-01-20', 'Not Started');

INSERT INTO Payments (PaymentID, AttendeeID, Amount, PaymentDate, Status)
VALUES
    (1, 1, 100.00, '2024-01-02', 'Paid'),
    (2, 2, 150.00, '2024-01-03', 'Paid'),
    (3, 3, 80.00, '2024-01-05', 'Pending'),
    (4, 4, 120.00, '2024-01-08', 'Paid'),
    (5, 5, 200.00, '2024-01-10', 'Pending');

INSERT INTO Transportation (TransportID, EventID, Mode, DeparturePoint, ArrivalPoint, DepartureTime, ArrivalTime, Cost)
VALUES
    (1, 1, 'Bus', 'Lahore', 'Islamabad', '2024-01-15 08:00:00', '2024-01-15 12:00:00', 500.00),
    (2, 2, 'Car', 'Lahore', 'Karachi', '2024-02-01 10:00:00', '2024-02-01 18:00:00', 1000.00),
    (3, 3, 'Train', 'Lahore', 'Faisalabad', '2024-02-10 14:00:00', '2024-02-10 16:00:00', 300.00),
    (4, 4, 'Flight', 'Lahore', 'Quetta', '2024-02-20 12:00:00', '2024-02-20 16:00:00', 1200.00),
    (5, 5, 'Bus', 'Lahore', 'Multan', '2024-03-01 09:00:00', '2024-03-01 13:00:00', 400.00);

INSERT INTO Accommodations (AccommodationID, EventID, Name, Location, CheckInDate, CheckOutDate, CostPerNight)
VALUES
    (1, 1, 'Luxury Hotel', 'Lahore', '2024-01-15', '2024-01-17', 150.00),
    (2, 2, 'Beach Resort', 'Karachi', '2024-02-01', '2024-02-03', 200.00),
    (3, 3, 'City Inn', 'Faisalabad', '2024-02-10', '2024-02-11', 80.00),
    (4, 4, 'Quetta Lodge', 'Quetta', '2024-02-20', '2024-02-22', 100.00),
    (5, 5, 'Multan Guest House', 'Multan', '2024-03-01', '2024-03-02', 120.00);

INSERT INTO Exhibitors (ExhibitorID, EventID, ExhibitorName, BoothNumber, ContactPerson, ContactNumber, Email)
VALUES
    (1, 1, 'Tech Expo', 'Booth A1', 'Ahmed Khan', '+92 300 1113344', 'ahmed@example.com'),
    (2, 2, 'Finance Solutions', 'Booth B2', 'Sara Ali', '+92 321 2224455', 'sara@example.com'),
    (3, 3, 'GreenTech Innovations', 'Booth C3', 'Ali Raza', '+92 333 3335566', 'ali@example.com'),
    (4, 4, 'Digital Marketing Hub', 'Booth D4', 'Nida Shah', '+92 345 4446677', 'nida@example.com'),
    (5, 5, 'AI Tech', 'Booth E5', 'Bilal Ahmed', '+92 302 5557788', 'bilal@example.com');

INSERT INTO SocialMediaPromotion (PromotionID, EventID, Platform, Content, DatePosted)
VALUES
    (1, 1, 'Twitter', 'Exciting tech conference coming up in Lahore! #TechExpo', '2024-01-05'),
    (2, 2, 'Facebook', 'Join us at the Finance Seminar in Karachi. Register now!', '2024-02-01'),
    (3, 3, 'Instagram', "GreenTech Workshop in Faisalabad. Don't miss out!", '2024-02-10'),
    (4, 4, 'LinkedIn', 'Digital Marketing Showcase in Quetta. Connect with experts!', '2024-02-20'),
    (5, 5, 'Twitter', 'AI Innovation event in Multan. Explore the future!', '2024-03-01');

INSERT INTO Security (SecurityID, EventID, SecurityCompany, ContactPerson, ContactNumber, AccessControlDetails)
VALUES
    (1, 1, 'SecureGuard Services', 'Ali Khan', '+92 300 1114455', 'Strict access control at all entry points'),
    (2, 2, 'SafeEvent Solutions', 'Sara Ahmed', '+92 321 2226677', '24/7 surveillance and emergency response'),
    (3, 3, 'GreenSecure', 'Ahmed Raza', '+92 333 3338899', 'Eco-friendly security practices'),
    (4, 4, 'DigitalSafe', 'Nida Fatima', '+92 345 4441122', 'Secure digital access to event areas'),
    (5, 5, 'AI Security Solutions', 'Bilal Khan', '+92 302 5553344', 'Artificial intelligence-powered surveillance');

INSERT INTO Catering (CateringID, EventID, CateringCompany, ContactPerson, ContactNumber, MenuDetails, Cost)
VALUES
    (1, 1, 'FoodFiesta Caterers', 'Ali Khan', '+92 300 1117788', 'Buffet with a variety of cuisines', 2000.00),
    (2, 2, 'TasteBuds Catering', 'Sara Ahmed', '+92 321 2229900', 'Customized menu for the seminar', 1500.00),
    (3, 3, 'GreenEats Catering', 'Ahmed Raza', '+92 333 3331122', 'Sustainable and healthy food options', 1800.00),
    (4, 4, 'DigitalDine Catering', 'Nida Fatima', '+92 345 4443344', 'Digital-themed menu for the showcase', 2200.00),
    (5, 5, 'AICuisine Caterers', 'Bilal Khan', '+92 302 5555566', 'AI-curated menu for the innovation event', 2500.00);

INSERT INTO EventCategoriesMapping (EventID, CategoryID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO AttendeeSessions (AttendeeID, SessionID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO EventExhibitors (EventID, ExhibitorID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO EventSecurity (EventID, SecurityID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO EventSpeakers (EventID, SpeakerID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO EventPayments (EventID, PaymentID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO EventCatering (EventID, CateringID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

Show tables;

