unit Procedures;
interface
uses Types;

procedure Init(var Head:p_elem);
function Length(Head:p_elem):integer;
procedure Print(Head:p_elem);
procedure Clear(var Head:p_elem);
procedure Add(var Head:p_elem; x,y:integer);
procedure Del(var Head:p_elem; x:integer);
procedure Search(Head:p_elem; x:integer);

implementation

procedure Init(var Head:p_elem);
begin
  Head:= nil;
end;

function Length(Head:p_elem):integer;
var
 k:integer;
 cur:p_elem;
begin
  if Head = nil then k:= 0
  else begin
    k:= 1;
    cur:= Head^.next;
    while cur <> Head do begin
      inc(k);
      cur:= cur^.next;
    end;
  end;
  Length:= k;
end;

procedure Print(Head:p_elem);
var
  cur:p_elem;
begin
  if Head <> nil then begin
    cur:= Head;
    write('(', cur^.coord.X, ';', cur^.coord.Y, ') ');
    if cur^.next <> Head then begin
      cur:= cur^.next;
      while cur <> Head do begin
        write('(', cur^.coord.X, ';', cur^.coord.Y, ') ');
        cur:= cur^.next;
      end;
    end;
  end;
  writeln;
end;

procedure Clear(var Head:p_elem);
var
  cur, cur_del:p_elem;
begin
  if Head <> nil then begin
    cur:= Head^.next;
    while cur <> Head do begin
      cur_del:= cur;
      cur:= cur^.next;
      dispose(cur_del);
    end;
    cur:= nil;
    dispose(Head);
    Head:= nil;
  end;
end;

procedure Add(var Head:p_elem; x,y:integer);
var
  cur, cur_new:p_elem;
begin
  new(cur_new);
  cur_new^.coord.X:= x;
  cur_new^.coord.Y:= y;
  if Head = nil then begin      //Список пустой
    Head:= cur_new;
    cur_new^.next:= Head;
  end
  else
    if x >= Head^.coord.X then begin    //Перед первым
      cur_new^.next:= Head;
      Head:= cur_new;
      cur:= cur_new^.next;
      while cur^.next <> cur_new^.next do
        cur:= cur^.next;
      cur^.next:= Head;
    end
    else
      if x >= Head^.next^.coord.X then begin    //Между первым и вторым
        cur_new^.next:= Head^.next;
        Head^.next:= cur_new;
      end
      else begin                               //В остальных случаях
        cur:= Head^.next;
        while (cur^.next <> Head) and (cur^.next^.coord.X >= x) do
          cur:= cur^.next;
        if cur^.next = Head then begin
          cur_new^.next:= Head;
          cur^.next:= cur_new;
        end
        else begin
          cur_new^.next:= cur^.next;
          cur^.next:= cur_new;
        end;
      end;
end;

procedure Del(var Head:p_elem; x:integer);  //Удаление всех с заданным значением
var
  cur, cur_d:p_elem;
begin
  if Head <> nil then begin
    while (Head^.coord.X = x) and (Head^.next <> Head) do begin    //Если нужное значение идёт в самом начале (может повторяться)
      cur_d:= Head;
      cur:= Head^.next;
      while cur^.next <> Head do
        cur:= cur^.next;
      cur^.next:= Head^.next;
      Head:= Head^.next;
      dispose(cur_d);
    end;
    if (Head^.coord.X = x) and (Head^.next = Head) then begin
      cur:= nil;
      dispose(Head);
    end
    else begin                      //В остальных случаях
      cur:= Head;
      while (cur^.next^.coord.X >= x) and (cur^.next <> Head) do begin
        if cur^.next^.coord.X = x then begin
          cur_d:= cur^.next;
          cur^.next:= cur_d^.next;
          dispose(cur_d);
        end
        else
          cur:= cur^.next;
      end;
    end;
  end;
end;

procedure Search(Head:p_elem; x:integer);
var
  cur:p_elem;
  flag:boolean;
begin
  if Head <> nil then begin
    if Head^.coord.X = x then begin
      writeln('(', Head^.coord.X, ';', Head^.coord.Y, ')');
    end
    else begin
      cur:= Head^.next; flag:= True;
      while (cur^.coord.X >= x) and flag and (cur <> Head) do begin
        if cur^.coord.X = x then begin
          writeln('(', cur^.coord.X, ';', cur^.coord.Y, ')');
          flag:= False;
        end;
        cur:= cur^.next;
      end;
      if flag then
        writeln(MAXINT);
    end;
  end
  else
    writeln(MAXINT);
end;

begin
  
end.