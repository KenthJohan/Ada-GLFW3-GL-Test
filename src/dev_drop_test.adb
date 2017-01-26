with Ada.Text_IO;
with Ada.Streams;
with Interfaces.C;
with Interfaces.C.Strings;
with Ada.Streams.Stream_IO;
with Ada.Directories;
with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Drops;
with Ada.Exceptions;

procedure Dev_Drop_Test is

   use Interfaces.C;
   use GLFW3;
   use GLFW3.Windows;
   use GLFW3.Windows.Drops;

   procedure Read (Name : String; Content : out String) is
      use Ada.Streams.Stream_IO;
      File : File_Type;
      Stream_Item : Stream_Access;
   begin
      Open (File, In_File, Name);
      Stream_Item := Stream (File);
      String'Read (Stream_Item, Content);
      Close (File);
   end;

   procedure drop_callback (W : Window; Count : int; Paths : File_Path_List) with Convention => C;
   procedure drop_callback (W : Window; Count : int; Paths : File_Path_List) is
      pragma Unreferenced (W);
      use Interfaces.C.Strings;
      use Ada.Text_IO;
      use Ada.Directories;
      Buffer : String (1 .. 100) := (others => ' ');
   begin
      Put_Line ("Count: " & Count'Img);
      for I in size_t (0) .. size_t (Count - 1) loop
         declare
            Name : constant String := Value (Paths (I));
         begin
            Put_Line (Name);
            Read (Name, Buffer (1 .. Natural (Size (Name))));
            New_Line;
            Put_Line (Buffer);
            New_Line (2);
         end;
      end loop;
   exception
      when E : Constraint_Error =>
         Put_Line (Ada.Exceptions.Exception_Message (E));
   end;

   Main_Window : Window;

begin
   GLFW3.Initialize;
   Main_Window := Create_Window_Ada (1024, 1024, "Hello123");
   Make_Context_Current (Main_Window);
   Set_Drop_Callback (Main_Window, drop_callback'Unrestricted_Access);
   loop
      Poll_Events;
      -- Swap_Buffers (Main_Window);
      pragma Warnings (Off);
      exit when Window_Should_Close (Main_Window) = 1;
      pragma Warnings (On);
      delay 0.01;
   end loop;
end;
