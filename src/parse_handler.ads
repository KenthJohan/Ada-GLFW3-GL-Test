with Interfaces.C;
with GLFW3;
with GLFW3.Windows.Drops;
with Meshes;

package Parse_Handler is

   Mesh_List : Meshes.Mesh_Vector (10);
   Key_Pad_List : array (Natural range 0 .. 9) of Meshes.Mesh_Vectors.Base_Index := (others => Meshes.Mesh_Vectors.No_Index);


   procedure drop_callback (W : GLFW3.Window; Count : Interfaces.C.int; Paths : GLFW3.Windows.Drops.File_Path_List) with Convention => C;

   procedure Parse (File_Name : String);

   procedure Hide (I : Natural);

   task Parse_Task is
      entry Start;
      entry Quit;
   end;

end;
