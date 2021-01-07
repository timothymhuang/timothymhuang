!f4::
Sleep, 500
Progress, b w500, Please Wait, Increasing WiFi Speed, Wifi Speed Increaser
TheProgress = 0
Loop
{
    Random, AddRandom, 0, 30
    TheProgress := TheProgress + AddRandom
    Progress, %TheProgress%
    Random, WaitRandom, 500, 1500
    Sleep, %WaitRandom%
    if(TheProgress > 99){
        Break
    }
}
Sleep, 500
Progress, Off
Random, RandomNum , 1, 40
MsgBox % "WiFi speed has now increased by " RandomNum "%"
Return

esc::ExitApp