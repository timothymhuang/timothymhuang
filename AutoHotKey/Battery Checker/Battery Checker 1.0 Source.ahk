
; https://autohotkey.com/board/topic/7022-acbattery-status/

ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
}

GetBatteryStatus()
{
	VarSetCapacity(powerStatus, 1+1+1+1+4+4)
	success := DllCall("GetSystemPowerStatus", "UInt", &powerStatus)
	
	acLineStatus:=ReadInteger(&powerstatus,0,1,false)
	batteryFlag:=ReadInteger(&powerstatus,1,1,false)
	batteryLifePercent:=ReadInteger(&powerstatus,2,1,false)
	batteryLifeTime:=ReadInteger(&powerstatus,4,4,false)
	batteryFullLifeTime:=ReadInteger(&powerstatus,8,4,false)
	
	output := {}
	output.acLineStatus := acLineStatus
	output.batteryFlag := batteryFlag
	output.batteryLifePercent := batteryLifePercent
	output.batteryLifeTime := batteryLifeTime
	output.batteryFullLifeTime := batteryFullLifeTime
	
	Return output
}

#SingleInstance force
SetWorkingDir %A_ScriptDir%
tone = %A_ScriptDir%\tone.wav
filemaxbatt = %A_ScriptDir%\max.txt
fileminbatt = %A_ScriptDir%\min.txt

Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu, Tray, Add, Help, help
Menu, Tray, Add, Maximum Battery, maxbatt
Menu, Tray, Add, Minimum Battery, minbatt
Menu, Tray, Add, Exit, exitapp



LowAlert = 1
HighAlert = 1

BatteryAmount := BatteryStatus.batteryLifePercent
BatteryStatus := GetBatteryStatus()
BatteryAmount := BatteryStatus.batteryLifePercent
BatteryStatus := GetBatteryStatus()

If(BatteryAmount == 255){
    MsgBox,4096,Error: No Battery Found,This program only works if the computer has a battery (such as a laptop). The program will quit in 10 seconds.,10
    ;ExitApp 
} else {
    MsgBox,4096,Battery Checker 1.0,Battery Checker 1.0 is now active.,3
}

RestartLoop:
Loop
{
    BatteryAmount := BatteryStatus.batteryLifePercent
    BatteryStatus := GetBatteryStatus()
    BatteryAmount := BatteryStatus.batteryLifePercent
    BatteryStatus := GetBatteryStatus()
    if !FileExist(filemaxbatt)
        FileAppend, 80, %filemaxbatt%
    else
    {
        FileRead, temp, %filemaxbatt%
        if (temp>0 && temp<=100 && Mod(temp, Floor(temp))=0){
            maxbatt := temp
        } else {
            FileDelete, %filemaxbatt%
            FileAppend, 80, %filemaxbatt%
            minbatt := temp
        }
    }
    
    if !FileExist(fileminbatt)
        FileAppend, 40, %fileminbatt%
    else
    {
        FileRead, temp, %fileminbatt%
        if (temp>0 && temp<=100 && Mod(temp, Floor(temp))=0){
            minbatt := temp
        } else {
            FileDelete, %fileminbatt%
            FileAppend, 40, %fileminbatt%
            minbatt := temp
        }
    }


    If (BatteryStatus.acLineStatus = 0 && BatteryAmount <= %minbatt%){
        HighAlert = 1
        If LowAlert = 0
        {
            Sleep, 5000
            GoSub, RestartLoop
        }
        
        if FileExist(tone)
            SoundPlay, %tone%
        else
            SoundBeep, 500, 500
        
        MsgBox,4097,Battery Low, Please plug in your laptop.`n`nYes to Snooze for 1 minute.`nCancel to ignore this alert.,10
        IfMsgBox, Cancel
        {
            LowAlert = 0
        }
        else IfMsgBox, OK
        {
            Sleep, 60000
            GoSub, RestartLoop
        }
        else IfMsgBox, Timeout
        {
            GoSub, RestartLoop
        }
    } else if(BatteryStatus.acLineStatus = 1 && BatteryAmount >= %maxbatt%){
        LowAlert = 1
        If HighAlert = 0
        {
            Sleep, 5000
            GoSub, RestartLoop
        }

        if FileExist(tone)
            SoundPlay, %tone%
        else
            SoundBeep, 500, 500
        
        MsgBox, 4097,Battery High,Please unplug your laptop.`n`nYes to Snooze for 1 minute.`nCancel to ignore this alert.,10
        IfMsgBox, Cancel
        {
            HighAlert = 0
        }
        else IfMsgBox, OK
        {
            Sleep, 60000
            GoSub, RestartLoop
        }
        else IfMsgBox, Timeout
        {
            GoSub, RestartLoop
        }
    } else {
        LowAlert = 1
        HighAlert = 1
    }
    Sleep, 5000
}

Return

maxbatt:
{
    InputBox, temp, Maximum Battery, Please enter maximum battery amount. It's currently at %maxbatt%`%
    if ErrorLevel
        Return
    else
        If(temp>0 && temp<=100 && Mod(temp, Floor(temp))=0)
        {
            FileDelete, %filemaxbatt%
            FileAppend, %temp%, %filemaxbatt%
        } else {
            MsgBox, 4096,Invalid Input, Please enter a whole number between 1-100.,10
        }
}
Return

minbatt:
{
    InputBox, temp, Minimum Battery, Please enter minimum battery amount. It's currently at %minbatt%`%
    if ErrorLevel
        Return
    else
        If(temp>0 && temp<=100 && Mod(temp, Floor(temp))=0)
        {
            FileDelete, %fileminbatt%
            FileAppend, %temp%, %fileminbatt%
        } else {
            MsgBox, 4096,Invalid Input, Please enter a whole number between 1-100.,10
        }
}
Return

help:
url := "https://github.com/timothymhuang/timothymhuang/tree/main/AutoHotKey/Battery%20Checker"
Run %url%
Return

exitapp:
MsgBox, 4100, Battery Checker, Are you sure you want to quit Battery Checker?
IfMsgBox, Yes
    exitapp
Return