USE [furniture]
GO

/****** Object:  View [dbo].[ordersView]    Script Date: 04.07.2024 21:41:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ordersView] WITH SCHEMABINDING
AS
SELECT ap.namePerson as applicantName, ap.surnamePerson as applicantSurname, dap.depName as department, o.applicationReason, cm.namePerson as coordinatingManagerName, cm.surnamePerson as coordinatingManagerSurname, dcm.depName as coordinatingManagerDepartment, dcm.divName as coordinatingManagerDivision, cm.position as coordinatingManager, res.resolutionName as resolution, sol.solutionsName as solution, o.eventDate, s.statusName as status
FROM [order].[orders] o
INNER JOIN [staff].[persons] ap ON ap.id = o.applicantId
INNER JOIN [staff].[persons] cm ON cm.id = o.coordinatingManagerId
INNER JOIN [staff].[departments] dap ON dap.id = ap.department
INNER JOIN [staff].[departments] dcm ON dcm.id = cm.department
INNER JOIN [types].resolutions res ON res.id = o.resolution
INNER JOIN [types].solutions sol ON sol.id = o.resolution
INNER JOIN [types].statuses s ON s.id = o.status
GO


