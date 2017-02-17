with Interfaces.C.Strings;
with Ada.Text_IO;
with System;
with Ada.Unchecked_Conversion;


package body Applications.Main_Drop_Callbacks is

   procedure drop_callback (W : Window; Count : int; Paths : File_Path_List) is
      use Interfaces.C.Strings;
      use Ada.Text_IO;
      use Simple_File_Drop_Storage;
      use System;
      type Application_Access is access all Application;
      function Convert is new Ada.Unchecked_Conversion (Address, Application_Access);
      Main_App : constant Application_Access := Convert (GLFW3.Windows.Get_Window_User_Pointer (W));
   begin
      Put_Line ("Count: " & Count'Img);
      for I in size_t (0) .. size_t (Count - 1) loop
         declare
            Name : constant String := Value (Paths (I));
         begin
            Simple_File_Drop_Storage.Append (Main_App.Main_Dropped_Files, Name);
         end;
      end loop;
   end;

end;
