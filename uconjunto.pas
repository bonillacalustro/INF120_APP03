unit uconjunto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;
const
  MAX_ELE=256;
type

  { TConjunto }

  TConjunto = class
    private
      elem:array[1..MAX_ELE]of char;
      dim:integer;
    public
      constructor crear();
      procedure setElem(pos:integer;ele:char);
      function getElem(pos:integer):char;
      procedure setDim(dime:integer);
      function getDim():integer;
      function pertenece(ele:char):boolean;
      procedure agregar(ele:char);
      procedure remover(ele:char);
      procedure mostrar();    // CTRL+SHIFT+C
      procedure union(A,B:TConjunto);
      procedure inter(A,B:TConjunto);
  end;

implementation

{ TConjunto }

constructor TConjunto.crear();
var
  i:integer;
begin
  dim:=0;
  for i:=1 to MAX_ELE do
    elem[i]:=Char(0); //NULL
end;

procedure TConjunto.setElem(pos: integer; ele: char);
begin
  if(pos>=1)AND(pos<=dim)then
    elem[pos]:=ele
  else
    writeln('Posicion Fuera de Rango...');
end;

function TConjunto.getElem(pos: integer): char;
begin
  if(pos>=1)AND(pos<=dim)then
    result:=elem[pos]
  else
    result:=char(0); //NULL
end;

procedure TConjunto.setDim(dime: integer);
begin
  if(dime>=0)AND(dime<=MAX_ELE)then
    dim:=dime
  else
    write('Dimension Fuera de Rango...');
end;

function TConjunto.getDim(): integer;
begin
  result:=dim;
end;

function TConjunto.pertenece(ele: char): boolean;
var
  pos:integer;
  sw:boolean;
begin
  sw:=false;
  pos:=1;
  while(pos<=dim)AND(NOT sw)do
  begin
    if(elem[pos]=ele)then
      sw:=true
    else
      pos:=pos+1;
  end;
  result:=sw;
end;

procedure TConjunto.agregar(ele: char);
begin
  if(dim<MAX_ELE)then              //hay espacio ?
  begin
    if(NOT Pertenece(ele))then  //Elemento NO esta en el conjunto
    begin
      dim:=dim+1;
      elem[dim]:=ele;
    end;
  end;
end;

procedure TConjunto.remover(ele: char);
var
  pos,des:integer;
  sw:boolean;
begin
  if(Pertenece(ele))then //si esta en el conjunto
  begin
    sw:=false;                 //BUSCAR SECUENCIAL
    pos:=1;
    while(pos<=dim)AND(NOT sw)do
    begin
      if(elem[pos]=ele)then
        sw:=true
      else
        pos:=pos+1;
    end;
  end;
  for des:=pos to dim-1 do           //ELIMINAR
    elem[des]:=elem[des+1];
  dim:=dim-1
end;

procedure TConjunto.mostrar();
var
  i:integer;
begin
  write('{');
  for i:=1 to dim do
    write(elem[i],',');
  writeln('}');
end;

procedure TConjunto.union(A, B: TConjunto);
var
  pos:integer;
begin
  dim:=0;
  for pos := 1 to A.getDim() do   //Todos los elementos de A
    agregar(A.getElem(pos));
  for pos := 1 to B.getDim() do  //Todos lo elementos de B que NO pertenecen a A
    if(NOT A.pertenece(B.getElem(pos)))then
      agregar(B.getElem(pos));
end;

procedure TConjunto.inter(A, B: TConjunto);
var
  pos:integer;
begin
  dim:=0;
  for pos:=1 to A.getDim() do   //Todos lo elementos de A que pertenecen a B
    if(B.pertenece(A.getElem(pos)))then
      agregar(A.getElem(pos));
end;

end.

