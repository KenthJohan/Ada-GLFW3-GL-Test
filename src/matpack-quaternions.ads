package Matpack.Quaternions is

   type Quaternion is new Vector_4;
   function Quaternion_Unit return Quaternion is (1.0, 0.0, 0.0, 0.0);

   procedure Hamilton_Product (Left, Right : Quaternion; Result : out Quaternion);
   function Hamilton_Product (Left, Right : Quaternion) return Quaternion ;

   procedure Quaternion_To_Matrix_4 (Item : Quaternion; Result : out Matrix_4);

   procedure Convert_Axis_Angle_To_Quaterion (Revolve_Axis : Axis; Amount : Radian; Result : out Quaternion);
   function Convert_Axis_Angle_To_Quaterion (A : Axis; Amount : Radian) return Quaternion;

end;
