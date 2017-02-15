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
      N0 : Bitmap (1 .. 10, 1 .. 10);
      N1 : Bitmap (1 .. 10, 1 .. 10);
      N2 : Bitmap (1 .. 10, 1 .. 10);
      --N_000 : Bitmap (1 .. 10, 1 .. 10) := (others => (others => 0));
      --N_255 : Bitmap (1 .. 10, 1 .. 10) := (others => (others => 255));
      --N_111 : Bitmap (1 .. 10, 1 .. 10) := (others => (others => 111));
--        N3 : Bitmap (1 .. 10, 1 .. 10);
--        N4 : Bitmap (1 .. 10, 1 .. 10);
--        N5 : Bitmap (1 .. 10, 1 .. 10);
--        N6 : Bitmap (1 .. 10, 1 .. 10);
--        N7 : Bitmap (1 .. 10, 1 .. 10);
--        N8 : Bitmap (1 .. 10, 1 .. 10);
--        N9 : Bitmap (1 .. 10, 1 .. 10);
   begin
      N0 :=
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
      N1 :=
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
      N2 :=
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
      --N2 := N_255;
      --N1 := N_000;
      --N0 := N_111;

      Load_3D (Item.T, 0, 0, 0, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N0'Address);
      Load_3D (Item.T, 0, 0, 1, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N1'Address);
      Load_3D (Item.T, 0, 0, 2, 10, 10, 1, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, N2'Address);
   end;

   procedure Render_Char (Item : in out Text_Render; I : Natural) is
      use GL.Math;
      use GL.Buffers;
      use System;
      use type GL.Math.Real_Float;
      use GL.Textures;


      X : constant Real_Float := -1.0;
      Y : constant Real_Float := -1.0;
      W : constant Real_Float := 2.0;
      H : constant Real_Float := 2.0;
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

--        for E of Item.V loop
--           E (1) := E (1) * 0.2;
--           E (2) := E (2) * 0.2;
--        end loop;
   end;





--     procedure Render_Text (Item : in out Text_Render; Text : String) is
--     begin
--        for C of Text loop
--           if C in '0' .. '9' then
--              Render_Char (Item, C);
--           end if;
--        end loop;
--     end;



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
      --type Vertex_Array1 is array (Integer range <>) of Real_Float_Vector4;
      --Vertex_Data : Vertex_Array1 (1 .. 6);
--        X : constant Real_Float := 0.0;
--        Y : constant Real_Float := 0.0;
--        W : constant Real_Float := 1.0;
--        H : constant Real_Float := 1.0;
   begin

--        for X in Bitmap_Data'Range (1) loop
--           for Y in Bitmap_Data'Range (2) loop
--              if abs (X - Y) > 5 then
--                 Bitmap_Data (X, Y) := 0;
--              end if;
--           end loop;
--        end loop;
--        Vertex_Data (1) := (X,     Y + H, 0.0, 0.0);
--        Vertex_Data (2) := (X,     Y,     0.0, 1.0);
--        Vertex_Data (3) := (X + W, Y,     1.0, 1.0);
--        Vertex_Data (4) := (X,     Y + H, 0.0, 0.0);
--        Vertex_Data (5) := (X + W, Y,     1.0, 1.0);
--        Vertex_Data (6) := (X + W, Y + H, 1.0, 0.0);

      --Shader list need to be empty for this to works.
      --Empty the list does not feel like a good solution.
      Item.P.Shader_List.Empty;
      Item.P.Obj := GL.Programs.Create_Empty;
      Simple_Shaders.Append (Item.P, "text.glvs");
      Simple_Shaders.Append (Item.P, "text.glfs");
      Simple_Shaders.Build (Item.P);

      Item.Layer_Loc := GL.Programs.Uniforms.Get_Checked (Item.P.Obj, "layer");

      glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
      glActiveTexture (GL_TEXTURE0);
      glEnable (GL_BLEND);
      GL.Textures.Set_Unpack_Pixel_Alignment (1);


      Item.T := Create (Targets.Texture_2D_Array);

      Set_Parameter (Item.T, Texture_Wrap_S, Clamp_To_Edge_Param);
      Set_Parameter (Item.T, Texture_Wrap_T, Clamp_To_Edge_Param);
      --glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
      --glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
      Set_Parameter (Item.T, Texture_Mag_Filter, Nearest_Param);
      Set_Parameter (Item.T, Texture_Min_Filter, Linear_Param);

      Allocate_3D (Item.T, R8_Internal_Pixel_Format, 10, 10, 3);
      Insert_Text (Item);
      --Load (Item.T, 0, 0, 100, 100, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);
      --Load (Item.T, 0, 0, 10, 10, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data2'Address);
      --Load (Item.T, 10, 0, 10, 10, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data3'Address);
      --Load (Item.T, 0, 20, 10, 10, RGBA_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data2'Address);
      --Load (Texture_2D_Texture_Target, 100, 100, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);
      --Load (Item.T, 0, 0, 100, 100, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);
      --Load (Item.T, 0, 0, 50, 50, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);

      --Render_Char (Item, 1);
      Item.VBO := GL.Buffers.Create_Buffer;
      Item.VAO := GL.Vertex_Array_Objects.Create_Attribute;
      Create_New_Storage (Item.VBO, Item.V'Size / Storage_Unit, Item.V'Address, Dynamic_Usage);
      Set_Attribute_Enable (Item.VAO, 0);
      Set_Attribute_Enable (Item.VAO, 1);
      Set_Attribute_Memory_Layout (Item.VAO, 0, Real_Float_Vector4'Length, Float_Type, False, 0);
      Set_Attribute_Memory_Layout (Item.VAO, 1, Real_Float_Vector4'Length, Float_Type, False, Real_Float_Vector4'Size / Storage_Unit);
      glVertexArrayAttribBinding (GLuint (Item.VAO), 0, 0);
      glVertexArrayAttribBinding (GLuint (Item.VAO), 1, 0);
      glVertexArrayVertexBuffer (GLuint (Item.VAO), 0, GLuint (Item.VBO), 0, Item.V'Component_Size / Storage_Unit);
   end;

   -- Program object is invalid if the application is restarted.
   procedure Render (Item : in out Text_Render; Lay : GL.C.GLint) is
      use GL.Textures;
   begin
      Bind (Targets.Texture_2D_Array, Item.T);
      GL.Programs.Set_Current (Item.P.Obj);
      GL.Programs.Uniforms.Modify_1i (Item.Layer_Loc, Lay);
      GL.Vertex_Array_Objects.Bind (Item.VAO);
      GL.Drawings.Draw (GL.Drawings.Triangles_Mode, 0, 6);
      null;
   end;


end;
