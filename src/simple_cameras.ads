with GL.Math;

package Simple_Cameras is

   use GL.Math;
   use type GL.Math.GLfloat;

   type Camera is record
      FOV : GLfloat := 1.57079632679;
      Aspect : GLfloat := 3.0/4.0;
      Near : GLfloat := 0.1;
      Far : GLfloat := 80.0;
      Translation_Velocity : Float_Vector4;
      Position : Float_Vector4;
      Rotation : Float_Vector4;
      Projection_Matrix : Float_Matrix4;
      Rotation_Matrix  : Float_Matrix4;
      Translation_Matrix  : Float_Matrix4;
      Result_Matrix  : Float_Matrix4;
   end record;

   procedure Init (Result : out Camera);
   procedure Update (Result : in out Camera);

end;
