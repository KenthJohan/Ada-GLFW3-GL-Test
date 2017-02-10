with GL.Programs;

with GL.Shaders;


package Simple_Shaders is

   type Program is record
      Dummy1 : Boolean;
      Item_Program : GL.Programs.Program;
      Vertex_Shader : GL.Shaders.Shader;
      Fragment_Shader : GL.Shaders.Shader;
   end record;

   procedure Setup (Item : in out Program);
   procedure Compile_Vertex_Shader_File (Item : in out Program; File_Name : String);
   procedure Compile_Fragment_Shader_File (Item : in out Program; File_Name : String);
   procedure Compile_Program (Item : in out Program);

end;
