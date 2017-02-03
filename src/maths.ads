with GL.Math;
with Home_Mathematics;
with Home_Mathematics.Projections;
with Home_Mathematics.Quaternions;
with Home_Mathematics.Text_IO;
with Home_Mathematics.Products;
with Home_Mathematics.Additions;

package Maths is

   use GL.Math;
   use type GL.Math.GLfloat;
   use Home_Mathematics;
   use Home_Mathematics.Projections;
   use Home_Mathematics.Quaternions;
   use Home_Mathematics.Text_IO;
   use Home_Mathematics.Additions;
   use Home_Mathematics.Products;


   function "+" is new
     Generic_CVecN_CVecN_Addition (Dimension3, GLfloat, Float_Vector3);

   function "*" is new
     Generic_Constrained_Square_Matrix_Vector_Product (Dimension3, GLfloat, Float_Matrix3, Float_Vector3);

   function "*" is new
     Generic_Constrained_Square_Matrix_Matrix_Product_IKJ (Dimension4, GLfloat, Float_Matrix4);



   function "*" is new
     Generic_Quaternion_Quaternion_Hamilton_Product (Dimension4, GLfloat, Float_Vector4, 0.0);


   procedure Normalize is new
     Generic_Normalize (Dimension, GLfloat, Float_Vector, 0.0, 1.0, Elementary_Functions.Sqrt);

   -- | 1  0  0  0 |
   -- | 0  1  0  0 |
   -- | 0  0  1  0 |
   -- | 0  0  0  1 |
   function Identity is new
     Generic_Create_Matrix_Identidy (Dimension4, GLfloat, Float_Matrix4, 0.0, 1.0);

   -- | 1  0  0  0 |
   -- | 0  1  0  0 |
   -- | 0  0  1  0 |
   -- | 0  0  0  1 |
   function Identity is new
     Generic_Create_Matrix_Identidy (Dimension3, GLfloat, Float_Matrix3, 0.0, 1.0);

   -- | d  r  r  r |
   -- | r  d  r  r |
   -- | r  r  d  r |
   -- | r  r  r  d |
   procedure Make_Matrix_Diagonal is new
     Generic_Make_Matrix_Diagonal (Dimension, GLfloat, Float_Matrix);

   function Convert_Axis_Angle_To_Quaternion is new
     Generic_Axis_Quaternion_Conversion_Function (Dimension4, Dimension3, GLfloat, Float_Vector4, Float_Vector3, 2.0, Elementary_Functions.Sin, Elementary_Functions.Cos);

   -- Desc
   procedure Make_Perspective_Matrix is new
     Generic_Matrix_Perspective_Conversion (Dimension4, GLfloat, Float_Matrix4, 1.0, 2.0, Elementary_Functions.Tan);


   -- A^T x + x -> x
   procedure Product_Transpose_Accumulate is new
     Generic_Constrianed_Square_Matrix_Vector_Transpose_Product_Accumulate
       (Dimension4, GLfloat, Float_Matrix4, Float_Vector4);

   -- A^T x = y
   function Product_Transpose is new
     Generic_Matrix_T1_Vector_Product (Dimension, GLfloat, Float_Matrix, Float_Vector, 0.0);


   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   procedure Make_Translation_Matrix is new
     Generic_Vector_Matrix_Translation_Conversion (Dimension4, GLfloat, Float_Vector4, Float_Matrix4);

   -- f : R^4 -> R^(4x4)
   procedure Make_Rotation_Matrix is new
     Generic_Quaternion_Matrix_4_Conversion (Dimension4, GLfloat, Float_Vector4, Float_Matrix4, 2.0);

   -- f : R^4 -> R^(4x4)
   function Make_Rotation_Matrix4 is new
     Generic_Quaternion_Matrix4_Conversion_Function (Dimension4, GLfloat, Float_Vector4, Float_Matrix4);

   -- f : R^4 -> R^(3x3)
   function Make_Rotation_Matrix3 is new
     Generic_Quaternion_Matrix3_Conversion_Function (Dimension3, Dimension4, GLfloat, Float_Vector4, Float_Matrix3);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Matrix_NxN (Dimension4, GLfloat, Float_Matrix4);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Matrix_NxN (Dimension3, GLfloat, Float_Matrix3);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Vector_N (Dimension4, GLfloat, Float_Vector4);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Vector_N (Dimension3, GLfloat, Float_Vector3);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Unconstrained_Matrix_NxN (Dimension, GLfloat, Float_Matrix);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Unconstrained_Vector_N (Dimension, GLfloat, Float_Vector);

end;
