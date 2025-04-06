This is a set of Windows Batch scripts to replicate a base RetroTINK-4K profile to multiples systems.

RT4K_MISTER_DV1_REPLICATE - MiSTer FPGA Direct Video profile switcher
Replicate one profile to all cores or a specific group of cores (e.g Arcade,Handheld,CPS2,etc) to RetroTINK-4K profile/DV1 folder.
This script supports all Consoles, and Arcades, including Alternatives.

RT4K_CONSOLES_REPLICATE.bat - System specific profile
Replicate one profile to all consoles or a specific group of consoles (e.g 480P Consoles, 480I-240P Consoles) on RetroTINK-4K profile folder. 
Useful for cases that you have a already button mapped on the remote for each console profile. 

RT4K_SVS_REPLICATE.bat - Scalable Video Switcher profile switcher
Replicate one profile to all consoles or a specific group of consoles (e.g 480P Consoles, 480I-240P Consoles) on RetroTINK-4K profile/SVS folder. 
Useful for cases that you have a already button of the remote for each console profile. 


Pre-Requisites:
- Desired Base profile (.RT4) created and adjusted in the desired resolutions/input.
  This step is the most important as some profile settings (Interpolation,Scaling) are per Input/Resolution, and an incorrect profile for a specific resolution/input, will propagate the issue to all destination profiles.
  Always double check your Consoles inputs
  
  
Restrictions:
- These tools are not capable to modify any content of RT4 file it self.
- For RT4K_MISTER_DV1_REPLICATE script, /media/fat from MiSTer need to be accessible in the PC (SMB,SDCARD,USB) and FTP not supported.
