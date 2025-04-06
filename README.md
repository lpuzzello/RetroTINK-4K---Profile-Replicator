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
2) Create a text file named DV1_PROFILES.txt for RT4K_MISTER_DV1_REPLICATE and SVS_PROFILES_txt for RT4K_SVS_REPLICATE.bat in the same folder of the scripts.
3) Edit the text files by adding  your profile mapping configuration following the steps for each file:
   
   DV1_PROFILES.txt
      - First line will have the default profile (mandatory) with "\\" separator
      - Subsequent lines will have secondary profile and core setname list (optional)
      - Blank lines are ignored, so you can use to be more visually friendly.
      Example with 3 profiles (1 default and 2 optional profiles)

      ![image](https://github.com/user-attachments/assets/47fc9c6c-afa7-4dca-a385-eab4d0a03137)
   
      - Cores that are not pre-configured in this file will be retrieved automatically from MiSTer (including alternatives) and will receive the default profile.

   SVS_PROFILES.txt
      - Add at least one profile with "\\" separator and include the profile name corresponding to each input (e.g: S0_N64,S1_PS2)
      - You can use the same profile for multiples inputs
        
      ![image](https://github.com/user-attachments/assets/2b0d2547-7a07-4ae2-92d7-165c2be839c5)

4) Run the desired scripts:
   
   RT4K_MISTER_DV1_REPLICATE.bat
      - This script will first look for the default profile in DV1_PROFILES.txt and the core exception list.
      - Cores that are not listed will be retrieved directly from MiSTer shared folder (SMB) or SDCard that is configured in the script (RT4K and MISTER variables).
      - For performance reasons, a text file DV1_ARCADE.txt will be saved in a subfolder _AUX in order to store current core Arcade list (more than 2k entries) and speed-up the next executions (first execution will take more time in this step, this is expected as all MRAs will be scanned for the SETNAME). If a core is added to the MiSTer, or this file can be deleted in order to be recreated by the script or changed manually including the SETNAME from MRA file.

                
   RT4K_SVS_REPLICATE.bat
      - This script will first look for the default profile in SVS_PROFILES.txt.
      - Unlike MiSTer script, this will rely exclusively in the SVS_PROFILES.txt.
