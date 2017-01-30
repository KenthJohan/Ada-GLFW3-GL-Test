with Ada.Directories;
with Ada.Strings.Fixed;
with Ada.Integer_Text_IO;


package body File_Name_List is

   procedure Put_Column (Item : String) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
   begin
      Put (Head (Item, 20));
   end;

   procedure Put_Info (Name : String) is
      package File_Size_IO is new Ada.Text_IO.Integer_IO (Ada.Directories.File_Size);
      use File_Size_IO;
      use Ada.Directories;
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
      F : File_Type;
      Row : Natural := 0;
   begin
      Put_Column ("File name");
      Put (Name);
      New_Line;
      Put_Column ("File kind");
      Put (File_Kind'Image (Kind (Name)));
      New_Line;
      Put_Column ("File size");
      Put (Size (Name), 0);
      New_Line;
      Put_Column ("File extension");
      Put (Extension (Name));
      New_Line;
      Open (F, In_File, Name);
      while not End_Of_File (F) loop
         Skip_Line (F);
         Row := Row + 1;
      end loop;
      Close (F);
      Put_Column ("File rows");
      Put (Row, 0);
   end;


   procedure Put_Info (Item : Unbounded_String_Vector) is
      package Count_Type_IO is new Ada.Text_IO.Integer_IO (Ada.Containers.Count_Type);
      use Count_Type_IO;
      use Unbounded_String_Vectors;
      use Ada.Strings.Unbounded;
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
   begin
      Put_Column ("File count");
      Put (Length (Item), 0);
      New_Line (2);
      for E : Unbounded_String of Item loop
         Put_Info (To_String (E));
         New_Line (4);
      end loop;
   end;

end;
