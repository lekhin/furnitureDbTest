--truncate table [order].[orders]

USE [furniture]
GO

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
           (1
		   ,(SELECT id FROM staff.persons WHERE namePerson = N'Иван' AND surnamePerson = N'Иванов')
           ,N'я что-то нажал и оно сломалось'
           ,(SELECT id FROM staff.persons WHERE namePerson = N'Николай' AND surnamePerson = N'Николаев')
           ,1
           ,2
           ,1
           ,1)
           ,(2
		   ,(SELECT id FROM staff.persons WHERE namePerson = N'Василий' AND surnamePerson = N'Петров')
           ,N'поломка'
           ,(SELECT id FROM staff.persons WHERE namePerson = N'Владимир' AND surnamePerson = N'Александров')
           ,1
           ,1
           ,1
           ,2)
GO