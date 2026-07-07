USE [PracticeDB]
GO
/****** Object:  StoredProcedure [dbo].[SpParkingReportNew]    Script Date: 29-01-2025 17:58:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[dbo].[SpParkingReportNew] 1,0,'A',0
ALTER PROCEDURE [dbo].[SpParkingReportNew] 
	@ProjectId smallint,
	@BuildingId smallint,
	@AllotedVacantVal varchar(5),
	@LinkedParking bit
AS
BEGIN
	
	SET NOCOUNT ON;
	if(@LinkedParking=1 AND @AllotedVacantVal = '')
	Begin
   SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id LEFT OUTER JOIN
			dbo.ParkingLinkingMaster On  dbo.ParkingMaster.RowNumber= dbo.ParkingLinkingMaster.ParkingMasterId
			WHERE  (@ProjectId = 0 OR dbo.ParkingMaster.ProjectId = @ProjectId) AND (@BuildingId = 0 OR dbo.ParkingMaster.BuildingId = @BuildingId) 
			        AND  dbo.ParkingMaster.RowNumber In (Select ParkingMasterId from ParkingLinkingMaster)

   Union ALL
   SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			--dbo.ParkingLinkingMaster On  dbo.ParkingMaster.RowNumber= dbo.ParkingLinkingMaster.ParkingMasterId
			WHERE   (@ProjectId = 0 OR dbo.ParkingMaster.ProjectId = @ProjectId) AND (@BuildingId = 0 OR dbo.ParkingMaster.BuildingId = @BuildingId) 
			      --AND  dbo.ParkingMaster.RowNumber NOT IN (Select ParkingMasterId from ParkingLinkingMaster)
		
    End
	---------------------------------------------------------------------Alloted with Linked----------------------------------------------------------------------------------------
	else if(@LinkedParking=1 AND  @AllotedVacantVal = 'A')
	Begin
	 SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id LEFT OUTER JOIN
			dbo.ParkingLinkingMaster On  dbo.ParkingMaster.RowNumber= dbo.ParkingLinkingMaster.ParkingMasterId
			WHERE  (@ProjectId = 0 OR dbo.ParkingMaster.ProjectId = @ProjectId) AND (@BuildingId = 0 OR dbo.ParkingMaster.BuildingId = @BuildingId)
                    AND dbo.ParkingMaster.RowNumber IN (SELECT ParkingMasterId FROM ParkingLinkingMaster)
					AND  dbo.ParkingMaster.UnitId <> 0
   
    Union

   SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   (@ProjectId = 0 OR dbo.ParkingMaster.ProjectId = @ProjectId) AND (@BuildingId = 0 OR dbo.ParkingMaster.BuildingId = @BuildingId) 
			      --AND  dbo.ParkingMaster.RowNumber NOT IN (Select ParkingMasterId from ParkingLinkingMaster)
				    AND   dbo.ParkingMaster.UnitId <> 0
	End
	------------------------------------Vacant With Linked case-------------------------------------------------------------------------------------------------

	else if(@LinkedParking=1 AND @AllotedVacantVal = 'V' )
	Begin
	WITH FirstQuery AS (
   SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance, ROW_NUMBER() OVER (ORDER BY dbo.ParkingLinkingMaster.RowNo DESC) AS RowNum
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id LEFT OUTER JOIN
			dbo.ParkingLinkingMaster On  dbo.ParkingMaster.RowNumber= dbo.ParkingLinkingMaster.ParkingMasterId
			WHERE   dbo.ParkingMaster.ProjectId = 1 AND  dbo.ParkingMaster.BuildingId = 1
                    AND dbo.ParkingMaster.RowNumber IN (SELECT ParkingMasterId FROM ParkingLinkingMaster)
                    AND  dbo.ParkingMaster.UnitId = 0 
),
SecondQuery AS (
  SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance,Null as RowNum
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   dbo.ParkingMaster.ProjectId = 1 AND dbo.ParkingMaster.BuildingId = 1
				    AND  dbo.ParkingMaster.UnitId = 0
),

FinalTable As(
  SELECT *  FROM FirstQuery
  UNION 
   SELECT *  FROM SecondQuery
   )
    select  ProjectDesc,ProjectId,BuildingDescription,BuildingId,ParkingType,ParkingTypeId,ParkingArea,ParkingNo as ParkingNo,ParkingRate,UOM,UnitNo,Name, UnitId,BuildingDescription AS CB,
           ParkingFloorId, ParkingFloorDesc,ParkingLength,ParkingBreadth,ParkingVerticalClearance from FinalTable  ORDER BY RowNum DESC
	End
	--------------------------------------------------------------Only Alloted-------------------------------------------------------------------------------------
	else if(@LinkedParking=0 AND  @AllotedVacantVal = 'A')
	Begin

	 SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   (@ProjectId = 0 OR dbo.ParkingMaster.ProjectId = @ProjectId) AND (@BuildingId = 0 OR dbo.ParkingMaster.BuildingId = @BuildingId) 
				     AND dbo.ParkingMaster.UnitId <> 0 order by  dbo.FlatMaster.UnitNo

	End
	----------------------------------------------------------Only Vacant-----------------------------------------------------------------------
	else if(@LinkedParking=0 AND @AllotedVacantVal = 'V' )
	Begin

	 SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   (@ProjectId = 0 OR dbo.ParkingMaster.ProjectId = @ProjectId) AND (@BuildingId = 0 OR dbo.ParkingMaster.BuildingId = @BuildingId) 
				    AND  ((@AllotedVacantVal = 'V' AND dbo.ParkingMaster.UnitId = 0) OR (@AllotedVacantVal = 'A' AND dbo.ParkingMaster.UnitId <> 0)) order by dbo.ParkingMaster.RowNumber

	End
	--------------------------------------------------------------All with Linked------------------------------------------------------------------------------------------------
	else if(@LinkedParking=1 AND @AllotedVacantVal = 'ALL')
	Begin
	WITH FirstQuery AS (
    SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance, ROW_NUMBER() OVER (ORDER BY dbo.Booking.Name DESC) AS RowNum
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id LEFT OUTER JOIN
			dbo.ParkingLinkingMaster On  dbo.ParkingMaster.RowNumber= dbo.ParkingLinkingMaster.ParkingMasterId
			WHERE  dbo.ParkingMaster.ProjectId = 1 AND  dbo.ParkingMaster.BuildingId = 1 AND dbo.ParkingMaster.RowNumber IN (SELECT ParkingMasterId FROM ParkingLinkingMaster)
					and dbo.ParkingMaster.UnitId <> 0 
),
SecondQuery AS (
     SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance, NULL AS RowNum 
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   dbo.ParkingMaster.ProjectId = 1 AND  dbo.ParkingMaster.BuildingId = 1  
				    AND dbo.ParkingMaster.UnitId<> 0
),

THIRDQuery AS (
    SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance,NULL AS RowNum 
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   dbo.ParkingMaster.ProjectId = 1 AND  dbo.ParkingMaster.BuildingId = 1  AND dbo.ParkingMaster.RowNumber IN (SELECT ParkingMasterId FROM ParkingLinkingMaster)
				    AND dbo.ParkingMaster.UnitId= 0

),
FOURTHQUERY AS (
       SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance,NULL AS RowNum 
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   dbo.ParkingMaster.ProjectId = 1 AND  dbo.ParkingMaster.BuildingId = 1 
				    AND dbo.ParkingMaster.UnitId= 0
),

 FinalTable As(
  SELECT *  FROM FirstQuery
  UNION 
   SELECT *  FROM SecondQuery
  UNION 
   SELECT *  FROM THIRDQuery
  UNION 
   SELECT *  FROM FOURTHQUERY
   )
  select  ProjectDesc,ProjectId,BuildingDescription,BuildingId,ParkingType,ParkingTypeId,ParkingArea,ParkingNo as ParkingNo,ParkingRate,UOM,UnitNo,Name, UnitId,BuildingDescription AS CB,
           ParkingFloorId, ParkingFloorDesc,ParkingLength,ParkingBreadth,ParkingVerticalClearance from FinalTable  ORDER BY RowNum DESC

    End

	else if(@LinkedParking=0 AND @AllotedVacantVal = 'ALL')
	Begin

	  SELECT   dbo.ProjectMaster.ProjectDesc, dbo.ProjectMaster.ProjectId, dbo.BuildingMaster.BuildingDescription, dbo.BuildingMaster.BuildingId, dbo.ParkingTypeMasterClient.ParkingType, 
            dbo.ParkingTypeMasterClient.ParkingTypeId, dbo.ParkingMaster.ParkingArea,dbo.ParkingMaster.ParkingNo as ParkingNo, dbo.ParkingMaster.ParkingRate, dbo.ParkingMaster.UOM, dbo.FlatMaster.UnitNo, dbo.Booking.Name, 
            dbo.ParkingMaster.UnitId, BuildingMaster_1.BuildingDescription AS CB,
            dbo.ParkingMaster.ParkingFloorId, dbo.ParkingFloorMaster.ParkingFloorDesc,
            dbo.ParkingMaster.ParkingLength,dbo.ParkingMaster.ParkingBreadth,dbo.ParkingMaster.ParkingVerticalClearance
            FROM dbo.ParkingMaster INNER JOIN
            dbo.ProjectMaster ON dbo.ProjectMaster.ProjectId = dbo.ParkingMaster.ProjectId INNER JOIN
            dbo.ParkingTypeMasterClient ON dbo.ParkingTypeMasterClient.ParkingTypeId = dbo.ParkingMaster.ParkingTypeId LEFT OUTER JOIN
            dbo.BuildingMaster ON dbo.BuildingMaster.BuildingId = dbo.ParkingMaster.BuildingId LEFT OUTER JOIN
            dbo.Booking ON dbo.ParkingMaster.UnitId = dbo.Booking.UnitId LEFT OUTER JOIN
            dbo.FlatMaster ON dbo.FlatMaster.UnitId = dbo.ParkingMaster.UnitId LEFT OUTER JOIN
            dbo.BuildingMaster AS BuildingMaster_1 ON BuildingMaster_1.BuildingId = dbo.Booking.BuildingId LEFT OUTER JOIN
            dbo.ParkingFloorMaster ON dbo.ParkingMaster.ParkingFloorId = dbo.ParkingFloorMaster.Id 
			WHERE   (@ProjectId = 0 OR dbo.ParkingMaster.ProjectId = @ProjectId) AND (@BuildingId = 0 OR dbo.ParkingMaster.BuildingId = @BuildingId) 
			    

	End

								
END
