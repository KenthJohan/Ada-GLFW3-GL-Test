with Ada.Numerics.Generic_Elementary_Functions;
--with Ada.Text_IO;

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
      null;
   end;

   procedure Generic_Normalize_Constrained (Item : in out Vector) is
      function Length is new Generic_Length_Constrained (Index, Element, Vector);
      procedure Scale is new Generic_Scale_Constrained (Index, Element, Vector);
      Factor : constant Element := Length (Item);
   begin
      Scale (Item, 1.0 / Factor);
      null;
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














   procedure Generic_Constrained_Square_Matrix_Multiply_Accumulate_IJ (Left, Right : Matrix; I, J : Index; Result : in out Matrix) is
   begin
      for K in Index loop
         if Swapped then
            Result (I, J) := Result (I, J) + Left (K, J) * Right (I, K);
         else
            Result (I, J) := Result (I, J) + Left (I, K) * Right (K, J);
         end if;
      end loop;
   end;

   procedure Generic_Constrained_Square_Matrix_Multiply_Accumulate (Left, Right : Matrix; Result : in out Matrix) is
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            for K in Index loop
               if Swapped then
                  Result (I, J) := Result (I, J) + Left (K, J) * Right (I, K);
               else
                  Result (I, J) := Result (I, J) + Left (I, K) * Right (K, J);
               end if;
            end loop;
         end loop;
      end loop;
   end;

   function Generic_Constrained_Square_Matrix_Multiply (Left, Right : Matrix) return Matrix is
      Result : Matrix := (others => (others => 0.0));
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            for K in Index loop
               if Swapped then
                  Result (I, J) := Result (I, J) + Left (K, J) * Right (I, K);
               else
                  Result (I, J) := Result (I, J) + Left (I, K) * Right (K, J);
               end if;
            end loop;
         end loop;
      end loop;
      return Result;
   end;


   procedure Generic_Unconstrained_Vector_Add (Left, Right : Vector; Result : out Vector) is
   begin
      for I in Result'Range loop
         Result (I) := Left (I) + Right (I);
      end loop;
   end;


   procedure Generic_Constrained_Vector_Add (Left, Right : Vector; Result : out Vector) is
   begin
      for I in Index loop
         Result (I) := Left (I) + Right (I);
      end loop;
   end;


   function Generic_Constrained_Vector_Add_Return (Left, Right : Vector) return Vector is
      Result : Vector;
   begin
      for I in Index loop
         Result (I) := Left (I) + Right (I);
      end loop;
      return Result;
   end;






   function Generic_Constrained_Vector_Vector_Hadamard_Product_Return (Left, Right : Vector) return Vector is
      Result : Vector;
   begin
      for I in Index loop
         Result (I) := Left (I) * Right (I);
      end loop;
      return Result;
   end;



   procedure Generic_Constrained_Scalar_Vector_Multiply_Accumulate (Left : Element; Right : Vector; Result : in out Vector) is
   begin
      for I in Index loop
         Result (I) := Result (I) + Left * Right (I);
      end loop;
   end;


   function Generic_Constrained_Vector_Matrix_Multiply_Return (Left : Vector; Right : Matrix) return Vector is
      Result : Vector := (others => 0.0);
   begin
      for I in Index loop
         for K in Index loop
            if Swapped then
               Result (I) := Result (I) + Left (K) * Right (I, K);
            else
               Result (I) := Result (I) + Left (K) * Right (K, I);
            end if;
         end loop;
      end loop;
      return Result;
   end;

   procedure Generic_Constrained_Vector_Matrix_Multiply_Accumulate (Left : Vector; Right : Matrix; Result : in out Vector) is
   begin
      for I in Index loop
         for K in Index loop
            if Swapped then
               Result (I) := Result (I) + Left (K) * Right (I, K);
            else
               Result (I) := Result (I) + Left (K) * Right (K, I);
            end if;
         end loop;
      end loop;
   end;


   function Generic_Constrained_Vector_Init_Return return Vector is
      Result : constant Vector := (others => Value);
   begin
      return Result;
   end;


   function Generic_Constrained_Vector_Init_Diagonal_Return return Matrix is
      Result : Matrix := (others => (others => 0.0));
   begin
      for I in Index loop
         Result (I, I) := Value;
      end loop;
      return Result;
   end;


end;
