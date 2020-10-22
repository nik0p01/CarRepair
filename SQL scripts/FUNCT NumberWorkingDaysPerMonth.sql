USE [CarRepair]
GO

/****** Object:  UserDefinedFunction [dbo].[NumberWorkingDaysPerMonth]    Script Date: 22.10.2020 15:54:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[NumberWorkingDaysPerMonth] (@dateStart date,  @dateEnd date, @month int)
RETURNS int
AS
BEGIN
	DECLARE @workingDays int
	DECLARE @deltaStart int;
	DECLARE @deltaEnd int;
	SET @deltaStart = 0 ;
	SET @deltaEnd = 0 ;

	DECLARE @firstDayMonth date;
	SET @firstDayMonth = DATEFROMPARTS ( 2020, @month, 01 );
	DECLARE @lastDayMonth date;
	SET @lastDayMonth =  EOMONTH(@firstDayMonth);

	IF @dateStart > @dateEnd OR @dateStart>	@lastDayMonth OR @dateEnd < @firstDayMonth
		SET @workingDays = 0;
	ELSE
		BEGIN
			IF @dateStart> @firstDayMonth 
				SET @deltaStart =  DATEDIFF_BIG(day, @firstDayMonth , @dateStart);
			IF @dateEnd < @lastDayMonth
				SET @deltaEnd =  DATEDIFF_BIG(day,  @dateEnd, @lastDayMonth);
			SET @workingDays = DAY(@lastDayMonth) - @deltaStart - @deltaEnd;
		END
	RETURN(@workingDays)
END

GO

