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
		   ,(SELECT id FROM staff.persons WHERE namePerson = N'����' AND surnamePerson = N'������')
           ,N'� ���-�� ����� � ��� ���������'
           ,(SELECT id FROM staff.persons WHERE namePerson = N'�������' AND surnamePerson = N'��������')
           ,1
           ,2
           ,1
           ,1)
           ,(2
		   ,(SELECT id FROM staff.persons WHERE namePerson = N'�������' AND surnamePerson = N'������')
           ,N'�������'
           ,(SELECT id FROM staff.persons WHERE namePerson = N'��������' AND surnamePerson = N'�����������')
           ,1
           ,1
           ,1
           ,2)
GO