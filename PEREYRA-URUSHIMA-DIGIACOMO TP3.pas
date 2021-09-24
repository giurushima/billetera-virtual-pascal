program trabajopractico3;

uses crt,dos;

type

unusuario=record
dni:string[8];
contra:string;
nbre:string[30];
mail:string[40];
end;

cuenta=record
codban:integer;
tipotar:char;
saltar: real;
end;

tarj=array [1..5] of cuenta;

unacuentasvirtual=record
dni:string[8];
tar:tarj;
salbill:real;
end;

unmovimiento=record
dni:string[8];
codban:integer;
tiptar:char;
imp:real;
tipmov:char;
day, month, year: word;
codcom:integer;
dnio:string[8];
end;

uncomer=record
codcom:integer;
nbre:string[30];
cuit:string[12];
est:Boolean;
end;

unbanco=record
nbre:string[30];
cod:integer;
end;

usuario=file of unusuario;
cuentasvirtuales=file of unaCuentasVirtual;
movimientos=file of unMovimiento;
bancos=file of unbanco;
comercios=file of uncomer;

var

usu:usuario;
u:unusuario;
//
cuen:cuentasvirtuales;
cv:unacuentasvirtual;
//
mov:movimientos;
m:unmovimiento;
//
com:comercios;
c:uncomer;
//
ban:Bancos;
b:unbanco;
//
ano,mes,dia,sem: word;
codigodebanco:integer;
ccom:integer;
opcion:integer;
g_usu: integer;
err:integer;
t,i:integer;
cont: integer;
//
band:boolean;
log_dni:string[8];
odni:string[8];
contra:string;
//
env:real;
tecla:char;

procedure valida (var v:integer;ini,fin:integer );
begin
repeat
readln(v);
until (v>=ini) and (v<=fin);
end;

{BANCOS}

procedure altabancos;
begin
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(10,3); writeln ('BIENVENIDO A ALTAS DE BANCOS');
  writeln( );
  TextBackGround(0);
  TextColor(15);
  GotoXY(50,20); Write('Digite "0" para volver al menu');
  GotoXY(10,6);write('Ingrese codigo del banco(numero entre 0 y 10000): ');
  valida (b.cod,0,10000);
while b.cod <>0 do
begin
   GotoXY(10,7);Write('Ingrese nombre del nuevo banco: '); readln(b.nbre);
   seek(ban,filesize(ban));
   write(ban,b);
   writeln( );
   writeln( );
   TextBackGround(2);
   TextColor(0);
   GotoXY(30,10);writeln('BANCO REGISTRADO CON EXITO');
   Delay(2000);
   TextBackGround(0);
   TextColor(15);
   clrscr;
   TextBackGround(15);
   TextColor(0);
   gotoxy(10,3); writeln ('BIENVENIDO A ALTAS DE BANCOS');
   writeln( );
   TextBackGround(0);
   TextColor(15);
   GotoXY(50,20); Write('Digite "0" para volver al menu');
   GotoXY(10,6);write('Ingrese codigo del banco(numero entre 0 y 10000): ');
   valida (b.cod,0,10000);
end;
end;

procedure listadobancos;
begin
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(10,2); writeln (' LISTADO DE BANCOS ACTUALES ');
  writeln( );
  TextBackGround(15);
  TextColor(0);
  writeln( );
  reset (ban);
  GotoXY(10,5); writeln (' Codigo del banco ');
  GotoXY(40,5); writeln (' Nombre del banco ');
  TextBackGround(0);
  TextColor(15);
  writeln ('---------------------------------------------------------------------');
while not (eof(ban)) do begin
      read (ban,b) ;
      write ('               ',b.cod);
      write  ('                            ',b.nbre);
      writeln( );
      end;
      GotoXY(70,3); Write('Presione una tecla para salir');
      repeat until keypressed;
end;

