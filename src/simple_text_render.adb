with GL.C;
with GL.Math;
with System;
with GL.C.Complete;
with GL.Drawings;
with GL.Programs;
with GLFW3.Windows.Keys;
with GL.Programs.Uniforms;

package body Simple_Text_Render is

   procedure Insert_Text (Item : in out Text_Render) is
      use GL.Textures;
      type Bitmap is array (Integer range <>, Integer range <>) of GL.C.GLubyte;
      subtype Bitmap10 is Bitmap (1 .. 10, 1 .. 10);
      type Bitmap10_Array is array (Integer range <>) of Bitmap10;
      N : Bitmap10_Array (0 .. 9);
   begin
      N (0) :=
        (
         (145, 000, 000, 000, 255, 255, 000, 000, 000, 100),
         (011, 000, 000, 255, 000, 000, 255, 000, 000, 000),
         (000, 000, 255, 000, 000, 000, 000, 255, 000, 000),
         (000, 000, 255, 000, 000, 000, 000, 255, 000, 000),
         (000, 000, 255, 000, 000, 000, 000, 255, 000, 000),
         (000, 000, 255, 000, 000, 000, 000, 255, 000, 000),
         (000, 000, 255, 000, 000, 000, 000, 255, 000, 000),
         (000, 000, 255, 000, 000, 000, 000, 255, 000, 000),
         (000, 000, 000, 255, 000, 000, 255, 000, 000, 000),
         (100, 000, 000, 000, 255, 255, 000, 000, 000, 100)
        );
      N (1) :=
        (
         (100, 000, 000, 000, 255, 255, 000, 000, 000, 100),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (100, 000, 000, 000, 255, 255, 255, 000, 000, 100)
        );
      N (2) :=
        (
         (100, 000, 000, 222, 255, 000, 000, 000, 000, 100),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 000, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 000, 000, 000, 000, 000),
         (100, 000, 000, 000, 255, 255, 000, 000, 000, 100)
        );
      N (3) :=
        (
         (100, 000, 000, 222, 255, 000, 000, 000, 000, 100),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (100, 000, 000, 222, 255, 000, 000, 000, 000, 100)
        );
      N (4) :=
        (
         (100, 000, 000, 222, 000, 255, 000, 000, 000, 100),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (100, 000, 000, 000, 000, 000, 000, 000, 000, 100)
        );
      N (5) :=
        (
         (100, 000, 000, 222, 255, 255, 000, 000, 000, 100),
         (000, 000, 000, 222, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 222, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (100, 000, 000, 255, 255, 255, 000, 000, 000, 100)
        );
      N (6) :=
        (
         (100, 000, 000, 222, 255, 255, 000, 000, 000, 100),
         (000, 000, 000, 222, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 000, 000, 000, 000, 000),
         (000, 000, 000, 222, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 255, 000, 000, 000, 000),
         (100, 000, 000, 255, 255, 255, 000, 000, 000, 100)
        );
      N (7) :=
        (
         (100, 000, 000, 222, 255, 255, 000, 000, 000, 100),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 255, 000, 000, 000, 000, 000),
         (000, 000, 000, 000, 255, 000, 000, 000, 000, 000),
         (000, 000, 000, 000, 255, 000, 000, 000, 000, 000),
         (000, 000, 000, 000, 255, 000, 000, 000, 000, 000),
         (100, 000, 000, 000, 255, 000, 000, 000, 000, 100)
        );
      N (8) :=
        (
         (100, 000, 000, 222, 255, 255, 000, 000, 000, 100),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 000, 255, 000, 000, 000, 000),
         (100, 000, 000, 255, 255, 255, 000, 000, 000, 100)
        );
      N (9) :=
        (
         (100, 000, 000, 222, 255, 255, 000, 000, 000, 100),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 222, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 255, 255, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (000, 000, 000, 000, 000, 255, 000, 000, 000, 000),
         (100, 000, 000, 255, 255, 255, 000, 000, 000, 100)
        );
      Load_3D (Item.T, 0, 0, 0, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (0)'Address);
      Load_3D (Item.T, 0, 0, 1, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (1)'Address);
      Load_3D (Item.T, 0, 0, 2, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (2)'Address);
      Load_3D (Item.T, 0, 0, 3, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (3)'Address);
      Load_3D (Item.T, 0, 0, 4, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (4)'Address);
      Load_3D (Item.T, 0, 0, 5, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (5)'Address);
      Load_3D (Item.T, 0, 0, 6, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (6)'Address);
      Load_3D (Item.T, 0, 0, 7, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (7)'Address);
      Load_3D (Item.T, 0, 0, 8, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (8)'Address);
      Load_3D (Item.T, 0, 0, 9, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N (9)'Address);
   end;

   procedure Render_Char (Item : in out Text_Render; X, Y, W, H : GL.Math.Real_Float; I : Natural) is
      use GL.Math;
      use GL.Buffers;
      use System;
      use type GL.Math.Real_Float;
      use GL.Textures;


--        X : constant Real_Float := -1.0;
--        Y : constant Real_Float := -1.0;
--        W : constant Real_Float := 0.4;
--        H : constant Real_Float := 0.4;
   begin
      Item.V (1).Pos  := (X,     Y,     0.0, 1.0);
      Item.V (1).STUV := (0.0, 1.0, Real_Float (I), 0.0);

      Item.V (2).Pos  := (X + W, Y,     1.0, 1.0);
      Item.V (2).STUV := (1.0, 1.0, Real_Float (I), 0.0);

      Item.V (3).Pos  := (X,     Y + H, 0.0, 0.0);
      Item.V (3).STUV := (0.0, 0.0, Real_Float (I), 0.0);

      Item.V (4).Pos  := (X + W, Y + H, 1.0, 0.0);
      Item.V (4).STUV := (1.0, 0.0, Real_Float (I), 0.0);

      Item.V (5).Pos  := (X,     Y + H, 0.0, 0.0);
      Item.V (5).STUV := (0.0, 0.0, Real_Float (I), 0.0);

      Item.V (6).Pos  := (X + W, Y,     1.0, 1.0);
      Item.V (6).STUV := (1.0, 1.0, Real_Float (I), 0.0);

      Redefine_Storage (Item.VBO, 0, Item.V'Size / Storage_Unit, Item.V'Address);

      Bind (Targets.Texture_2D_Array, Item.T);
      GL.Programs.Set_Current (Item.P.Obj);
      GL.Vertex_Array_Objects.Bind (Item.VAO);
      GL.Drawings.Draw (GL.Drawings.Triangles_Mode, 0, 6);
   end;





   procedure Render_Text (Item : in out Text_Render; X, Y, W, H : Real_Float; Text : String) is
      use GL.Math;
      use type GL.Math.Real_Float;
      XX : Real_Float := X;
   begin
      for C of Text loop
         if C in '0' .. '9' then
            Render_Char (Item, XX, Y, W, H, Integer'Value (C & ""));
            XX := XX + W;
         end if;
      end loop;
   end;



   procedure Load_Texture (Item : in out Text_Render) is
      use GL.Math;
      use GL.Buffers;
      use GL.Vertex_Array_Objects;
      use GL.Textures;
      use GL.C.Complete;
      use GL.C;
      use System;
      use type GL.C.GLint;
      use type GL.Math.Real_Float;
   begin

      --Shader list need to be empty for this to works.
      --Empty the list does not feel like a good solution:
      Item.P.Shader_List.Empty;
      Item.P.Obj := GL.Programs.Create_Empty;
      Simple_Shaders.Append (Item.P, "text.glvs");
      Simple_Shaders.Append (Item.P, "text.glfs");
      Simple_Shaders.Build (Item.P);

      --This is just temporary:
      Item.Layer_Loc := GL.Programs.Uniforms.Get_Checked (Item.P.Obj, "layer");

      --These are necessery. Improve code understandability here:
      glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
      glActiveTexture (GL_TEXTURE0);
      glEnable (GL_BLEND);
      GL.Textures.Set_Unpack_Pixel_Alignment (1);


      --Texture creation:
      Item.T := Create (Targets.Texture_2D_Array);
      Set_Parameter (Item.T, Texture_Wrap_S, Clamp_To_Edge_Param);
      Set_Parameter (Item.T, Texture_Wrap_T, Clamp_To_Edge_Param);
      Set_Parameter (Item.T, Texture_Mag_Filter, Nearest_Param);
      Set_Parameter (Item.T, Texture_Min_Filter, Linear_Param);
      --Allocate 3 pcs of 10 by 10 texels:
      Allocate_3D (Item.T, R8_Internal_Pixel_Format, 10, 10, 10);
      Insert_Text (Item);



      Item.VBO := GL.Buffers.Create_Buffer;
      Item.VAO := GL.Vertex_Array_Objects.Create_Attribute;
      Create_New_Storage (Item.VBO, Item.V'Size / Storage_Unit, Null_Address, Dynamic_Usage);
      Set_Attribute_Enable (Item.VAO, 0);
      Set_Attribute_Enable (Item.VAO, 1);
      Set_Attribute_Memory_Layout (Item.VAO, 0, Real_Float_Vector4'Length, Float_Type, False, 0);
      Set_Attribute_Memory_Layout (Item.VAO, 1, Real_Float_Vector4'Length, Float_Type, False, Real_Float_Vector4'Size / Storage_Unit);

      --Store bindingindex 0 in 0 and 1 in 0. Very confusing improve understandability here:
      glVertexArrayAttribBinding (GLuint (Item.VAO), 0, 0);
      glVertexArrayAttribBinding (GLuint (Item.VAO), 1, 0);
      glVertexArrayVertexBuffer (GLuint (Item.VAO), 0, GLuint (Item.VBO), 0, Item.V'Component_Size / Storage_Unit);
   end;




end;
