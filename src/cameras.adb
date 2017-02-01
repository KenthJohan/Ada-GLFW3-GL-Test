with Maths;

package body Cameras is

   procedure Init (Result : out Camera) is
      use Maths;
   begin
      Result.Rotation := (1.0, 0.0, 0.0, 0.0);
      Result.Position := (0.0, 0.0, 0.0, 0.0);
      Result.Projection_Matrix := (others => (others => 0.0));
      Result.Rotation_Matrix := Identity;
      Result.Translation_Matrix := Identity;
   end;


   procedure Update (Result : in out Camera) is
      use Maths;
   begin
      Make_Perspective_Matrix (Result.FOV, Result.Aspect, Result.Near, Result.Far, Result.Projection_Matrix);
      Product_Transpose_Accumulate (Result.Rotation_Matrix, Result.Translation_Velocity, Result.Position);
      Make_Translation_Matrix (Result.Position, Result.Translation_Matrix);
      --Make_Rotation_Matrix (Result.Rotation, Result.Rotation_Matrix);
      Result.Rotation_Matrix := Make_Rotation_Matrix4 (Result.Rotation);
      Result.Result_Matrix := Result.Projection_Matrix * Result.Rotation_Matrix * Result.Translation_Matrix;
   end;

end;
