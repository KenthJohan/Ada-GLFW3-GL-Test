:loop
del /s /q bin\dev_mesh_test.exe
gprbuild -p main.gpr
pause
cd bin
dev_mesh_test.exe
cd ..
pause
goto loop