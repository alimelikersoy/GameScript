#include <ImageSearch2015.au3>
#include <AutoItConstants.au3>

;HotKeySet("{S}", "start")
HotKeySet("{ESC}", "stop")

#comments-start
   Skill's Place On Skill Bar
   1-)Skill
   2-)HP Potion
   3-)MP Potion
   4-)Wolf
   5-)
   6-)
   7-)
   8-)MagicHammer
   9-)
#comments-end

;WIN WAIT ACTIVE
;$knightOnline = WinWaitActive ("Knight OnLine Client", "")

;SETUP OPT
Opt("SendKeyDownDelay", 50)

;MID SCREEN
$midX = 960
$midY = 540

;TRADE VARIABLES
$tradeX = 1780
$tradeY = 100
$blockTradeX = 1720
$blockTradeY = 330

;PARTY VARIABLES
$partyX = 1780
$partyY = 115
$blockPartyX = 1780
$blockPartyY = 360

;WEAPON REPAIR VARIABLES
$weaponLeftX = 1850
$weaponTopY = 250
$weaponRightX = 1890
$weaponBottomY = 290
$weaponColorX = $weaponLeftX + ($weaponRightX - $weaponLeftX) / 2
$weaponColorY = $weaponTopY + ($weaponBottomY - $weaponTopY) / 2
$weaponColor = 0

;HP VARIABLES
$hpLeftX = 25
$hpTopY = 35
$hpRightX = 220
$hpBottomY = 50
$hpColorX = 0
$hpColorY = 37
$hpColor = 986895
$hpBarLength = 0
$hpPotionPercentage = 30
$healingPercentage = 70

;MP VARIABLES
$mpLeftX = 25
$mpTopY = 50
$mpRightX = 220
$mpBottomY = 65
$mpColorX = 0
$mpColorY = 60
$mpColor = 0
$mpBarLength = 0
$mpPercentage = 20

;WOLF VARIABLES
$wolfPicture = "C:\Program Files (x86)\AutoIt3\KnightOnlineScripts\pngs\wolf.png"
$wolfSearchLeftX = 0
$wolfSearchTopY = 85
$wolfSearchRightX = 290
$wolfSearchBottomY = 165
$wolfCordinateX = 0
$wolfCordinateY = 0
$wolfResultPosition = 1
$wolfTolerance = 5
$wolfSendKey = "{4}"
$wolfRemainingTime = 120000
$wolfTime = 120000

;ENEMY VARIABLES
$enemyPicture = "C:\Program Files (x86)\AutoIt3\KnightOnlineScripts\pngs\skeletonwarrior.png"
$secondenemyPicture = "C:\Program Files (x86)\AutoIt3\KnightOnlineScripts\pngs\skeletonknight.png"
$enemySearchLeftX = 845
$enemySearchTopY = 10
$enemySearchRightX = 1070
$enemySearchBottomY = 100
$enemyCordinateX = 0
$enemyCordinateY = 0
$enemyResultPosition = 1
$enemyTolerance = 5
$enemyChoosen = False

;ENEMY TOO FAR
$toofarPicture = "C:\Program Files (x86)\AutoIt3\KnightOnlineScripts\pngs\toofar.png"
$toofarSearchLeftX = 1315
$toofarSearchTopY = 985
$toofarSearchRightX = 1900
$toofarSearchBottomY = 1005
$toofarCordinateX = 0
$toofarCordinateY = 0
$toofarResultPosition = 1
$toofarTolerance = 5

;PET VARIABLES
$pethpLeftX = 25 ;Hp Bar Left Cordinate X
$pethpTopY = 35 ;Hp Bar Left Cordinate Y
$pethpRightX = 220 ;Hp Bar Right Cordinate X
$pethpBottomY = 50 ;Hp Bar Right Cordinate Y
$pethpColorX = 0
$pethpColorY = 37
$pethpColor = 986895
$pethpBarLength = 0 ;Hp Bar Lenght

