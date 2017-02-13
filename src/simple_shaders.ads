with Ada.Strings.Unbounded;

with GL.Programs;
with GL.Programs.Shaders;
with GL.Errors;


with Home_Containers.Generic_Vectors;


package Simple_Shaders is

   use GL.Errors;
   use GL.Programs;
   use GL.Programs.Shaders;
   use Ada.Strings.Unbounded;
   use Home_Containers;

   type Shader_Composition is record
      Stage : Shader_Stage;
      Obj : Shader;
      File_Name : Unbounded_String;
   end record;

   package Shader_Composition_Vectors is new Home_Containers.Generic_Vectors (Shader_Composition);
   subtype Shader_Composition_Vector is Shader_Composition_Vectors.Vector;

   type Program_Composition (Count : Home_Containers.Count) is record
      Obj : Program;
      Shader_List : Shader_Composition_Vector (Count);
   end record;

   procedure Append (P : out Program_Composition; File_Name : String) with
     Post => Check_No_Error;

   procedure Build (P : in out Program_Composition) with
     Post => Check_No_Error;

   procedure Delete (P : in out Program_Composition) with
     Post => Check_No_Error;

end;
