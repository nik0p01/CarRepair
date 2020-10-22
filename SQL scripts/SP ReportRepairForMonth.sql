USE [CarRepair]
GO

/****** Object:  StoredProcedure [dbo].[ReportRepairForMonth]    Script Date: 22.10.2020 15:52:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReportRepairForMonth]
     @month INT
AS
BEGIN
	WITH  RepairesFilterGroup( IDC, IDMaster, DateMin, SumPriceMaster) AS
	(SELECT R.IDCar, R.IDMaster, MIN( R.DateStart ), SUM(R.Price)
	FROM Repaires AS R
	WHERE R.DateStart >= DATEFROMPARTS(2020, @month, 01)  AND R.DateStart <= EOMONTH(DATEFROMPARTS(2020, @month, 01))
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
END
GO

