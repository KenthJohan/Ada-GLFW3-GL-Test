with System;

with GL.Math;
with GL.Colors;
with GL.C;
with GL.Vertex_Array_Objects;
with GL.Buffers;

with Home_Containers.Generic_Vectors;

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

   procedure Configurate_Vertex_Attributes (VAO : GL.Vertex_Array_Objects.Vertex_Array_Object; VBO : GL.Buffers.Buffer);
end;
