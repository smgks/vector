unit formabout;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
		StdCtrls;

type

		{ Taboutinfo }

    Taboutinfo = class(TForm)
				Button1: TButton;
				PaintBox1: TPaintBox;
				Timer1: TTimer;
				procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
				procedure PaintBox1Paint(Sender: TObject);
				procedure Timer1Timer(Sender: TObject);
    private

    public

    end;

var
    aboutinfo: Taboutinfo;
    x,y:integer;
    t:Double;

implementation

{$R *.lfm}

{ Taboutinfo }

procedure Taboutinfo.FormCreate(Sender: TObject);
begin
t:=0;
end;

procedure Taboutinfo.Button1Click(Sender: TObject);
begin
    Close;
end;

procedure Taboutinfo.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Brush.Color:=clRed;
  PaintBox1.Canvas.Ellipse(x-10,y-10,x+10,y+10);
end;

procedure Taboutinfo.Timer1Timer(Sender: TObject);
begin

  t:=t+0.08;
  if(t >(pi*2)) then t:=0;
  x:= 225 + round(200*cos(t));
  y:= 175 + round(150*sin(t));
  PaintBox1.Canvas.Clear;
   PaintBox1.Invalidate;
end;

end.