procedure bancos_p;
begin
  repeat
      clrscr;
      TextBackGround(15);
      TextColor(0);
      gotoxy(40,2); writeln ('BIENVENIDO A LA OPCION BANCOS');
      gotoxy (40,4); writeln ('MENU DE OPCIONES BANCOS');
      TextBackGround(0);
      TextColor(15);
      gotoxy (40,6); writeln ('1) Alta de bancos');
      gotoxy (40,7); writeln ('2) Listado de todos los bancos');
      gotoxy (40,8); writeln ('0) Fin');
      gotoxy (40,9); write ('Ingrese su Opcion:  ');
      repeat
            readln (opcion)
      until (opcion>= 0)  and (opcion<=4);
      case opcion of
           1: altabancos;
           2: listadobancos;
           0: ;
      end;
until opcion=0;
end;

{BANCOS}

{COMERCIOS}

procedure altacomer;
 begin
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(15,2); writeln ('BIENVENIDO A ALTAS DE COMERCIOS ADHERIDOS');
  writeln( );
  TextBackGround(0);
  TextColor(15);
  Gotoxy(70,3);write('Con codigo de comercio=0, cierra el programa');
  gotoxy(10,5);write('Ingrese codigo del comercio(numero entre 0 y 1000): ');
  valida(c.codcom,0,10000);
  while c.codcom <>0 do
  begin
      gotoxy(10,6);write ('Ingrese nombre del comercio adherido: ');readln(c.nbre);
      gotoxy(10,7);write('Ingrese el cuit de ',c.nbre, ': '); readln(c.cuit);
      seek(ban,filesize(ban));
      write(com,c);
      TextBackGround(2);
      TextColor(15);
      gotoxy(30,10);write('COMERCIO ADHERIDO CON EXITO');
      Delay(2000);
      TextBackGround(0);
      clrscr;
      writeln( );
      writeln( );
      TextBackGround(15);
      TextColor(0);
      gotoxy(15,2); writeln ('BIENVENIDO A ALTAS DE COMERCIOS ADHERIDOS');
      writeln( );
      TextBackGround(0);
      TextColor(15);
      Gotoxy(70,3);write('Digite "0" para volver al menu');
      gotoxy(10,5);write('Ingrese codigo del comercio(numero entre 0 y 1000): ');
      valida(c.codcom,0,10000);
  end;
end;

procedure listadocomer;
begin
  cont:=cont+1;
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(30,2); writeln (' LISTADO DE COMERCIOS ');
  writeln( );
  TextBackGround(0);
  TextColor(15);
  GotoXY(70,3); Write('Presione una tecla para salir');
  seek(com,0);;
  GotoXY(2,5);writeln ('Codigo');
  GotoXY(20,5);writeln ('Nombre');
  GotoXY(40,5);writeln ('Codigo');
  GotoXY(2,6);writeln ('---------------------------------------------');
  while not (eof(com)) do begin
      cont:=cont+1;
      read (com,c) ;
      GotoXY(4,5+cont);writeln (c.codcom);
      GotoXY(17,5+cont);writeln (c.nbre);
      GotoXY(40,5+cont);writeln (c.cuit);
      writeln( );end;  repeat until keypressed;
end;

function busadorcomercios(a: integer):boolean;
begin
seek(com,0);
while(not eof(com))and(c.codcom<>a)  do
begin
read(com,c);
end;
if(c.codcom=a)
then
begin
busadorcomercios:=true;
end
else
begin
busadorcomercios:=false;
end;
end;


