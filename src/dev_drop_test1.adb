with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Exceptions;
with Interfaces.C;
with Interfaces.C.Strings;
with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Drops;
with GL.Drawings;
with Parse_Handler;

procedure Dev_Drop_Test1 is


   procedure App is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Drops;
      Main_Window : constant Window := Create_Window_Ada (1024, 1024, "Hello123");
   begin
      Make_Context_Current (Main_Window);
      Set_Drop_Callback (Main_Window, Parse_Handler.drop_callback'Unrestricted_Access);
      loop
         Poll_Events;
         Swap_Buffers (Main_Window);
         pragma Warnings (Off);
         exit when Window_Should_Close (Main_Window) = 1;
         pragma Warnings (On);
         delay 0.01;
      end loop;
      Destroy_Window (Main_Window);
      Parse_Handler.Parse_Task.Quit;
   end;




begin
   GLFW3.Initialize;
   App;
end;
