with Generic_Vectors;
with Ada.Text_IO; use Ada.Text_IO;


procedure Dev_Vector_Test is

   type Fruit is record
      Price : Float;
      Weight : Float;
   end record;

   package Fruit_Vectors is new Generic_Vectors (Fruit);
   subtype Fruit_Vector is Fruit_Vectors.Vector;

   V : Fruit_Vector (4);

begin

   V.Append ((1.0, 1.0));
   V.Append ((2.0, 1.0));
   --V.Append ((2.0, 1.0));
   --V.Append ((5.0, 1.0));

   for E of V loop
      E.Price := E.Price + 0.1;
      Put_Line ("Price " & E.Price'Img);
      --Put_Line ("Price " & E.Weight'Img);
   end loop;


--     for I in V.Iterate loop
--        declare
--           E : Fruit renames V (I);
--        begin
--           Put_Line ("Price " & E.Price'Img);
--           Put_Line ("Price " & E.Weight'Img);
--        end;
--     end loop;


end;
