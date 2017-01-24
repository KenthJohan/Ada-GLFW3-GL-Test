with GL.Math;
with Matpack;
with Matpack.Projections;
with Matpack.Quaternions;

package Maths is

   use GL.Math;
   use type GL.Math.GLfloat;
   use Matpack;
   use Matpack.Projections;
   use Matpack.Quaternions;

   function "*" is new
     Generic_Quaternion_Quaternion_Hamilton_Product (Dimension4, GLfloat, Float_Vector4, 0.0);

   function "*" is new
     Generic_Matrix_Matrix_Product_IKJ (Dimension, GLfloat, Float_Matrix, 0.0);

   procedure Normalize is new
     Generic_Normalize (Dimension, GLfloat, Float_Vector, 0.0, 1.0, Elementary_Functions.Sqrt);

   -- | 1  0  0  0 |
   -- | 0  1  0  0 |
   -- | 0  0  1  0 |
   -- | 0  0  0  1 |
   procedure Make_Matrix_Identity is new
     Generic_Make_Matrix_Identity (Dimension, GLfloat, Float_Matrix, 0.0, 1.0);

   function Convert_Axis_Angle_To_Quaternion is new
     Generic_Axis_Quaternion_Conversion_Function (Dimension4, Dimension3, GLfloat, Float_Vector4, Float_Vector3, 2.0, Elementary_Functions.Sin, Elementary_Functions.Cos);

   -- Desc
   procedure Make_Perspective_Matrix is new
     Generic_Matrix_Perspective_Conversion (Dimension4, GLfloat, Float_Matrix4, 1.0, 2.0, Elementary_Functions.Tan);

   -- A^T x
   procedure Mul_T1 is new
     Generic_Matrix_T1_Vector_Product (Dimension, GLfloat, Float_Matrix, Float_Vector);

   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   procedure Make_Translation_Matrix is new
     Generic_Vector_Matrix_Translation_Conversion (Dimension4, GLfloat, Float_Vector4, Float_Matrix4);

   -- f : R^4 -> R^(4x4)
   procedure Make_Rotation_Matrix is new
     Generic_Quaternion_Matrix_4_Conversion (Dimension4, GLfloat, Float_Vector4, Float_Matrix4, 2.0);

   procedure Put is new
     Generic_Put_Matrix (Dimension, GLfloat, Float_Matrix);

   procedure Put is new
     Generic_Put_Vector (Dimension, GLfloat, Float_Vector);

end;
