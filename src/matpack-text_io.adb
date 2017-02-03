with Ada.Text_IO;

package body Matpack.Text_IO is

   procedure Generic_Put_Constrained_Matrix_NxN (Item : Matrix) is
      package IO is new Ada.Text_IO.Float_IO (Element);
      use IO;
      use Ada.Text_IO;
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (1) loop
            Put (Item (J, I), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Generic_Put_Constrained_Vector_N (Item : Vector) is
      package IO is new Ada.Text_IO.Float_IO (Element);
      use IO;
      use Ada.Text_IO;
   begin
      for E of Item loop
         Put (E, 3, 3, 0);
      end loop;
   end;

   procedure Generic_Put_Constrained_Matrix_MxN (Item : Matrix) is
      package IO is new Ada.Text_IO.Float_IO (Element);
      use IO;
      use Ada.Text_IO;
   begin
      for I in Index_M loop
         for J in Index_N loop
            Put (Item (J, I), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Generic_Put_Unconstrained_Matrix_NxN (Item : Matrix) is
      package IO is new Ada.Text_IO.Float_IO (Element);
      use IO;
      use Ada.Text_IO;
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (1) loop
            Put (Item (J, I), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Generic_Put_Unconstrained_Vector_N (Item : Vector) is
      package IO is new Ada.Text_IO.Float_IO (Element);
      use IO;
      use Ada.Text_IO;
   begin
      for E of Item loop
         Put (E, 3, 3, 0);
      end loop;
   end;

end;
