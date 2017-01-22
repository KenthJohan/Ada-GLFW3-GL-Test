with GL.C;
with GL.Math;
with Generic_Matpack;
with Generic_Matpack.Projections;
with Generic_Matpack.Quaternions;

package Maths is

   use GL.C;
   use GL.Math;
   use type GL.C.GLfloat;

   function Convert_Axis_Angle_To_Quaternion is new Generic_Matpack.Quaternions.Axis_Quaternion_Conversion_Function (Dimension_4, Dimension_3, GLfloat, Vector_4, Vector_3, 2.0, Elementary_Functions.Sin, Elementary_Functions.Cos);
   function "*" is new Generic_Matpack.Quaternions.Quaternion_Quaternion_Hamilton_Product (Dimension_4, GLfloat, Vector_4, 0.0);
   procedure Normalize is new Generic_Matpack.Normalize (Dimension, GLfloat, Vector, 0.0, 1.0, Elementary_Functions.Sqrt);
   procedure Make_Matrix_Identity is new Generic_Matpack.Make_Matrix_Identity (Dimension, GLfloat, Matrix, 0.0, 1.0);
   procedure Make_Perspective_Matrix is new Generic_Matpack.Projections.Matrix_Perspective_Conversion (Dimension_4, GLfloat, Matrix_4, 1.0, 2.0, Elementary_Functions.Tan);
   function "*" is new Generic_Matpack.Matrix_Matrix_Product_IKJ (Dimension, GLfloat, Matrix, 0.0);
   procedure Mul_T1 is new Generic_Matpack.Matrix_T1_Vector_Product (Dimension, GLfloat, Matrix, Vector);
   procedure Make_Translation_Matrix is new Generic_Matpack.Projections.Vector_Matrix_Translation_Conversion (Dimension_4, GLfloat, Vector_4, Matrix_4);
   procedure Make_Rotation_Matrix is new Generic_Matpack.Quaternions.Quaternion_Matrix_4_Conversion (Dimension_4, GLfloat, Vector_4, Matrix_4, 2.0);
   procedure Put is new Generic_Matpack.Put (Dimension, GLfloat, Matrix);

end;
