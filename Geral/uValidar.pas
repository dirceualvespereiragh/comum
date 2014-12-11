unit uValidar;

interface

uses
    Controls, Messages,  Forms,

   uExcecao;

type

   TValidar = class
      public
         class procedure CampoObrigatorio (Campo: String; ShowMsg: Boolean;Menssagem: String; Componente: TWinControl);
         class procedure CampoExtend(Campo: String; ShowMsg: Boolean;Menssagem: String; Componente: TWinControl);
   end;

implementation

{ TValidar }

class procedure TValidar.CampoExtend(Campo: String; ShowMsg: Boolean;  Menssagem: String; Componente: TWinControl);
var
  float         : Extended;
  PosicaoDoErro : Integer;
begin
   val(Campo,float,PosicaoDoErro);
   if PosicaoDoErro <> 0 then begin
     Componente.SetFocus;
     if ShowMsg then   raise TConGeralExcecao.Create(Menssagem);
   end;
end;

class procedure TValidar.CampoObrigatorio(Campo: String; ShowMsg: Boolean;  Menssagem: String; Componente: TWinControl);
begin
  if  Campo = '' then  begin
     Componente.SetFocus;
     if ShowMsg then   raise TConGeralExcecao.Create(Menssagem);
  end;
end;

end.





