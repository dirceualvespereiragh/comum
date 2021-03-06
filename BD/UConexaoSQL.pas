unit UConexaoSQL;

interface

uses
strUtils, typinfo,variants,  Provider,dbclient,dblocal,
 SysUtils,Classes,DB,INIFiles,   ADODB,

UConexao ;


CONST str_senha : String = 'password=bjj*34jb';

type
   TConGeralExcecao = class(Exception);//Exece��o  Gen�rica

   TConexaoSQL = class(TConexaoBD)
      private
         // Variavel est�tica para armazenar a unica instancia
         FConexao             : TADOConnection;

         // Construtor privado para que possamos criar
         // o objeto somente dentro da propria classe
         constructor create();

         procedure CarregaConfig;
         procedure CarregaConfigPadrao;
         procedure SetConexao(const Value: TADOConnection);

      published
         property Conexao :  TADOConnection read FConexao write SetConexao;
      public
         class function GetObjetoConexao: TConexaoSQL;
      end;

implementation

var FInstancia:TConexaoBD = nil;


{ TConexaoSQL }

constructor TConexaoSQL.create();
begin
   try
      // criar nossa conexao que ser� fornecida para todos o objetos DAOs
      FConexao          := TADOConnection.create(nil);
      FConexao.ConnectionString := ''  ;
      CarregaConfig();
   except
      on TConGeralExcecao do begin
            FConexao.Free;
            FConexao := nil;
            FMensagemErro := 'Erro nos parametros para abrir o Banco de Dados.';
            Raise
               TConGeralExcecao.Create('('+ FMensagemErro);
      end;
   end;
end;





procedure TConexaoSQL.SetConexao(const Value: TADOConnection);
begin
   FConexao := Value;
end;


class function TConexaoSQL.GetObjetoConexao(): TConexaoSQL;
begin
   if (not Assigned(FInstancia)) then begin
      FInstancia := create();
   end;
   result := TConexaoSQL(FInstancia);
end;


procedure TConexaoSQL.CarregaConfig;
var
   Arquivo      : TINIFile;
   pQualCaminho : String;
begin
   inherited;
   if (Caminho <> '') then begin
      FConexao.ConnectionString := StringDEConexao ;
   end;
end;


procedure TConexaoSQL.CarregaConfigPadrao;
begin

end;


end.

