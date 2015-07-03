-- CONCESSÕES A USUÁRIOS
-- 
-- Cria funções ("roles") e define permissões a elas.
--
-- Usuários deverão ser acrescentados à função por:
--	exec sp_addrolemember 'role', 'user'.
--
-- Informações sobre usuários e funções poderão ser obtidas por:
--	exec sp_helprole ...
--	exec sp_helprotect ...
--	exec sp_helprolemember ...
-- ou ainda por:
--	select user_name(role_principal_id), user_name(member_principal_id) from sys.database_role_members
--	order by 2;

------------------------------------------------------
-- INFORMAÇÕES
------------------------------------------------------

use [sistema-horarios-oficial]
--use [sistema-horarios-depuracao]
go

exec sp_helprolemember sch;
go

------------------------------------------------------
-- DEFINIÇÕES
------------------------------------------------------

use [sistema-horarios-oficial]
--use [sistema-horarios-depuracao]
go

-- Se ainda não criado, descomentar:
--create role sch;

grant
	insert, update, delete, select
	on dbo.Divisao
	to "sch";
	
grant
	insert, update, delete, select
	on dbo.Tabela_Horarios
	to "sch";
	
grant
	insert, update, delete, select
	on dbo.IMT_Atividades_Outras
	to "sch";

grant
	insert, update, delete, select
	on dbo.IMT_TG
	to "sch";
	
grant
	insert,
	update (Nome, Nome_Formatado, IMT_Categoria, IMT_Regime, MagSup_DataIni, IMT_Data_Desligamento, Observacoes),
	select
	on dbo.Professores
	to "sch";
	
grant
	insert,
	update,
	select
	on dbo.PG_Professores
	to "sch";

grant
	insert,
	update (Motivo, Observacoes),
	select
	on dbo.IMT_Licenca_Afastamento
	to "sch";

go