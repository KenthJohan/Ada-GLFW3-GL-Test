with GL.Buffers;
with GL.Vertex_Array_Objects;
with GL.Drawings;
with GL.Math;
with Generic_Vectors;
with Ada.Containers.Vectors;

package Meshes is

   use GL.Math;

   type Vertex is record
      Pos : Float_Vector3 := (0.0, 0.0, 0.0);
      Col : Float_Vector4 := (0.0, 0.0, 0.0, 0.0);
   end record;

   type Vertex_Array is array (Positive range <>) of Vertex;

   package Vertex_Vectors is new Generic_Vectors (Positive, Vertex);
   subtype Vertex_Vector is Vertex_Vectors.Vector;

   type Mesh_Status is (Under_Construction_Status, GPU_Setup_Status, GPU_Render_Status);

   type Mesh is record
      Vertex_Array_Name : GL.Vertex_Array_Objects.Vertex_Array_Object;
      Buffer_Name : GL.Buffers.Buffer;
      Data : Vertex_Vector (2000);
      Draw_Mode : GL.Drawings.Mode;
      Dummy : Boolean;
      Status : Mesh_Status := GPU_Setup_Status;
   end record;

   package Mesh_Vectors is new Ada.Containers.Vectors (Positive, Meshes.Mesh, Meshes."=");

   procedure Update (Item : in out Mesh);
   procedure Update (List : in out Mesh_Vectors.Vector);


   procedure Make_Grid_Lines (Item : in out Mesh);
   procedure Make_Triangle (Item : in out Mesh);
   procedure Make_Sin (Item : in out Mesh);


end;
