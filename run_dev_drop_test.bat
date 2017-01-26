:loop
gprbuild -p main.gpr
pause
cd bin
dev_drop_test.exe
cd ..
pause
goto loop