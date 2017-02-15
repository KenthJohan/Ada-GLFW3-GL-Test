with GL.Textures;
with GL.Buffers;
with GL.Vertex_Array_Objects;
with Simple_Shaders;
with GL.Math;
with GL.Programs.Uniforms;
with GLFW3.Windows;

package Simple_Text_Render is

   use GL.Math;

   type Vertex_Glyph is array (1 .. 6) of Real_Float_Vector4;
   type Vertex_Glyph_Array is array (Integer range <>) of Real_Float_Vector4;

   type Text_Render is record
      P : Simple_Shaders.Program_Composition (2);
      VBO : GL.Buffers.Buffer;
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      T : GL.Textures.Texture;
      Layer_Loc : GL.Programs.Uniforms.Location;
      V : Vertex_Glyph;
   end record;




   procedure Load_Texture (Item : in out Text_Render);
   procedure Render (W : GLFW3.Windows.Window; Item : in out Text_Render);

end Simple_Text_Render;
