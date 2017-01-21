package body Generic_Matpack.Quaternions is


   procedure Quaternion_Quaternion_Hamilton_Product_Procedure (Left, Right : Quaternion; Result : out Quaternion) is
      --Left_Q1 : Element renames Left (Left'First);
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

   function Quaternion_Quaternion_Hamilton_Product (Left, Right : Quaternion) return Quaternion is
      procedure Hamilton_Product is new Quaternion_Quaternion_Hamilton_Product_Procedure (Index, Element, Quaternion, "*", "+", "-");
      Result : Quaternion := (others => Zero);
   begin
      Hamilton_Product (Left, Right, Result);
      Return Result;
   end;

   procedure Quaternion_Matrix_4_Conversion (Item : Quaternion; Result : out Matrix_4) is
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

   procedure Axis_Quaternion_Conversion_Procedure (Item : Axis; Amount : Element; Result : out Quaternion) is
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

   function Axis_Quaternion_Conversion_Function (Item : Axis; Amount : Element) return Quaternion is
      procedure Convert is new Axis_Quaternion_Conversion_Procedure (Quaternion_Index, Axis_Index, Element, Quaternion, Axis, Two, Sin, Cos, "*", "/");
      R : Quaternion;
   begin
      Convert (Item, Amount, R);
      return R;
   end;

end;
