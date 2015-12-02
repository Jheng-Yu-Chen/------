#include <MsgBoxConstants.au3>


Global $userHome = EnvGet("SystemDrive") & EnvGet("HOMEPATH")

;載入ini設定
init_func()

;檢查影片是否存在
fileExists_func()

;修改下次要播放第幾集
changeEP_func()

;播放影片
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
   ;設定檔存放在使用者家目錄, 如: C:\Users\username\config.ini
   ;影片存放資料夾
   Global $videoDIR = IniRead($userHome & "\config.ini", "general", "video_dir", "Null")
   ;要播放的影片代號
   Global $playDrama = IniRead($userHome & "\config.ini", "general", "play_drama", "Null")
   ;要播放的影片名稱
   Global $dramaName = IniRead($userHome & "\config.ini", "drama", $playDrama, "Null")
   ;影片的格式
   Global $videoFormat = IniRead($userHome & "\config.ini", $playDrama, "format", "Null")
   ;要播放哪一集
   Global $nextEP = IniRead($userHome & "\config.ini", $playDrama, "next_ep", "Null")
   ;影片的完整路徑
   Global $video = $videoDIR & "\" & $dramaName & "\" & "ep_" & $nextEP & "." & $videoFormat
   ;影片是否存在
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
	  ;播放第一集
	  $nextEP=1
	  $video = $videoDIR & "\" & $dramaName & "\" & "ep_" & $nextEP & "." & $videoFormat
	  IniWrite($userHome & "\config.ini", $playDrama, "next_ep", "2")
   EndIf

EndFunc

Func playVideo_func()
   ShellExecuteWait($video)
   Sleep(2000)
   ;針對Windows Media Player, 放大到全螢幕(Alt+Enter)
   Send("{ALT Down}{ENTER}{ALT Up}")
EndFunc

Func changeDrama_func()
   Local $dramaCode = IniRead($userHome & "\config.ini", "hotkey", @HotKeyPressed, "Null")
   if $dramaCode <> "Null" Then
	  If $dramaCode <> $playDrama Then
		 ;MsgBox($MB_SYSTEMMODAL, "", $dramaCode)
		 ;修改預設要播放的戲劇
		 IniWrite($userHome & "\config.ini", "general", "play_drama", $dramaCode)
		 If $fileNotExists = True Then
			;還原next_ep
			IniWrite($userHome & "\config.ini", $playDrama, "next_ep", "1")
		 Else
			;還原next_ep
			IniWrite($userHome & "\config.ini", $playDrama, "next_ep", $nextEP)

		 EndIf
		 ;關閉目前的影片
		 WinClose("[CLASS:WMP Skin Host]")

		 ;載入ini設定
		 init_func()

		 ;檢查影片是否存在
		 fileExists_func()

		 ;修改下次要播放第幾集
		 changeEP_func()

		 ;播放影片
		 playVideo_func()


		 ;Exit
	  EndIf
   EndIf
EndFunc

