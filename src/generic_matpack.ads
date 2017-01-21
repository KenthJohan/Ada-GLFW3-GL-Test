package Generic_Matpack is

   generic
      type Index is (<>);
      type Element is private;
      type Vector is array (Index range <>) of Element;
      type Matrix is array (Index range <>, Index range <>) of Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
   procedure Matrix_T0_Vector_Product (Left : Matrix; Right : Vector; Result : in out Vector);

   generic
      type Index is (<>);
      type Element is private;
      type Matrix is array (Index range <>, Index range <>) of Element;
      type Vector is array (Index range <>) of Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
   procedure Matrix_T1_Vector_Product (Left : Matrix; Right : Vector; Result : in out Vector);

   generic
      type Index is (<>);
      type Element is private;
      type Matrix is array (Index range <>, Index range <>) of Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
   procedure Matrix_Matrix_Product_Accumulate_IJK (Left : Matrix; Right : Matrix; Result : in out Matrix);

   generic
      type Index is (<>);
      type Element is private;
      type Matrix is array (Index range <>, Index range <>) of Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
   procedure Matrix_Matrix_Product_Accumulate_IKJ (Left : Matrix; Right : Matrix; Result : in out Matrix);

   generic
      type Index is (<>);
      type Element is private;
      type Matrix is array (Index range <>, Index range <>) of Element;
      Zero : Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
   function Matrix_Matrix_Product_IJK (Left : Matrix; Right : Matrix) return Matrix;

   generic
      type Index is (<>);
      type Element is private;
      type Matrix is array (Index range <>, Index range <>) of Element;
      Zero : Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
   function Matrix_Matrix_Product_IKJ (Left : Matrix; Right : Matrix) return Matrix;

end;
