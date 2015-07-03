use [sistema-horarios-oficial]

declare @min_sv_th bigint
declare @min_sv_div bigint
declare @sv bigint

-- Vers�o m�nima v�lida.
set @min_sv_th = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Tabela_Horarios'));
set @min_sv_div = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Divisao'));

-- Vers�o corrente.
set @sv = CHANGE_TRACKING_CURRENT_VERSION();

-- Inser��o dos valores na tabela.
insert into [CT_Versoes] (DataHora, Versao_Minima_TH, Versao_Minima_Div, Versao_Corrente)
values (GETDATE(), @min_sv_th, @min_sv_div, @sv);

-- Exibi��o dos valores rec�m-inseridos.
select
	ctv.ID,
	ctv.DataHora as 'Data e Hora',
	ctv.Versao_Minima_TH as 'Vers�o M�nima V�lida TH',
	ctv.Versao_Minima_Div as 'Vers�o M�nima V�lida Div',
	ctv.Versao_Corrente as 'Vers�o Corrente'	
from [CT_Versoes] as ctv
where ctv.ID = (select MAX(ctv.ID) from [CT_Versoes] as ctv);