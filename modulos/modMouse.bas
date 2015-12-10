Attribute VB_Name = "modMouse"
Option Compare Database
Option Explicit

'--------------------------------------------------------------
'MOUSE
'--------------------------------------------------------------
'Posiciona e realiza cliques com o mouse.
'--------------------------------------------------------------
'Funções principais:
'   * SetCursorPos()
'   * SingleClick()
'   * DoubleClick()
'   * RightClick()
'--------------------------------------------------------------
'Ref.: http://excelhelphq.com/how-to-move-and-click-the-mouse-in-vba/
'--------------------------------------------------------------
'Adaptado por 'mpt'.
'--------------------------------------------------------------

Public Declare Function SetCursorPos Lib "user32" (ByVal x As Long, ByVal y As Long) As Long

Public Declare Sub mouse_event Lib "user32" (ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long)
Public Const MOUSEEVENTF_LEFTDOWN = &H2
Public Const MOUSEEVENTF_LEFTUP = &H4
Public Const MOUSEEVENTF_RIGHTDOWN As Long = &H8
Public Const MOUSEEVENTF_RIGHTUP As Long = &H10

Public Sub SingleClick()
  'Single click
  mouse_event MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0
  mouse_event MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
End Sub

Public Sub DoubleClick()
  'Double click as a quick series of two clicks
  mouse_event MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0
  mouse_event MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
  mouse_event MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0
  mouse_event MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
End Sub

Public Sub RightClick()
  'Right click
  mouse_event MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0
  mouse_event MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0
End Sub
