program NetworkTrafficMonitor;

uses
  Forms,
  IPHelper in 'IPHelper.pas',
  IPHLPAPI in 'IPHLPAPI.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  TrafficUnit in 'TrafficUnit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
