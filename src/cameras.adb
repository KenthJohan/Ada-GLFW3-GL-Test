with Generic_Matpack;
with Generic_Matpack.Projections;
with Generic_Matpack.Quaternions;

package body Cameras is

   procedure Init (Result : out Camera) is
      procedure Make_Matrix_Identity is new Generic_Matpack.Make_Matrix_Identity (Dimension, GLfloat, Matrix, 0.0, 1.0);
   begin
      Result.Rotation := (1.0, 0.0, 0.0, 0.0);
      Result.Position := (0.0, 0.0, 0.0, 0.0);
      Result.Projection_Matrix := (others => (others => 0.0));
      Make_Matrix_Identity (Result.Rotation_Matrix);
      Make_Matrix_Identity (Result.Translation_Matrix);
      Make_Matrix_Identity (Result.Result_Matrix);
   end;

   procedure Setup_Perspective (Field_Of_View, Aspect, Near, Far : GLfloat; Result : out Camera) is
      use type GLfloat;
      procedure Matrix_Perspective_Conversion is new Generic_Matpack.Projections.Matrix_Perspective_Conversion (Dimension_4, GLfloat, Matrix_4, 1.0, 2.0, Elementary_Functions.Tan);
   begin
      Matrix_Perspective_Conversion (Field_Of_View, Aspect, Near, Far, Result.Projection_Matrix);
   end;



   procedure Update (Result : in out Camera) is
      use type GLfloat;
      function "*" is new Generic_Matpack.Matrix_Matrix_Product_IKJ (Dimension, GLfloat, Matrix, 0.0);
      procedure Mul_T is new Generic_Matpack.Matrix_T1_Vector_Product (Dimension, GLfloat, Matrix, Vector);
      procedure Make_Translation_Matrix is new Generic_Matpack.Projections.Vector_Matrix_Translation_Conversion (Dimension_4, GLfloat, Vector_4, Matrix_4);
      procedure Make_Rotation_Matrix is new Generic_Matpack.Quaternions.Quaternion_Matrix_4_Conversion (Dimension_4, GLfloat, Vector_4, Matrix_4, 2.0);
   begin
      Mul_T (Result.Rotation_Matrix, Result.Translation_Velocity, Result.Position);
      Make_Translation_Matrix (Result.Position, Result.Translation_Matrix);
      Make_Rotation_Matrix (Result.Rotation, Result.Rotation_Matrix);
      Result.Result_Matrix := Result.Projection_Matrix * Result.Rotation_Matrix * Result.Translation_Matrix;
   end;

end;
