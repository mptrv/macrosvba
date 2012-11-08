use [sistema-horarios-oficial]

declare @sv bigint
declare @min_sv bigint

-- Vers�o m�nima v�lida.
set @min_sv = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Tabela_Horarios'));

-- Vers�o corrente.
set @sv = CHANGE_TRACKING_CURRENT_VERSION();

-- Inser��o dos valores na tabela.
insert into [CT_Versoes] (DataHora, Versao_Minima, Versao_Corrente)
values (GETDATE(), @min_sv, @sv);

-- Exibi��o dos valores rec�m-inseridos.
select
	ctv.ID,
	ctv.DataHora as 'Data e Hora',
	ctv.Versao_Minima as 'Vers�o M�nima V�lida',
	ctv.Versao_Corrente as 'Vers�o Corrente'	
from [CT_Versoes] as ctv
where ctv.ID = (select MAX(ctv.ID) from [CT_Versoes] as ctv);