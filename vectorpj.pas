program vectorpj;

{$mode objfpc}{$H+}

uses
    {$IFDEF UNIX}{$IFDEF UseCThreads}
    cthreads,
    {$ENDIF}{$ENDIF}
    Interfaces, // this includes the LCL widgetset
    Forms, mainform, formabout
    { you can add units after this };

{$R *.res}

begin
    RequireDerivedFormResource:=True;
    Application.Initialize;
		Application.CreateForm(TVector, Vector);
		Application.CreateForm(Taboutinfo, aboutinfo);
    Application.Run;
end.

