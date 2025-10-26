Unit TOSH; { Unit to communicate with Toshiba chips } {v1.41}
Interface
{Note: Mfg. ID from 2nd bank}

Implementation

Uses Flash, GenFlash, Tools;

Function TOSHIdChip( DevId : Word; Var CInfo : ChipInfo ) : Boolean; Far;
Begin
 TOSHIdChip := False;
 With CInfo do
  Begin
   Case DevId of
    $38,
    $4C,
    $BA : Begin {v1.41}
           Flags  := 0;   {sector mode}
           PgSize := 128; {'page' size, program 128 bytes at a time}
           Progr  := AMDSecProg;
           Erase := AMDSecErase;
           Sectors[ 0, 0 ] := 1;  {1 x 16k}
           Sectors[ 0, 1 ] := 128;
           Sectors[ 1, 0 ] := 2;  {2 x 8k}
           Sectors[ 1, 1 ] := 64;
           Sectors[ 2, 0 ] := 1;  {1 x 32k}
           Sectors[ 2, 1 ] := 256;
           Sectors[ 3, 0 ] := 7;  {7 x 64k}
           Sectors[ 3, 1 ] := 512;
           Size := 512;
           Case DevId of
            $38 : Name := ConstPtr( 'TC58F400/5V' ); {Bottom Boot Block}
            $4C : Name := ConstPtr( 'TC58FVB400/3V' ); {Bottom Boot Block}
            $BA : Name := ConstPtr( 'TC58FVB004/3V' ); {Bottom Boot Block}
           End;
          End;     
     $CE : Begin {v1.41}
           Flags  := 0;   {sector mode}
           PgSize := 128; {'page' size, program 128 bytes at a time}
           Progr  := AMDSecProg;
           Erase := AMDSecErase;
           Sectors[ 0, 0 ] := 1;  {1 x 16k}
           Sectors[ 0, 1 ] := 128;
           Sectors[ 1, 0 ] := 2;  {2 x 8k}
           Sectors[ 1, 1 ] := 64;
           Sectors[ 2, 0 ] := 1;  {1 x 32k}
           Sectors[ 2, 1 ] := 256;
           Sectors[ 3, 0 ] := 7;  {7 x 64k}
           Sectors[ 3, 1 ] := 512;
           Size := 1024;
           Case DevId of
            $CE : Name := ConstPtr( 'TC58FVB800/3V' ); {Bottom Boot Block}
           End;
          End;     
    $3B,
    $68,
    $98 : Begin {v1.41}
           Flags  := 0;   {sector mode}
           PgSize := 128; {'page' size, program 128 bytes at a time}
           Progr  := AMDSecProg;
           Erase := AMDSecErase;
           Sectors[ 0, 0 ] := 7;  {7 x 64k}
           Sectors[ 0, 1 ] := 512;
           Sectors[ 1, 0 ] := 1;  {1 x 32k}
           Sectors[ 1, 1 ] := 256;
           Sectors[ 2, 0 ] := 2;  {2 x 8k}
           Sectors[ 2, 1 ] := 64;
           Sectors[ 3, 0 ] := 1;  {1 x 16k}
           Sectors[ 3, 1 ] := 128;
           Size := 512;
           Case DevId of
           	$3B : Name := ConstPtr( 'TC58FVT004/3V' ); {Top Boot Block}
            $68 : Name := ConstPtr( 'TC58F401/5V' ); {Top Boot Block}
            $98 : Name := ConstPtr( 'TC58FVT400/3V' ); {Top Boot Block}
           End;
          End;
    $4F : Begin {v1.41}
           Flags  := 0;   {sector mode}
           PgSize := 128; {'page' size, program 128 bytes at a time}
           Progr  := AMDSecProg;
           Erase := AMDSecErase;
           Sectors[ 0, 0 ] := 15;  {7 x 64k}
           Sectors[ 0, 1 ] := 512;
           Sectors[ 1, 0 ] := 1;  {1 x 32k}
           Sectors[ 1, 1 ] := 256;
           Sectors[ 2, 0 ] := 2;  {2 x 8k}
           Sectors[ 2, 1 ] := 64;
           Sectors[ 3, 0 ] := 1;  {1 x 16k}
           Sectors[ 3, 1 ] := 128;
           Size := 1024;
           Case DevId of
            $4F : Name := ConstPtr( 'TC58FVT800/3V' ); {Top Boot Block}
           End;
          End;
    else Exit;
   End;
  End;
 CInfo.Manuf := ConstPtr( 'Toshiba' );
 TOSHIdChip := True;
End;

Begin
 RegisterFlashManu( $98, TOSHIdChip );
End.