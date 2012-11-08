/*** Rotina para verifica��o manual das mudan�as realizadas. ***/

use [sistema-horarios-oficial]

declare @sv bigint
declare @atual_sv bigint
declare @min_sv bigint

-- Vers�o m�nima v�lida.
set @min_sv = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Tabela_Horarios'));

-- Vers�o corrente.
set @atual_sv = CHANGE_TRACKING_CURRENT_VERSION();

-- Sele��o da vers�o. Para valores, rodar 'CT-ListarVersoes.sql'.
set @sv = 54001

-- Exibi��o das vers�es.
select @min_sv as 'Vers�o M�nima V�lida', @atual_sv as 'Vers�o Corrente', @sv as "Vers�o Selecionada"

-- Exibi��o das mudan�as.
select ct.Id_Turma, ct.Nome_Aula, ct.sys_change_operation, ct.sys_change_columns, ct.sys_change_context
	from changetable(changes Tabela_Horarios, @sv) as ct
	where ct.sys_change_operation like '%'
	order by ct.Id_Turma