@ECHO OFF
setlocal enabledelayedexpansion enableextensions
::Replicate profiles to MiSTer profiles/DV1/ on Retrotink 4K

:: USER CONFIGURATION - Set RT4K SD Card root drive letter 
SET RT4K=F:\
IF [%RT4K%]==[] ( 
  ECHO "RT4K SD Card root drive letter not set (I:\,J:\,K:\)"
  EXIT /B  
)

:: USER CONFIGURATION - Set MiSTer root drive letter (SMB or SD Card)
SET MISTER=M:\
IF [%MISTER%]==[] ( 
  ECHO "MiSTer root drive letter not set (L:\,M:\,N:\)"
  EXIT /B  
)

SET AUX_ARCADE="_AUX\DV1_ARCADE.txt"
SET DV1_PROFILES="DV1_PROFILES.txt"


:: Read DV1_PROFILES.txt and create the exception profiles (if present)
SET COUNT=0
FOR /F "tokens=*" %%f IN ('type %DV1_PROFILES%') DO (
  SET /A COUNT +=1
  SET LINE=%%f
  SET SEP=!LINE:~0,2%!
  
  IF !SEP!==// (
    IF !COUNT!==1 (
      SET BASE_PROFILE=!LINE:~2,255%!
	  ECHO Base profile !BASE_PROFILE!
    )
    SET CUSTOM_PROFILE=!LINE:~2,255%!
	ECHO Current profile !CUSTOM_PROFILE!
  )ELSE ( 
	 IF NOT EXIST %RT4K%profile\DV1\%%f.rt4 (
	  ECHO Copying %RT4K%!CUSTOM_PROFILE! to %RT4K%profile\DV1\%%f.rt4
	  COPY "%RT4K%!CUSTOM_PROFILE!" %RT4K%profile\DV1\%%f.rt4
	 ) ELSE (
	  ECHO "%%f.rt4 already exists. ignoring"
	 )	 
  )
 )
)

:: Read MiSTer MRA files and create Arcade list in a local file to speed-up process 
IF NOT EXIST %AUX_ARCADE% (
 FOR /F "tokens=3 delims=><" %%f IN ('findstr /S setname %MISTER%_Arcade\*.mra') do (
   ECHO Creating an auxiliar file for Arcade cores, this will take a while
   ECHO %%f >> %AUX_ARCADE%
 )
)

:: Read MiSTer Console core folder and create the RT4 profile based on RBF filename 
:: (e.g: MegaDrive_2024021.rbf > MegaDrive.rt4)
FOR %%f IN (%MISTER%_Console\*.rbf) DO (
  FOR /f "tokens=1 delims=_ " %%a IN ("%%~nf") DO (     
	 IF NOT EXIST %RT4K%profile\DV1\%%a.rt4 (
      ECHO _Console folder
	  ECHO Copying !BASE_PROFILE! to %RT4K%profile\DV1\%%a.rt4
	  COPY "%RT4K%!BASE_PROFILE!" %RT4K%profile\DV1\%%a.rt4
	 ) ELSE (
	  ECHO "%%a.rt4 already exists. ignoring"
	 )	 
  )
)

:: Read MiSTer Unstable core folder and create the RT4 profile based on RBF filename 
:: (e.g: MegaDrive_unstable_20250210_136348.rbf > MegaDrive.rt4)
FOR %%f IN (%MISTER%_Unstable\*.rbf) DO (
  FOR /f "tokens=1 delims=_ " %%a IN ("%%~nf") DO (     
	 IF NOT EXIST %RT4K%profile\DV1\%%a.rt4 (
      ECHO _Unstable folder
	  ECHO Copying !BASE_PROFILE! to %RT4K%profile\DV1\%%a.rt4
	  COPY "%RT4K%!BASE_PROFILE!" %RT4K%profile\DV1\%%a.rt4	  
	 ) ELSE (
	  ECHO "%%a.rt4 already exists. ignoring"
	 )	 
  )
)

:: Read MiSTer Computer core folder and create the RT4 profile based on RBF filename 
:: (e.g: memtest_2024021.rbf > memtest.rt4)
FOR %%f IN (%MISTER%_Computer\*.rbf) DO (
  FOR /f "tokens=1 delims=_ " %%a IN ("%%~nf") DO (     
	 IF NOT EXIST %RT4K%profile\DV1\%%a.rt4 (
	  ECHO _Computer folder
	  ECHO Copying !BASE_PROFILE! to %RT4K%profile\DV1\%%a.rt4
	  COPY "%RT4K%!BASE_PROFILE!" %RT4K%profile\DV1\%%a.rt4
	 ) ELSE (
	  ECHO "%%a.rt4 already exists. ignoring"
	 )	 
  )
)

:: Read MiSTer Utility core folder and create the RT4 profile based on RBF filename 
:: (e.g: memtest_2024021.rbf > memtest.rt4)
FOR %%f IN (%MISTER%_Utility\*.rbf) DO (
  FOR /f "tokens=1 delims=_ " %%a IN ("%%~nf") DO (     
	 IF NOT EXIST %RT4K%profile\DV1\%%a.rt4 (
	  ECHO _Computer folder
	  ECHO Copying !BASE_PROFILE! to %RT4K%profile\DV1\%%a.rt4
	  COPY "%RT4K%!BASE_PROFILE!" %RT4K%profile\DV1\%%a.rt4
	 ) ELSE (
	  ECHO "%%a.rt4 already exists. ignoring"
	 )	 
  )
)

:: Menu Core
IF NOT EXIST %RT4K%profile\DV1\Menu.rt4 ( COPY "!BASE_PROFILE!" %RT4K%profile\DV1\Menu.rt4 ) ELSE ( ECHO "Menu.rt4 already exists. ignoring" )