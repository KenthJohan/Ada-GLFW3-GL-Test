with GLFW3.Windows;
with GLFW3.Windows.Drops;
with Interfaces.C;

package Applications.Main_Drop_Callbacks is

   use GLFW3.Windows;
   use GLFW3.Windows.Drops;
   use Interfaces.C;
   pragma Warnings (Off);
   procedure drop_callback (W : Window; Count : int; Paths : File_Path_List) with Convention => C;
   pragma Warnings (On);

end;
