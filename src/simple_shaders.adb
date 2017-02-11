with Ada.Directories;
with GL.Programs.Shaders.Files;

package body Simple_Shaders is

   procedure Set_Shader_File (Item : out Shader_Composition; File_Name : String) is
      use Ada.Directories;
      Ext : constant String := Extension (File_Name);
   begin
      if Ext = "glvs" then
         Item.Stage := Vertex_Stage;
         Item.Obj := Create_Empty (Vertex_Stage);
      elsif Ext = "glfs" then
         Item.Stage := Fragment_Stage;
         Item.Obj := Create_Empty (Fragment_Stage);
      else
         return;
      end if;
      Item.File_Name := To_Unbounded_String (File_Name);
   end;

   procedure Append (P : out Program_Composition; File_Name : String) is
      use GL.Programs.Shaders.Files;
   begin
      P.Shader_List.Append;
      Set_Shader_File (P.Shader_List.Last_Element, File_Name);
      Attach (P.Obj, P.Shader_List.Last_Element.Obj);
   end;

   procedure Build (P : in out Program_Composition) is
      use GL.Programs.Shaders.Files;
   begin
      for S : Shader_Composition of P.Shader_List loop
         Set_Source_File (S.Obj, To_String (S.File_Name));
         Compile_Checked (S.Obj);
      end loop;
      Link_Checked (P.Obj);
   end;


   procedure Delete (P : in out Program_Composition) is
   begin
      for S : Shader_Composition of P.Shader_List loop
         Delete (S.Obj);
         S.File_Name := Null_Unbounded_String;
      end loop;
      Delete (P.Obj);
      P.Shader_List.Empty;
   end;

end;
