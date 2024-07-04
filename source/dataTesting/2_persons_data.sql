--delete from [staff].[persons]

USE [furniture]
GO

INSERT INTO [staff].[persons]
           ([namePerson]
           ,[surnamePerson]
           ,[department]
           ,[position])
     VALUES
           (N'Иван'
           ,N'Иванов'
           ,(SELECT id FROM staff.departments WHERE depName = N'Департамент ИТ')
           ,N'тестировщик')
           ,(N'Николай'
           ,N'Николаев'
           ,(SELECT id FROM staff.departments WHERE depName = N'Департамент хозяйственной деятельности')
           ,N'менеджер')
		   ,(N'Василий'
           ,N'Петров'
           ,(SELECT id FROM staff.departments WHERE depName = N'Департамент ИТ')
           , NULL)
		   ,(N'Владимир'
           ,N'Александров'
           ,(SELECT id FROM staff.departments WHERE depName = N'Департамент хозяйственной деятельности')
           , N'заведующий хозяйством')

GO





