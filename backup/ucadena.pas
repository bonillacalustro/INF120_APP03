unit ucadena;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uconjunto, Dialogs, LazUTF8;
const
  MAX_ELEM=5000;
type

  { TCadena }

  TCadena = class
    private
      elem: array[1..MAX_ELEM]of char;
      dim:integer;
      May,Min,Dig,Sep:TConjunto;
    public
      constructor crear();
      procedure setDim(dime:integer);
      function getDim():integer;
      procedure setChar(pos:integer;ele:char);
      function getChar(pos:integer):char;
      procedure addChar(ele:char);
      procedure insChar(pos:integer;ele:char);
      procedure elimChar(pos:integer);
      function cantPal():integer;
      procedure leerPal(var pos:integer;var pal:string);
      function busqPal(palB:string):integer;
      procedure addPal(pal:string);
      procedure insPal(pos:integer;pal:string);
      procedure elimPal(pal:string);
      procedure cambPal(pal0,palR:string);
      procedure invCad();
      procedure rotarCad();
      procedure toMayus();
      procedure toMinus();
      procedure TituloCad();
  end;

implementation

{ TCadena }

constructor TCadena.crear();
var
  pos:integer;
begin
  dim:=0;
  for pos:=1 to MAX_ELEM do
    elem[pos]:=char(0); //NULL

  May:=TConjunto.crear();
  for pos:=0 to 25 do
    May.agregar(char(65+pos));

  Min:=TConjunto.crear();
  for pos:=0 to 25 do
    Min.agregar(char(97+pos));

  Dig:=TConjunto.crear();
  for pos:=0 to 9 do
    Dig.agregar(char(48+pos));

  //Sep={'-','_',',','.',':',';','#',' '}
  Sep:=TConjunto.crear();
  Sep.agregar('-');
  Sep.agregar('_');
  Sep.agregar(',');
  Sep.agregar('.');
  Sep.agregar(':');
  Sep.agregar(';');
  Sep.agregar('#');
  Sep.agregar(' ');
end;

procedure TCadena.setDim(dime: integer);
begin
  if(dime>=0)AND(dime<=MAX_ELEM)then
    dim:=dime
  else
    showMessage('Dimension Fuera de Rango...');
end;

function TCadena.getDim(): integer;
begin
  result:=dim
end;

procedure TCadena.setChar(pos: integer; ele: char);
begin
  if(pos>=1)AND(pos<=dim)then
    elem[pos]:=ele
  else
    showMessage('Dimension fuera de Rango...');
end;

function TCadena.getChar(pos: integer): char;
begin
  if(dim<MAX_ELEM)then
    result:=elem[pos]
  else
    result := char(0); //NULL
end;

procedure TCadena.addChar(ele: char);
begin
  if(dim<MAX_ELEM)then
    begin
      dim:=dim+1;
      elem[dim]:=ele;
    end;
end;

procedure TCadena.insChar(pos: integer; ele: char);
var
  des:integer;
begin
  if(pos>=1)AND(pos<=dim+1)and(dim<=MAX_ELEM)then
  begin
    for des:=dim downto pos do
      elem[des+1]:=elem[des];
    elem[pos]:=ele;
    dim:=dim+1;
  end
  else
    showMessage('Posicion Fuera de Rango...');
end;

procedure TCadena.elimChar(pos: integer);
var
  des:integer;
begin
  if(pos>=1)AND(pos<=dim)then
  begin
    for des:=pos to dim-1 do
      elem[des]:=elem[des+1];
    dim:=dim-1;
  end
  else
    showMessage('Posicion fuera de Rango...');
end;

function TCadena.cantPal(): integer;
var
  cp,pos:integer;
  pal:string;
begin
  cp:=0;
  pos:=1;
  while(pos<=dim)do
  begin
    leerPal(pos,pal);
    if(pal<>'')then
      cp:=cp+1;
  end;
  result:=cp;
end;

