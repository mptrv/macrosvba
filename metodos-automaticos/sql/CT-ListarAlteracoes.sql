/*** Rotina para verifica��o manual das mudan�as realizadas. ***/

use [sistema-horarios-oficial]

declare @sv bigint
declare @atual_sv bigint
declare @min_sv bigint
declare @tabela nvarchar(30)
declare @id_tabela int


/***** Escolhas do usu�rio. *****/

-- Escolha da tabela.
set @id_tabela = 0

-- Sele��o da vers�o. Para valores, rodar 'CT-ListarVersoes.sql'.
set @sv = 301423

/***** Fim Escolhas do usu�rio *****/


-- Nome da tabela.
set @tabela =
	case @id_tabela
		when 0 then 'Tabela_Horarios'
		when 1 then 'Divisoes'
	end;

-- Vers�o m�nima v�lida.
set @min_sv = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(@tabela));

-- Vers�o corrente.
set @atual_sv = CHANGE_TRACKING_CURRENT_VERSION();

-- Exibi��o das vers�es.
select @min_sv as 'Vers�o M�nima V�lida', @atual_sv as 'Vers�o Corrente', @sv as "Vers�o Selecionada"

-- Exibi��o das mudan�as.

if @id_tabela = 0 /* Tabela_Horarios */
	select ct.Id_Turma, ct.Nome_Aula, ct.sys_change_operation, ct.sys_change_columns, ct.sys_change_context
		from changetable(changes Tabela_Horarios, @sv) as ct
		where ct.sys_change_operation like '%'
			--and ct.Id_Turma like '%4%D%'
		order by ct.Id_Turma, Nome_Aula
else if @id_tabela = 1 /* Divisao */
	select ct.Id_Turma, ct.sys_change_operation, ct.sys_change_columns, ct.sys_change_context
		from changetable(changes Divisao, @sv) as ct
		--where ct.sys_change_operation like '%'
			--and ct.Id_Turma like '%4%D%'
		--order by ct.Id_Turma