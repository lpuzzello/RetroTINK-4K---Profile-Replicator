@ECHO OFF
setlocal enabledelayedexpansion enableextensions
:: Utility script to allow the generate a list of DV1 profiles based in a criteria.
:: All MRA file attributes supported (rotation,rbf,etc)

:: USER CONFIGURATION - Set MiSTer root drive letter (SMB or SD Card)
SET MISTER=M:\
IF [%MISTER%]==[] ( 
  ECHO "MiSTer root drive letter not set (L:\,M:\,N:\)"
  EXIT /B  
)

:: USER CONFIGURATION - Set your desired filter (attribute name and value from MRA file like core name, orientation)
:: example of attributes from MRA file 
:: <rbf>jt1942</rbf>
:: <rotation>vertical (ccw)</rotation>
SET ATT_CRITERIA=rotation
SET VAL_CRITERIA=vertical


:: END OF USER CONFIGURATION

SET AUX_DIR=_AUX
SET MRA_LIST="%AUX_DIR%\%VAL_CRITERIA%MRA_LIST.txt"
SET SET_NAME="%VAL_CRITERIA%DV1_PROFILES.txt"


MD %AUX_DIR%


:: Search for core list
ECHO Creating auxiliar file %MRA_LIST% for Arcade cores, this will take a while
findstr /M /I /R "<%ATT_CRITERIA%>%VAL_CRITERIA%<\/%ATT_CRITERIA%>" %MISTER%_Arcade\*.mra >> %MRA_LIST%
findstr /M /I /R /S "<%ATT_CRITERIA%>%VAL_CRITERIA%<\/%ATT_CRITERIA%>" %MISTER%_Arcade\_alternatives\*.mra >> %MRA_LIST%

:: Create the output setname
IF EXIST %MRA_LIST% (
 ECHO Creating SETNAME for Arcade cores
 FOR /F "tokens=*" %%f IN ('type %MRA_LIST%') DO (
  FOR /F "tokens=3 delims=><" %%a IN ('findstr setname "%%f"') do (
   ECHO %%a >> %SET_NAME%
  )
 )
 DEL %MRA_LIST%
 ECHO MiSTer DV1 custom list %SET_NAME% created. Append the content into DV1_PROFILES.txt with the desired profile on top of it
) ELSE (
 ECHO File %MRA_LIST% not created, check your filter.
)