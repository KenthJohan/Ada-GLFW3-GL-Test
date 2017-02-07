with GL.Programs.Shaders;
with GL.Shaders.Files;
with Ada.Text_IO;

package body Shaders is

   function Setup_Shader (Name : String; Stage : GL.Shaders.Shader_Stage) return GL.Shaders.Shader is
      use GL.Shaders;
      use GL.Shaders.Files;
      use Ada.Text_IO;
      Item : constant Shader := Create_Empty (Stage);
   begin
      Set_Source_File (Item, Name);
      Compile_Checked (Item);
      return Item;
   exception
      when Compile_Error =>
         Put_Line ("Compile_Error");
         Put_Line (Get_Compile_Log (Item));
         return Item;
   end;

   function Setup_Program return GL.Programs.Program is
      use GL.Shaders;
      use GL.Programs;
      use GL.Programs.Shaders;
      use GL.Shaders.Files;
      use Ada.Text_IO;
      Item : constant Program := GL.Programs.Create_Empty;
   begin
      GL.Programs.Shaders.Attach (Item, Setup_Shader ("test.glvs", Vertex_Stage));
      GL.Programs.Shaders.Attach (Item, Setup_Shader ("test.glfs", Fragment_Stage));
      GL.Programs.Link_Checked (Item);
      return Item;
   exception
      when Link_Error =>
         Put_Line ("Link_Error");
         Put_Line (GL.Programs.Get_Link_Log (Item));
         return Item;
   end;

end Shaders;
