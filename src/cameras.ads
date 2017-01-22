with GL.Math;
with GL.C;

package Cameras is

   use GL.Math;
   use GL.C;

   type Camera is record
      Translation_Velocity : Vector_4;
      Position : Vector_4;
      Rotation : Vector_4;
      Projection_Matrix : Matrix_4;
      Rotation_Matrix  : Matrix_4;
      Translation_Matrix  : Matrix_4;
      Result_Matrix  : Matrix_4;
   end record;

   procedure Init (Result : out Camera);
   procedure Setup_Perspective (Field_Of_View, Aspect, Near, Far : GLfloat; Result : out Camera);
   procedure Update (Result : in out Camera);

end;
