package Matpack.Projections is


   generic
      type Index_4 is (<>);
      type Element is private;
      type Perspective_Matrix_4 is array (Index_4, Index_4) of Element;
      One : Element;
      Two : Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "/" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element) return Element is <>;
   procedure Generic_Matrix_Frustum_Conversion (Left, Right, Bottom, Top, Near, Far : Element; Result : out Perspective_Matrix_4);

   generic
      type Index_4 is (<>);
      type Element is private;
      type Perspective_Matrix_4 is array (Index_4, Index_4) of Element;
      One : Element;
      Two : Element;
      with function Tan (Left : Element) return Element is <>;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "/" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element) return Element is <>;
   procedure Generic_Matrix_Perspective_Conversion (Field_Of_View, Aspect, Near, Far : Element; Result : in out Perspective_Matrix_4);


   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   generic
      type Index_4 is (<>);
      type Element is private;
      type Translation_Vector_4 is array (Index_4) of Element;
      type Translation_Matrix_4 is array (Index_4, Index_4) of Element;
   procedure Generic_Vector_Matrix_Translation_Conversion (Item : Translation_Vector_4; Result : out Translation_Matrix_4);

end;
