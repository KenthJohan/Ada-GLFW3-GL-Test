with GLFW3;
with GLFW3.Windows;

procedure Dev_GLFW is
   use GLFW3;
   use GLFW3.Windows;
   Main_Window : Window;
begin
   GLFW3.Initialize;
   Main_Window := Create_Window_Ada (1024, 1024, "Hello Window");
   Make_Context_Current (Main_Window);
   loop
      Poll_Events;
      Swap_Buffers (Main_Window);
      pragma Warnings (Off);
      exit when Window_Should_Close (Main_Window) = 1;
      pragma Warnings (On);
      delay 0.01;
   end loop;
end;
