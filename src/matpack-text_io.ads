package Matpack.Text_IO is

   generic
      type Index is (<>);
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
   procedure Generic_Put_Constrained_Matrix_NxN (Item : Matrix);

   generic
      type Index_M is (<>);
      type Index_N is (<>);
      type Element is digits <>;
      type Matrix is array (Index_N, Index_M) of Element;
   procedure Generic_Put_Constrained_Matrix_MxN (Item : Matrix);

   generic
      type Index is (<>);
      type Element is digits <>;
      type Vector is array (Index) of Element;
   procedure Generic_Put_Constrained_Vector_N (Item : Vector);

   generic
      type Index is (<>);
      type Element is digits <>;
      type Matrix is array (Index range <>, Index range <>) of Element;
   procedure Generic_Put_Unconstrained_Matrix_NxN (Item : Matrix);

   generic
      type Index is (<>);
      type Element is digits <>;
      type Vector is array (Index range <>) of Element;
   procedure Generic_Put_Unconstrained_Vector_N (Item : Vector);

end;
