package body Matpack.Quaternions is


   procedure Generic_Quaternion_Quaternion_Hamilton_Product_Procedure (Left, Right : Quaternion; Result : out Quaternion) is
      --Left_Q (I1) : Element renames Left (Left'First);
      I1 : constant Index := Index'First;
      I2 : constant Index := Index'Succ (Index'First);
      I3 : constant Index := Index'Succ (Index'Succ (Index'First));
      I4 : constant Index := Index'Succ (Index'Succ (Index'Succ (Index'First)));
   begin
      Result (I1) := (Left (I1) * Right (I1)) - (Left (I2) * Right (I2)) - (Left (I3) * Right (I3)) - (Left (I4) * Right (I4));
      Result (I2) := (Left (I1) * Right (I2)) + (Left (I2) * Right (I1)) + (Left (I3) * Right (I4)) - (Left (I4) * Right (I3));
      Result (I3) := (Left (I1) * Right (I3)) - (Left (I2) * Right (I4)) + (Left (I3) * Right (I1)) + (Left (I4) * Right (I2));
      Result (I4) := (Left (I1) * Right (I4)) + (Left (I2) * Right (I3)) - (Left (I3) * Right (I2)) + (Left (I4) * Right (I1));
   end;

   function Generic_Quaternion_Quaternion_Hamilton_Product (Left, Right : Quaternion) return Quaternion is
      procedure Hamilton_Product is new Generic_Quaternion_Quaternion_Hamilton_Product_Procedure (Index, Element, Quaternion, "*", "+", "-");
      Result : Quaternion := (others => Zero);
   begin
      Hamilton_Product (Left, Right, Result);
      Return Result;
   end;

   procedure Generic_Quaternion_Matrix_4_Conversion (Item : Quaternion; Result : out Matrix_4) is
      I1 : constant Index := Index'First;
      I2 : constant Index := Index'Succ (Index'First);
      I3 : constant Index := Index'Succ (Index'Succ (Index'First));
      I4 : constant Index := Index'Succ (Index'Succ (Index'Succ (Index'First)));
   begin
      Result (I1, I1) := (Item (I1) ** 2) + (Item (I2) ** 2) - (Item (I3) ** 2) - (Item (I4) ** 2);
      Result (I2, I2) := (Item (I1) ** 2) - (Item (I2) ** 2) + (Item (I3) ** 2) - (Item (I4) ** 2);
      Result (I3, I3) := (Item (I1) ** 2) - (Item (I2) ** 2) - (Item (I3) ** 2) + (Item (I4) ** 2);
      Result (I1, I2) := (Two * Item (I2) * Item (I3)) - (Two * Item (I1) * Item (I4));
      Result (I2, I1) := (Two * Item (I2) * Item (I3)) + (Two * Item (I1) * Item (I4));
      Result (I1, I3) := (Two * Item (I2) * Item (I4)) + (Two * Item (I1) * Item (I3));
      Result (I3, I1) := (Two * Item (I2) * Item (I4)) - (Two * Item (I1) * Item (I3));
      Result (I2, I3) := (Two * Item (I3) * Item (I4)) - (Two * Item (I1) * Item (I2));
      Result (I3, I2) := (Two * Item (I3) * Item (I4)) + (Two * Item (I1) * Item (I2));
   end;

   function Generic_Quaternion_Matrix4_Conversion_Function (Q : Quaternion) return Matrix4 is
      I1 : constant Index := Index'First + 0;
      I2 : constant Index := Index'First + 1;
      I3 : constant Index := Index'First + 2;
      I4 : constant Index := Index'First + 3;
      R : Matrix4 := (others => (others => 0.0));
   begin
      R (I1, I1) := (Q (I1) ** 2) + (Q (I2) ** 2) - (Q (I3) ** 2) - (Q (I4) ** 2);
      R (I2, I2) := (Q (I1) ** 2) - (Q (I2) ** 2) + (Q (I3) ** 2) - (Q (I4) ** 2);
      R (I3, I3) := (Q (I1) ** 2) - (Q (I2) ** 2) - (Q (I3) ** 2) + (Q (I4) ** 2);
      R (I1, I2) := (2.0 * Q (I2) * Q (I3)) - (2.0 * Q (I1) * Q (I4));
      R (I2, I1) := (2.0 * Q (I2) * Q (I3)) + (2.0 * Q (I1) * Q (I4));
      R (I1, I3) := (2.0 * Q (I2) * Q (I4)) + (2.0 * Q (I1) * Q (I3));
      R (I3, I1) := (2.0 * Q (I2) * Q (I4)) - (2.0 * Q (I1) * Q (I3));
      R (I2, I3) := (2.0 * Q (I3) * Q (I4)) - (2.0 * Q (I1) * Q (I2));
      R (I3, I2) := (2.0 * Q (I3) * Q (I4)) + (2.0 * Q (I1) * Q (I2));
      R (I4, I4) := 1.0;
      return R;
   end;

   function Generic_Quaternion_Matrix3_Conversion_Function (Q : Quaternion) return Matrix3 is
      R1 : constant Matrix3_Index := Matrix3_Index'First + 0;
      R2 : constant Matrix3_Index := Matrix3_Index'First + 1;
      R3 : constant Matrix3_Index := Matrix3_Index'First + 2;
      Q1 : constant Quaternion_Index := Quaternion_Index'First + 0;
      Q2 : constant Quaternion_Index := Quaternion_Index'First + 1;
      Q3 : constant Quaternion_Index := Quaternion_Index'First + 2;
      Q4 : constant Quaternion_Index := Quaternion_Index'First + 3;
      R : Matrix3;
   begin
      R (R1, R1) := (Q (Q1) ** 2) + (Q (Q2) ** 2) - (Q (Q3) ** 2) - (Q (Q4) ** 2);
      R (R2, R2) := (Q (Q1) ** 2) - (Q (Q2) ** 2) + (Q (Q3) ** 2) - (Q (Q4) ** 2);
      R (R3, R3) := (Q (Q1) ** 2) - (Q (Q2) ** 2) - (Q (Q3) ** 2) + (Q (Q4) ** 2);
      R (R1, R2) := (2.0 * Q (Q2) * Q (Q3)) - (2.0 * Q (Q1) * Q (Q4));
      R (R2, R1) := (2.0 * Q (Q2) * Q (Q3)) + (2.0 * Q (Q1) * Q (Q4));
      R (R1, R3) := (2.0 * Q (Q2) * Q (Q4)) + (2.0 * Q (Q1) * Q (Q3));
      R (R3, R1) := (2.0 * Q (Q2) * Q (Q4)) - (2.0 * Q (Q1) * Q (Q3));
      R (R2, R3) := (2.0 * Q (Q3) * Q (Q4)) - (2.0 * Q (Q1) * Q (Q2));
      R (R3, R2) := (2.0 * Q (Q3) * Q (Q4)) + (2.0 * Q (Q1) * Q (Q2));
      return R;
   end;

   procedure Generic_Axis_Quaternion_Conversion_Procedure (Item : Axis; Amount : Element; Result : out Quaternion) is
      R1 : Element renames Result (Quaternion'First);
      R2 : Element renames Result (Quaternion_Index'Succ (Quaternion'First));
      R3 : Element renames Result (Quaternion_Index'Succ (Quaternion_Index'Succ (Quaternion'First)));
      R4 : Element renames Result (Quaternion_Index'Succ (Quaternion_Index'Succ (Quaternion_Index'Succ (Quaternion'First))));
      A1 : Element renames Item (Item'First);
      A2 : Element renames Item (Axis_Index'Succ (Item'First));
      A3 : Element renames Item (Axis_Index'Succ (Axis_Index'Succ (Item'First)));
      Sin_Factor : constant Element := Sin (Amount / Two);
   begin
      R1 := Cos (Amount / Two);
      R2 := A1 * Sin_Factor;
      R3 := A2 * Sin_Factor;
      R4 := A3 * Sin_Factor;
   end;

   function Generic_Axis_Quaternion_Conversion_Function (Item : Axis; Amount : Element) return Quaternion is
      procedure Convert is new Generic_Axis_Quaternion_Conversion_Procedure (Quaternion_Index, Axis_Index, Element, Quaternion, Axis, Two, Sin, Cos, "*", "/");
      R : Quaternion;
   begin
      Convert (Item, Amount, R);
      return R;
   end;

end;
