program
var
   x,n : integer ;

function even (n: integer) : boolean ;
begin
   even := 2 * (n / 2) = n
end ;

function power(x,n : integer) : integer ;
var y :  integer ;
begin
  if n = 0 then
     power := 1
  else begin
     y := power (x, n/2) ;
     y := y * y ;
     if (even(n)) then
        power := y
     else
        power := x * y
  end 
end ;

begin
   read(x) ; read(n) ;
   writeln(power(x,n))
end;;