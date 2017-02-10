with GL.Programs.Shaders;
with GL.Shaders.Files;
with Ada.Text_IO;

package body Simple_Shaders is

--     function Setup_Shader (Name : String; Stage : GL.Shaders.Shader_Stage) return GL.Shaders.Shader is
--        use GL.Shaders;
--        use GL.Shaders.Files;
--        use Ada.Text_IO;
--        Item : constant Shader := Create_Empty (Stage);
--     begin
--        Set_Source_File (Item, Name);
--        Compile_Checked (Item);
--        return Item;
--     exception
--        when Compile_Error =>
--           Put_Line ("Compile_Error");
--           Put_Line (Get_Compile_Log (Item));
--           return Item;
--     end;
--
--     function Setup_Program return GL.Programs.Program is
--        use GL.Shaders;
--        use GL.Programs;
--        use GL.Programs.Shaders;
--        use GL.Shaders.Files;
--        use Ada.Text_IO;
--        Item : constant Program := GL.Programs.Create_Empty;
--     begin
--        GL.Programs.Shaders.Attach (Item, Setup_Shader ("test.glvs", Vertex_Stage));
--        GL.Programs.Shaders.Attach (Item, Setup_Shader ("test.glfs", Fragment_Stage));
--        GL.Programs.Link_Checked (Item);
--        return Item;
--     exception
--        when Link_Error =>
--           Put_Line ("Link_Error");
--           Put_Line (GL.Programs.Get_Link_Log (Item));
--           return Item;
--     end;

   procedure Setup (Item : in out Program) is
      use GL.Programs;
      use GL.Shaders;
      use GL.Programs.Shaders;
   begin
      Item.Item_Program := Create_Empty;
      Item.Vertex_Shader := Create_Empty (Vertex_Stage);
      Item.Fragment_Shader := Create_Empty (Fragment_Stage);
      Attach (Item.Item_Program, Item.Vertex_Shader);
      Attach (Item.Item_Program, Item.Fragment_Shader);
   end;


   procedure Compile_Vertex_Shader_File (Item : in out Program; File_Name : String) is
      use Ada.Text_IO;
      use GL.Shaders;
      use GL.Shaders.Files;
   begin
      Item.Dummy1 := False;
      Set_Source_File (Item.Vertex_Shader, File_Name);
      Compile_Checked (Item.Vertex_Shader);
   exception
      when Compile_Error =>
         Put_Line ("Compile_Error");
         Put_Line (Get_Compile_Log (Item.Vertex_Shader));
   end;


   procedure Compile_Fragment_Shader_File (Item : in out Program; File_Name : String) is
      use Ada.Text_IO;
      use GL.Shaders;
      use GL.Shaders.Files;
   begin
      Item.Dummy1 := False;
      Set_Source_File (Item.Fragment_Shader, File_Name);
      Compile_Checked (Item.Fragment_Shader);
   exception
      when Compile_Error =>
         Put_Line ("Compile_Error");
         Put_Line (Get_Compile_Log (Item.Fragment_Shader));
   end;

   procedure Compile_Program (Item : in out Program) is
      use Ada.Text_IO;
      use GL.Programs;
   begin
      Item.Dummy1 := False;
      Link_Checked (Item.Item_Program);
   exception
      when Link_Error =>
         Put_Line ("Link_Error");
         Put_Line (GL.Programs.Get_Link_Log (Item.Item_Program));
   end;


end;
