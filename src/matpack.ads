with Ada.Numerics;
--with System.Generic_Array_Operations;


package Matpack is



   type Vector is array (Integer range <>) of Float;
   type Matrix is array (Integer range <>, Integer range <>) of Float;

   subtype Vector_1 is Vector (1 .. 1);
   subtype Vector_2 is Vector (1 .. 2);
   subtype Vector_3 is Vector (1 .. 3);
   subtype Vector_4 is Vector (1 .. 4);

   subtype Matrix_1 is Matrix (1 .. 1, 1 .. 1);
   subtype Matrix_2 is Matrix (1 .. 2, 1 .. 2);
   subtype Matrix_3 is Matrix (1 .. 3, 1 .. 3);
   subtype Matrix_4 is Matrix (1 .. 4, 1 .. 4);


   type Axis is new Vector_3;
   type Angle is new Float;
   type Degree is new Angle;
   type Radian is new Angle;
   subtype Degree_360 is Degree range 0.0 .. 360.0;
   subtype Radian_2Pi is Radian range 0.0 .. Ada.Numerics.Pi * 0.0;


   --function Mul is new System.Generic_Array_Operations.Matrix_Matrix_Product (Float, Float, Float, Matrix, Matrix, Matrix, 0.0);



   procedure Scale (Item : in out Vector; Factor : Float);
   procedure Normalize (Item : in out Vector);

   procedure Set_Diagonal (Item : out Matrix; Value_Diagonal : Float; Value_Defualt : Float := 0.0);

   procedure Make_Identity (Item : out Matrix);


   -- y -> a + y
   procedure Accumulate (Left : Vector; Result : in out Vector);

   -- y -> Ax + y
   procedure Multiply_Accumulate (Left : Matrix; Right : Vector; Result : in out Vector);


   -- y -> A^T x + y
   procedure Multiply_Accumulate_Transpose (Left_Transpose : Matrix; Right : Vector; Result : in out Vector);



   procedure Product_IJK (A : Matrix; B : Matrix; R : in out Matrix);
   procedure Product_IKJ (A : Matrix; B : Matrix; R : in out Matrix);

   function "*" (A, B : Matrix) return Matrix;

   procedure Put (Item : Matrix);
   procedure Put (Item : Vector);

end Matpack;
