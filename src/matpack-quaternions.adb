with Ada.Numerics.Generic_Elementary_Functions;

package body Matpack.Quaternions is

   procedure Convert_Axis_Angle_To_Quaterion (Revolve_Axis : Axis; Amount : Radian; Result : out Quaternion) is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
      use Elementary_Functions;
      Sin_Factor : constant Float := Sin (Float (Amount) / 2.0);
   begin
      Result (1) := Cos (Float (Amount) / 2.0);
      Result (2) := Revolve_Axis (1) * Sin_Factor;
      Result (3) := Revolve_Axis (2) * Sin_Factor;
      Result (4) := Revolve_Axis (3) * Sin_Factor;
   end;

   function Convert_Axis_Angle_To_Quaterion (A : Axis; Amount : Radian) return Quaternion is
      Q : Quaternion;
   begin
      Convert_Axis_Angle_To_Quaterion (A, Amount, Q);
      return Q;
   end;

   procedure Hamilton_Product (Left, Right : Quaternion; Result : out Quaternion) is
   begin
      Result (1) := (Left (1) * Right (1)) - (Left (2) * Right (2)) - (Left (3) * Right (3)) - (Left (4) * Right (4));
      Result (2) := (Left (1) * Right (2)) + (Left (2) * Right (1)) + (Left (3) * Right (4)) - (Left (4) * Right (3));
      Result (3) := (Left (1) * Right (3)) - (Left (2) * Right (4)) + (Left (3) * Right (1)) + (Left (4) * Right (2));
      Result (4) := (Left (1) * Right (4)) + (Left (2) * Right (3)) - (Left (3) * Right (2)) + (Left (4) * Right (1));
   end;

   procedure Quaternion_To_Matrix_4 (Item : Quaternion; Result : out Matrix_4) is
   begin
      Result (1, 1) := (Item (1) ** 2) + (Item (2) ** 2) - (Item (3) ** 2) - (Item (4) ** 2);
      Result (2, 2) := (Item (1) ** 2) - (Item (2) ** 2) + (Item (3) ** 2) - (Item (4) ** 2);
      Result (3, 3) := (Item (1) ** 2) - (Item (2) ** 2) - (Item (3) ** 2) + (Item (4) ** 2);
      Result (1, 2) := (2.0 * Item (2) * Item (3)) - (2.0 * Item (1) * Item (4));
      Result (2, 1) := (2.0 * Item (2) * Item (3)) + (2.0 * Item (1) * Item (4));
      Result (1, 3) := (2.0 * Item (2) * Item (4)) + (2.0 * Item (1) * Item (3));
      Result (3, 1) := (2.0 * Item (2) * Item (4)) - (2.0 * Item (1) * Item (3));
      Result (2, 3) := (2.0 * Item (3) * Item (4)) - (2.0 * Item (1) * Item (2));
      Result (3, 2) := (2.0 * Item (3) * Item (4)) + (2.0 * Item (1) * Item (2));
   end;

   function Hamilton_Product (Left, Right : Quaternion) return Quaternion is
      Result : Quaternion;
   begin
      Hamilton_Product (Left, Right, Result);
      return Result;
   end;

end;
