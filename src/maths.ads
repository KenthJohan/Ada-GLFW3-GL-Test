with GL.C;
with GL.Math;
with Matpack;
with Matpack.Projections;
with Matpack.Quaternions;

package Maths is

   use GL.C;
   use GL.Math;
   use Matpack;
   use Matpack.Projections;
   use Matpack.Quaternions;

   use type GL.C.GLfloat;

   function "*"                              is new Generic_Quaternion_Quaternion_Hamilton_Product (Dimension_4, GLfloat, Vector_4, 0.0);
   function "*"                              is new Generic_Matrix_Matrix_Product_IKJ (Dimension, GLfloat, Matrix, 0.0);

   procedure Normalize                       is new Generic_Normalize (Dimension, GLfloat, Vector, 0.0, 1.0, Elementary_Functions.Sqrt);

   -- | 1  0  0  0 |
   -- | 0  1  0  0 |
   -- | 0  0  1  0 |
   -- | 0  0  0  1 |
   procedure Make_Matrix_Identity            is new Generic_Make_Matrix_Identity (Dimension, GLfloat, Matrix, 0.0, 1.0);

   function Convert_Axis_Angle_To_Quaternion is new Generic_Axis_Quaternion_Conversion_Function (Dimension_4, Dimension_3, GLfloat, Vector_4, Vector_3, 2.0, Elementary_Functions.Sin, Elementary_Functions.Cos);

   -- Desc
   procedure Make_Perspective_Matrix         is new Generic_Matrix_Perspective_Conversion (Dimension_4, GLfloat, Matrix_4, 1.0, 2.0, Elementary_Functions.Tan);

   -- A^T x
   procedure Mul_T1                          is new Generic_Matrix_T1_Vector_Product (Dimension, GLfloat, Matrix, Vector);

   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   procedure Make_Translation_Matrix         is new Generic_Vector_Matrix_Translation_Conversion (Dimension_4, GLfloat, Vector_4, Matrix_4);

   -- f : R^4 -> R^(4x4)
   procedure Make_Rotation_Matrix            is new Generic_Quaternion_Matrix_4_Conversion (Dimension_4, GLfloat, Vector_4, Matrix_4, 2.0);

   procedure Put                             is new Generic_Put (Dimension, GLfloat, Matrix);

end;
