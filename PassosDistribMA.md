## Descrição ##

Relação dos passos que devem ser realizados para a geração de uma versão de distruição, alocada em '/tags'.

## Passos ##

  1. Atualizar a numeração da versão dos programas nos programas.
  1. Alterar a referência de banco de dados para o remoto oficial, em todos os programas.
  1. Atualizar a numeração da versão dos programas na tabela de versões do Servidor.
  1. Fazer _commit_ (com `svn ci`).
  1. Gerar a distribuição por:
    * execução de `svnco-distr`, em `.../distribuicoes/`; ou
    * realização dos passos abaixo:
      1. Gerar cópia de trabalho (_working copy_, com `svn co`) no subdiretório `.../distribuicoes/` com base na versão anterior em `.../tags/`; neste momento, deverá ser criado o subdiretório `.../distribuicoes/metodos-automaticos-<versão>/`.
      1. Descompactar o arquivo compactado.
      1. Remover do controle de versão o arquivo compactado (com `svn rm`).
      1. Preparar o conteúdo dos subdiretórios. Em especial, copiar as macros de interesse para o subdiretório correspondente.
      1. Salvar o programa CGH, gerando o arquivo `construcao-grade_horaria.bloqueio`.
      1. Alterar atributo de arquivo para oculto de `construcao-grade_horaria.bloqueio` e de `servidor-sistema-horarios-oficial.dsn`.
      1. Renomear os arquivos de extensão `.accdb` para `.accdr`.
      1. Compactar o conteúdo todo em formato `.7z`.
      1. Pode-se excluir o conteúdo previamente descompactado.
      1. Adicionar o arquivo compactado ao controle de versão (com `svn add`).
      1. Enviar a cópia de trabalho para a correspondente _tag_, em `.../tags/metodos-automaticos-<versão>/` (com `svn copy`).