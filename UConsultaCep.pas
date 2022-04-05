unit UConsultaCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.Buttons;

type
  TFrmConsultaCEP = class(TForm)
    EdtCEP: TMaskEdit;
    Image1: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    MemTable: TFDMemTable;
    Memo1: TMemo;
    Label1: TLabel;
    btnConsultar: TBitBtn;
    edtlimpar: TBitBtn;
    procedure btnConsultar2Click(Sender: TObject);
    procedure edtlimpar1Click(Sender: TObject);
    procedure edtlimparClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
     function ConsultaCEP(cep: string):boolean;
  public
    { Public declarations }


end;

var
  FrmConsultaCEP: TFrmConsultaCEP;

implementation

{$R *.dfm}

procedure TFrmConsultaCEP.btnConsultarClick(Sender: TObject);
begin
    // Chamando a função que esta implementada o consumo da API RESTFULL
    ConsultaCEP(EdtCEP.Text);
end;

function TFrmConsultaCEP.ConsultaCEP(cep: string):boolean;
VAR CONTAR :INTEGER;
begin
    //Receber a quantidade de caracteres digitados
    CONTAR:= LENGTH(EdtCEP.Text);

    if CONTAR <> 8  then
     ShowMessage('Possívelmente CEP inválido!!!')
    else
     begin
         //Passando a URL VIACEP.COM.BR/WS + CEP DENTRO DO EDIT + FORMATO DESEJADO JSON
         RESTRequest1.Resource:= EdtCEP.Text+'/json';
         RESTRequest1.Execute;

         //Verificando o status de retorno da API se 200 continuar
         if RESTRequest1.Response.StatusCode = 200 then
          begin
            // Se retornar ERRO então CEP não ecnontrado
            if RESTRequest1.Response.Content.IndexOf('erro')>0 then
             begin
               ShowMessage('CEP NÃO ENCONTRADO');

             end
            ELSE
             BEGIN
               //Limpando memo que esta sendo usado no exemplo.
               Memo1.Clear;
               WITH MemTable do
                begin
                   //Adicionando nas linahs do MEMO.
                   Memo1.Lines.Add('CEP:'+FieldByName('CEP').ASString);
                   Memo1.Lines.Add('logradouro:'+FieldByName('Logradouro').ASString);
                   Memo1.Lines.Add('complemento:'+FieldByName('Complemento').ASString);
                   Memo1.Lines.Add('bairro:'+FieldByName('Bairro').ASString);
                   Memo1.Lines.Add('localidade:'+FieldByName('Localidade').ASString);
                   Memo1.Lines.Add('uf:'+FieldByName('UF').ASString);
                   Memo1.Lines.Add('ibge:'+FieldByName('IBGE').ASString);
                   Memo1.Lines.Add('gia:'+FieldByName('GIA').ASString);
                   Memo1.Lines.Add('ddd:'+FieldByName('DDD').ASString);
                   Memo1.Lines.Add('siafi:'+FieldByName('SIAFI').ASString);
                end;
             END;

          end;

     end;
end;


procedure TFrmConsultaCEP.edtlimpar1Click(Sender: TObject);
begin
    //Limpar o conteudo para nova pesquisa.
    memo1.Lines.Clear;
    EdtCEP.Clear;
end;

procedure TFrmConsultaCEP.edtlimparClick(Sender: TObject);
begin
    //Limpar o conteudo para nova pesquisa.
    memo1.Lines.Clear;
    EdtCEP.Clear;
end;

procedure TFrmConsultaCEP.btnConsultar2Click(Sender: TObject);
begin
    // Chamando a função que esta implementada o consumo da API RESTFULL
    ConsultaCEP(EdtCEP.Text);
end;

end.
