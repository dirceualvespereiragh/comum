unit UBaseContabilIB;
// Exemplo de Singleton "Mais Elegente"  no Final do código mas infelizmente só funciona a partir do Delphi 2010 .

interface

uses
strUtils, typinfo,variants,  Provider,IBDatabase ,dbclient,dblocal,
IBStoredProc,IBQuery, SysUtils,Classes,DB,INIFiles,

UContabil , uExcecao;

type

   TBaseContabilIB = class(TContabil)
      private

         // Construtor privado para que possamos criar
         // o objeto somente dentro da propria classe
         constructor create();

         procedure CarregaConfig;
         function EstadoBanco: Boolean;
      public
         class function GetObjetoConexao: TContabil;
         procedure Abretransacao;
         procedure CancelaTransacao;
         procedure CompletaCaminho(var fCaminho:String);    override;
      end;

implementation

var FInstancia:TContabil = nil;

constructor TBaseContabilIB.create();
begin
   try
      // criar nossa conexao que será fornecida para todos o objetos DAOs
      FConexao          := TIBDatabase.create(nil);
      FConexao.DatabaseName := ''  ;
      CarregaConfigPadrao;
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


function TBaseContabilIB.EstadoBanco: Boolean;
begin

end;

class function TBaseContabilIB.GetObjetoConexao(): TContabil;
begin
   if (not Assigned(FInstancia)) then begin
      FInstancia := create();
   end;
   result := TContabil(FInstancia);
end;


procedure TBaseContabilIB.CarregaConfig;
begin
   inherited;
   if (Caminho <> '') then begin
   quero tirar este codio abaixo para passar paRA O ANCESTRAL
   MAS APARECE ERRO NA SEGUNDA CHAMADA
   //   FConexao.DatabaseName := Caminho;
   //   FConexao.Params.Add('user_name='+ Usuario);
   //   FConexao.Params.Add(Senha);
   //   FConexao.Params.Add('lc_ctype=ISO8859_1');
   end;
end;


procedure TBaseContabilIB.Abretransacao;
begin

end;

procedure TBaseContabilIB.CancelaTransacao;
begin

end;

procedure TBaseContabilIB.CompletaCaminho(var fCaminho: String);
begin
   fCaminho := fCaminho + 'BSCONTAB.FDB';
end;

end.

