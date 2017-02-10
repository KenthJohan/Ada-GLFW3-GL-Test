with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;

package body Simple_Debug_Systems is

   use Ada.Containers;


   function Get_Priority (Element : Debug_Message) return Natural is
   begin
      return Element.Priority;
   end Get_Priority;

   function Before (Left, Right : Natural) return Boolean is
   begin
      return Left > Right;
   end Before;


   procedure Enqueue (Item : in out Debug_Message_Queue; Priority : Natural; Message_String : String) is
      use Ada.Strings.Unbounded;
   begin
      Item.Q.Enqueue ((Priority, To_Unbounded_String (Message_String)));
   end;

   procedure Enqueue (Priority : Natural; Message_String : String) is
   begin
      Enqueue (Global_Debug_Message_Queue, Priority, Message_String);
   end;

   procedure Put_Lines_Dequeue (Item : in out Debug_Message_Queue) is
      use Ada.Text_IO.Unbounded_IO;
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
      Element : Debug_Message;
   begin
      while Item.Q.Current_Use > 0 loop
         Item.Q.Dequeue (Element);
         Put (Element.Priority);
         Put (" : ");
         Put (Element.Content);
         New_Line;
      end loop;
   end;


   procedure Put_Lines_Dequeue is
   begin
      Put_Lines_Dequeue (Global_Debug_Message_Queue);
   end;

end;
