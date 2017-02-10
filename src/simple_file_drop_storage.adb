with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;




package body Simple_File_Drop_Storage is




   function Get_Priority (Element : Simple_File) return Natural is
   begin
      return Element.Priority;
   end Get_Priority;

   function Before (Left, Right : Natural) return Boolean is
   begin
      return Left > Right;
   end Before;

   procedure Enqueue (Item : in out Simple_File_Queue; Priority : Natural; File_Name : String) is
      use Ada.Strings.Unbounded;
   begin
      Item.Q.Enqueue ((Priority, To_Unbounded_String (File_Name)));
   end;

   procedure Put_Lines_Dequeue (Item : in out Simple_File_Queue) is
      use Ada.Text_IO.Unbounded_IO;
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
      use type Ada.Containers.Count_Type;
      Element : Simple_File;
   begin
      while Item.Q.Current_Use > 0 loop
         Item.Q.Dequeue (Element);
         Put (Element.Priority);
         Put (" : ");
         Put (Element.Content);
         New_Line;
      end loop;
   end;


end;
