with Ada.Text_IO;
with Matpack;

procedure Dev_Mat is

   use Matpack;
   use Ada.Text_IO;

   A : Matrix_2 := ((1.0, 2.0), (3.0, 4.0));
   X : Vector_2 := (2.0, 4.0);
   R : Vector_2 := (others => 0.0);

begin

   Put (A);
   New_Line;
   Put (X);

   New_Line(2);

   Multiply_Accumulate (A, X, R);

   Put (R);
   New_Line;

end;
