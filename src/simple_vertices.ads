with GL.Math;
with Home_Containers.Generic_Vectors;
with GL.Colors;
with System;
with GL.C;

package Simple_Vertices is

   use GL.Math;
   use GL.Colors.Colors_RGBA;
   use System;

   type Vertex is record
      Pos : Real_Float_Vector3 := (0.0, 0.0, 0.0);
      Col : Color_Amount_Vector := (0.0, 0.0, 0.0, 0.0);
   end record;

   type Vertex_Array is array (Positive range <>) of Vertex;

   use type GL.C.GLsizei;
   Vertex_Array_Stride : constant GL.C.GLsizei := Vertex_Array'Component_Size / Storage_Unit;

   package Vertex_Vectors is new Home_Containers.Generic_Vectors (Vertex);
   subtype Vertex_Vector is Vertex_Vectors.Vector;

   procedure Set_Random_Color (Item : out Vertex);

   procedure Make_1 (V : in out Vertex_Vector; D : Real_Float; Count : Natural);

   procedure Translate (V : in out Vertex_Vector; T : Real_Float_Vector3);
   procedure Transform (V : in out Vertex_Vector; T : Real_Float_Matrix3);

end;
