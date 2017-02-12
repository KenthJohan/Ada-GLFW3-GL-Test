with GL.Textures;
with GL.Buffers;
with GL.Vertex_Array_Objects;
with Simple_Shaders;


package Simple_Text_Render is

   type Text_Render is record
      P : Simple_Shaders.Program_Composition (2);
      VBO : GL.Buffers.Buffer;
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      T : GL.Textures.Texture;

   end record;

   procedure Load_Texture (Item : in out Text_Render);
   procedure Render (Item : in out Text_Render);

end Simple_Text_Render;
