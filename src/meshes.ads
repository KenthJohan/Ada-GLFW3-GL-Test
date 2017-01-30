with GL.Buffers;
with GL.Vertex_Array_Objects;
with GL.Drawings;
with GL.Math;
with Ada.Containers.Vectors;
with Vertices;

package Meshes is

   use GL.Math;

   type Mesh_State is (Setup_Mesh_State, Draw_Mesh_State);

   type Mesh is record
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      VBO : GL.Buffers.Buffer;
      Data : Vertices.Vertex_Vector (10000);
      Draw_Mode : GL.Drawings.Mode;
      State : Mesh_State := Setup_Mesh_State;
   end record;

   package Mesh_Vectors is new Ada.Containers.Vectors (Positive, Meshes.Mesh, Meshes."=");
   subtype Mesh_Vector is Mesh_Vectors.Vector;

   procedure Update (List : in out Mesh_Vectors.Vector);
   procedure Draw (List : in out Mesh_Vectors.Vector);


   procedure Make_Grid_Lines (Item : in out Mesh);
   procedure Make_Triangle (Item : in out Mesh);
   procedure Make_Sin (Item : in out Mesh);


end;
