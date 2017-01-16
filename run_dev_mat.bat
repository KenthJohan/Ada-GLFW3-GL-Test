:loop
gprbuild -p main.gpr
pause
cd bin
dev_mat.exe
cd ..
pause
goto loop