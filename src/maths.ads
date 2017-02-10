with GL.Math;
with Home_Mathematics;
with Home_Mathematics.Projections;
with Home_Mathematics.Quaternions;
with Home_Mathematics.Text_IO;
with Home_Mathematics.Products;
with Home_Mathematics.Additions;

package Maths is

   use GL.Math;
   use Home_Mathematics;
   use Home_Mathematics.Projections;
   use Home_Mathematics.Quaternions;
   use Home_Mathematics.Text_IO;
   use Home_Mathematics.Additions;
   use Home_Mathematics.Products;

   use type GL.Math.Real_Float;

   function "+" is new
     Generic_Constrained_Vector_Vector_Addition (Dimension3, Real_Float, Real_Float_Vector3);

   function "*" is new
     Generic_Constrained_Square_Matrix_Vector_Product (Dimension3, Real_Float, Real_Float_Matrix3, Real_Float_Vector3);

   function "*" is new
     Generic_Constrained_Square_Matrix_Matrix_Product_IKJ (Dimension4, Real_Float, Real_Float_Matrix4);



   function "*" is new
     Generic_Quaternion_Quaternion_Hamilton_Product (Dimension4, Real_Float, Real_Float_Vector4, 0.0);


   procedure Normalize is new
     Generic_Normalize (Dimension, Real_Float, Real_Float_Vector, 0.0, 1.0, Elementary_Functions.Sqrt);

   -- | 1  0  0  0 |
   -- | 0  1  0  0 |
   -- | 0  0  1  0 |
   -- | 0  0  0  1 |
   function Identity is new
     Generic_Create_Matrix_Identidy (Dimension4, Real_Float, Real_Float_Matrix4, 0.0, 1.0);

   -- | 1  0  0  0 |
   -- | 0  1  0  0 |
   -- | 0  0  1  0 |
   -- | 0  0  0  1 |
   function Identity is new
     Generic_Create_Matrix_Identidy (Dimension3, Real_Float, Real_Float_Matrix3, 0.0, 1.0);

   -- | d  r  r  r |
   -- | r  d  r  r |
   -- | r  r  d  r |
   -- | r  r  r  d |
   procedure Make_Matrix_Diagonal is new
     Generic_Make_Matrix_Diagonal (Dimension, Real_Float, Real_Float_Matrix);

   function Convert_Axis_Angle_To_Quaternion is new
     Generic_Axis_Quaternion_Conversion_Function (Dimension4, Dimension3, Real_Float, Real_Float_Vector4, Real_Float_Vector3, 2.0, Elementary_Functions.Sin, Elementary_Functions.Cos);

   -- Desc
   procedure Make_Perspective_Matrix is new
     Generic_Matrix_Perspective_Conversion (Dimension4, Real_Float, Real_Float_Matrix4, 1.0, 2.0, Elementary_Functions.Tan);


   -- A^T x + x -> x
   procedure Product_Transpose_Accumulate is new
     Generic_Constrianed_Square_Matrix_Vector_Transpose_Product_Accumulate
       (Dimension4, Real_Float, Real_Float_Matrix4, Real_Float_Vector4);

   -- A^T x = y
   function Product_Transpose is new
     Generic_Matrix_T1_Vector_Product (Dimension, Real_Float, Real_Float_Matrix, Real_Float_Vector, 0.0);


   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   procedure Make_Translation_Matrix is new
     Generic_Vector_Matrix_Translation_Conversion (Dimension4, Real_Float, Real_Float_Vector4, Real_Float_Matrix4);

   -- f : R^4 -> R^(4x4)
   procedure Make_Rotation_Matrix is new
     Generic_Quaternion_Matrix_4_Conversion (Dimension4, Real_Float, Real_Float_Vector4, Real_Float_Matrix4, 2.0);

   -- f : R^4 -> R^(4x4)
   function Make_Rotation_Matrix4 is new
     Generic_Quaternion_Matrix4_Conversion_Function (Dimension4, Real_Float, Real_Float_Vector4, Real_Float_Matrix4);

   -- f : R^4 -> R^(3x3)
   function Make_Rotation_Matrix3 is new
     Generic_Quaternion_Matrix3_Conversion_Function (Dimension3, Dimension4, Real_Float, Real_Float_Vector4, Real_Float_Matrix3);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Square_Matrix (Dimension4, Real_Float, Real_Float_Matrix4);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Square_Matrix (Dimension3, Real_Float, Real_Float_Matrix3);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Vector (Dimension4, Real_Float, Real_Float_Vector4);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Constrained_Vector (Dimension3, Real_Float, Real_Float_Vector3);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Unconstrained_Matrix (Dimension, Real_Float, Real_Float_Matrix);

   procedure Put is new
     Home_Mathematics.Text_IO.Generic_Put_Unconstrained_Vector (Dimension, Real_Float, Real_Float_Vector);

end;
