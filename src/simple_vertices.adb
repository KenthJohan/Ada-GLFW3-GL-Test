with Ada.Numerics.Float_Random;
with Ada.Numerics; use Ada.Numerics;

with Maths;


with GL.C.Complete;


package body Simple_Vertices is

   procedure Set_Random (Item : out GL.Colors.RGBA.Vector) is
      use GL.Colors;
      use Ada.Numerics.Float_Random;
      G : Generator;
   begin
      Reset (G);
      for E of Item loop
         E := Random (G);
      end loop;
   end;

   procedure Set_Random_Color (Item : out Vertex) is
   begin
      Set_Random (Item.Col);
   end;

   procedure Translate (V : in out Vertex_Vector; T : Real_Float_Vector3) is
      use Maths;
   begin
      for I in V.First_Index .. V.Last_Index loop
         V (I).Pos := V (I).Pos + T;
      end loop;
   end;

   procedure Transform (V : in out Vertex_Vector; T : Real_Float_Matrix3) is
      use Maths;
   begin
      for I in V.First_Index .. V.Last_Index loop
         V (I).Pos := T * V (I).Pos;
      end loop;
   end;


   procedure Make_2 (V : in out Vertex_Vector; D : Real_Float; Count : Natural; R : Real_Float_Matrix3; T : Real_Float_Vector3) is
      use type GL.Math.Real_Float;
      use GL.Colors;
      procedure Set_Pos (P : Real_Float_Vector3) is
         use Maths;
      begin
         V.Last_Element.Pos := R * P + T;
      end;
      U : Real_Float;
   begin
      V.Append;
      Set_Pos ((0.0, 0.0, 0.0));
      V.Last_Element.Col := RGBA.White_Vector;
      V.Append;
      Set_Pos ((D * Real_Float (Count), 0.0, 0.0));
      V.Last_Element.Col := RGBA.White_Vector;

      for I in 0 .. Count - 1 loop
         if I mod 10 = 0 then
            U := 0.4;
         elsif I mod 5 = 0 then
            U := 0.2;
         else
            U := 0.1;
         end if;
         V.Append;
         Set_Pos ((D * Real_Float (I), -1.0 * U, 0.0));
         V.Last_Element.Col := RGBA.White_Vector;
         V.Append;
         Set_Pos ((D * Real_Float (I), 1.0 * U, 0.0));
         V.Last_Element.Col := RGBA.White_Vector;
      end loop;
   end;

   procedure Make_1 (V : in out Vertex_Vector; D : Real_Float; Count : Natural) is
      use Maths;
      use type GL.Math.Real_Float;
      Q : Real_Float_Vector4;
      R : Real_Float_Matrix3;
   begin
      Q := Convert_Axis_Angle_To_Quaternion ((0.0, 0.0, 1.0), 0.0);
      R := Make_Rotation_Matrix3 (Q);
      Make_2 (V, D, Count, R, (0.0, 0.0, 0.0));
      Q := Convert_Axis_Angle_To_Quaternion ((0.0, 0.0, 1.0), - (Pi / 2.0));
      R := Make_Rotation_Matrix3 (Q);
      Make_2 (V, D, Count, R, (0.0, 0.0, 0.0));
      null;
   end;

   procedure Configurate_Vertex_Attributes (VAO : GL.Vertex_Array_Objects.Vertex_Array_Object; VBO : GL.Buffers.Buffer) is
      use GL.Vertex_Array_Objects;
      use GL.C;
      use GL.C.Complete;
   begin
      Set_Attribute_Enable (VAO, 0);
      Set_Attribute_Enable (VAO, 1);
      Set_Attribute_Memory_Layout (VAO, 0, Real_Float_Vector3'Length, Float_Type, False, 0);
      Set_Attribute_Memory_Layout (VAO, 1, Real_Float_Vector4'Length, Float_Type, False, Real_Float_Vector3'Size / Storage_Unit);
      glVertexArrayAttribBinding (GLuint (VAO), 0, 0);
      glVertexArrayAttribBinding (GLuint (VAO), 1, 0);
      glVertexArrayVertexBuffer (GLuint (VAO), 0, GLuint (VBO), 0, Vertex_Array_Stride);
   end;

end;
