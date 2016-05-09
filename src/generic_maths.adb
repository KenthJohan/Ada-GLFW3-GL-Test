with Ada.Numerics.Generic_Elementary_Functions;

package body Generic_Maths is

   function Generic_Length2_Unconstrained (Item : Vector) return Element is
      Result : Element := 0.0;
   begin
      for E of Item loop
         Result := Result + (E ** 2);
      end loop;
      return Result;
   end;

   function Generic_Length2_Constrained (Item : Vector) return Element is
      Result : Element := 0.0;
   begin
      for E of Item loop
         Result := Result + (E ** 2);
      end loop;
      return Result;
   end;

   function Generic_Length_Unconstrained (Item : Vector) return Element is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Element);
      use Elementary_Functions;
      function Length2 is new Generic_Length2_Unconstrained (Index, Element, Vector);
   begin
      return Sqrt (Length2 (Item));
   end;

   function Generic_Length_Constrained (Item : Vector) return Element is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Element);
      use Elementary_Functions;
      function Length2 is new Generic_Length2_Constrained (Index, Element, Vector);
   begin
      return Sqrt (Length2 (Item));
   end;



   procedure Generic_Scale_Constrained (Item : in out Vector; Factor : Element) is
   begin
      for E of Item loop
         E := Factor * E;
      end loop;
   end;

   procedure Generic_Scale_Unconstrained (Item : in out Vector; Factor : Element) is
   begin
      for E of Item loop
         E := Factor * E;
      end loop;
   end;



   procedure Generic_Normalize_Unconstrained (Item : in out Vector) is
      function Length is new Generic_Length_Unconstrained (Index, Element, Vector);
      procedure Scale is new Generic_Scale_Unconstrained (Index, Element, Vector);
      Factor : constant Element := Length (Item);
   begin
      Scale (Item, 1.0 / Factor);
   end;

   procedure Generic_Normalize_Constrained (Item : in out Vector) is
      function Length is new Generic_Length_Constrained (Index, Element, Vector);
      procedure Scale is new Generic_Scale_Constrained (Index, Element, Vector);
      Factor : constant Element := Length (Item);
   begin
      Scale (Item, 1.0 / Factor);
   end;

   procedure Generic_Set_Diagonal_Square_Matrix_Unconstrained (Item : in out Matrix; Value : Element) is
   begin
      for I in Item'Range (1) loop
         Item (I, I) := Value;
      end loop;
   end;

   procedure Generic_Set_Diagonal_Square_Matrix_Constrained (Item : in out Matrix; Value : Element) is
   begin
      for I in Index loop
         Item (I, I) := Value;
      end loop;
   end;

   function Generic_Create_Unit_Matrix_Constrained return Matrix is
      procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Constrained (Index, Element, Matrix);
      Result : Matrix := (others => (others => 0.0));
   begin
      Set_Diagonal (Result, 1.0);
      return Result;
   end;


   procedure Generic_Matrix_Product_IJ_RC_Constrained (Left, Right : Matrix; I, J : Index; Result : out Matrix) is
   begin
      for K in Left'Range (1) loop
         Result (I, J) := Left (I, K) * Right (K, J);
      end loop;
   end;

   procedure Generic_Matrix_Product_IJ_CR_Constrained (Left, Right : Matrix; I, J : Index; Result : out Matrix) is
   begin
      for K in Left'Range (1) loop
         Result (I, J) := Left (K, I) * Right (J, K);
      end loop;
   end;

   procedure Generic_Matrix_Product_RC_Constrained (Left, Right : Matrix; Result : out Matrix) is
      procedure Product_IJ is new Generic_Matrix_Product_IJ_RC_Constrained (Index, Element, Matrix);
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            Product_IJ (Left, Right, I, J, Result);
         end loop;
      end loop;
   end;

   procedure Generic_Matrix_Product_CR_Constrained (Left, Right : Matrix; Result : out Matrix) is
      procedure Product_IJ is new Generic_Matrix_Product_IJ_CR_Constrained (Index, Element, Matrix);
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            Product_IJ (Left, Right, I, J, Result);
         end loop;
      end loop;
   end;

   function Generic_Matrix_Create_Product_RC_Constrained (Left, Right : Matrix) return Matrix is
      procedure Product is new Generic_Matrix_Product_RC_Constrained (Index, Element, Matrix);
      Result : Matrix;
   begin
      Product (Left, Right, Result);
      return Result;
   end;

   function Generic_Matrix_Create_Product_CR_Constrained (Left, Right : Matrix) return Matrix is
      procedure Product is new Generic_Matrix_Product_CR_Constrained (Index, Element, Matrix);
      Result : Matrix;
   begin
      Product (Left, Right, Result);
      return Result;
   end;



end;
