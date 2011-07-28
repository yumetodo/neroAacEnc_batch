
@echo off

echo *******************************
echo *  neroAacEnc encoding batch  *
echo *******************************

set INFILE=%1
set OUTFILE=%~dp0%~n1
set EXEFILE=%~dp0neroAacEnc.exe

if not exist %EXEFILE% (goto quit)

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

%EXEFILE% -q %QUALITY% %PROFILE% -if %INFILE% -of %OUTFILE%.m4a
goto quit

:2pass
echo Input Bitrate (specify in kbits)
set /p BITRATE=
set /a BITRATE=BITRATE*1000
%EXEFILE% -br %BITRATE% -2pass %PROFILE% -if %INFILE% -of %OUTFILE%.m4a

:quit
exit
