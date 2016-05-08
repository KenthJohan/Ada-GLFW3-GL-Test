with GL.C;
with GL.Vertex_Attributes;

package Vertices is

   use GL.C;
   use GL.Vertex_Attributes;

   type Vector is array (Integer range <>) of GLfloat;

   subtype Vector_3 is Vector (1 .. 3);
   subtype Vector_4 is Vector (1 .. 4);

   type Vertex is record
      Pos : Vector_3;
      Col : Vector_4;
   end record;

   type Vertex_Array is array (Integer range <>) of Vertex;



   procedure Setup_Vertex_Attribute;

end;
