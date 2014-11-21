unit UContabil;

interface

uses
INIFiles,SysUtils,

UConexaoFB , uExcecao;

CONST str_senha : String = 'password=bjj*34jb';

type
   TContabil = class(TConexaoFB)
   protected
      procedure CarregaConfig() overload;
      procedure CompletaCaminho(var fCaminho:String); virtual;  abstract;
      destructor destroy();
   end;

implementation

{ TContabil }

procedure TContabil.CarregaConfig;
var
   Arquivo      : TINIFile;
   pQualCaminho : String;
begin
      pQualCaminho := 'c:\ap\contabil.cfg';

      if FileExists(pQualCaminho) then   begin
         Arquivo  := TIniFile.Create(pQualCaminho);
         Caminho  := '';
         Caminho :=  Arquivo.ReadString('BANCO','CAMINHO','');
         CompletaCaminho(fCaminho);
         StringDeConexao :=  Arquivo.ReadString('BANCO','STRINGCONEXAO','');
         Arquivo.Free;
         Usuario := 'SYSDBA';
         Senha   := str_senha;
         if (Caminho = '') then begin
            FConexao := nil;
            FMensagemErro := 'Informações para configuração do Sistema não estão corretas'+#13#10+'Sistema Abortado';
            Raise TConGeralExcecao.Create(FMensagemErro);
         end else begin
            FConexao.DatabaseName := Caminho;
            FConexao.Params.Add('user_name='+ Usuario);
            FConexao.Params.Add(Senha);
            FConexao.Params.Add('lc_ctype=ISO8859_1');
         end;
      end else begin
         FConexao := nil;
         FMensagemErro := 'Arquivo de configuração do Sistema não encontrado'+#13#10+'Sistema Abortado';
         Raise TConGeralExcecao.Create(FMensagemErro);
      end;

end;


destructor TContabil.destroy;
begin
 inherited;
  try
     FTransacao.Free;
     FTransacao := nil;
     inherited;
  except
     on TConGeralExcecao do begin
        FConexao := nil;
        FMensagemErro := 'Erro ao Finalizar o Serviço e Banco de Dados';
        Raise TConGeralExcecao.Create(FMensagemErro);
     end;
  end;

end;


end.
