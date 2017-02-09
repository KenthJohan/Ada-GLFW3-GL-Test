with Ada.Containers.Synchronized_Queue_Interfaces;
with Ada.Containers.Unbounded_Priority_Queues;
with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;


package body Debugs is

   use Ada.Containers;


   function Get_Priority (Element : Queue_Element) return Natural is
   begin
      return Element.Priority;
   end Get_Priority;

   function Before (Left, Right : Natural) return Boolean is
   begin
      return Left > Right;
   end Before;

   package String_Queues is new Synchronized_Queue_Interfaces
     (Element_Type => Queue_Element);

   package String_Priority_Queues is new Unbounded_Priority_Queues
     (Queue_Interfaces => String_Queues,
      Queue_Priority => Natural);


   Message_Queue : String_Priority_Queues.Queue;

   procedure Enqueue (Priority : Natural; Item : String) is
   begin
      Message_Queue.Enqueue ((Priority, To_Unbounded_String (Item)));
   end;

   procedure Put_Lines is
      use Ada.Text_IO.Unbounded_IO;
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
      Element : Queue_Element;
   begin
      while Message_Queue.Current_Use > 0 loop
         Message_Queue.Dequeue (Element => Element);
         Put (Element.Priority);
         Put (" : ");
         Put (Element.Content);
         New_Line;
      end loop;
   end;


end Debugs;
