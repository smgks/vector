unit mainform;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
		StdCtrls, Menus, ColorBox, Spin, ExtDlgs,formabout;

type

		{ TVector }

    TVector = class(TForm)
				body: TPanel;
				Buttonbcg: TButton;
				Buttoncolor: TButton;
				Colorcur: TColorBox;
				ColorDialog: TColorDialog;
				head: TPanel;
				MainMenu: TMainMenu;
				Menufile: TMenuItem;
				Menusave: TMenuItem;
				Menuopen: TMenuItem;
				info: TMenuItem;
				about: TMenuItem;
				linelen: TSpinEdit;
				PaintBox: TPaintBox;
				linewidth: TSpinEdit;
				procedure aboutClick(Sender: TObject);
    procedure ButtonbcgClick(Sender: TObject);
				procedure ButtoncolorClick(Sender: TObject);
    procedure ColorcurChange(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure FormKeyPress(Sender: TObject; var Key: char);
				procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
						Shift: TShiftState; X, Y: Integer);
				procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
						Y: Integer);
				procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
						Shift: TShiftState; X, Y: Integer);
				procedure PaintBoxPaint(Sender: TObject);
    private

    public

    end;
    TLine = record
        line: array of TPoint;
        len: integer;
        Width:Integer;
        Color: TColor;
    end;
var
    Vector: TVector;
    PBmouve:TPoint;
    Flag_ispaint:Boolean;
    linepool:array of TLine;
    bcgcl:TColor;
    k,z:Integer;  //счетчики
implementation

{$R *.lfm}

{ TVector }


procedure TVector.ColorcurChange(Sender: TObject);
begin
    PaintBox.Canvas.Pen.Color:=Colorcur.Selected;
end;

procedure TVector.FormCreate(Sender: TObject);
begin
    bcgcl:=clWhite;
end;

procedure TVector.FormKeyPress(Sender: TObject; var Key: char);
begin
    if (ord(Key)=26)then //undo on ctr+Z
     begin
        if(k>0)then
         begin
         k:=k-1;
         PaintBox.Invalidate;
         z:=z+1;
				 end;
		 end;

    if (ord(Key)=1)then  //redo on ctr+A
     begin
        if(z>0)then
         begin
         k:=k+1;
         z:=z-1;
         PaintBox.Invalidate;
				 end;
		 end;
end;

procedure TVector.ButtonbcgClick(Sender: TObject);
begin
    bcgcl:=Colorcur.Selected;
    PaintBox.Invalidate;
end;

procedure TVector.aboutClick(Sender: TObject);
begin
    aboutinfo.Show;
end;

procedure TVector.ButtoncolorClick(Sender: TObject);
begin
    if(ColorDialog.Execute)then Colorcur.Selected:=ColorDialog.Color;
end;

procedure TVector.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
		Shift: TShiftState; X, Y: Integer);
begin
     Flag_ispaint:=True;
     k:=k+1;
     SetLength(linepool,k+1);
     linepool[k].len:=0;
     SetLength(linepool[k].line,linepool[k].len+1);
     linepool[k].line[0]:=point(x,y);
     linepool[k].Color:=Colorcur.Selected;
     linepool[k].Width:=linewidth.Value;
end;

procedure TVector.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
		Y: Integer);
begin
    PBmouve:=Point(x,y);
   if (Flag_ispaint and (sqrt(((linepool[k].line[linepool[k].len].x - PBmouve.x)*
   (linepool[k].line[linepool[k].len].x - PBmouve.x)) + ((linepool[k].line[linepool[k].len].y
   - PBmouve.y)*(linepool[k].line[linepool[k].len].y - PBmouve.y)) )>=linelen.Value)) then
    //флаг и длинна вектора
    begin
      linepool[k].len:=linepool[k].len+1;
      SetLength(linepool[k].line,linepool[k].len+1);
      linepool[k].line[linepool[k].len]:=PBmouve;
      PaintBox.Invalidate;
      z:=0;
		end;

end;

procedure TVector.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
		Shift: TShiftState; X, Y: Integer);
begin
    Flag_ispaint:=False;
    if(linepool[k].len=0)then k:=k-1; //пустая линия
end;

procedure TVector.PaintBoxPaint(Sender: TObject);
var i:Integer;
begin
    PaintBox.Canvas.Brush.Color:=bcgcl;
      PaintBox.Canvas.Pen.Color:=bcgcl;
      PaintBox.Canvas.Rectangle(0,0,PaintBox.Width,paintbox.Height);
   if (k>0)then
    begin
      for i:=0 to k do
      begin
        PaintBox.Canvas.Pen.Color:=linepool[i].Color;
        PaintBox.Canvas.Pen.Width:=linepool[i].Width;
        PaintBox.Canvas.Polyline(linepool[i].line);
      end;
		end;
end;

end.

