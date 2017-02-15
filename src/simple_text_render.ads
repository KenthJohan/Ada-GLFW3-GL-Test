with GL.Textures;
with GL.Buffers;
with GL.Vertex_Array_Objects;
with Simple_Shaders;
with GL.Math;
with GL.Programs.Uniforms;
with GLFW3.Windows;
with GL.C;

package Simple_Text_Render is

   use GL.Math;

   type Glyph_Vertex is record
      Pos : Real_Float_Vector4;
      STUV : Real_Float_Vector4;
   end record with Pack;

   type Glyph_Vertex_Quad is array (1 .. 6) of Glyph_Vertex;
   type Glyph_Vertex_Quad_Array is array (Integer range <>) of Glyph_Vertex_Quad;



   type Text_Render is record
      P : Simple_Shaders.Program_Composition (2);
      VBO : GL.Buffers.Buffer;
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      T : GL.Textures.Texture;
      Layer_Loc : GL.Programs.Uniforms.Location;
      V : Glyph_Vertex_Quad;
   end record;




   procedure Load_Texture (Item : in out Text_Render);
   procedure Render (Item : in out Text_Render; Lay : GL.C.GLint);
   procedure Render_Char (Item : in out Text_Render; I : Natural);

end Simple_Text_Render;
