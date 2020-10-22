USE [CarRepair]
GO

/****** Object:  View [dbo].[CarsInMay]    Script Date: 22.10.2020 15:51:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[CarsInMay] AS
WITH  RepairesFilterGroup( IDC, IDMaster, DateMin, SumPriceMaster) AS
(SELECT R.IDCar, R.IDMaster, MIN( R.DateStart ), SUM(R.Price)
FROM Repaires AS R
WHERE R.DateStart >='2020.05.01' AND R.DateStart<'2020.06.01'
GROUP BY R.IDCar, R.IDMaster)
SELECT TOP 10000 *, dbo.MasterWorkPercentPerMonth(IDMaster, 5) AS MasterWorkPercentPerMonth  FROM RepairesFilterGroup
JOIN 
(SELECT IDC AS IDCar, MIN(R.DateMin) AS DateMinCar, SUM(R.SumPriceMaster) AS SumPriceCar
FROM RepairesFilterGroup as R
GROUP BY IDC) AS GrouCar
ON IDC = IDCar
JOIN 
(SELECT Cars.ID AS CarID, Cars.Nuber, RTRIM(Brands.Name)+' '+ Models.Name AS Model FROM Models, Brands, Cars
WHERE Models.IDBrand = Brands.ID AND Cars.IDModel = Models.ID) AS CarModel
ON IDCar = CarModel.CarID
JOIN
Masters 
ON IDMaster = Masters.ID
ORDER BY DateMinCar,  FullName, Model
GO

