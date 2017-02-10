with GL.Math;

package Simple_Cameras is

   use GL.Math;
   use type GL.Math.Real_Float;

   type Camera is record
      FOV : Real_Float := 1.57079632679;
      Aspect : Real_Float := 3.0/4.0;
      Near : Real_Float := 0.1;
      Far : Real_Float := 80.0;
      Translation_Velocity : Real_Float_Vector4;
      Position : Real_Float_Vector4;
      Rotation : Real_Float_Vector4;
      Projection_Matrix : Real_Float_Matrix4;
      Rotation_Matrix  : Real_Float_Matrix4;
      Translation_Matrix  : Real_Float_Matrix4;
      Result_Matrix  : Real_Float_Matrix4;
   end record;

   procedure Init (Result : out Camera);
   procedure Update (Result : in out Camera);

end;
