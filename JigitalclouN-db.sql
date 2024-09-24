
CREATE DATABASE JigitalclouN;

USE JigitalclouN;

Drop database JigitalclouN

CREATE TABLE MsProcessor(
    ProcessorID CHAR(9) PRIMARY KEY CHECK (ProcessorID LIKE 'JCN-P[3-7][1-2][0-9][0-9]') NOT NULL,
    ProcessorName VARCHAR(255) NOT NULL,
    ProcessorModel VARCHAR(255) NOT NULL,
    ProcessorPriceIDR INT NOT NULL,
    ProcessorClockMHZ INT CHECK (ProcessorClockMHZ BETWEEN 1500 AND 6000) NOT NULL,
    ProcessorCoreCount INT CHECK (ProcessorCoreCount BETWEEN 1 AND 24) NOT NULL
);

CREATE TABLE MsMemory(
    MemoryID CHAR(9) PRIMARY KEY CHECK (MemoryID LIKE 'JCN-M[3-7][1-2][0-9][0-9]') NOT NULL,
    MemoryName VARCHAR(266) NOT NULL,
    MemoryCode VARCHAR(255) NOT NULL,
    MemoryPrice INT NOT NULL,
    MemoryFrequencyMHz INT CHECK (MemoryFrequencyMHz BETWEEN 1000 AND 5000) NOT NULL,
    MemoryCapacityGB INT CHECK (MemoryCapacityGB BETWEEN 1 AND 256) NOT NULL
);

CREATE TABLE MsLocation(
    LocationID CHAR(9) PRIMARY KEY CHECK (LocationID LIKE 'JCN-L[3-7][1-2][0-9][0-9]') NOT NULL,
    LocationCityName VARCHAR(255),
    LocationCountryName VARCHAR(255),
    LocationZipcode INT NOT NULL,
    LocationLatitude INT CHECK (LocationLatitude BETWEEN -90 AND 90) NOT NULL,
    LocationLongitude INT CHECK (LocationLongitude BETWEEN -180 AND 180) NOT NULL
);

