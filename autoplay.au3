#include <MsgBoxConstants.au3>


Global $userHome = EnvGet("SystemDrive") & EnvGet("HOMEPATH")

;���Jini�]�w
init_func()

;�ˬd�v���O�_�s�b
fileExists_func()

;�ק�U���n����ĴX��
changeEP_func()

;����v��
playVideo_func()

HotKeySet("1", "changeDrama_func")
HotKeySet("2", "changeDrama_func")
HotKeySet("3", "changeDrama_func")
HotKeySet("5", "changeDrama_func")
HotKeySet("6", "changeDrama_func")
HotKeySet("7", "changeDrama_func")
HotKeySet("8", "changeDrama_func")
HotKeySet("9", "changeDrama_func")
HotKeySet("0", "changeDrama_func")
HotKeySet("-", "changeDrama_func")
HotKeySet("=", "changeDrama_func")
While 1
    Sleep(100)
WEnd



Func init_func()
   ;�]�w�ɦs��b�ϥΪ̮a�ؿ�, �p: C:\Users\username\config.ini
   ;�v���s���Ƨ�
   Global $videoDIR = IniRead($userHome & "\config.ini", "general", "video_dir", "Null")
   ;�n���񪺼v���N��
   Global $playDrama = IniRead($userHome & "\config.ini", "general", "play_drama", "Null")
   ;�n���񪺼v���W��
   Global $dramaName = IniRead($userHome & "\config.ini", "drama", $playDrama, "Null")
   ;�v�����榡
   Global $videoFormat = IniRead($userHome & "\config.ini", $playDrama, "format", "Null")
   ;�n������@��
   Global $nextEP = IniRead($userHome & "\config.ini", $playDrama, "next_ep", "Null")
   ;�v����������|
   Global $video = $videoDIR & "\" & $dramaName & "\" & "ep_" & $nextEP & "." & $videoFormat
   ;�v���O�_�s�b
   Global $fileNotExists = False
EndFunc


Func fileExists_func ()
   Local $iFileExists = FileExists($video)
   If Not $iFileExists Then
	  $fileNotExists = True
   EndIf
EndFunc

Func changeEP_func ()
   If $fileNotExists = False Then
	  ;nextEP + 1
	  Local $ep = $nextEP + 1
	  IniWrite($userHome & "\config.ini", $playDrama, "next_ep", $ep)
   Else
	  ;����Ĥ@��
	  $nextEP=1
	  $video = $videoDIR & "\" & $dramaName & "\" & "ep_" & $nextEP & "." & $videoFormat
	  IniWrite($userHome & "\config.ini", $playDrama, "next_ep", "2")
   EndIf

EndFunc

Func playVideo_func()
   ShellExecuteWait($video)
   Sleep(2000)
   ;�w��Windows Media Player, ��j����ù�(Alt+Enter)
   Send("{ALT Down}{ENTER}{ALT Up}")
EndFunc

Func changeDrama_func()
   Local $dramaCode = IniRead($userHome & "\config.ini", "hotkey", @HotKeyPressed, "Null")
   if $dramaCode <> "Null" Then
	  If $dramaCode <> $playDrama Then
		 ;MsgBox($MB_SYSTEMMODAL, "", $dramaCode)
		 ;�ק�w�]�n�������@
		 IniWrite($userHome & "\config.ini", "general", "play_drama", $dramaCode)
		 If $fileNotExists = True Then
			;�٭�next_ep
			IniWrite($userHome & "\config.ini", $playDrama, "next_ep", "1")
		 Else
			;�٭�next_ep
			IniWrite($userHome & "\config.ini", $playDrama, "next_ep", $nextEP)

		 EndIf
		 ;�����ثe���v��
		 WinClose("[CLASS:WMP Skin Host]")

		 ;���Jini�]�w
		 init_func()

		 ;�ˬd�v���O�_�s�b
		 fileExists_func()

		 ;�ק�U���n����ĴX��
		 changeEP_func()

		 ;����v��
		 playVideo_func()


		 ;Exit
	  EndIf
   EndIf
EndFunc

