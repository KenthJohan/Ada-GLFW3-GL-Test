package Matpack.Quaternions is

   generic
      type Index is (<>);
      type Element is private;
      type Quaternion is array (Index) of Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element; Right : Element) return Element is <>;
   procedure Generic_Quaternion_Quaternion_Hamilton_Product_Procedure (Left, Right : Quaternion; Result : out Quaternion);

   generic
      type Index is (<>);
      type Element is private;
      type Quaternion is array (Index) of Element;
      Zero : Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element; Right : Element) return Element is <>;
   function Generic_Quaternion_Quaternion_Hamilton_Product (Left, Right : Quaternion) return Quaternion;

   generic
      type Index is (<>);
      type Element is private;
      type Quaternion is array (Index) of Element;
      type Matrix_4 is array (Index, Index) of Element;
      Two : Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element; Right : Element) return Element is <>;
      with function "**" (Left : Element; Right : Integer) return Element is <>;
   procedure Generic_Quaternion_Matrix_4_Conversion (Item : Quaternion; Result : out Matrix_4);

   generic
      type Index is (<>);
      type Element is private;
      type Quaternion is array (Index) of Element;
      type Matrix4 is array (Index, Index) of Element;
      Zero : Element;
      One : Element;
      Two : Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element; Right : Element) return Element is <>;
      with function "**" (Left : Element; Right : Integer) return Element is <>;
   function Generic_Quaternion_Matrix4_Conversion_Function (Item : Quaternion) return Matrix4;

   generic
      type Matrix3_Index is (<>);
      type Quaternion_Index is (<>);
      type Element is private;
      type Quaternion is array (Quaternion_Index) of Element;
      type Matrix3 is array (Matrix3_Index, Matrix3_Index) of Element;
      Two : Element;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "+" (Left : Element; Right : Element) return Element is <>;
      with function "-" (Left : Element; Right : Element) return Element is <>;
      with function "**" (Left : Element; Right : Integer) return Element is <>;
   function Generic_Quaternion_Matrix3_Conversion_Function (Item : Quaternion) return Matrix3;

   generic
      type Quaternion_Index is (<>);
      type Axis_Index is (<>);
      type Element is private;
      type Quaternion is array (Quaternion_Index) of Element;
      type Axis is array (Axis_Index) of Element;
      Two : Element;
      with function Sin (Left : Element) return Element is <>;
      with function Cos (Left : Element) return Element is <>;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "/" (Left : Element; Right : Element) return Element is <>;
   procedure Generic_Axis_Quaternion_Conversion_Procedure (Item : Axis; Amount : Element; Result : out Quaternion);

   generic
      type Quaternion_Index is (<>);
      type Axis_Index is (<>);
      type Element is private;
      type Quaternion is array (Quaternion_Index) of Element;
      type Axis is array (Axis_Index) of Element;
      Two : Element;
      with function Sin (Left : Element) return Element is <>;
      with function Cos (Left : Element) return Element is <>;
      with function "*" (Left : Element; Right : Element) return Element is <>;
      with function "/" (Left : Element; Right : Element) return Element is <>;
   function Generic_Axis_Quaternion_Conversion_Function (Item : Axis; Amount : Element) return Quaternion;

--
end;
