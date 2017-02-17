with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;
with Ada.Directories;
with Ada.Strings.Unbounded;
with Ada.Streams.Stream_IO;
with Ada.Strings.Fixed;

with Interfaces;

with Home_Pictures.BMP_Images;
with Home_Pictures.BMP_Images.Puts;

package body Simple_File_Drop_Storage is



   procedure Append (Item : in out Dropped_File_Vector; File_Name : String) is
      use Ada.Strings.Unbounded;
      use Ada.Directories;
      E : Dropped_File;
   begin
      E.File_Name := To_Unbounded_String (File_Name);
      E.Ext_Name := To_Unbounded_String (Extension (File_Name));
      Item.Append (E);
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


   procedure Put_Lines (Item : in out Dropped_File_Vector) is
      use Ada.Strings.Unbounded;
      use Ada.Directories;
      use Ada.Text_IO.Unbounded_IO;
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use type Ada.Containers.Count_Type;
   begin
      for E : Dropped_File of Item loop
         Put (Head ("File name", 40));
         Put (E.File_Name);
         New_Line;
         Put (Head ("Ext name", 40));
         Put (E.Ext_Name);
         New_Line;
         if E.Ext_Name = "bmp" then
            Put_BMP (To_String (E.File_Name));
         end if;
      end loop;
   end;




end;