;SET HP POTION PERCENTAGE
Func setHpPercentage()
   Sleep(1000)
   $hpBarLength = $hpRightX - $hpLeftX
   $hpPotionPercentage = $hpBarLength * $hpPotionPercentage / 100
EndFunc

;USING HP POTION
Func usingHpPotion()
   If PixelGetColor(($hpLeftX + $hpPotionPercentage), $hpColorY) = 0x343434 Or PixelGetColor(($hpLeftX + $hpPotionPercentage), $hpColorY) = 0x353535 Then
	  Send("{2}")
   EndIf
EndFunc

;SET MP POTION PERCENTAGE
Func setMpPercentage()
   Sleep(1000)
   $mpBarLength = $mpRightX - $mpLeftX
   $mpPercentage = $mpBarLength * $mpPercentage / 100
EndFunc

;USING MP POTION
Func usingMpPotion()
   If PixelGetColor(($mpLeftX + $mpPercentage), $mpColorY) = $mpColor Then
	  Send("{3}")
   EndIf
EndFunc

;FEED PET
Func feedPet()
   ;If Not PixelGetColor(249, 56) = 0xD6D631 Then
   If PixelGetColor(255, 58) = 0x6B524A Then
	  Send("{p}")
	  Sleep(2000)
	  MouseClick($MOUSE_CLICK_LEFT, 1720, 45, 1)
	  Sleep(1000)
	  MouseClickDrag($MOUSE_CLICK_LEFT, 1699, 290, 1874, 160)
	  Sleep(1000)
	  MouseClick($MOUSE_CLICK_LEFT, 1717, 203, 1)
	  Send("{p}")
   EndIf
EndFunc

;SET MAGICHAMMER
Func setMagichammer()
   Sleep(1000)
   Send("{I}")
   Sleep(2000)
   $weaponColor = PixelGetColor($weaponColorX, $weaponColorY)
EndFunc

;USING MAGICHAMMER
Func usingMagicHammer()
   If PixelGetColor($weaponColorX, $weaponColorY) <> $weaponColor Then
	  Send("{8}")
	  Sleep(2000)
   EndIf
EndFunc

;TIMELY SKILLS
Func timelySkill($picture, $resultPosition, $searchLeftX, $searchTopY, $searchRightX, $searchBottomY, $cordinateX, $cordinateY, $tolerance, $sendKey, ByRef $remainingTime, $time)
   If TimerDiff($remainingTime) >= $time Then
	  While _ImageSearchArea($picture, $resultPosition, $searchLeftX, $searchTopY, $searchRightX, $searchBottomY, $cordinateX, $cordinateY, $tolerance) = 0
		 Send($sendKey)
		 Sleep(1500)
		 If _ImageSearchArea($picture, $resultPosition, $searchLeftX, $searchTopY, $searchRightX, $searchBottomY, $cordinateX, $cordinateY, $tolerance) = 1 Then
			$remainingTime = TimerInit()
		 EndIf
	  WEnd
   EndIf
EndFunc

