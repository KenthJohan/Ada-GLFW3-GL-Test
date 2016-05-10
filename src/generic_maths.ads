package Generic_Maths is

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index range <>) of Element;
   function Generic_Length2_Unconstrained (Item : Vector) return Element;

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index) of Element;
   function Generic_Length2_Constrained (Item : Vector) return Element;

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index range <>) of Element;
   function Generic_Length_Unconstrained (Item : Vector) return Element;

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index) of Element;
   function Generic_Length_Constrained (Item : Vector) return Element;

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index range <>) of Element;
   procedure Generic_Scale_Unconstrained (Item : in out Vector; Factor : Element);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index) of Element;
   procedure Generic_Scale_Constrained (Item : in out Vector; Factor : Element);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index range <>) of Element;
   procedure Generic_Normalize_Unconstrained (Item : in out Vector);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index) of Element;
   procedure Generic_Normalize_Constrained (Item : in out Vector);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index range <>, Index range <>) of Element;
   procedure Generic_Set_Diagonal_Square_Matrix_Unconstrained (Item : in out Matrix; Value : Element);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
   procedure Generic_Set_Diagonal_Square_Matrix_Constrained (Item : in out Matrix; Value : Element);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
   function Generic_Create_Unit_Matrix_Constrained return Matrix;








   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
      Swapped : Boolean;
   procedure Generic_Constrained_Square_Matrix_Multiply_Accumulate_IJ (Left, Right : Matrix; I, J : Index; Result : in out Matrix);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
      Swapped : Boolean;
   procedure Generic_Constrained_Square_Matrix_Multiply_Accumulate (Left, Right : Matrix; Result : in out Matrix);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
      Swapped : Boolean;
   function Generic_Constrained_Square_Matrix_Multiply (Left, Right : Matrix) return Matrix;








   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index range <>) of Element;
   procedure Generic_Vector_Add_Unconstrained (Left, Right : Vector; Result : out Vector);






   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index) of Element;
   procedure Generic_Vector_Add_Constrained (Left, Right : Vector; Result : out Vector);


end;
