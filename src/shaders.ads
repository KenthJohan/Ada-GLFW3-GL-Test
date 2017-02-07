with GL.Programs;

with GL.Shaders;


package Shaders is

   function Setup_Shader (Name : String; Stage : GL.Shaders.Shader_Stage) return GL.Shaders.Shader;

   function Setup_Program return GL.Programs.Program;

end Shaders;
