:loop
gprbuild -p main.gpr
pause
cd bin
dev.exe
cd ..
pause
goto loop