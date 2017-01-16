with GL.C;
with GL.Buffers;
with GL.Vertex_Attributes;
with GL.Drawings;

package Meshes is

   type Vector is array (Integer range <>) of GL.C.GLfloat;

   subtype Vector_3 is Vector (1 .. 3);
   subtype Vector_4 is Vector (1 .. 4);

   type Vertex is record
      Pos : Vector_3 := (0.0, 0.0, 0.0);
      Col : Vector_4 := (0.0, 0.0, 0.0, 0.0);
   end record;

   type Vertex_Array is array (Integer range <>) of Vertex;

   type Mesh is record
      VBO : GL.Buffers.Buffer;
      VAO : GL.Vertex_Attributes.Config;
      Data : Vertex_Array (1 .. 2000);
      First : Natural := 0;
      Count : Natural := 0;
      Draw_Mode : GL.Drawings.Mode;
   end record;

   procedure Setup (Item : in out Mesh);
   procedure Draw (Item : Mesh);
   procedure Make_Grid_Lines (Item : in out Mesh);
   procedure Make_Triangle (Item : in out Mesh);

end;