procedure modificacomer;
var cod_modwf:integer;
op_modwf:integer;
begin
repeat
clrscr;
TextBackGround(15);
TextColor(0);
GotoXY(5,2); write('BIENVENIDO A MODIFICADOR DE COMERCIOS ADHERIDOS');
TextBackGround(0);
TextColor(15);
gotoxy(10,5);write('Ingrese codigo del comercio a modificar: '); read(cod_modwf);
if (busadorcomercios(cod_modwf))
then
begin
c.codcom:=cod_modwf;
seek(com,filepos(com)-1);
gotoxy(10,6);write('Ingrese nuevo nombre: ');  readln; read(c.nbre);readln;
gotoxy(10,7);write('Ingrese nuevo cuit: '); read(c.cuit);readln;
write(com,c);
textBackGround(2);
textColor(15);
gotoxy(15,12);write(' MODIFICACION EXITOSA ');
delay(2000);
textBackGround(0);
textColor(15);
gotoxy(10,12);write('         ');
end
else
begin
clrscr;
write('Comercio no adherido');
readln();
end;
clrscr;
gotoxy(10,10);write('Desea modificar otro comercio?: ');
gotoxy(10,11);write('1) Si');
gotoxy(10,12);write('2) No');
gotoxy(42,10);read(op_modwf);
gotoxy(10,10);write(''                                 );
gotoxy(10,7);write('                             ');
gotoxy(10,9);write('                                              ');
gotoxy(10,10);write('                                             ');
gotoxy(10,11);write('    ');

gotoxy(10,8);write('                    ');
gotoxy(10,9);write('                                                ');
until(op_modwf=2);
end;

procedure baja_logica;
var
codigo,cont, band:integer;
rta: char;
begin
clrscr;
textcolor(0);
textbackground(15);
gotoxy(30,2); writeln ('BAJA LOGICA DE COMERCIOS ADHERIDOS');
textcolor(15);
textbackground(0);
GotoXY(70,3); Write('Digite "0" para volver al menu');
writeln( );
gotoxy(10,4);write('Ingrese codigo del comercio a dar de baja:  ');
valida(codigo,0,10000);
while (codigo<>0)do
begin
reset (com);
cont:=0;
band := 0;
while (not eof(com))and (band = 0) do
begin
read (com,c);
cont:=filepos(com);
if c.codcom=codigo then
begin
writeln ( );
gotoxy(15,6);writeln('Codigo del comercio: ', c.codcom);
gotoxy(15,7);writeln('Nombre del comercio: ', c.nbre);
gotoxy(15,8);writeln('Cuit del comercio:  ',c.cuit);
gotoxy(15,9);write('Seguro desea dar de baja este comercio?(S/N): ');
repeat
read(rta)
until (rta='S')or  (rta='N') or (rta='s')or (rta='n');
if  (rta='S')or (rta='s') then
begin

c.codcom :=0 ;
c.nbre:='***';
c.cuit:='***';
seek(com,cont-1);
write(com,c);
band:= 1
end;
end;

end;
clrscr;
textcolor(0);
textbackground(15);
gotoxy(40,2); writeln ('BAJA LOGICA DE COMERCIOS ADHERIDOS');
textcolor(15);
textbackground(0);
GotoXY(70,3); Write('Digite "0" para volver al menu');
writeln( );
gotoxy(10,4);write('Ingrese codigo del comercio a dar de baja:  ');
valida(codigo,0,10000);
end;
end;

procedure comercios123;
Begin
repeat
textcolor(15);
textbackground(0);
clrscr;
textcolor(0);
textbackground(15);
gotoxy(40,2); writeln (' BIENVENIDO A ABM DE COMERCIOS ADHERIDOS ');
gotoxy (40,4); writeln (' MENU DE OPCIONES ');
textcolor(15);
textbackground(0);
gotoxy (40,6); writeln ('1) Alta de comercios');
gotoxy (40,7); writeln ('2) Modifica comercios');
gotoxy (40,8); writeln ('3) Listado de los comercios adheridos');
gotoxy (40,9); writeln ('4) Baja de comercios');
gotoxy (40,10); writeln ('0) Fin');
gotoxy (40,11); write ('Ingrese su Opcion:  ');
repeat
readln (opcion)
until (opcion>= 0)  and (opcion<=5);
case opcion of
1: altacomer;
2: modificacomer;
3: listadocomer;
4: baja_logica;
0: ;
end;
until opcion=0;
end;

{COMERCIOS}

{USUARIOS}

function busadordnicuentas(v:string[8]):boolean;
begin
seek(cuen,0);
while(not eof(cuen))and(cv.dni<>v)  do
begin
read(cuen,cv);
end;
if(cv.dni=v)
then
begin
busadordnicuentas:=true;
end
else
begin
busadordnicuentas:=false;
end;
end;

