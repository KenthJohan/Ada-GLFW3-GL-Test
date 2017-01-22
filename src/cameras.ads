with GL.Math;
with GL.C;

package Cameras is

   use GL.Math;
   use GL.C;
   use type GL.C.GLfloat;

   type Camera is record
      FOV : GLfloat := 1.57079632679;
      Aspect : GLfloat := 3.0/4.0;
      Near : GLfloat := 0.1;
      Far : GLfloat := 80.0;
      Translation_Velocity : Vector_4;
      Position : Vector_4;
      Rotation : Vector_4;
      Projection_Matrix : Matrix_4;
      Rotation_Matrix  : Matrix_4;
      Translation_Matrix  : Matrix_4;
      Result_Matrix  : Matrix_4;
   end record;

   procedure Init (Result : out Camera);
   procedure Update (Result : in out Camera);

end;
