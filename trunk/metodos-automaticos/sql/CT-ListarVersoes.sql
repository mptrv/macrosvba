/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT [ID]
      ,[DataHora]
      ,[Versao_Minima]
      ,[Versao_Corrente]
  FROM [sistema-horarios-oficial].[dbo].[CT_Versoes]
  ORDER BY [DataHora];