:loop
del /s /q bin\dev_vector_test.exe
gprbuild -p main.gpr
pause
cd bin
dev_vector_test.exe
cd ..
pause
goto loop