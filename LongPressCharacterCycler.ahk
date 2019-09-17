#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
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
$*u::
$*n::
$*s::
$*d::
$*=::
$*-::
originalLetter := RegExReplace(A_ThisHotkey, "\$?\*?(.)", "$1")
currentKeyboardLayout := DllCall("GetKeyboardLayout", "Int", DllCall("GetWindowThreadProcessId", "Int", WinActive("A"), "Int", 0))
if (currentKeyboardLayout != KEYBOARD_LAYOUT_ENGLISH)
{
	Send {Blind}{%originalLetter%}
	return
}
if 0
{
	return
}
else if InStr(A_ThisHotkey, "a")
{
	variantPairs := [["Á","á"],["Ä","ä"],["α"],["Ɐ"],["Æ","æ"],["Å","å"]]
}
else if InStr(A_ThisHotkey, "e")
{
	variantPairs := [["É","é"],["Ë","ë"],["€"],["ϵ","ε"],["∃"],["∅"]]
}
else if InStr(A_ThisHotkey, "i")
{
	variantPairs := [["Í","í"],["∞"]]
}
else if InStr(A_ThisHotkey, "o")
{
	variantPairs := [["Ó","ó"],["Ö","ö"],["Ω","ω"]]
}
else if InStr(A_ThisHotkey, "u")
{
	variantPairs := [["Ú","ú"],["Ü","ü"],["∪"],["∩"]]
}
else if InStr(A_ThisHotkey, "d")
{
	variantPairs := [["∂"]]
}
else if InStr(A_ThisHotkey, "n")
{
	variantPairs := [["Ñ","ñ"]]
}
else if InStr(A_ThisHotkey, "s")
{
	variantPairs := [["₪"],["ẞ"],["Σ","σ"],["§"]]
}
else if InStr(A_ThisHotkey, "=")
{
	variantPairs := [["≈"],["≠"],["∈"],["∉"],["⊂"],["⊆"]]
}
else if InStr(A_ThisHotkey, "-")
{
	variantPairs := [["—"],["⸺"],["⸻"]]
}
Send {Blind}{%originalLetter%}
For _,pair in variantPairs 
{
	KeyWait, %originalLetter%, T0.7
	if !ErrorLevel 
	{
		return
	}
	Capitalize := (GetKeyState("Shift", "P") ^ GetKeyState("CapsLock", "T") = 1) ; Shift XOR CapsLock
	uppercaseLetter := pair[1]
	lowercaseLetter := pair[2] ; sometimes this will be empty
	if (Capitalize  || !lowercaseLetter)
	{
		Send {BackSpace}{%uppercaseLetter%}
	}
	else
	{
		Send {BackSpace}{%lowercaseLetter%}
	}
}
KeyWait, %originalLetter%
return