procedure TCadena.leerPal(var pos: integer; var pal: string);
begin
  pal:='';
  while(pos<=dim)AND(NOT Sep.Pertenece(elem[pos]))do
  begin
    pal:=pal+elem[pos];
    pos:=pos+1;
  end;
  while(pos<=dim)AND(Sep.pertenece(elem[pos]))do
    pos:=pos+1;
end;

function TCadena.busqPal(palB: string): integer;
var
  pos,posant:integer;
  sw:boolean;
  pal:string;
begin
  sw  := false;
  pos := 1;
  while(pos<=dim)AND(NOT sw)do
  begin
    posant:=pos;
    leerPal(pos,Pal);
    if(Pal=palB)then  //'Hola'='Hola' =>TRUE
      sw:=true        //'HOLA'='Hola' =>FALSE
  end;
  if(sw)then
    result:=posant
  else
    result:=-1
end;

procedure TCadena.addPal(pal: string);
var
  n,des:integer;
begin
  n:=length(pal);
  if(dim+n+1<MAX_ELEM)then //hay espacin para la palabra
  begin
    if(dim>0)then
      addChar(' ');
    for des:=1 to n do
      addChar(pal[des]);
  end
  else
    showMessage('Almacenamiento Lleno...');
end;

procedure TCadena.insPal(pos: integer; pal: string);
var
  n,des:integer;
begin
  n:=length(pal);
  if(dim+n+2<=MAX_ELEM)then
  begin
    insChar(pos,' ');
    for des:=1 to n do
      insChar(pos+des,pal[des]);
    insChar(pos+n+1,' ');
  end
  else
    showMessage('No hay espacio de Almacenamiento...');
end;

procedure TCadena.elimPal(pal: string);
var
  pos,n,des:integer;
begin
  pos:=busqPal(pal);
  if(pos<>-1)then
  begin
    n:=length(pal);
    for des:=1 to n do  //pal='Juan'
      elimChar(pos);    //espacio ANTES
    if(pos<=dim)and(elem[pos]='')then
      elimChar(pos) //espacio Despues
    else
      if(pos>1)and(elem[pos-1]='')then
        elimChar(pos-1);
  end
  else
    showMessage('La Palabra no Existe...');
end;

procedure TCadena.cambPal(pal0, palR: string);
var
  pos:integer;
begin
  pos:=busqPal(pal0);
  if(pos<>-1)then // si la encontramos
  begin
    elimPal(Pal0);
    insPal(pos-1,PalR);
  end
  else
    showMessage('La palabra no Existe...');
end;

procedure TCadena.invCad();
var
  izq,der:integer;
  aux:char;
begin
  if(dim<MAX_ELEM)then
  begin
    izq:=1; der:=dim;
    while(izq<der)do
    begin
      aux:=elem[izq];
      elem[izq]:=elem[der];
      elem[der]:=aux;
      izq:=izq+1; der:=der-1;
    end;
  end
  else
    showmessage('TCadena::invertir: Posicion Fuera de Rango');
end;

procedure TCadena.rotarCad();
var
  aux:char;pos:integer;
begin
  if(dim>1)then
  begin
    pos:=dim;
    aux:=elem[dim];
    while(pos>1)do
    begin
      elem[pos]:=elem[pos-1];
      pos:=pos-1;
    end;
    elem[1]:=aux;
  end;
end;

procedure TCadena.toMayus();
var
  i:integer;
begin
  for i:=1 to dim do
  begin
    elem[i]:=UpCase(elem[i]);
  end;
end;

procedure TCadena.toMinus();
var
  i:integer;
begin
  for i:=1 to dim do
  begin
    elem[i]:=lowerCase(elem[i]);
  end;
end;

procedure TCadena.TituloCad();
var
  i:integer;
begin
  for i:=1 to dim do
  begin
    if(dim>=1)and(not sep.pertenece(elem[1]))then
    elem[1]:=upcase(elem[1]);
    for i:=1 to dim-1 do
    begin
      // Si la posición actual es un separador y la siguiente NO lo es:
      if sep.pertenece(elem[i]) and (not sep.pertenece(elem[i + 1])) then
      begin
        elem[i+1]:=upcase(elem[i+1]);
      end;
    end;
  end;
end;

end.

