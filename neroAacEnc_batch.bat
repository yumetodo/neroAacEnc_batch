echo **********************************************
echo *  neroAacEnc encoding batch Remastered 1.00 *
echo **********************************************
REM Please connect @yumetodo when you want more infomation.
setlocal
set INFILE=%1
set EXEFILEPATH=%~dp0

if "%~x1".==".wav". (goto nowstart)
if "%~x1".==".WAV". (goto nowstart)
goto quit


:nowstart
if not exist %EXEFILEPATH%neroAacEnc.exe (goto quit)
REM define where shold we be outputted
set inputpath=%~dp1
set name=%~n1
echo --------------------------------------------------------------------
echo Please choose the directory where you want to output.
echo Press [Enter], you can be outputted to the directory of Input-file.
echo --------------------------------------------------------------------
echo 例）D:\ライブラリー系\Desktop\
set /p Outputpath=
if not %Outputpath%.==. goto enc
set Outputpath=%inputpath%
set OUTFILE="%Outputpath%%name%.m4a"

echo ---------------------------
echo Select a profile you use 
echo ---------------------------
echo [1] AAC-LC (AAC Low Complexity) [128kbps~]
echo [2] HE-AAC (High-Efficiency AAC) [64kbps~128kbps]
echo [3] HE-AAC v2 (HE-AAC Version 2) [~64kbps]
echo [4] Cancel

set /p INPUT=
if %INPUT% == 1 (goto lc)
if %INPUT% == 2 (goto he)
if %INPUT% == 3 (goto hev2)
if %INPUT% == 4 (goto quit)

:lc
set PROFILE=-lc
goto selectmode

:he
set PROFILE=-he
goto 2pass

:hev2
set PROFILE=-hev2
goto 2pass


:selectmode
echo -----------------------
echo Select encoding mode 
echo -----------------------
echo [1] VBR encoding
echo [2] 2pass encoding
echo [3] cancel

set /p INPUT2=
if %INPUT2% == 1 (goto VBR)
if %INPUT2% == 2 (goto 2pass)
if %INPUT2% == 3 (goto quit)


:VBR
echo +-------------------------+
echo + [Quality] === [Bitrate] +
echo +-------------------------+
echo    q 0.05   ===   15 kbps
echo    q 0.15   ===   32 kbps
echo    q 0.25   ===   63 kbps
echo    q 0.35   ===   99 kbps
echo    q 0.45   ===  146 kbps
echo    q 0.55   ===  197 kbps
echo    q 0.65   ===  248 kbps
echo    q 0.75   ===  299 kbps
echo    q 0.85   ===  350 kbps
echo    q 0.95   ===  401 kbps

echo Input Quality
set /p QUALITY=
pushd %EXEFILEPATH%
neroAacEnc.exe -ignorelength -q %QUALITY% %PROFILE% -if "%INFILE%" -of %OUTFILE%
popd
goto quit

:2pass
echo Input Bitrate (specify in kbits)
set /p BITRATE=
set /a BITRATE=BITRATE*1000
pushd %EXEFILEPATH%
neroAacEnc.exe -ignorelength -br %BITRATE% -2pass %PROFILE% -if "%INFILE%" -of %OUTFILE%
popd
:quit
endlocal
pause
exit