function buscadordniusuarios(k:string[8]):boolean;
begin
seek(usu,0);
while(not eof(usu))and(u.dni<>k) do
begin
read(usu,u);
end;
if(u.dni=k)
then
begin
Buscadordniusuarios:=true;
end
else
begin
Buscadordniusuarios:=false;
end;
end;

procedure altasdeusuarios;
begin
seek(usu,filesize(usu));
textcolor(0);
textbackground(15);
GOTOXY(5,2);write(' REGISTRO DE USUARIOS ');
textcolor(15);
textbackground(0);
GOTOXY(10,4);write('Ingrese su nombre y apellido: '); readln; read(u.nbre);
Gotoxy(10,5);write('Ingrese Mail: '); readln; read(u.mail);
u.dni:=log_dni;
u.contra:=contra;
Write(usu,u);
textcolor(15);
textbackground(2);
GOTOXY(30,8);write('Usuario registrado con exito');
DELAY(1000);
textcolor(15);
textbackground(0);
GotoXY(45,10); Write('Presione una tecla para continuar');
repeat until keypressed;
seek(usu,0);
end;

procedure listadousuarios;
begin
clrscr;
seek(usu,0);
if(not eof(usu))
then
begin
for i:= 1 to filesize(usu) do
begin
read(usu,u);
textcolor(0);
textbackground(15);
gotoxy(10,1); write(' USUARIOS REGISTRADOS ');
textcolor(15);
textbackground(0);
GOTOXY(10,3); Write('DNI');
GOTOXY(40,3); Write('Nombre y apellido');
GOTOXY(80,3); Write('Mail');
GOTOXY(20,4); Write('----------------------------------------------------------------------------------');
gotoxy(10,6+i);write(u.dni);
gotoxy(40,6+i);write(u.NBRE);
gotoxy(80,6+i);write(u.mail);
end;
repeat until keypressed;
end
else
begin
gotoxy(70,4); write('No hay usuarios registrados al momento');
end;
end;

{INICIO DE SESION}

procedure verclave;
begin
if (u.contra=contra)
then
begin
textcolor(15);
textbackground(2);
gotoxy(20,10);write('Clave correcta');
textcolor(15);
textbackground(0);
end
else
begin
textcolor(15);
textbackground(4);
gotoxy(20,10);write('Clave incorrecta');
err:=err+1;
textcolor(15);
textbackground(0);
end;
end;

