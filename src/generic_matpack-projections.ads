package Generic_Matpack.Projections is

   generic
      type Index_4 is (<>);
      type Element is private;
      type Translation_Vector_4 is array (Index_4) of Element;
      type Translation_Matrix_4 is array (Index_4, Index_4) of Element;
   procedure Vector_Matrix_Translation_Conversion (Item : Translation_Vector_4; Result : out Translation_Matrix_4);

end;
