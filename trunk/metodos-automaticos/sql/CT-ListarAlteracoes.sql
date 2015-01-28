/*** Rotina para verificação manual das mudanças realizadas. ***/

use [sistema-horarios-oficial]

declare @sv bigint
declare @atual_sv bigint
declare @min_sv bigint
declare @tabela nvarchar(30)
declare @id_tabela int


/***** Escolhas do usuário. *****/

-- Escolha da tabela.
set @id_tabela = 0

-- Seleção da versão. Para valores, rodar 'CT-ListarVersoes.sql'.
set @sv = 778178

/***** Fim Escolhas do usuário *****/


-- Nome da tabela.
set @tabela =
	case @id_tabela
		when 0 then 'Tabela_Horarios'
		when 1 then 'Divisoes'
		when 2 then 'Professores'
	end;

-- Versão mínima válida.
set @min_sv = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(@tabela));

-- Versão corrente.
set @atual_sv = CHANGE_TRACKING_CURRENT_VERSION();

-- Exibição das versões.
select @min_sv as 'Versão Mínima Válida', @atual_sv as 'Versão Corrente', @sv as "Versão Selecionada"

-- Exibição das mudanças.

if @id_tabela = 0 /* Tabela_Horarios */
	select ct.* --, ct.Id_Turma, ct.Nome_Aula, ct.sys_change_operation, ct.sys_change_columns, ct.sys_change_context
		from changetable(changes Tabela_Horarios, @sv) as ct
		where ct.sys_change_operation like '%'
			-- and ct.Id_Turma like '%2015%' and ct.sys_change_operation = 'D'
		order by ct.sys_change_version desc --ct.Id_Turma, Nome_Aula
else if @id_tabela = 1 /* Divisao */
	select ct.Id_Turma, ct.sys_change_operation, ct.sys_change_columns, ct.sys_change_context
		from changetable(changes Divisao, @sv) as ct
		--where ct.sys_change_operation like '%'
			--and ct.Id_Turma like '%4%D%'
		--order by ct.Id_Turma
else if @id_tabela = 2 /* Professores */
	select ct.RF, ct.sys_change_operation, ct.sys_change_columns, ct.sys_change_context
		from changetable(changes Professores, @sv) as ct
