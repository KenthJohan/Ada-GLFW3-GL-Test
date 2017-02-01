with Ada.Text_IO;
with Ada.Exceptions;
with Interfaces.C;
with Interfaces.C.Strings;
with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Drops;
with File_Name_List;
with Ada.Strings;
with Ada.Strings.Unbounded;

procedure Dev_Drop_Test1 is

   Dropped_List : File_Name_List.Unbounded_String_Vector;

   task File_Read_Task is
      entry Start;
      entry Quit;
   end;
   task body File_Read_Task is
   begin
      loop
         select
            accept Start;
            File_Name_List.Put_Info (Dropped_List);
         or
            accept Quit;
            exit;
         end select;
      end loop;
   end;


   procedure drop_callback (W : GLFW3.Window; Count : Interfaces.C.int; Paths : GLFW3.Windows.Drops.File_Path_List) with Convention => C;
   procedure drop_callback (W : GLFW3.Window; Count : Interfaces.C.int; Paths : GLFW3.Windows.Drops.File_Path_List) is
      pragma Unreferenced (W);
      use Interfaces.C;
      use Interfaces.C.Strings;
      use Ada.Text_IO;
      use Ada.Strings.Unbounded;
   begin
      for I in size_t (0) .. size_t (Count - 1) loop
         declare
            Name : constant String := Value (Paths (I));
         begin
            Dropped_List.Append (To_Unbounded_String (Name));
         end;
      end loop;
      File_Read_Task.Start;
   exception
      when E : Constraint_Error =>
         Put_Line (Ada.Exceptions.Exception_Message (E));
   end;



   procedure App is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Drops;
      Main_Window : constant Window := Create_Window_Ada (1024, 1024, "Hello123");
   begin
      Make_Context_Current (Main_Window);
      Set_Drop_Callback (Main_Window, drop_callback'Unrestricted_Access);
      loop
         Poll_Events;
         Swap_Buffers (Main_Window);
         pragma Warnings (Off);
         exit when Window_Should_Close (Main_Window) = 1;
         pragma Warnings (On);
         delay 0.01;
      end loop;
      Destroy_Window (Main_Window);
      File_Read_Task.Quit;
   end;




begin
   GLFW3.Initialize;
   App;
end;
