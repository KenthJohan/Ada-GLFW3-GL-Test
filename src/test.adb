with Maths;
with Ada.Text_IO;

procedure Test is
   use Maths;

   Left1 : Matrix_CR_4 := Unit;
   Right1 : Matrix_CR_4 := Unit;
   R1 : Matrix_CR_4 := (others => (others => 0.0));

   Left2 : Matrix_RC_4 := Unit;
   Right2 : Matrix_RC_4 := Unit;
   R2 : Matrix_RC_4 := (others => (others => 0.0));
begin

   Left1 (4, 4) := 0.0;
   Left1 (3, 4) := -1.0;
   Right1 (4, 3) := 3.0;

   Product (Left1, Right1, R1);
   --R := Left * Right;

   Put (Matrix_CR (Left1));
   Ada.Text_IO.New_Line;
   Put (Matrix_CR (Right1));
   Ada.Text_IO.New_Line;
   Put (Matrix_CR (R1));

   Ada.Text_IO.New_Line (3);



   Left2 (4, 4) := 0.0;
   Left2 (4, 3) := -1.0;
   Right2 (3, 4) := 3.0;

   Product (Left2, Right2, R2);
   --R := Left * Right;

   Put (Matrix_RC (Left2));
   Ada.Text_IO.New_Line;
   Put (Matrix_RC (Right2));
   Ada.Text_IO.New_Line;
   Put (Matrix_RC (R2));

end;
