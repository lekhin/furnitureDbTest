--delete from [staff].[persons]

USE [furniture]
GO

INSERT INTO [staff].[persons]
           ([namePerson]
           ,[surnamePerson]
           ,[department]
           ,[position])
     VALUES
           (N'����'
           ,N'������'
           ,(SELECT id FROM staff.departments WHERE depName = N'����������� ��')
           ,N'�����������')
           ,(N'�������'
           ,N'��������'
           ,(SELECT id FROM staff.departments WHERE depName = N'����������� ������������� ������������')
           ,N'��������')
		   ,(N'�������'
           ,N'������'
           ,(SELECT id FROM staff.departments WHERE depName = N'����������� ��')
           , NULL)
		   ,(N'��������'
           ,N'�����������'
           ,(SELECT id FROM staff.departments WHERE depName = N'����������� ������������� ������������')
           , N'���������� ����������')

GO





