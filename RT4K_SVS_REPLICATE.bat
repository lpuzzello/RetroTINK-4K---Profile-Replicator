@echo off
setlocal enabledelayedexpansion enableextensions
::Replicate profiles to SVS profiles/SVS/ on RetroTINK-4K

:: Set RT4K SD Card root drive letter 
SET RT4K=F:\
IF [%RT4K%]==[] ( 
  ECHO "RT4K SD Card root drive letter not set (I:\,J:\,K:\)"
  EXIT /B  
)

SET SVS_PROFILES="SVS_PROFILES.txt"

:: Read SVS_PROFILES.txt and create the profiles
FOR /F "tokens=*" %%f IN ('type %SVS_PROFILES%') DO (
  SET LINE=%%f
  SET SEP=!LINE:~0,2%!
  IF !SEP!==// (
    SET CUSTOM_PROFILE=!LINE:~2,255%!
	ECHO Current profile !CUSTOM_PROFILE!
  )ELSE ( 
	 IF NOT EXIST %RT4K%profile\DV1\%%f.rt4 (
	  ECHO Copying %RT4K%!CUSTOM_PROFILE! to %RT4K%profile\SVS\%%f.rt4
	  COPY "%RT4K%!CUSTOM_PROFILE!" %RT4K%profile\SVS\%%f.rt4
	 ) ELSE (
	  ECHO "%%f.rt4 already exists. ignoring"
	 )	 
  )
 )
)