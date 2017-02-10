with Simple_Vertices;

with Home_Containers.Generic_Vectors;

with GL.Vertex_Array_Objects;
with GL.Buffers;
with GL.Drawings;
with GL.C;

package Simple_Meshes is

   type Mesh_Status is (Uninitialized_Mesh_Status, Contruction_Mesh_Status, GPU_Load_Mesh_Status, Draw_Mesh_Status);

   type Mesh is record
      Dummy1 : Boolean := False;
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      VBO : GL.Buffers.Buffer;
      Vertex_List : Simple_Vertices.Vertex_Vector (10000);
      Draw_Mode : GL.Drawings.Mode := GL.Drawings.Line_Strip_Mode;
      Main_Mesh_Status : Mesh_Status := Uninitialized_Mesh_Status;
   end record;

   package Mesh_Vectors is new Home_Containers.Generic_Vectors (Mesh);
   subtype Mesh_Vector is Mesh_Vectors.Vector;


   procedure Initialize (Item : in out Mesh);
   procedure Initialize (Item : in out Mesh_Vector);

   procedure Update (Item : in out Mesh_Vector);
   procedure Update (Item : in out Mesh);

   procedure Draw (Item : in out Mesh);
   procedure Draw (Item : in out Mesh_Vector);

   procedure Make_Triangle (Item : in out Mesh);
   procedure Make_Grid_Lines (Item : in out Mesh; Size : GL.C.GLfloat; Stride : GL.C.GLfloat);

end;
