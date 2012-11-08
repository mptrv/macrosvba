use [sistema-horarios-oficial]

declare @sv bigint
declare @min_sv bigint

-- Versão mínima válida.
set @min_sv = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Tabela_Horarios'));

-- Versão corrente.
set @sv = CHANGE_TRACKING_CURRENT_VERSION();

-- Inserção dos valores na tabela.
insert into [CT_Versoes] (DataHora, Versao_Minima, Versao_Corrente)
values (GETDATE(), @min_sv, @sv);

-- Exibição dos valores recém-inseridos.
select
	ctv.ID,
	ctv.DataHora as 'Data e Hora',
	ctv.Versao_Minima as 'Versão Mínima Válida',
	ctv.Versao_Corrente as 'Versão Corrente'	
from [CT_Versoes] as ctv
where ctv.ID = (select MAX(ctv.ID) from [CT_Versoes] as ctv);