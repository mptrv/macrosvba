/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT [ID]
      ,[DataHora]
      ,[Versao_Minima_TH]
      ,[Versao_Minima_Div]
      ,[Versao_Corrente]
  FROM [sistema-horarios-oficial].[dbo].[CT_Versoes]
  ORDER BY [DataHora] DESC;