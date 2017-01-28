with Interfaces.C;
with GLFW3;
with GLFW3.Windows.Drops;
with Meshes;

package Parse_Handler is


   Mesh_List : Meshes.Mesh_Vectors.Vector;

   procedure drop_callback (W : GLFW3.Window; Count : Interfaces.C.int; Paths : GLFW3.Windows.Drops.File_Path_List) with Convention => C;

   procedure Parse (File_Name : String);

   task Parse_Task is
      entry Start;
      entry Quit;
   end;

end;
