program ConsultaCEP;

uses
  Vcl.Forms,
  UConsultaCep in 'UConsultaCep.pas' {FrmConsultaCEP};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmConsultaCEP, FrmConsultaCEP);
  Application.Run;
end.
