#include <MsgBoxConstants.au3>

;�ˬd�v���O�_����
Example()

Func Example()


;�]�w�n�ˬd��1����ĴX��
For $i = 1 To 426 Step 1

   ;�]�w�v����m�P�v���W��(EX: ep_123.mp4)
   Local $iFileExists = FileExists("E:\Videos\�����@�a\ep_" & $i & ".mp4")
   If Not $iFileExists Then
	  ;��ܯʭ��@��
	  MsgBox($MB_SYSTEMMODAL, "", "The file doesn't exist." & @CRLF & "FileExist returned: " & $i)
   EndIf
Next





EndFunc



