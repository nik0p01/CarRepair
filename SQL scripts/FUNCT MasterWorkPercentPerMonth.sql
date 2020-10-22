USE [CarRepair]
GO

/****** Object:  UserDefinedFunction [dbo].[MasterWorkPercentPerMonth]    Script Date: 22.10.2020 15:53:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[MasterWorkPercentPerMonth] (@IDMaster int,  @month int)
RETURNS int
AS
BEGIN
	DECLARE @AllWoringDays int;
	DECLARE @MasterWoringDays int;
	--bad decision to count it every time
	SELECT @AllWoringDays = SUM(dbo.NumberWorkingDaysPerMonth(R.DateStart, R.DataEnd, @month)) 
	FROM dbo.Repaires AS R

	SELECT @MasterWoringDays = SUM(dbo.NumberWorkingDaysPerMonth(R.DateStart, R.DataEnd, @month)) 
	FROM dbo.Repaires AS R
	WHERE r.IDMaster = @IDMaster

	RETURN @MasterWoringDays*100/@AllWoringDays;
END



GO

