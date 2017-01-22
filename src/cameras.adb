with Maths;

package body Cameras is

   procedure Init (Result : out Camera) is
      use Maths;
   begin
      Result.Rotation := (1.0, 0.0, 0.0, 0.0);
      Result.Position := (0.0, 0.0, 0.0, 0.0);
      Result.Projection_Matrix := (others => (others => 0.0));
      Make_Matrix_Identity (Result.Rotation_Matrix);
      Make_Matrix_Identity (Result.Translation_Matrix);
      Make_Matrix_Identity (Result.Result_Matrix);
   end;

   procedure Setup_Perspective (Field_Of_View, Aspect, Near, Far : GLfloat; Result : out Camera) is
      use Maths;
   begin
      Make_Perspective_Matrix (Field_Of_View, Aspect, Near, Far, Result.Projection_Matrix);
   end;



   procedure Update (Result : in out Camera) is
      use Maths;
   begin
      Mul_T1 (Result.Rotation_Matrix, Result.Translation_Velocity, Result.Position);
      Make_Translation_Matrix (Result.Position, Result.Translation_Matrix);
      Make_Rotation_Matrix (Result.Rotation, Result.Rotation_Matrix);
      Result.Result_Matrix := Result.Projection_Matrix * Result.Rotation_Matrix * Result.Translation_Matrix;
   end;

end;
