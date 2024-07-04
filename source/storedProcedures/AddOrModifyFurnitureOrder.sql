USE furniture;
GO
CREATE PROCEDURE AddOrModifyFurnitureOrder
    @json NVARCHAR(max)
AS

--Вставка подразделения заказчика
IF NOT EXISTS (SELECT dap.id, dap.depName, dap.divName
  FROM [staff].[departments] dap 
  WHERE 1 = 1
  AND dap.depName = JSON_VALUE(@json, '$.applicant.department'))
  BEGIN
	INSERT INTO [staff].[departments]
           ([depName]
           ,[divName])
     VALUES
           (JSON_VALUE(@json, '$.applicant.department')
           , NULL)
  END

--Вставка заказчика
IF NOT EXISTS (SELECT ap.id, ap.namePerson, ap.surnamePerson, dap.depName
  FROM [staff].[persons] ap
  INNER JOIN [staff].[departments] dap ON dap.id = ap.department
  WHERE 1 = 1
  AND ap.id = JSON_VALUE(@json, '$.applicant.id')
  AND ap.namePerson = JSON_VALUE(@json, '$.applicant.name')
  AND ap.surnamePerson = JSON_VALUE(@json, '$.applicant.surname')
  AND dap.depName = JSON_VALUE(@json, '$.applicant.department'))
  BEGIN
	INSERT INTO [staff].[persons]
           ([id]
		   ,[namePerson]
           ,[surnamePerson]
           ,[department]
           ,[position])
     VALUES
           (JSON_VALUE(@json, '$.applicant.id')
		   ,JSON_VALUE(@json, '$.applicant.name')
           ,JSON_VALUE(@json, '$.applicant.surname')
           ,(SELECT TOP 1 id FROM staff.departments WHERE depName = JSON_VALUE(@json, '$.applicant.department'))
           ,NULL)
  END

--Вставка подразделения менеджера
IF NOT EXISTS (SELECT dap.id, dap.depName, dap.divName
  FROM [staff].[departments] dap 
  WHERE 1 = 1
  AND dap.depName = JSON_VALUE(@json, '$.coordinatingManager.department')
  AND dap.divName = JSON_VALUE(@json, '$.coordinatingManager.division'))
  BEGIN
	INSERT INTO [staff].[departments]
           ([depName]
           ,[divName])
     VALUES
           (JSON_VALUE(@json, '$.coordinatingManager.department')
           ,JSON_VALUE(@json, '$.coordinatingManager.division'))
  END

--Вставка менеджера
IF NOT EXISTS (SELECT ap.id, ap.namePerson, ap.surnamePerson, dap.depName
  FROM [staff].[persons] ap
  INNER JOIN [staff].[departments] dap ON dap.id = ap.department
  WHERE 1 = 1
  AND ap.id = JSON_VALUE(@json, '$.coordinatingManager.id')
  AND ap.namePerson = JSON_VALUE(@json, '$.coordinatingManager.name')
  AND ap.surnamePerson = JSON_VALUE(@json, '$.coordinatingManager.surname')
  AND ap.position = JSON_VALUE(@json, '$.coordinatingManager.position')
  AND dap.depName = JSON_VALUE(@json, '$.coordinatingManager.department')
  AND dap.divName = JSON_VALUE(@json, '$.coordinatingManager.division'))
  BEGIN
	INSERT INTO [staff].[persons]
           ([id]
		   ,[namePerson]
           ,[surnamePerson]
           ,[department]
           ,[position])
     VALUES
           (JSON_VALUE(@json, '$.coordinatingManager.id')
		   ,JSON_VALUE(@json, '$.coordinatingManager.name')
           ,JSON_VALUE(@json, '$.coordinatingManager.surname')
           ,(SELECT TOP 1 id FROM staff.departments WHERE depName = JSON_VALUE(@json, '$.coordinatingManager.department'))
           ,JSON_VALUE(@json, '$.coordinatingManager.position'))
  END

--Вставка заказа
IF NOT EXISTS (SELECT o.id
FROM [order].[orders] o
INNER JOIN [types].resolutions res ON res.id = o.resolution
INNER JOIN [types].solutions sol ON sol.id = o.resolution
INNER JOIN [types].statuses s ON s.id = o.status
WHERE o.id = JSON_VALUE(@json, '$.furnitureOrderId'))
  BEGIN
INSERT INTO [order].[orders]
           ([id]
		   ,[applicantId]
           ,[applicationReason]
           ,[coordinatingManagerId]
           ,[resolution]
           ,[resolutionPeriod]
           ,[resolutionSolution]
           ,[status])
     VALUES
           (JSON_VALUE(@json, '$.furnitureOrderId')
		   ,JSON_VALUE(@json, '$.applicant.id')
           ,JSON_VALUE(@json, '$.applicationReason')
           ,JSON_VALUE(@json, '$.coordinatingManager.id')
           ,(SELECT TOP 1 id FROM [types].resolutions WHERE resolutionName = JSON_VALUE(@json, '$.resolution'))
           ,JSON_VALUE(@json, '$.resolutionPeriod')
           ,(SELECT TOP 1 id FROM [types].solutions WHERE solutionsName = JSON_VALUE(@json, '$.resolutionSolution'))
           ,(SELECT TOP 1 id FROM [types].statuses WHERE statusName = JSON_VALUE(@json, '$.status')))
  END
--Обновление заказа
ELSE
  BEGIN
    UPDATE [order].[orders]
	SET [applicantId] = JSON_VALUE(@json, '$.applicant.id')
           ,[applicationReason] = JSON_VALUE(@json, '$.applicationReason')
           ,[coordinatingManagerId] = JSON_VALUE(@json, '$.coordinatingManager.id')
           ,[resolution] = (SELECT TOP 1 id FROM [types].resolutions WHERE resolutionName = JSON_VALUE(@json, '$.resolution'))
           ,[resolutionPeriod] = JSON_VALUE(@json, '$.resolutionPeriod')
           ,[resolutionSolution] = (SELECT TOP 1 id FROM [types].solutions WHERE solutionsName = JSON_VALUE(@json, '$.resolutionSolution'))
           ,[status] = (SELECT TOP 1 id FROM [types].statuses WHERE statusName = JSON_VALUE(@json, '$.status'))
  END