;CHOOSE ENEMY
Func chooseEnemy()
   If $enemyChoosen = False Then
	  PixelSearch(862, 10, 862, 100, 0x000000)
	  If _ImageSearchArea($enemyPicture, $enemyResultPosition, $enemySearchLeftX, $enemySearchTopY, $enemySearchRightX, $enemySearchBottomY, $enemyCordinateX, $enemyCordinateY, $enemyTolerance) = 0 And _ImageSearchArea($secondenemyPicture, $enemyResultPosition, $enemySearchLeftX, $enemySearchTopY, $enemySearchRightX, $enemySearchBottomY, $enemyCordinateX, $enemyCordinateY, $enemyTolerance) = 0 Then
		 Call ("timelySkill", $wolfPicture, $wolfResultPosition, $wolfSearchLeftX, $wolfSearchTopY, $wolfSearchRightX, $wolfSearchBottomY, $wolfCordinateX, $wolfCordinateY, $wolfTolerance, $wolfSendKey, $wolfRemainingTime, $wolfTime)
		 Send("{Z}")
		 If _ImageSearchArea($enemyPicture, $enemyResultPosition, $enemySearchLeftX, $enemySearchTopY, $enemySearchRightX, $enemySearchBottomY, $enemyCordinateX, $enemyCordinateY, $enemyTolerance) = 1 Or _ImageSearchArea($secondenemyPicture, $enemyResultPosition, $enemySearchLeftX, $enemySearchTopY, $enemySearchRightX, $enemySearchBottomY, $enemyCordinateX, $enemyCordinateY, $enemyTolerance) = 1 Then
			$enemyChoosen = True
		 EndIf
	  ElseIf Not @error Then
		 Call ("timelySkill", $wolfPicture, $wolfResultPosition, $wolfSearchLeftX, $wolfSearchTopY, $wolfSearchRightX, $wolfSearchBottomY, $wolfCordinateX, $wolfCordinateY, $wolfTolerance, $wolfSendKey, $wolfRemainingTime, $wolfTime)
		 Send("{Z}")
		 PixelSearch(861, 10, 861, 100, 0x97272A)
		 If Not @error Then
			If _ImageSearchArea($enemyPicture, $enemyResultPosition, $enemySearchLeftX, $enemySearchTopY, $enemySearchRightX, $enemySearchBottomY, $enemyCordinateX, $enemyCordinateY, $enemyTolerance) = 1 Or _ImageSearchArea($secondenemyPicture, $enemyResultPosition, $enemySearchLeftX, $enemySearchTopY, $enemySearchRightX, $enemySearchBottomY, $enemyCordinateX, $enemyCordinateY, $enemyTolerance) = 1 Then
			   $enemyChoosen = True
			EndIf
		 EndIf
	  Else
		 $enemyChoosen = True
	  EndIf
   Else
   	  If _ImageSearchArea($toofarPicture, $toofarResultPosition, $toofarSearchLeftX, $toofarSearchTopY, $toofarSearchRightX, $toofarSearchBottomY, $toofarCordinateX, $toofarCordinateY, $toofarTolerance) = 1 Then
		 Call ("timelySkill", $wolfPicture, $wolfResultPosition, $wolfSearchLeftX, $wolfSearchTopY, $wolfSearchRightX, $wolfSearchBottomY, $wolfCordinateX, $wolfCordinateY, $wolfTolerance, $wolfSendKey, $wolfRemainingTime, $wolfTime)
		 Send("{Z}")
	  EndIf
   EndIf
EndFunc

;ATTACK
Func attack()
   If $enemyChoosen = True Then
	  PixelSearch(861, 10, 861, 100, 0x97272A)
	  If Not @error Then
		 Send("{1}")
	  Else
		 $enemyChoosen = False
	  EndIf
   EndIf
EndFunc

;PARTY AND TRADE BLOCK FUCNTION
Func partyAndTradeBlock()
   Sleep(1000)
   Send("{H}")
   Sleep(1000)
   Send("{DOWN}")
   Sleep(1000)
   Send("{TAB}")
   Sleep(1000)
   Send("{DOWN}")
   Sleep(1000)
   Send("{ENTER}")
   Sleep(1000)
   Send("{TAB}")
   Sleep(1000)
   Send("{DOWN}")
   Sleep(1000)
   Send("{TAB}")
   Sleep(1000)
   Send("{DOWN}")
   Sleep(1000)
   Send("{DOWN}")
   Sleep(1000)
   Send("{DOWN}")
   Sleep(1000)
   Send("{ENTER}")
   Sleep(1000)
   Send("{ESC}")
   Sleep(1000)
EndFunc

Func Setup()
   Sleep(5000)
   ;Call ("partyAndTradeBlock")
   Call ("setHpPercentage")
   Call ("setMpPercentage")
   ;Call ("setMagichammer")
EndFunc

Func Update()
   While 1
	  Call ("feedPet")
	  Call ("chooseEnemy")
	  Call ("usingHpPotion")
	  Call ("usingMpPotion")
	  ;Call ("usingMagicHammer")
	  Call ("attack")
   WEnd
EndFunc

Call("Setup")
Call("Update")

Func stop()
   Exit
EndFunc
