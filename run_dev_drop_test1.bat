:loop
gprbuild -p main.gpr
pause
cd bin
dev_drop_test1.exe
cd ..
pause
goto loop