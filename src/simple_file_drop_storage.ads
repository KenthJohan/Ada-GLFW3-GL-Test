with Ada.Containers.Synchronized_Queue_Interfaces;
with Ada.Containers.Unbounded_Priority_Queues;
with Ada.Strings.Unbounded;



package Simple_File_Drop_Storage is

   type Simple_File_Queue is limited private;
   type Simple_File is private;

   procedure Enqueue (Item : in out Simple_File_Queue; Priority : Natural; File_Name : String);
   procedure Put_Lines_Dequeue (Item : in out Simple_File_Queue);

private

   type Simple_File is record
      Priority : Natural;
      Content  : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   function Get_Priority (Element : Simple_File) return Natural;
   function Before (Left, Right : Natural) return Boolean;

   package Simple_File_Queues is new Ada.Containers.Synchronized_Queue_Interfaces (Simple_File);
   package Simple_File_Priority_Queues is new Ada.Containers.Unbounded_Priority_Queues (Simple_File_Queues, Natural);

   type Simple_File_Queue is record
      Q : Simple_File_Priority_Queues.Queue;
   end record;



end;
