program Main;
uses Types, Procedures;
var
  H:p_elem;
  i:integer;

begin
  Init(H);
  for i:=1 to 10 do
    Add(H,i mod 5, 1);
  Print(H); 
  Search(H,0);
  
  for i:= 1 to 5 do
    Del(H, 2*i-1);
  
  Print(H);
  
  for i:= 1 to 7 do
    Add(H,i, i);
  Print(H);
 
 
end.