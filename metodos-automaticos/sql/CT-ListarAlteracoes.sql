/*** Rotina para verificação manual das mudanças realizadas. ***/

use [sistema-horarios-oficial]

declare @sv bigint
declare @atual_sv bigint
declare @min_sv bigint

-- Versão mínima válida.
set @min_sv = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Tabela_Horarios'));

-- Versão corrente.
set @atual_sv = CHANGE_TRACKING_CURRENT_VERSION();

-- Seleção da versão. Para valores, rodar 'CT-ListarVersoes.sql'.
set @sv = 54001

-- Exibição das versões.
select @min_sv as 'Versão Mínima Válida', @atual_sv as 'Versão Corrente', @sv as "Versão Selecionada"

-- Exibição das mudanças.
select ct.Id_Turma, ct.Nome_Aula, ct.sys_change_operation, ct.sys_change_columns, ct.sys_change_context
	from changetable(changes Tabela_Horarios, @sv) as ct
	where ct.sys_change_operation like '%'
	order by ct.Id_Turma