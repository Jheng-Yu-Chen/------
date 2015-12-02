#include <MsgBoxConstants.au3>

;檢查影片是否有缺
Example()

Func Example()


;設定要檢查第1集到第幾集
For $i = 1 To 426 Step 1

   ;設定影片位置與影片名稱(EX: ep_123.mp4)
   Local $iFileExists = FileExists("E:\Videos\風水世家\ep_" & $i & ".mp4")
   If Not $iFileExists Then
	  ;顯示缺哪一集
	  MsgBox($MB_SYSTEMMODAL, "", "The file doesn't exist." & @CRLF & "FileExist returned: " & $i)
   EndIf
Next





EndFunc



