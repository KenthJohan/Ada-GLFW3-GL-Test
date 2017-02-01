with Ada.Numerics.Float_Random;
with GL.C;
with Maths;
with Ada.Numerics; use Ada.Numerics;

package body Vertices is

   procedure Set_Random (Item : out Color_Amount_Vector) is
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

   procedure Translate (V : in out Vertex_Vector; T : Float_Vector3) is
      use Maths;
   begin
      for I in V.First_Index .. V.Last_Index loop
         V (I).Pos := V (I).Pos + T;
      end loop;
   end;

   procedure Transform (V : in out Vertex_Vector; T : Float_Matrix3) is
      use Maths;
   begin
      for I in V.First_Index .. V.Last_Index loop
         V (I).Pos := T * V (I).Pos;
      end loop;
   end;


   procedure Make_2 (V : in out Vertex_Vector; D : GLfloat; Count : Natural; R : Float_Matrix3; T : Float_Vector3) is
      use type GL.C.GLfloat;
      use GL.Colors;
      procedure Set_Pos (P : Float_Vector3) is
         use Maths;
      begin
         V.Last_Element.Pos := R * P + T;
      end;
      U : GLfloat;
   begin
      V.Append;
      Set_Pos ((0.0, 0.0, 0.0));
      V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
      V.Append;
      Set_Pos ((D * GLfloat (Count), 0.0, 0.0));
      V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;

      for I in 0 .. Count - 1 loop
         if I mod 10 = 0 then
            U := 0.4;
         elsif I mod 5 = 0 then
            U := 0.2;
         else
            U := 0.1;
         end if;
         V.Append;
         Set_Pos ((D * GLfloat (I), -1.0 * U, 0.0));
         V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
         V.Append;
         Set_Pos ((D * GLfloat (I), 1.0 * U, 0.0));
         V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
      end loop;
   end;

   procedure Make_1 (V : in out Vertex_Vector; D : GLfloat; Count : Natural) is
      use Maths;
      use type GL.Math.GLfloat;
      Q : Float_Vector4;
      R : Float_Matrix3;
   begin
      Q := Convert_Axis_Angle_To_Quaternion ((0.0, 0.0, 1.0), 0.0);
      R := Make_Rotation_Matrix3 (Q);
      Make_2 (V, D, Count, R, (0.0, 0.0, 0.0));
      Q := Convert_Axis_Angle_To_Quaternion ((0.0, 0.0, 1.0), - (Pi / 2.0));
      R := Make_Rotation_Matrix3 (Q);
      Make_2 (V, D, Count, R, (0.0, 0.0, 0.0));
      null;
   end;

end;
