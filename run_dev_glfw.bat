:loop
del /s /q bin\dev_glfw.exe
gprbuild -p main.gpr
pause
cd bin
dev_glfw.exe
cd ..
pause
goto loop