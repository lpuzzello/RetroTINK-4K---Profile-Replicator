This is a set of Windows Batch scripts to replicate a base RetroTINK-4K profile to multiples systems.

RT4K_MISTER_DV1_REPLICATE.bat - MiSTer FPGA Direct Video profile switcher
Replicate one profile to all cores or a specific group of cores (e.g Arcade,Handheld,CPS2,etc) to RetroTINK-4K profile/DV1 folder.
This script supports all Consoles, and Arcades, including Alternatives.

RT4K_SVS_REPLICATE.bat - Scalable Video Switcher profile switcher
Replicate one profile to all consoles or a specific group of consoles (e.g 480P Consoles, 480I-240P Consoles) on RetroTINK-4K profile/SVS folder. 


Pre-Requisites:
- Desired Base profile (.RT4) created and adjusted in the desired resolutions/input.
  This step is the most important as some profile settings (Interpolation,Scaling) are per Input/Resolution, and an incorrect profile for a specific resolution/input, will propagate the issue to all destination profiles.
  Always double check your target Consoles inputs

Restrictions:
- These tools are not capable to modify any content of RT4 file it self.
- For RT4K_MISTER_DV1_REPLICATE script, /media/fat from MiSTer need to be accessible in the PC (SMB,SDCARD,USB) and FTP not supported.

How to use:

1) Copy the scripts in a folder in your PC.
2) Edit the RT4K_MISTER_DV1_REPLICATE.bat and RT4K_SVS_REPLICATE.bat and set your MiSTer storage and RT4K SD Card drive letter.
3) Create a text file named DV1_PROFILES.txt for RT4K_MISTER_DV1_REPLICATE.bat and SVS_PROFILES_txt for RT4K_SVS_REPLICATE.bat in the same folder of the scripts.
4) Edit the text files by adding  your profile mapping configuration following the steps for each file:
   
   DV1_PROFILES.txt
      - First line will have the default profile (mandatory) with "//" separator
      - Subsequent lines could have a secondary profile and core setname list (optional)
      - Blank lines are ignored, so you can use to be more visually friendly.
      Example with 3 profiles (1 default and 3 optional profiles)

      ![image](https://github.com/user-attachments/assets/c6b4197c-3dbc-414c-89b2-5bfbc70e4eb0)

   
      - If cores are not pre-configured in this file, those will be retrieved automatically from MiSTer (including alternatives) and will receive the default profile.

   SVS_PROFILES.txt
      - Add at least one profile with "//" separator and include the profile name corresponding to each input (e.g: S0_N64,S1_PS2)
      - You can use the same profile for multiples inputs
        
      ![image](https://github.com/user-attachments/assets/ba4a6aab-dfc4-4e18-8bbb-45835c668d42)


5) Run the desired scripts:
   
   RT4K_MISTER_DV1_REPLICATE.bat
      - This script will first look for the default profile in DV1_PROFILES.txt and the core exception list.
      - Cores that are not listed will be retrieved directly from MiSTer shared folder (SMB) or SDCard that is configured in the script (RT4K and MISTER variables).
      - For performance reasons, a text file DV1_ARCADE.txt will be saved in a subfolder _AUX in order to store current core Arcade list (more than 2k entries) and speed-up the next executions (first execution will take more time in this step, this is expected as all MRAs will be scanned for the SETNAME). If a core is added to the MiSTer, or this file can be deleted in order to be recreated by the script or changed manually including the SETNAME from MRA file.

                
   RT4K_SVS_REPLICATE.bat
      - This script will first look for the default profile in SVS_PROFILES.txt.
      - Unlike MiSTer script, this will rely exclusively in the SVS_PROFILES.txt.

6) This is other part of fun of owning these excelent devices like tweaking settings, and playing games.
   If you have any suggestion or find issues with these scripts feel free raise a Issue. Feel free also to copy or reuse, however please give the proper author credits, this kind of attitude only motivates the community to create new stuff.