CREATE TABLE MsStaff(
    StaffID CHAR(9) PRIMARY KEY CHECK (StaffID LIKE 'JCN-S[3-7][1-2][0-9][0-9]') NOT NULL,
    StaffName VARCHAR(255) NOT NULL,
    StaffGender VARCHAR(255) CHECK (StaffGender IN ('Male', 'Female')) NOT NULL,
    StaffEmail VARCHAR(255) CHECK (StaffEmail LIKE '%@gmail.com') NOT NULL,
    StaffDate DATE NOT NULL,
    StaffPhone CHAR(12) CHECK (StaffPhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
    StaffAddress VARCHAR(255) NOT NULL,
    StaffSalary INT CHECK (StaffSalary BETWEEN 3500000 AND 20000000) NOT NULL
);

CREATE TABLE MsCustomer(
    CustomerID CHAR(9) PRIMARY KEY CHECK (CustomerID LIKE 'JCN-C[3-7][1-2][0-9][0-9]') NOT NULL,
    CustomerName VARCHAR(255) NOT NULL,
    CustomerAge INT CHECK (CustomerAge > 14) NOT NULL, 
    CustomerGender VARCHAR(255) CHECK (CustomerGender IN ('Male', 'Female')) NOT NULL,
    CustomerEmail VARCHAR(255) CHECK (CustomerEmail LIKE '%gmail.com') NOT NULL,
    CustomerDate DATE NOT NULL,
    CustomerPhone CHAR(12) CHECK (CustomerPhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
    CustomerAddress VARCHAR(255) NOT NULL
);

CREATE TABLE MsServer(
    ServerID CHAR(9) PRIMARY KEY CHECK (ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]') NOT NULL,
    MemoryID CHAR(9) REFERENCES MsMemory(MemoryID) NOT NULL,
    ProcessorID CHAR(9) REFERENCES MsProcessor(ProcessorID) NOT NULL,
    LocationID CHAR(9) REFERENCES MsLocation(LocationID) NOT NULL,
    ServerPriceIDR INT NOT NULL
);

CREATE TABLE TrHeaderSale(
    SaleID CHAR(9) PRIMARY KEY CHECK (SaleID LIKE 'JCN-S[0-2][1-2][0-9][0-9]') NOT NULL,
    StaffID CHAR(9) REFERENCES MsStaff(StaffID) NOT NULL,
    CustomerID CHAR(9) REFERENCES MsCustomer(CustomerID) NOT NULL,
    ServerID CHAR(9) REFERENCES MsServer(ServerID) NOT NULL,
    TransactionDate DATE NOT NULL DEFAULT GETDATE() 
);



CREATE TABLE TrDetailSale(
    SaleID CHAR(9) REFERENCES TrHeaderSale(SaleID) NOT NULL,
    ServerID CHAR(9) REFERENCES MsServer(ServerID) NOT NULL,
    Quantity INT NOT NULL,
Primary Key (SaleID, ServerID)
);

CREATE TABLE TrHeaderRent(
    RentID CHAR(9) PRIMARY KEY CHECK (RentID LIKE 'JCN-R[0-2][1-2][0-9][0-9]') NOT NULL,
    StaffID CHAR(9) REFERENCES MsStaff(StaffID) NOT NULL,
    CustomerID CHAR(9) REFERENCES MsCustomer(CustomerID) NOT NULL,
    ServerID CHAR(9) REFERENCES MsServer(ServerID) NOT NULL,
    RentStartDate DATE NOT NULL CHECK (RentStartDate >= '2012-01-01' AND RentStartDate <= GETDATE()),
	RentEndDate DATE NOT NULL,
	RentDuration int not null
);

CREATE TABLE TrDetailRent(
    RentID CHAR(9) REFERENCES TrHeaderRent(RentID) NOT NULL,
    ServerID CHAR(9) REFERENCES MsServer(ServerID) NOT NULL,
	Primary Key (RentID, ServerID)
  
);


insert into MsProcessor values 
('JCN-P3180', 'Intel i5 gen 11', 'i5-11', '3500000', '2200', '10'),
('JCN-P4291', 'Intel i7 gen 11', 'i7-11', '4500000', '2300', '15'),
('JCN-P5172', 'Intel i9 gen 11', 'i9-11', '5500000', '3500', '5'),
('JCN-P6243', 'Intel i5 gen 12', 'i5-12', '4300000', '4250', '6'),
('JCN-P7234', 'Intel i7 gen 12', 'i7-12', '5500000', '4500', '20'),
('JCN-P5145', 'Intel i9 gen 12', 'i9-12', '4500000', '3200', '24'),
('JCN-P6266', 'Intel i5 gen 13', 'i5-13', '3600000', '2350', '4'),
('JCN-P7137', 'Intel i7 gen 13', 'i7-13', '3450000', '3350', '20'),
('JCN-P5148', 'Intel i9 gen 13', 'i9-13', '4500000', '4300', '15'),
('JCN-P3269', 'Ryzen 5400', 'Ry-54', '3456000', '1500', '15')

insert into MsLocation values 
('JCN-L3111', 'Jakarta', 'Indonesia', '12', '-90', '-180'),
('JCN-L3113', 'Bali', 'Indonesia', '11', '90', '180'),
('JCN-L3114', 'Semarang', 'Indonesia', '13', '90', '170'),
('JCN-L3115', 'Singapore', 'Singapore', '14', '-30', '160'),
('JCN-L3116', 'Kuala Lumpur', 'Malaysia', '15', '30', '150'),
('JCN-L3117', 'Selangor', 'Malaysua', '16', '45', '130'),
('JCN-L3118', 'Sydney', 'Australia', '17', '-25', '-100'),
('JCN-L3119', 'Melbourne', 'Australia', '18', '20', '100'),
('JCN-L3211', 'Adelaide', 'Australia', '19', '65', '135'),
('JCN-L3222', 'Perth', 'Australia', '20', '67', '145')

Insert into MsMemory Values
('JCN-M3100','V-Gen','ECC-5627','661','2400','128'),
('JCN-M3153','HP','ECC-3682','500','1333','8'),
('JCN-M3170','Samsung','ECC-8823','850','2666','32'),
('JCN-M3215','Hynix','ECC-6539','778','2400','160'),
('JCN-M3277','Kingston','ECC-1479','792','4666','16'),
('JCN-M3233','SkHynix','ECC-1277','600','2400','250'),
('JCN-M3269','Corsair','ECC-1427','820','3200','160'),
('JCN-M3144','Adata','ECC-9637','700','3400','80'),
('JCN-M3101','V-Gen','ECC-7254','847','4666','32'),
('JCN-M3189','Dell','ECC-5274','475','4333','28')

Insert into MsStaff Values
('JCN-S6288','Hendrik Susanto','Male','hendrikaeee@gmail.com','1999-05-22','088877775555','Jl.Anggrek','4000000'),
('JCN-S6177','Santi Susanti','Female','santi666@gmail.com','1997-11-12','081276538900','Jl.Cendrawasih','4500000'),
('JCN-S5186','Bayu Gunawan','Male','bayugun221@gmail.com','2000-10-17','082298007652','Jl.Melati','5500000'),
('JCN-S5261','Olivia Natalie','Female','olivianat@gmail.com','1996-09-27','088167788456','Jl.Jeruk','6300000'),
('JCN-S4159','Kevin Santoso','Male','kevinnsan18@gmail.com','2003-12-02','086712345570','Jl.Mawar','6500000'),
('JCN-S4102','Rafael Jason','Male','rafaeljason@gmail.com','2001-06-21','087743698022','Jl.Latumenten','7000000'),
('JCN-S3299','Dessy Putri','Female','dessyputri346@gmail.com','2002-05-03','088233661881','Jl.Mangga','7400000'),
('JCN-S7299','Michelle Wijaya ','Female','mchelleewjy88@gmail.com','1998-08-19','081165533542','Jl.Duku','8100000'),
('JCN-S4144','Rudi Hartono','Male','rudihartono668@gmail.com','1989-02-18','088511334570','Jl.Jalak','8500000'),
('JCN-S5213','Lina Setiawan','Female','linasetiawann45@gmail.com','1991-04-23','089862277944','Jl.Manggis','9700000')

Insert into MsServer Values 
('JCN-V3111', 'JCN-M3100', 'JCN-P3180', 'JCN-L3111', '5000000'),
('JCN-V3112', 'JCN-M3153', 'JCN-P4291', 'JCN-L3113', '500000'),
('JCN-V3113', 'JCN-M3170', 'JCN-P5172', 'JCN-L3114', '30000000'),
('JCN-V3114', 'JCN-M3215', 'JCN-P6243', 'JCN-L3115', '500000'),
('JCN-V3115', 'JCN-M3277', 'JCN-P7234', 'JCN-L3116', '70000000'),
('JCN-V3116', 'JCN-M3233', 'JCN-P5145', 'JCN-L3117', '1000000'),
('JCN-V3117', 'JCN-M3269', 'JCN-P6266', 'JCN-L3118', '570000'),
('JCN-V3118', 'JCN-M3144', 'JCN-P7137', 'JCN-L3119', '51100000'),
('JCN-V3119', 'JCN-M3101', 'JCN-P5148', 'JCN-L3211', '5900000'),
('JCN-V3120', 'JCN-M3189', 'JCN-P3269', 'JCN-L3222', '60000000')

Insert into MsCustomer Values
('JCN-C4188', 'Agus Wijaya', '23', 'Male', 'aguswjy223@gmail.com', '1999-10-28', '081911667382', 'Jl.Pahlawan No.12'),
('JCN-C3299', 'Dewi Simatupang', '30', 'Female', 'dewisima98@gmail.com', '2000-01-16', '082211437899', 'Jl.Sudirman No.21'),
('JCN-C5187', 'Wahyu Kusuma', '19', 'Male', 'wahyukusuma44@gmail.com', '1988-08-23', '083376736811', 'Jl.Pahlawan No.32'),
('JCN-C3177', 'Dina Permata', '20', 'Female', 'dinapermata11@gmail.com', '2002-03-25', '081925365438', 'Jl.Abadi No.25'),
('JCN-C6276', 'Anggi Rahayu', '23', 'Female', 'anggirahay445@gmail.com', '1997-09-08', '081577263722', 'Jl.Matahari No.77'),
('JCN-C7100', 'Rian Hidayat', '26', 'Male', 'rianhidayat663@gmail.com', '1989-12-12', '082365355390', 'Jl.Flamboyan No.102'),
('JCN-C7211', 'Dodi Randolph', '38', 'Male', 'doniirann553@gmail.com', '1988-04-19', '088313349984', 'Jl.Kamboja No.46'),
('JCN-C4158', 'Rizky Pratama', '41', 'Male', 'rizkypra88@gmail.com', '1995-05-27', '083817677265', 'Jl.Rafflesia No.59'),
('JCN-C4266', 'Rani Permatasari', '18', 'Female', 'ranipermata103@gmail.com', '1996-07-07', '084562567526', 'Jl.Angsana No.68'),
('JCN-C5144', 'Annisa Putri', '22', 'Female', 'annisaputri8@gmail.com', '1994-02-14', '087872656757', 'Jl.Cempaka No.86')


insert into TrHeaderSale values
('JCN-S0101','JCN-S6288', 'JCN-C4188', 'JCN-V3111',  '2020-03-01'),
('JCN-S1121', 'JCN-S6288', 'JCN-C4188', 'JCN-V3111', '2017-03-02'),
('JCN-S1122', 'JCN-S6177', 'JCN-C3299', 'JCN-V3112', '2010-03-03'),
('JCN-S1123', 'JCN-S6177', 'JCN-C3299', 'JCN-V3112', '2011-03-04'),
('JCN-S1124', 'JCN-S5186', 'JCN-C5187', 'JCN-V3113', '2012-03-05'),
('JCN-S1125', 'JCN-S5186', 'JCN-C5187', 'JCN-V3113', '2012-03-06'),
('JCN-S1126', 'JCN-S5261', 'JCN-C3177', 'JCN-V3114', '2022-03-07'),
('JCN-S1127', 'JCN-S5261', 'JCN-C3177', 'JCN-V3114', '2017-03-08'),
('JCN-S1128', 'JCN-S4159', 'JCN-C6276', 'JCN-V3115', '2019-03-09'),
('JCN-S1129', 'JCN-S4159', 'JCN-C6276', 'JCN-V3115', '2020-03-10'),
('JCN-S0121', 'JCN-S4102', 'JCN-C7100', 'JCN-V3116', '2011-03-11'),
('JCN-S0122', 'JCN-S4102', 'JCN-C7100', 'JCN-V3116', '2019-03-12'),
('JCN-S0123', 'JCN-S3299', 'JCN-C7211', 'JCN-V3117', '2019-03-13'),
('JCN-S0124', 'JCN-S3299', 'JCN-C4158', 'JCN-V3117', '2016-03-14'),
('JCN-S0125', 'JCN-S7299', 'JCN-C4158', 'JCN-V3118', '2015-03-15'),
('JCN-S0126', 'JCN-S7299', 'JCN-C4266', 'JCN-V3118', '2010-03-16'),
('JCN-S0127', 'JCN-S4144', 'JCN-C4266', 'JCN-V3119', '2020-03-17'),
('JCN-S0128', 'JCN-S4144', 'JCN-C7211', 'JCN-V3119', '2022-03-18'),
('JCN-S0129', 'JCN-S5213', 'JCN-C5144', 'JCN-V3120', '2023-03-19'),
('JCN-S0130', 'JCN-S5213', 'JCN-C5144', 'JCN-V3120', '2017-03-21')


insert into TrHeaderSale values
('JCN-S0131', 'JCN-S6288', 'JCN-C5187', 'JCN-V3117', '2019-03-22'),
('JCN-S0132', 'JCN-S4159', 'JCN-C6276', 'JCN-V3119', '2020-03-23'),
('JCN-S0133', 'JCN-S7299', 'JCN-C5144', 'JCN-V3118', '2021-03-24'),
('JCN-S0134', 'JCN-S4144', 'JCN-C3177', 'JCN-V3116', '2022-03-25'),
('JCN-S0135', 'JCN-S5213', 'JCN-C3299', 'JCN-V3112', '2022-03-26')

Insert into TrHeaderRent Values
('JCN-R2251', 'JCN-S6288', 'JCN-C4188', 'JCN-V3111', '2013-09-21','2013-12-21', DATEDIFF(MONTH, '2013-09-21','2013-12-21')),
('JCN-R2252', 'JCN-S6288', 'JCN-C4188', 'JCN-V3111', '2013-09-24','2014-01-24', DATEDIFF(MONTH, '2013-09-24','2014-01-24')),
('JCN-R2253', 'JCN-S6177', 'JCN-C3299', 'JCN-V3112', '2014-08-13','2015-01-13', DATEDIFF(MONTH, '2014-08-13','2015-01-13')),
('JCN-R2254', 'JCN-S6288', 'JCN-C4188', 'JCN-V3112', '2014-08-17','2015-10-17', DATEDIFF(MONTH, '2014-08-17','2015-10-17')),
('JCN-R2255', 'JCN-S5186', 'JCN-C5187', 'JCN-V3113', '2015-10-25','2015-11-25', DATEDIFF(MONTH, '2015-10-25','2015-11-25')),
('JCN-R2256', 'JCN-S5186', 'JCN-C5187', 'JCN-V3113', '2015-10-29','2016-05-29', DATEDIFF(MONTH, '2015-10-29','2016-05-29')),
('JCN-R2257', 'JCN-S5261', 'JCN-C3177', 'JCN-V3114', '2016-07-20','2020-07-20', DATEDIFF(MONTH, '2016-07-20','2020-07-20')),
('JCN-R2258', 'JCN-S5261', 'JCN-C3177', 'JCN-V3114', '2016-07-22','2017-04-22', DATEDIFF(MONTH, '2016-07-22','2017-04-22')),
('JCN-R2259', 'JCN-S4159', 'JCN-C6276', 'JCN-V3115', '2017-06-23','2018-04-23', DATEDIFF(MONTH, '2017-06-23','2018-04-23')),
('JCN-R2260', 'JCN-S4159', 'JCN-C6276', 'JCN-V3115', '2017-06-27','2019-03-27', DATEDIFF(MONTH, '2017-06-27','2019-03-27')),
('JCN-R2261', 'JCN-S4102', 'JCN-C7100', 'JCN-V3116', '2018-08-03','2019-02-03', DATEDIFF(MONTH, '2018-08-03','2019-02-03')),
('JCN-R2262', 'JCN-S3299', 'JCN-C7211', 'JCN-V3117', '2018-12-06','2019-01-06', DATEDIFF(MONTH, '2018-12-06','2019-01-06')),
('JCN-R2263', 'JCN-S7299', 'JCN-C4158', 'JCN-V3118', '2019-03-18','2022-01-18', DATEDIFF(MONTH, '2019-03-18','2022-01-18')),
('JCN-R2264', 'JCN-S4144', 'JCN-C4266', 'JCN-V3119', '2020-10-16','2021-07-16', DATEDIFF(MONTH, '2020-10-16','2021-07-16')),
('JCN-R2265', 'JCN-S5213', 'JCN-C5144', 'JCN-V3120', '2021-05-28','2022-01-28', DATEDIFF(MONTH, '2021-05-28','2022-01-28'))

Insert into TrDetailSale values 
('JCN-S0101','JCN-V3111',3),
('JCN-S0121','JCN-V3116',2),
('JCN-S0122','JCN-V3116',3),
('JCN-S0123','JCN-V3117',1),
('JCN-S0124','JCN-V3117',5),
('JCN-S0125','JCN-V3118',1),
('JCN-S0126','JCN-V3118',1),
('JCN-S0127','JCN-V3119',5),
('JCN-S0128','JCN-V3119',1),
('JCN-S0129','JCN-V3120',1),
('JCN-S0130','JCN-V3120',8),
('JCN-S0121','JCN-V3117',1),
('JCN-S1121','JCN-V3112',6),
('JCN-S1122','JCN-V3112',1),
('JCN-S1123','JCN-V3113',7),
('JCN-S1124','JCN-V3114',1),
('JCN-S1125','JCN-V3113',1),
('JCN-S1126','JCN-V3114',7),
('JCN-S1127','JCN-V3114',1),
('JCN-S1128','JCN-V3115',1),
('JCN-S1129','JCN-V3115',1),
('JCN-S1124','JCN-V3113',2),
('JCN-S1127','JCN-V3115',3),
('JCN-S1122','JCN-V3114',5),
('JCN-S0130','JCN-V3112',1)


insert into TrDetailRent values 
('JCN-R2251', 'JCN-V3112') ,
('JCN-R2252',   'JCN-V3111') ,
('JCN-R2253',  'JCN-V3112'), 
('JCN-R2254', 'JCN-V3112'), 
('JCN-R2255', 'JCN-V3113'), 
('JCN-R2256', 'JCN-V3113'),
('JCN-R2257',  'JCN-V3114'), 
('JCN-R2258',  'JCN-V3114'),
('JCN-R2259',  'JCN-V3115'),
('JCN-R2260',  'JCN-V3115'),
('JCN-R2261',  'JCN-V3116'),
('JCN-R2262', 'JCN-V3117'), 
('JCN-R2263',  'JCN-V3118'),
('JCN-R2264',  'JCN-V3119'),
('JCN-R2265',  'JCN-V3120'),
('JCN-R2251','JCN-V3120'),
('JCN-R2252','JCN-V3120' ),
('JCN-R2253', 'JCN-V3119'),
('JCN-R2254', 'JCN-V3115'),
('JCN-R2255', 'JCN-V3114'),
('JCN-R2263',  'JCN-V3115'),
('JCN-R2259', 'JCN-V3113'),
('JCN-R2260', 'JCN-V3116'),
('JCN-R2264','JCN-V3114'),
('JCN-R2254','JCN-V3118')

-- simulation
insert  into MsCustomer values (
'JCN-C3188', 'Anton Salim', '21', 'Male', 'antonsalim@gmail.com', '1999-03-12','081925365439',
'Jl.Bunga No.5'),
('JCN-C3189', 'Fransisca Limit', '20', 'Female', 'framsisca12@gmail.com', '2001-09-21','081925365440',
'Jl.Kelopak No.75')

insert into TrHeaderSale values(
'JCN-S1130', 'JCN-S4144', 'JCN-C3188', 'JCN-V3117', '2023-06-03')
insert into TrDetailSale values (
'JCN-S1130', 'JCN-V3117', '2')


INSERT INTO TrHeaderRent values(
'JCN-R2266', 'JCN-S6177', 'JCN-C3189', 'JCN-V3118', '2023-01-20', '2023-05-20', DATEDIFF(MONTH, '2023-01-20', '2023-05-20' ))
insert into TrDetailRent values (
'JCN-R2266', 'JCN-V3118')

--1
select ms.StaffID, StaffName, StaffGender, StaffSalary,
[LongestPeriod]= max(thr.RentDuration)
from MsStaff ms join TrHeaderRent thr on ms.StaffID = thr.StaffID
join MsCustomer mc on mc.CustomerID = thr.CustomerID
where (StaffSalary) < 15000000 and (CustomerAge)<20
group by ms.StaffID, StaffName, StaffGender, StaffSalary

--2
select CONCAT(LocationCityName, ' '+LocationCountryName) as [Location], 
concat(min(ServerPriceIDR),'IDR') as [CheapestServerPrice]
from MsLocation ml join MsServer ms on ml.LocationID = ms.LocationID 
join MsProcessor mp on mp.ProcessorID = ms.ProcessorID
where (ProcessorClockMHZ) > 3000 and LocationLatitude between -30 and 30
group by LocationCityName, LocationCountryName

--3
select RentID, 
max(MemoryFrequencyMHz)[MaxMemoryFrequency],
sum(MemoryCapacityGB)[TotalMemoryCapacity]
from TrHeaderRent thr join MsServer ms on ms.ServerID = thr.ServerID
join MsMemory mm on mm.MemoryID = ms.MemoryID
where datename(quarter,RentStartDate) =4
group by RentID

--4
select 
SaleID,
count(SaleID) as 'ServerCount',
concat (avg(ServerPriceIDR/1000000), ' million(s) IDR') as 'AverageServerPrice'
from TrHeaderSale ths
join MsServer ms on ms.ServerID = ths.ServerID
where year(TransactionDate) between 2016 and 2020
group by SaleID
having avg(ServerPriceIDR) > 50000000

/*
5.	Display SaleID, MostExpensiveServerPrice (obtained from the most expensive server price in the transaction), 
HardwareRatingIndex (obtained from ((0.55 * ProcessorClock * ProcessorCoreCount) + (MemoryFrequency * MemoryCapacityGB * 0.05)) / 143200) formatted to 3 decimal places) 
for the sale transactions which has server listed in the top 10 most expensive servers which occurs in odd years. 
*/

SELECT TOP (10)
  SaleID,
  ServerPriceIDR,
  FORMAT(HardwareRatingIndex, '0.000') AS HardwareRatingIndex
FROM (
  SELECT
    ths.SaleID,
    ms.ServerPriceIDR,
    (SUM((0.55 * mp.ProcessorClockMHZ * mp.ProcessorCoreCount) + (mm.MemoryFrequencyMHz * mm.MemoryCapacityGB * 0.05)) / 143200) AS HardwareRatingIndex
  FROM TrHeaderSale ths
  JOIN MsServer ms ON ms.ServerID = ths.ServerID 
  JOIN MsProcessor mp ON mp.ProcessorID = ms.ProcessorID
  JOIN MsMemory mm ON mm.MemoryID = ms.MemoryID
  WHERE YEAR(ths.TransactionDate) % 2 != 0
  GROUP BY ths.SaleID, ms.ServerPriceIDR
) AS subquery
ORDER BY ServerPriceIDR DESC

--6 
SELECT
  CONCAT(LEFT(mp.ProcessorName, 5), ' ', mp.ProcessorModel) AS ProcessorName,
  CONCAT(mp.ProcessorCoreCount, ' core(s)') AS CoreCount,
  mp.ProcessorPriceIDR
FROM MsProcessor mp
WHERE mp.ProcessorCoreCount IN (
    SELECT mp1.ProcessorCoreCount
    FROM MsProcessor mp1
	Join MsServer ms ON mp1.ProcessorID = ms.ProcessorID
	Join MsLocation ml ON ms.LocationID = ml.LocationID
    WHERE
      ml.LocationLatitude BETWEEN 0 AND 90
      AND mp1.ProcessorPriceIDR = (
        SELECT
          MAX(mp2.ProcessorPriceIDR)
        FROM MsProcessor mp2
		Join MsServer ms ON mp2.ProcessorID = ms.ProcessorID
	    Join MsLocation ml ON ms.LocationID = ml.LocationID
        WHERE mp2.ProcessorCoreCount = mp1.ProcessorCoreCount
        AND ml.LocationLatitude BETWEEN 0 AND 90
      )
  )
GROUP BY
 ProcessorName, ProcessorCoreCount, ProcessorPriceIDR, ProcessorModel

 /*
7.	Display HiddenCustomerName (obtained from the first letter of CustomerName followed by '***** *****'), 
CurrentPurchaseAmount (obtained from the amount of sale transactions made), CountedPurchaseAmount (taken from the amount of sale transactions made in 2015 - 2019)
, RewardPointsGiven (obtained from the total spending (counted from the sum of ServerPriceIDR 
for all transactions made) of the customer divided by 1000000 followed by ' point(s)'), for each customer who is in the top 10 
customer with most spending in server purchasing (sale transactions) in 2015 until 2019 period. 
(ALIAS SUBQUERY)
 */
SELECT 
    CONCAT(LEFT(CustomerName, 1), '***** *****') AS HiddenCustomerName,
    SUM(ServerPriceIDR) AS CurrentPurchaseAmount,
    COUNT(SubqueryAlias.SaleID) AS CountedPurchaseAmount,
    CONCAT(SUM(SubqueryAlias.ServerPriceIDR) / 1000000, ' point(s)') AS RewardPointsGiven
FROM 
    (SELECT 
        mc.CustomerName,
        ths.SaleID,
        ms.ServerPriceIDR
    FROM 
        MsCustomer mc 
        JOIN TrHeaderSale ths ON mc.CustomerID = ths.CustomerID
        JOIN TrDetailSale tds ON ths.SaleID = tds.SaleID
        JOIN MsServer ms ON ths.ServerID = ms.ServerID
    WHERE 
        YEAR(ths.TransactionDate) BETWEEN 2015 AND 2019
    ) AS SubqueryAlias
GROUP BY 
    SubqueryAlias.CustomerName
ORDER BY 
    SUM(SubqueryAlias.ServerPriceIDR) DESC;

 /*
 8.	Display StaffName (obtained from 'Staff ' followed by the first word of StaffName), StaffEmail 
 (obtained from replacing part after the '@' in StaffEmail with 'jigitalcloun.net'), StaffAddress, 
 StaffSalary (obtained from StaffSalary divided by 10000000 followed by ' million(s) IDR'), TotalValue 
 (obtained from the sum of (ServerPriceIDR / 120 * RentalDuration)) for every staff who have a salary 
 below the average staff salary and has a TotalValue more than 10000000.
(ALIAS SUBQUERY)
 */


SELECT
    CONCAT('Staff ', SUBSTRING(StaffName, ' ', 1)) AS StaffName,
    CONCAT(SUBSTRING(StaffEmail, '@', 1), '@jigitalcloun.net') AS StaffEmail,
    StaffAddress,
    CONCAT(StaffSalary / 10000000, ' million(s) IDR') AS StaffSalary,
    SUM(ServerPriceIDR / 120 * RentDuration) AS TotalValue
FROM
    (SELECT
        ms.StaffName,
        ms.StaffEmail,
        ms.StaffAddress,
        ms.StaffSalary,
        mser.ServerPriceIDR,
        thr.RentDuration
    FROM
        MsStaff ms
        JOIN TrHeaderRent thr ON ms.StaffID = thr.StaffID
		Join MsServer mser on thr.ServerID = mser.ServerID
    WHERE
        ms.StaffSalary < (SELECT AVG(StaffSalary) FROM MsStaff)
    ) AS SubqueryAlias
GROUP BY
    StaffName, StaffEmail, StaffAddress, StaffSalary
HAVING
    TotalValue > 10000000;



 /*
 9.	Create a view named ‘ServerRentalDurationView’ to display Server (obtained from Replacing 'JCN-V' in ServerID with 'No. '), TotalRentalDuration (Obtained from the total rental duration 
 on the server followed by ' month(s)'), MaxSingleRentalDuration (Obtained from the maximum rental duration on the server followed by ' month(s)') 
 for all servers located in the southern hemisphere (Latitude is below 0 down to -90) which have more than 50 months of total rental duration.
 */
 go
 create VIEW ServerRentalDurationView AS
SELECT
    REPLACE(ms.ServerID, 'JCN-V', 'No. ') AS Server,
    CONCAT(SUM(thr.RentDuration), ' month(s)') AS TotalRentalDuration,
    CONCAT(MAX(thr.RentDuration), ' month(s)') AS MaxSingleRentalDuration
FROM
    TrHeaderRent thr
    JOIN MsServer ms ON thr.ServerID = ms.ServerID
    JOIN MsLocation ml ON ms.LocationID = ml.LocationID
    JOIN TrDetailRent tr ON thr.RentID = tr.RentID
WHERE
    ml.LocationLatitude < 0 AND ml.LocationLatitude >= -90
GROUP BY
    ms.ServerID
HAVING
    SUM(thr.RentDuration) > 50;


 /*
 10.	Create a view named ‘SoldProcessorPerformanceView’ to display SaleID, MinEffectiveClock 
 (obtained from the minimum value of ProcessorClockMHZ * ProcessorCoreCount * 0.675, displayed with 1 decimal places followed by ' MHz'), 
 MaxEffectiveClock (obtained from the maximum value of ProcessorClockMHZ * ProcessorCoreCount * 0.675, displayed with 1 decimal places followed by ' MHz') 
 for every rental transaction that rents a server using a processor with a core count of a power of 2 and that has a MinEffectiveClock of at least 10000.
 */
 go
Create VIEW SoldProcessorPerformanceView AS
SELECT
    TrHeaderRent.RentID AS SaleID,
    CONVERT(VARCHAR(10), MIN(MsProcessor.ProcessorClockMHZ * MsProcessor.ProcessorCoreCount * 0.675), 1) + ' MHz' AS MinEffectiveClock,
    CONVERT(VARCHAR(10), MAX(MsProcessor.ProcessorClockMHZ * MsProcessor.ProcessorCoreCount * 0.675), 1) + ' MHz' AS MaxEffectiveClock
FROM
    TrHeaderRent
    JOIN MsServer ON TrHeaderRent.ServerID = MsServer.ServerID
    JOIN MsProcessor ON MsServer.ProcessorID = MsProcessor.ProcessorID
WHERE
    MsProcessor.ProcessorCoreCount IN (1, 2, 4, 8, 16, 32)
GROUP BY
    TrHeaderRent.RentID
HAVING
    MIN(MsProcessor.ProcessorClockMHZ * MsProcessor.ProcessorCoreCount * 0.675) >= 10000;




