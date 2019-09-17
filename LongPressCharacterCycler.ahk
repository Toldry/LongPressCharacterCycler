﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;; https://www.autohotkey.com/boards/viewtopic.php?t=55584


KEYBOARD_LAYOUT_ENGLISH := 67699721
KEYBOARD_LAYOUT_HEBREW  := 67961869

$*a::
$*e::
$*i::
$*o::
$*c::
$*u::
$*n::
$*s::
if 		InStr(A_ThisHotkey, "a")
{
	originalLetter := "a"
	variantPairs := [["Á","á"],["Ä","ä"],["α","α"] ,["Å","å"],["À","à"],["Ä","ä"],["Ã","ã"],["Ā","ā"],["Æ","æ"]]
}
else if InStr(A_ThisHotkey, "e")
{
	originalLetter := "e"
	variantPairs := [["É","é"], ["Ë","ë"], ["ϵ","ε"], ["È","è"], ["Ê","ê"], ["Ē","ē"]]
}
else if InStr(A_ThisHotkey, "i")
{
	originalLetter := "i"
	variantPairs := [["Í","í"],["Ï","ï"],["Ì","ì"],["Î","î"],["Ī","ī"]]
}
else if InStr(A_ThisHotkey, "o")
{
	originalLetter := "o"
	variantPairs := [["Ó","ó"],["Ö","ö"],["Ø","ø"],["Ω","ω"],["Ò","ò"],["Õ","õ"],["Ō","ō"],["Œ","œ"]]
}
else if InStr(A_ThisHotkey, "u")
{
	originalLetter := "u"
	variantPairs := [["Ü","ü"],["Ú","ú"],["Ù","ù"],["Û","û"],["Ū","ū"]]
}
else if InStr(A_ThisHotkey, "c")
{
	originalLetter := "c"
	variantPairs := [["Ç","ç"]]
}
else if InStr(A_ThisHotkey, "n")
{
	originalLetter := "n"
	variantPairs := [["Ñ","ñ"]]
}
else if InStr(A_ThisHotkey, "s")
{
	originalLetter := "s"
	variantPairs := [["ẞ","ẞ"],["Σ","σ"],["§","§"]]
}
currentKeyboardLayout := DllCall("GetKeyboardLayout", "Int", DllCall("GetWindowThreadProcessId", "Int", WinActive("A"), "Int", 0))
if (currentKeyboardLayout != KEYBOARD_LAYOUT_ENGLISH)
{
	Send {Blind}{%originalLetter%}
	return
}
else 
{
	Send {Blind}{%originalLetter%}
	For _,pair in variantPairs 
	{
		KeyWait, %originalLetter%, T0.5
		if !ErrorLevel {
			return
		}
		Capital := (GetKeyState("Shift", "P") ^ GetKeyState("CapsLock", "T") = 1)
		uppercaseLetter := pair[1]
		lowercaseLetter := pair[2]
		if(!Capital)
		{
			Send {BackSpace}{%lowercaseLetter%}
		}
		else if (Capital)
		{
			Send {BackSpace}{%uppercaseLetter%}
		}
	}
	KeyWait, %originalLetter%
}
return