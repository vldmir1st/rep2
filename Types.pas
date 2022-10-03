unit Types;
interface

type p_elem = ^elem;
coord = record
  X:integer;
  Y:integer;
end;
elem = record
  coord:coord;
  next:p_elem;
end;

implementation

begin
  
end.
