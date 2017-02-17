with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;
with Home_Pictures.BMP_Images;
with Home_Pictures.BMP_Images.Puts;
with Ada.Directories;
with Ada.Strings.Unbounded;
with Ada.Streams.Stream_IO;
with Interfaces;


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

   procedure Put_BMP (Name : String) is
      use Interfaces;
      use Ada.Streams.Stream_IO;
      use type Interfaces.Unsigned_32;
      File : File_Type;
      Streamer : Stream_Access;
      Header : Home_Pictures.BMP_Images.BMP_Header;
   begin
      Open (File, In_File, Name);
      Streamer := Stream (File);
      Home_Pictures.BMP_Images.BMP_Header'Read (Streamer, Header);
      Home_Pictures.BMP_Images.Puts.Put_Lines (Header);
      Close (File);
   end;


   procedure Put_Lines_Dequeue (Item : in out Simple_File_Queue) is
      use Ada.Strings.Unbounded;
      use Ada.Directories;
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
         if Extension (To_String (Element.Content)) = "bmp" then
            Put_BMP (To_String (Element.Content));
         end if;
      end loop;
   end;




end;
