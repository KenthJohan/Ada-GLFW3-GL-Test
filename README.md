# Graph_Renderer
This is under development.

## Features
Many more features need to be added.
* [X] Ability to control camera by pressing `Key_A` `Key_W` `Key_S` `Key_D` `Key_Space` `Key_Left_Control` `Key_Up` `Key_Down` `Key_Left` `Key_Right` `Key_Q` `Key_E` `Key_O` `Key_L`
* [X] Ability to change grid size by pressing `Key_Kp_Add` `Key_Kp_Subtract`
* [X] Ability to link program and recompile shaders by pressing `Key_P`.
* [X] Ability to switch beetween fullscreen by pressing `Key_F11` `Key_F12`.
* [ ] Render text of frame count per sec and frame delta.
* [ ] Plot graph from files.
* [ ] Ability to swap between different graphs.
* [ ] Plot graph from remote clients.
* [ ] Ability to change coordinate system.
* [ ] Ability to add visual axises.

Internal features.

* [X] Ability to add debug messages in global queue or local queue.
* [ ] More control over the tasks.
* [ ] Implement log file outout.
* [ ] Complete error checking, Implement OpenGL https://www.khronos.org/opengl/wiki/Debug_Output.
* [ ] Clear seperation beetween context functions and non context functions. Some preperation does not need to be reinitialized to restart the context, but some do.
* [ ] Ability to read and render pictures.

## Dependency
* https://github.com/AdaHome/Ada-GL
OpenGL bindings
* https://github.com/AdaHome/Ada-GLFW3
GLFW3 bindings
* https://github.com/AdaHome/Home_Mathematics
Math functions.
* https://github.com/AdaHome/Home_Containers
Vectors.
* https://github.com/AdaHome/Home_Pictures
Read Pictures.