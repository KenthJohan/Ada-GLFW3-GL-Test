with GL.Buffers;
with GL.Vertex_Array_Objects;
with GL.Drawings;
with Vertices;
with Generic_Vectors;

package Meshes is

   type Mesh_State is (Setup_Mesh_State, Draw_Mesh_State, Hide_Mesh_State);

   type Mesh is record
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      VBO : GL.Buffers.Buffer;
      Data : Vertices.Vertex_Vector (10000);
      Data1 : Vertices.Vertex_Vector (10000);
      Draw_Mode : GL.Drawings.Mode;
      State : Mesh_State := Setup_Mesh_State;
   end record;

   package Mesh_Vectors is new Generic_Vectors (Meshes.Mesh);
   subtype Mesh_Vector is Mesh_Vectors.Vector;

   procedure Update (List : in out Mesh_Vectors.Vector);
   procedure Draw (List : in out Mesh_Vectors.Vector);


   procedure Make_Grid_Lines (Item : in out Mesh);
   procedure Make_Triangle (Item : in out Mesh);
   procedure Make_Sin (Item : in out Mesh);


end;