procedure Contrasena;
begin
i:=1; t:=0;
repeat
gotoxy(10,7);write('Ingrese Clave : ');
gotoxy(26,7);
if(t=1)and(i=9)
Then
Begin
clrscr;
gotoxy(10,7);write('Ingrese Clave : ********');
gotoxy(33,7);
end;
tecla := readkey;
if tecla in[#48..#57,#65..#90,#97..#122,#164,#165,#32]
then
begin
contra[i] := upcase(tecla);
contra[0] := chr(i);
gotoxy(25 + i,7);write('*');
i := i + 1;
end;
if tecla = #08 then
begin
i := i - 1;
if i < 1 then
i := 1;
contra[i] := ' ';
contra[0] := chr(i);
gotoxy(25 + i,7);write(' ');
end;
until (tecla = #13);
clrscr;
end;

procedure iniciodesecion;
begin
ClrScr;
textcolor(0);
textbackground(15);
GotoXY(5,2); write(' BIENVENIDO A INICIO DE SESION ');
textcolor(15);
textbackground(0);
gotoxy(10,5); write('Ingrese DNI: '); read(log_dni);
if (Buscadordniusuarios(log_dni))
then
begin
band:=true;
Repeat
contrasena;
verclave;
delay(1000);
if(err=3)
then
begin
ClrScr;
gotoxy(10,10); write(' 3 INTENTOS REALIZADOS ');
delay(1000);
band:=false;
end;
until(contra=u.contra)or(err=3);
end
else begin
band:=false;
gotoxy(10,10); write('                   ');
clrScr;
textcolor(15);
textbackground(0);
GotoXY(10,10); Write(' Usted no esta registrado ');
delay(2000);
clrScr;
contrasena;
altasdeusuarios;
gotoxy(20,10);write('Registracion completada');
Listadousuarios;
end
end;

{INICIO DE SESION}

{CUENTAS}

procedure listadocuenta;
   begin
   seek(cuen,filepos(cuen)-1);
   if(not eof(cuen))
   then
     begin
     for i:= 1 to filesize(cuen) do
     begin
        ClrScr;
        read(cuen,cv);
        textcolor(0);
        textbackground(15);
        gotoxy(10,2); write(' CUENTAS REGISTRADAS ');
        textcolor(15);
        textbackground(0);
        GOTOXY(12,4); Write('DNI');
        GOTOXY(25,4); Write('Saldo billetera');
        GOTOXY(10,5); Write('--------------------------------');
        gotoxy(10,6);write(CV.dni);
        gotoxy(30,6);write('$',cv.salbill:2:2);
        textcolor(0);
        textbackground(15);
        gotoxy(10,8); WRITE('TARJETAS VINCULADAS');
        textcolor(15);
        textbackground(0);
        GOTOXY(12,10); Write('Codigo de banco');
        GOTOXY(32,10); Write('Tipo de tarjeta');
        GOTOXY(52,10); Write('Saldo de la tarjeta');
        GOTOXY(10,11); Write('---------------------------------------------------------------');
        for i:=1 to 5 do
        begin
         gotoxy(19,11+I);write(cv.tar[i].codban);
         gotoxy(39,11+I);WRITE(CV.tar[i].tipotar);
         gotoxy(59,11+I);WRITE('$',cv.tar[i].saltar:2:2);
         end;

repeat until keypressed;

     end;
      end
     else
      begin
       textcolor(0);
       textbackground(15);
       gotoxy(70,4); write(' Usted no posee una cuenta');
       textcolor(15);
       textbackground(0);
       readkey;
       end;
end;


 
procedure altadecuentas;
    var
     opaltac:char;
    begin
     clrScr;
     textcolor(0);
     textbackground(15);
     GotoXY(5,2);Write(' ALTAS DE CUENTAS ');
     textcolor(15);
     textbackground(0);
     gotoxy(5,4);write(' Desea registrar tarjetas a su cuenta?(s/n): ');readln; read(opaltac);
     ClrScr;
    if(opaltac='s')
     then
      begin
       textcolor(0);
       textbackground(15);
       GotoXY(5,2);Write(' ALTAS DE CUENTAS ');
       textcolor(15);
       textbackground(0);
       seek(cuen,FileSize(cuen));
       cv.dni:=log_dni;
       for i:= 1 to 5 do
       begin
        ClrScr;
        textcolor(0);
        textbackground(15);
        GotoXY(5,2);Write(' TARJETA NUMERO: ',I);
        textcolor(15);
        textbackground(0);
        gotoxy(8,4);write('Ingrese codigo de banco: '); readln; read(cv.tar[i].codban);
        repeat
         gotoxy(8,5);write('Ingrese tipo de tarjeta: '); readln; read(cv.tar[i].tipotar);
        until(cv.tar[i].tipotar='d')or(cv.tar[i].tipotar='c');
        gotoxy(8,6);write('Ingrese saldo de la tarjeta: $'); readln; read(cv.tar[i].saltar);
       end;
       clrScr;
       gotoxy(8,4);write('Ingrese saldo de billetera: $'); readln; read(cv.salbill);
       clrScr;
       write(cuen,cv);
       seek(cuen,0);
      end;
     end;

procedure cuentas;
begin
ClrScr;
log_dni:=u.dni;
if (busadordnicuentas(log_dni))
then begin listadocuenta; end
else begin altadecuentas; end;

end;

{CUENTAS}

{MOVIMIENTOS}

procedure registromovimientos;                                                                                                                                     //Trabajando en esto//
    begin
    seek(mov,FileSize(mov));
    m.Dni:=log_dni;
    m.Imp:=env;
    m.tipmov:='E';
    write(mov,m);
    seek(mov,0);
   end;

procedure movcom;
   begin
    seek(mov,FileSize(mov));
    m.Dni:=log_dni;
    gotoxy(10,5);write('Ingrese importe: $');read(m.Imp);
    repeat
     gotoxy(10,6);write('Tipo de tarjeta: '); read(m.tiptar);
     until(m.tiptar='d')or(m.tiptar='c')or(m.tiptar='D')or(m.tiptar='C');
     repeat
     gotoxy(10,7);write('codigo de banco: '); readln;read(m.codban);
     codigodebanco:=m.codban;
     if(m.codban<0) then begin ClrScr; gotoxy(10,12);write('Codigo de banco incorrecto'); delay(2000);  end;
     until(m.codban>=0);

     repeat

      gotoxy(10,7);
      write('Ingrese numero de cuenta de sus tarjetas a debitar:  '); readln;read(i);
      if(cv.tar[i].saltar<m.Imp)then begin ClrScr; gotoxy(10,12);write('Saldo insuficiente'); delay(2000);end;
      until(i>=0)and(i<=6)and(cv.tar[i].saltar>=m.Imp);
      ClrScr;
      busadordnicuentas(log_dni);

      cv.tar[i].saltar:=cv.tar[i].saltar-m.Imp;
      write(cuen,cv);
      m.tipmov:='C';
      GetDate(ano,mes,dia,sem);
      m.day:=dia;
      m.month:=mes;
      m.year:=ano;
      m.dnio:='--';
      m.codcom:=ccom;
      write(mov,m);
      seek(mov,0);
     end;

procedure envios;
begin
   ClrScr;
   textcolor(0);
   textbackground(15);
   GotoXY(5,2);Write('BIENVENIDO A ENVIOS');
   textcolor(15);
   textbackground(0);
   gotoxy(8,4); write('DNI del destinatario: '); readln; read(odni);
   gotoxy(8,6); write('Ingrese el monto que desea enviar: $'); read(env);
   if (busadordnicuentas(odni))and(Buscadordniusuarios(odni))and(odni<>log_dni)
    then
     begin
      busadordnicuentas(log_dni);
      if(cv.salbill>=env)then begin
      registromovimientos;
      busadordnicuentas(log_dni);
      cv.salbill:=cv.salbill-env;
      write(cuen,cv);
      busadordnicuentas(odni);
      seek(cuen,filepos(cuen)-1);
      cv.salbill:=cv.salbill+env;
      write(cuen,cv);
      seek(cuen,0);
      ClrScr; gotoxy(10,9);
      ClrScr;
      textcolor(15);
      textbackground(2);
      GotoXY(30,10); Write(' OPERACION REALIZADA CON EXITO ');  delay(2000);
      textcolor(15);
      textbackground(0);
     end
    else
     Begin
      textcolor(15);
      textbackground(4);
      ClrScr; gotoxy(30,10); write(' Saldo insuficiente ');delay(2000); end;
      textcolor(15);
      textbackground(0);
     end
   else
    begin
     ClrScr;
     textcolor(15);
     textbackground(4);
     gotoxy(10,10); write(' DNI no registrado en billetera virtual '); delay(2000); end;
     textcolor(15);
     textbackground(0);
   ClrScr;
  end;

function buscacom(d:integer):boolean;
var imax,imin,imedio:integer;

begin
seek(com,0);
while not eof(com) do
read(com,c);
imin:=0;imax:=filesize(com)-1;imedio:=(imin+imax) div 2;
seek(com,imedio);read(com,c);
while (d<>c.codcom) and (imin<=imax) do
begin if d<c.codcom then imax:=imedio-1
else imin:=imedio+1;
imedio:=(imin+imax) div 2;
seek(com,imedio);read(com,c);
end;
if(c.codcom=d)
then begin
buscacom:=true;
end
else
begin
buscacom:=true;
end;
end;

function buscabanco(f:integer):boolean;

begin
seek(ban,0);
while(not eof(ban))and(b.cod<>f)  do
begin
read(ban,b);
end;
if(b.cod=f)
then
begin
buscabanco:=true;
end
else
begin
buscabanco:=false;
end;
end;

procedure muestracuenta;
var i,t:integer;
begin
seek(cuen,filepos(cuen));
if(not eof(cuen)) then
begin
for i:= 1 to FileSize(cuen) do
begin
read(cuen,cv);
gotoxy(10,3); write('Su cuenta registrada es ');
gotoxy(34,3);write('Dni: ',cv.dni);
gotoxy(55,25);write('Saldo de su billetera: ',cv.salbill:2:2);

for t:=1 to 5 do
begin
gotoxy(40,5+t*2);write('Codigo de banco: ', cv.tar[t].codban);
gotoxy(70,5+t*2);write('Tipo de tarjeta: ',cv.tar[t].tipotar);
gotoxy(100,5+t*2);write('Saldo: ',cv.tar[t].saltar:2:2);

end;
end;
end
  
else
begin
gotoxy(70,4); write('No tiene cuentas registradas');
readkey;
end;
end;

procedure compras;

begin
clrscr;
textcolor(0);
textbackground(15);
GotoXY(5,2);Write(' BIENVENIDO A COMPRAS ');
textcolor(15);
textbackground(0);
repeat
clrscr;
textcolor(0);
textbackground(15);
GotoXY(5,2);Write(' BIENVENIDO A COMPRAS ');
textcolor(15);
textbackground(0);
ClrScr; gotoxy(10,5);write('Ingrese codigo de comercio: ');readln(ccom);ClrScr;
until(ccom>=0);
if(buscacom(ccom))
then
begin
textcolor(0);
textbackground(15);
GotoXY(5,5);Write(' Datos del comercio ');
textcolor(15);
textbackground(0);
gotoxy(10,7); write('Negocio: ',c.nbre);
gotoxy(10,8); write('Codigo: ',c.codcom);
gotoxy(10,9); write('Cuit: ',c.cuit);
gotoXY(15,12); write('Para continuar presione una tecla');
repeat until keypressed;
     clrscr;
     muestracuenta;
     Delay(3000);
     ClrScr;
     textcolor(0);
     textbackground(15);
     GotoXY(5,2);Write(' Bienvenido a compras ');
     textcolor(15);
     textbackground(0);
     GotoXY(10,4); write('Ingrese codigo de banco de la tarjeta: ');readln(codigodebanco);
     if (buscabanco(codigodebanco))
      then
       begin
        movcom;
        ClrScr;
        ClrScr;
        textcolor(0);
        textbackground(15);
        gotoxy(15,4); write(' FACTURA ');
        textcolor(15);
        textbackground(0);
        gotoxy(10,6); write('Banco: ',codigodebanco);
        GotoXY(10,7); write('Comercio: ',c.nbre);
        GotoXY(10,8); write('Fecha de compra: ',dia,'/',mes,'/',ano );
        GotoXY(10,9); write('Monto: $',m.imp:2:2);
        GotoXY(30,12); write('Presione una tecla para continuar');
        Repeat until keypressed;
        ClrScr;
       end
      else
       begin
        Write('Banco no registrado');
       end;
    end
   else
    begin
     Write('Comercio no adherido');
    end;
end;

procedure movi;
begin
clrscr;
textcolor(0);
textbackground(15);
gotoxy(10,2); write (' Listado de movimientos ');
textcolor(15);
textbackground(0);
GotoXY(12,5);write ('DNI');
GotoXY(25,5);write ('Codigo de banco');
GotoXY(50,5);write ('Tipo de tarjeta');
GotoXY(80,5);write ('Importe');
GotoXY(100,5);write ('Tipo de movimiento');
GotoXY(120,5);write ('Codigo de comercio');
writeln( );
reset (MOV);
CONT:=0;
while not (eof(mov)) do
begin
cont:=cont+1;
read (MOV,M) ;
GotoXY(8,8+cont);write (M.DNI);
GotoXY(29,8+cont);write (M.codban);
GotoXY(54,8+cont);write (M.tiptar);
GotoXY(82,8+cont);write (M.imp:2:2);
GotoXY(104,8+cont);write (M.tipmov);
GotoXY(134,8+cont);write (M.codcom);
writeln( );end;  repeat until keypressed;
end;

procedure usuarios_pr;
begin
clrscr;
iniciodesecion;
clrScr;
while (band=true) do
begin
repeat
        ClrScr;
        textcolor(0);
        textbackground(15);
        GotoXY(15,2);Write(' BIENVENIDO A BILLETERA VIRTUAL ');
        textcolor(15);
        Textbackground(0);
        textcolor(0);
        textbackground(15);
        GotoXY(5,4);Write(' MENU DE OPCIONES ');
        textcolor(15);
        Textbackground(0);
        gotoxy(40,6);write ('1) Cuentas');
        gotoxy(40,8);write ('2) Envios');
        gotoxy(40,10);write('3) Compras');
        gotoxy(40,12);write('4) Movimientos');
        gotoxy(40,14);write('5) Listado de usuario');
        Repeat
         gotoxy(40,18);write('Ingrese una opcion: '); readln;
         read;
         GotoXY(30,18); read(g_usu);
        until(g_usu<=5)or(g_usu>=1);
        case g_usu of
         1:begin cuentas;  end;
         2:begin envios;  end;
         3:begin compras; end;
         4:begin movi; end;
         5:Begin listadousuarios; end;
         6:;
        end;
    until(g_usu=6);
   end;
   readkey;
  end;

procedure direct;
begin

case opcion of
1: bancos_p;
2: comercios123;
3: usuarios_pr;
4:;
end;
ClrScr;
end;

procedure assignabre1;
begin
Assign(com,'C:\Users\gabi\Desktop\pascal\comercios.dat');
Assign(ban,'C:\Users\gabi\Desktop\pascal\bancos.dat');
Assign(cuen,'C:\Users\gabi\Desktop\pascal\cuentasvirtuales.dat');
Assign(usu,'C:\Users\gabi\Desktop\pascal\usuarios.dat');
Assign(mov,'C:\Users\gabi\Desktop\pascal\movimientos.dat');

{I-}
reset(com); if(IOResult=2)then begin rewrite(com);end;
reset(ban); if(IOResult=2)then begin Rewrite(ban); end;
reset(mov);  if(IOResult=2)then begin rewrite(mov)end;
reset(cuen);  if(IOResult=2)then begin rewrite(cuen)end;
reset(usu);  if(IOResult=2)then begin rewrite(usu)end;
{I+}

end;

procedure cerrado1;
begin
close(mov);
close(cuen);
close(usu);
Close(ban);
Close(com);

end;

procedure programaprincipal;
 begin
 opcion:=0;
   ClrScr;
   textcolor(15);
   textbackground(3);
   GotoXY(40,10);Write('BIENVENIDO A BILLETERA VIRTUAL');
   textcolor(15);
   textbackground(0);
   GotoXY(40,15);Write(' Presione ENTER para ingresar');
   Repeat until keypressed;
    ClrsCr;
    Repeat
    textcolor(15);
    textbackground(3);
    GotoXY(40,10);Write(' MENU PRINCIPAL - BILLETERA VIRTUAL ');
    textcolor(15);
    textbackground(0);
    gotoxy(40,13); write(' 1) Bancos');
    gotoxy(40,14); write(' 2) ABM de Comercios Adheridos');
    gotoxy(40,15); write(' 3) Usuarios');
    gotoxy(40,16); write(' 4) Salir');
    gotoxy(40,20); write(' Elija su opcion: ');  gotoxy(58,20);readln(opcion);
   direct;
   until(opcion=4);
end;

begin

assignabre1;
programaprincipal;
cerrado1;

end.

