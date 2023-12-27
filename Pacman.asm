Multiply macro input1, input2;return AX = input1 * input2; Success
    push BX
    mov AX, input1
    mov BX, input2
    imul BX
	Mov DX, 0
    pop BX
endm
matrix_space macro X, Y, X_ADD, Y_ADD;Success
	local Pivotal_point, PASS
    push BX
    Mov BX, X
    add BX, X_ADD
    Multiply BX, 28
    Mov BX, AX
    add BX, Y
    add BX, Y_ADD
    Mov AX, 0
    Mov Al, matrix[BX]
	cmp Al, 7
	je Pivotal_point
	jne PASS
Pivotal_point:
	Mov Al, 0
PASS:
    pop BX
endm

matrix_return macro X, Y;Success
	local Pivotal_point, PASS
    push BX
    Mov BX, X
    Multiply BX, 28
    Mov BX, AX
    add BX, Y
    Mov AX, 0
    Mov Al, matrix[BX]
    pop BX
endm

Push5_parameter macro input1, input2, input3, input4, input5;Success
    Mov AX, input1
    Mov PX, AX
    Mov AX, input2
    Mov PY, AX
    Mov AX, input3
    Mov GX, AX
    Mov AX, input4
    Mov GY, AX
    Mov AX, input5
    Mov G_dir, AX
endm

Ghost1_to_Direction macro input1, input2, input3, input4, input5
	Mov AX, input1
	Mov GX, AX
	Mov AX, input2
	Mov GY, AX
	Mov AX, input3
	Mov G_dir, AX
	Mov AX, input4
	Mov PX, AX
	Mov AX, input5
	Mov PY, AX
	Mov Direction_usable[0], 0
    Mov Direction_usable[1], 0
    Mov Direction_usable[2], 0
    Mov Direction_usable[3], 0
endm
summanypixel macro x,y,size,col
local l1
push cx
mov b1,x
mov b2,y

mov cx,size
l1:
    WrPixel b1,b2,col
    inc b1
    dec cx 
    cmp cx,0
    jne l1
pop cx
endm
Ghost2_to_Direction macro
	local dir_0, dir_0_PASS, dir_1, dir_1_PASS, dir_2, dir_2_PASS, dir_3, dir_3_PASS
	Mov AX, Ghost2_X
	Mov GX, AX
	Mov AX, Ghost2_Y
	Mov GY, AX
    Mov AX, Ghost2_dir
	Mov G_dir, AX
	Mov Direction_usable[0], 0
    Mov Direction_usable[1], 0
    Mov Direction_usable[2], 0
    Mov Direction_usable[3], 0
	
	Mov AX, Pacman_Dir
	cmp AX, 0
	je dir_0
	jne dir_0_PASS
	dir_0:
		Mov AX, Pacman_X
		SUB AX, 8
		Mov PX, AX
		Mov AX, Pacman_Y
		Mov PY, AX
	dir_0_PASS:
	cmp AX, 1
	je dir_1
	jne dir_1_PASS
	dir_1:
		Mov AX, Pacman_Y
		ADD AX, 8
		Mov PY, AX
		Mov AX, Pacman_X
		Mov PX, AX
	dir_1_PASS:
	cmp AX, 2
	je dir_2
	jne dir_2_PASS
	dir_2:
		Mov AX, Pacman_X
		ADD AX, 8
		Mov PX, AX
		Mov AX, Pacman_Y
		Mov PY, AX
	dir_2_PASS:
	cmp AX, 3
	je dir_3
	jne dir_3_PASS
	dir_3:
		Mov AX, Pacman_Y
		SUB AX, 8
		Mov PY, AX
		Mov AX, Pacman_X
		Mov PX, AX
	dir_3_PASS:
endm
sumpac macro x,y,col
pushA
mov ax,x
mov bx,y
add ax,4
summanypixel ax,bx,3,col;1
inc bx
sub ax,2
summanypixel ax,bx,7,col;2
inc bx
dec ax
summanypixel ax,bx,9,col;3
dec ax
inc bx
summanypixel ax,bx,11,col;4
add ax,2
inc bx
summanypixel ax,bx,9,col;5
add ax,3
inc bx
summanypixel ax,bx,7,col;6
add ax,2
inc bx
summanypixel ax,bx,5,col;7
inc bx 
sub ax,2
summanypixel ax,bx,7,col;8
inc bx
sub ax,3
summanypixel ax,bx,9,col;9
inc bx
sub ax,2
summanypixel ax,bx,11,col;10
inc bx
inc ax
summanypixel ax,bx,9,col;11
inc bx
inc ax
summanypixel ax,bx,7,col;12
add ax,2
inc bx
summanypixel ax,bx,3,col;13
POPA
endm
sumghost macro x2,y2,col
pushA
mov cx,x2
mov dx,y2
add cx,6
summanypixel cx,dx,4,col;1
inc dx
sub cx,2
summanypixel cx,dx,8,col;2
inc dx
dec cx
summanypixel cx,dx,10,col;3
inc dx
dec cx
summanypixel cx,dx,3,col;4/1
add cx,3
summanypixel cx,dx,2,1111b;4/2
add cx,2
summanypixel cx,dx,4,col;4/3
add cx,4
summanypixel cx,dx,2,1111b;4/4
add cx,1
summanypixel cx,dx,2,col;4/5
inc dx
sub cx,11
summanypixel cx,dx,2,col;5/1
add cx,2
summanypixel cx,dx,4,1111b;5/2
add cx,4
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,4,1111b;5/5
add cx,4
WrPixel cx,dx,col
sub cx,12
inc dx
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,1111b
add cx,2
summanypixel cx,dx,2,0000b
add cx,2
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,1111b
add cx,2
summanypixel cx,dx,2,0000b;6
add cx,2
WrPixel cx,dx,col
sub cx,13
inc dx
summanypixel cx,dx,3,col;7
add cx,3
summanypixel cx,dx,2,1111b
add cx,2
summanypixel cx,dx,2,0000b
add cx,2
summanypixel cx,dx,2,col;7
add cx,2
summanypixel cx,dx,2,1111b
add cx,2
summanypixel cx,dx,2,0000b
add cx,2
WrPixel cx,dx,col;7
sub cx,13
inc dx
summanypixel cx,dx,4,col;8
add cx,4
summanypixel cx,dx,2,1111b
add cx,2
summanypixel cx,dx,4,col
add cx,4
summanypixel cx,dx,2,1111b
add cx,2
summanypixel cx,dx,2,col
sub cx,12
inc dx
summanypixel cx,dx,14,col;9
inc dx
summanypixel cx,dx,14,col;10
inc dx
summanypixel cx,dx,14,col;11
inc dx
summanypixel cx,dx,14,col;12
inc dx 
summanypixel cx,dx,2,col;13
add cx,3
summanypixel cx,dx,3,col
add cx,5
summanypixel cx,dx,3,col
add cx,4
summanypixel cx,dx,2,col;
sub cx,12
inc dx
WrPixel cx,dx,col;14
add cx,3
summanypixel cx,dx,2,col
add cx,4
summanypixel cx,dx,2,col
add cx,4
WrPixel cx,dx,col
popa
endm
Ghost3_to_Direction macro
    local Direction0_Pass, Direction1_Pass, Direction2_Pass, Direction3_Pass
    Mov AX, Ghost3_dir
    Mov G_dir, AX
	cmp Pacman_Dir, 0
    jne Direction0_Pass
    Mov AX, Pacman_Y
    SUB AX, 8
    Mov PY, AX
    Mov AX, Pacman_X
    Mov PX, AX
Direction0_Pass:
    cmp Pacman_Dir, 1
    jne Direction1_Pass
    Mov AX, Pacman_X
    SUB AX, 8
    Mov PX, AX
    Mov AX, Pacman_Y
    Mov PY, AX
Direction1_Pass:
    cmp Pacman_Dir, 2
    jne Direction2_Pass
    Mov AX, Pacman_Y
    ADD AX, 8
    Mov PY, AX
    Mov AX, Pacman_X
    Mov PX, AX
Direction2_Pass:
    cmp Pacman_Dir, 3
    jne Direction3_Pass
    Mov AX, Pacman_X
    ADD AX, 8
    Mov PX, AX
    Mov AX, Pacman_Y
    Mov PY, AX
Direction3_Pass:
	Mov Direction_usable[0], 0
    Mov Direction_usable[1], 0
    Mov Direction_usable[2], 0
    Mov Direction_usable[3], 0
endm

Ghost4_to_Direction macro
	local Direction0_Pass, Direction1_Pass, Direction2_Pass, Direction3_Pass
    Mov AX, Ghost4_dir
    Mov G_dir, AX
	cmp Pacman_Dir, 0
    jne Direction0_Pass
    Mov AX, Pacman_Y
    SUB AX, 16
    Mov PY, AX
    Multiply PY, 2
    SUB AX, Ghost2_Y
    Mov PY, AX
    Multiply Pacman_X, 2
    SUB AX, Ghost2_X
    Mov PX, AX
Direction0_Pass:
    cmp Pacman_Dir, 1
    jne Direction1_Pass
    Mov AX, Pacman_X
    SUB AX, 16
    Mov PX, AX
    Multiply PX, 2
    SUB AX, Ghost2_X
    Mov PX, AX
    Multiply Pacman_Y, 2
    SUB AX, Ghost2_Y
    Mov PY, AX
Direction1_Pass:
    cmp Pacman_Dir, 2
    jne Direction2_Pass
    Mov AX, Pacman_Y
    ADD AX, 16
    Mov PY, AX
    Multiply PY, 2
    SUB AX, Ghost2_Y
    Mov PY, AX
    Multiply Pacman_X, 2
    SUB AX, Ghost2_X
    Mov PX, AX
Direction2_Pass:
    cmp Pacman_Dir, 3
    jne Direction3_Pass
    Mov AX, Pacman_X
    ADD AX, 16
    Mov PX, AX
    Multiply PX, 2
    SUB AX, Ghost2_X
    Mov PX, AX
    Multiply Pacman_Y, 2
    SUB AX, Ghost2_Y
    Mov PY, AX
Direction3_Pass:
	Mov Direction_usable[0], 0
    Mov Direction_usable[1], 0
    Mov Direction_usable[2], 0
    Mov Direction_usable[3], 0
endm

Ghost1_Position_change macro
	local Position_0, Position_0_Pass, Position_1, Position_1_Pass, Position_2, Position_2_Pass, Position_3, Position_3_Pass
	
	cmp Ghost1_dir, 0
	je Position_0
	jne Position_0_Pass
	Position_0:
		DEC Ghost1_X
	Position_0_Pass:	
	
	cmp Ghost1_dir, 1
	je Position_1
	jne Position_1_Pass
	Position_1:
		INC Ghost1_Y
	Position_1_Pass:
	
	cmp Ghost1_dir, 2
	je Position_2
	jne Position_2_Pass
	Position_2:
		INC Ghost1_X
	Position_2_Pass:
	
	cmp Ghost1_dir, 3
	je Position_3
	jne Position_3_Pass
	Position_3:
		DEC Ghost1_Y
	Position_3_Pass:
endm

Ghost2_Position_change macro
	local Position_0, Position_0_Pass, Position_1, Position_1_Pass, Position_2, Position_2_Pass, Position_3, Position_3_Pass
	
	cmp Ghost2_dir, 0
	je Position_0
	jne Position_0_Pass
	Position_0:
		DEC Ghost2_X
	Position_0_Pass:	
	
	cmp Ghost2_dir, 1
	je Position_1
	jne Position_1_Pass
	Position_1:
		INC Ghost2_Y
	Position_1_Pass:
	
	cmp Ghost2_dir, 2
	je Position_2
	jne Position_2_Pass
	Position_2:
		INC Ghost2_X
	Position_2_Pass:
	
	cmp Ghost2_dir, 3
	je Position_3
	jne Position_3_Pass
	Position_3:
		DEC Ghost2_Y
	Position_3_Pass:
endm

Ghost3_Position_change macro;/////////////////////////////////
	local Position_0, Position_0_Pass, Position_1, Position_1_Pass, Position_2, Position_2_Pass, Position_3, Position_3_Pass
	
	cmp Ghost3_dir, 0
	je Position_0
	jne Position_0_Pass
	Position_0:
		DEC Ghost3_X
	Position_0_Pass:	
	
	cmp Ghost3_dir, 1
	je Position_1
	jne Position_1_Pass
	Position_1:
		INC Ghost3_Y
	Position_1_Pass:
	
	cmp Ghost3_dir, 2
	je Position_2
	jne Position_2_Pass
	Position_2:
		INC Ghost3_X
	Position_2_Pass:
	
	cmp Ghost3_dir, 3
	je Position_3
	jne Position_3_Pass
	Position_3:
		DEC Ghost3_Y
	Position_3_Pass:
endm

Ghost4_Position_change macro;/////////////////////////////////
	local Position_0, Position_0_Pass, Position_1, Position_1_Pass, Position_2, Position_2_Pass, Position_3, Position_3_Pass
	
	cmp Ghost4_dir, 0
	je Position_0
	jne Position_0_Pass
	Position_0:
		DEC Ghost4_X
	Position_0_Pass:	
	
	cmp Ghost4_dir, 1
	je Position_1
	jne Position_1_Pass
	Position_1:
		INC Ghost4_Y
	Position_1_Pass:
	
	cmp Ghost4_dir, 2
	je Position_2
	jne Position_2_Pass
	Position_2:
		INC Ghost4_X
	Position_2_Pass:
	
	cmp Ghost4_dir, 3
	je Position_3
	jne Position_3_Pass
	Position_3:
		DEC Ghost4_Y
	Position_3_Pass:
endm

Game_over macro
local Ghost1_compare, Ghost1_compare_pass, Ghost2_compare, Ghost2_compare_pass
local Ghost3_compare, Ghost3_compare_pass, Ghost4_compare, Ghost4_compare_pass, Return_1, RETURN
    Mov AX, Ghost1_X
    Mov BX, Pacman_X
	cmp AX, BX
    je Ghost1_compare
    jne Ghost1_compare_pass
Ghost1_compare:
    Mov AX, Ghost1_Y
    Mov BX, Pacman_Y
    cmp AX, BX
    je Return_1
Ghost1_compare_pass:

    Mov AX, Ghost2_X
    Mov BX, Pacman_X
	cmp AX, BX
    je Ghost2_compare
    jne Ghost2_compare_pass
Ghost2_compare:
    Mov AX, Ghost2_Y
    Mov BX, Pacman_Y
    cmp AX, BX
    je Return_1
Ghost2_compare_pass:

    Mov AX, Ghost3_X
    Mov BX, Pacman_X
	cmp AX, BX
    je Ghost3_compare
    jne Ghost3_compare_pass
Ghost3_compare:
    Mov AX, Ghost3_Y
    Mov BX, Pacman_Y
    cmp AX, BX
    je Return_1
Ghost3_compare_pass:

    Mov AX, Ghost4_X
    Mov BX, Pacman_X
	cmp AX, BX
    je Ghost4_compare
    jne Ghost4_compare_pass
Ghost4_compare:
    Mov AX, Ghost4_Y
    Mov BX, Pacman_Y
    cmp AX, BX
    je Return_1
Ghost4_compare_pass:
    Mov AX, 0
    JMP RETURN
Return_1:
    Mov AX, 1
RETURN:
endm
Scan_IN macro
    local PASS
	mov ah,06h
	mov dl,0ffh
	int 21h
    cmp al, 0
    je PASS
    Mov char, al
PASS:
endm

;///////////////////////////////////
Start_Time macro
	Mov ah, 2ch
	int 21h
	Mov Start_Time_h, Ch
	Mov Start_Time_m, Cl
	Mov Start_Time_s, dh
endm
;/////////////////////////////////////////
SetMode macro mode    ;?]?w?????
        mov ah,00h
        mov al,mode
        int 10h
        endm

SetColor macro color  ;?]?w?I????
         mov ah,0bh 
         mov bh,00h
         mov bl,color  
         int 10h
         endm
WrPixel macro col,row,color  ;?g?J???I
		push ax
		push bx
		push cx
		push dx
        mov ah,0ch
        mov bh,00h
        mov al,color
        mov cx,col
        mov dx,row
        int 10h
		pop dx
		pop cx
		pop bx
		pop ax
endm
sumghostc macro x2,y2,col
pushA
mov cx,x2
mov dx,y2
add cx,6
summanypixel cx,dx,4,col;1
inc dx
sub cx,2
summanypixel cx,dx,8,col;2
inc dx
dec cx
summanypixel cx,dx,10,col;3
inc dx
dec cx
summanypixel cx,dx,3,col;4/1
add cx,3
summanypixel cx,dx,2,col;4/2
add cx,2
summanypixel cx,dx,4,col;4/3
add cx,4
summanypixel cx,dx,2,col;4/4
add cx,1
summanypixel cx,dx,2,col;4/5
inc dx
sub cx,11
summanypixel cx,dx,2,col;5/1
add cx,2
summanypixel cx,dx,4,col;5/2
add cx,4
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,4,col;5/5
add cx,4
WrPixel cx,dx,col
sub cx,12
inc dx
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col;6
add cx,2
WrPixel cx,dx,col
sub cx,13
inc dx
summanypixel cx,dx,3,col;7
add cx,3
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col;7
add cx,2
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col
add cx,2
WrPixel cx,dx,col;7
sub cx,13
inc dx
summanypixel cx,dx,4,col;8
add cx,4
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,4,col
add cx,4
summanypixel cx,dx,2,col
add cx,2
summanypixel cx,dx,2,col
sub cx,12
inc dx
summanypixel cx,dx,14,col;9
inc dx
summanypixel cx,dx,14,col;10
inc dx
summanypixel cx,dx,14,col;11
inc dx
summanypixel cx,dx,14,col;12
inc dx 
summanypixel cx,dx,2,col;13
add cx,3
summanypixel cx,dx,3,col
add cx,5
summanypixel cx,dx,3,col
add cx,4
summanypixel cx,dx,2,col;
sub cx,12
inc dx
WrPixel cx,dx,col;14
add cx,3
summanypixel cx,dx,2,col
add cx,4
summanypixel cx,dx,2,col
add cx,4
WrPixel cx,dx,col
popa
endm
sumcircle macro x,y,col
push cx
push dx
mov cx,x
mov dx,y
add cx,5
summanypixel cx,dx,3,col;1
inc dx
sub cx,2
summanypixel cx,dx,7,col;2
inc dx
dec cx
summanypixel cx,dx,9,col;3
dec cx
inc dx
summanypixel cx,dx,11,col;4
inc dx
summanypixel cx,dx,11,col;5
dec cx 
inc dx
summanypixel cx,dx,13,col;6
inc dx
summanypixel cx,dx,13,col;7
inc dx
summanypixel cx,dx,13,col;8
inc dx
inc cx
summanypixel cx,dx,11,col;9
inc dx
summanypixel cx,dx,11,col;10
inc dx
inc cx
summanypixel cx,dx,9,col;11
inc cx
inc dx
summanypixel cx,dx,7,col;12
inc dx
add cx,2
summanypixel cx,dx,3,col;13
pop dx
pop cx
endm
upsmile macro x,y
push cx
push dx
mov cx,x
mov dx,y
add cx,5
summanypixel cx,dx,3,0h
inc dx  
dec cx
summanypixel cx,dx,5,0h ;4
inc dx
summanypixel cx,dx,5,0h 
inc dx
inc cx
summanypixel cx,dx,3,0h
inc dx
summanypixel cx,dx,3,0h
inc dx
summanypixel cx,dx,3,0h
inc dx
inc cx
WrPixel cx,dx,0h
inc dx
WrPixel cx,dx,0h
pop dx
pop cx
endm
downsmile macro x,y
push cx
push dx
mov cx,x
mov dx,y
add dx,6
add cx,6
WrPixel cx,dx,0h
inc dx
WrPixel cx,dx,0h
inc dx
dec cx
summanypixel cx,dx,3,0h
inc dx
summanypixel cx,dx,3,0h
inc dx
dec cx
summanypixel cx,dx,5,0h
inc dx
summanypixel cx,dx,5,0h
inc dx
summanypixel cx,dx,5,0h
pop dx
pop dx
endm
rightsmile macro x,y
push cx
push dx
mov cx,x
mov dx,y
add dx,4
add cx,10
summanypixel cx,dx,3,0h
inc dx
sub cx,2
summanypixel cx,dx,5,0h
inc dx
sub cx,2
summanypixel cx,dx,7,0h
inc dx
add cx ,2
summanypixel cx,dx,5,0h
inc dx
add cx,2
summanypixel cx,dx,3,0h
pop dx
pop cx
endm
sumcirclec macro x,y
push cx
push dx
mov cx,x
mov dx,y
add cx,4
summanypixel cx,dx,4,0;1
inc dx
sub cx,2
summanypixel cx,dx,8,0;2
inc dx
dec cx
summanypixel cx,dx,10,0;3
dec cx
inc dx
summanypixel cx,dx,12,0;4
inc dx
summanypixel cx,dx,12,0;5
inc dx
summanypixel cx,dx,14,0;6
inc dx
summanypixel cx,dx,14,0;7
inc dx
summanypixel cx,dx,14,0;8
inc dx
summanypixel cx,dx,12,0;9
inc dx
summanypixel cx,dx,12,0;10
inc dx
inc cx
summanypixel cx,dx,10,0;11
inc cx
inc dx
summanypixel cx,dx,8,0;12
inc dx
add cx,2
summanypixel cx,dx,4,0;13
pop dx
pop cx
endm
sunmap macro 
    local m1,m2,m3,m4,m5
    pushA
    mov ax,30
m1:
    push ax
    mov bx,15;高長
m2:
    push bx
    mov cx,28
m3:
    push cx
    matrix_space x1,y1,0,0
    mov dx,15;寬長
m4:
    push dx
    WrPixel y2,x2,0h
    cmp ax,1
    jne m5
    WrPixel y2,x2,1001b
m5:
    inc y2
    pop dx
    dec dx
    cmp dx,0
    jne m4
    inc y1
    pop cx
    dec cx
    cmp cx,0
    jne m3
    inc x2
    mov y1,0
    mov y2,0
    pop bx 
    dec bx
    cmp bx,0
    jne m2
    inc x1
    mov y1,0
    pop ax
    dec ax
    cmp ax,0
    jne m1
endm
heart macro x,y,col
push cx
push dx
mov cx,x
mov dx,y
inc cx 
summanypixel cx,dx,2,col
add cx,5
summanypixel cx,dx,2,col
sub cx,6
inc dx
summanypixel cx,dx,4,col
add cx,5
summanypixel cx,dx,4,col
sub cx,5
inc dx
summanypixel cx,dx,9,col
inc dx
summanypixel cx,dx,9,col
inc dx
inc cx 
summanypixel cx,dx,7,col
inc dx
inc cx
summanypixel cx,dx,5,col
inc dx
inc cx
summanypixel cx,dx,3,col
inc dx
inc cx
WrPixel cx,dx,col
endm
time_to_ms macro
    push BX
    mov ah, 2ch
    int 21h
    Mov BX, 0
    Mov Bl, Cl
    Mov time1, BX
    Mov BX, 0
    Mov Bl, Dh
    Mov time2, BX
    Mov BX, 0
    Mov Bl, Dl
    Mov time3, BX
    Multiply time1, 6000
    Mov BX, AX
    Multiply time2, 100
    Add BX, AX
    Add BX, time3
    Mov AX, BX
    pop BX
endm

Ghost_change_position_flag macro
    local Ghost_move, Ghost_move_PASS, return, Hour, Hour_PASS
    time_to_ms
    SUB AX, Ghost_time
    cmp AX, Ghost_space
    jae Ghost_move
    jb Ghost_move_PASS
Ghost_move:
    Mov G_change_position_flag, 1
    time_to_ms
    Mov Ghost_time, AX
    JMP return
Ghost_move_PASS:
    Mov G_change_position_flag, 0
return:
endm

Pacman_change_position_flag macro
    local Pacman_move, Pacman_move_Pass, return, Hour, Hour_PASS
    time_to_ms
    SUB AX, Pacman_time
    cmp AX, Pacman_space
    jae Pacman_move
    jb Pacman_move_PASS
Pacman_move:
    Mov P_change_position_flag, 1
    time_to_ms
    Mov Pacman_time, AX
    JMP return
Pacman_move_Pass:
    Mov P_change_position_flag, 0
return:
endm
play_sound  macro input
    local pause1, pause2, pause3, pause4, pause5, pause6
    mov     al, 182         ; Prepare the speaker for the
    out     43h, al         ;  note.
    mov     ax, 3619        ; Frequency number (in decimal)
                            ;  for middle C.
    out     42h, al         ; Output low byte.
    mov     al, ah          ; Output high byte.
    out     42h, al 
    in      al, 61h         ; Turn on note (get value from
                            ;  port 61h).
    or      al, 00000011b   ; Set bits 1 and 0.
    out     61h, al         ; Send new value.
    mov     bx, 25          ; Pause for duration of note.
pause1:
    mov     cx, 6553
pause2:
    dec     cx
    jne     pause2
    dec     bx
    jne     pause1
    in      al, 61h         ; Turn off note (get value from
                            ;  port 61h).
    and     al, 11111100b   ; Reset bits 1 and 0.
    out     61h, al         ; Send new value.
    
    mov     al, 182         ; Prepare the speaker for the
    out     43h, al         ;  note.
    mov     ax, 4063        ; Frequency number (in decimal)
                            ;  for middle C.
    out     42h, al         ; Output low byte.
    mov     al, ah          ; Output high byte.
    out     42h, al 
    in      al, 61h         ; Turn on note (get value from
                            ;  port 61h).
    or      al, 00000011b   ; Set bits 1 and 0.
    out     61h, al         ; Send new value.
    mov     bx, 25          ; Pause for duration of note.
pause3:
    mov     cx, 6553
pause4:
    dec     cx
    jne     pause4
    dec     bx
    jne     pause3
    in      al, 61h         ; Turn off note (get value from
                            ;  port 61h).
    and     al, 11111100b   ; Reset bits 1 and 0.
    out     61h, al         ; Send new value.
    
    mov     al, 182         ; Prepare the speaker for the
    out     43h, al         ;  note.
    mov     ax, 4560        ; Frequency number (in decimal)
                            ;  for middle C.
    out     42h, al         ; Output low byte.
    mov     al, ah          ; Output high byte.
    out     42h, al 
    in      al, 61h         ; Turn on note (get value from
                            ;  port 61h).
    or      al, 00000011b   ; Set bits 1 and 0.
    out     61h, al         ; Send new value.
    mov     bx, 25          ; Pause for duration of note.
pause5:
    mov     cx, 6553
pause6:
    dec     cx
    jne     pause6
    dec     bx
    jne     pause5
    in      al, 61h         ; Turn off note (get value from
                            ;  port 61h).
    and     al, 11111100b   ; Reset bits 1 and 0.
    out     61h, al         ; Send new value.
endm
;//////////////////////////////////
openfile macro 
    local yes
    mov al, 2
    mov ah, 3Dh ; open
    lea dx, file_name
    int 21h
    jnc yes
    mov cx, 0
    lea dx, file_name
    mov ah, 3ch;create
    int 21h
    SetCursor 15h,19h
    printstr13h Turtorial_1,1001b,33,0ffh,0ffh,00h
     SetCursor 17h,19h
    printstr13h Turtorial_2,1001b,34,0ffh,0ffh,00h

    mov al, 2
    mov ah, 3Dh ; open
    lea dx, file_name
    int 21h
    mov file_handle,ax
    mov bx, file_handle
    mov cx, 3
    lea dx, start_point
    mov ah, 40h
    int 21h
    closefile
    mov al, 2
    mov ah, 3Dh ; open
    lea dx, file_name
    int 21h
yes:
    mov file_handle,ax
    endm
writefile macro
    mov bx, file_handle
    mov cx, 3
    lea dx, score
    mov ah, 40h
    int 21h
    endm
readfile macro
    mov bx, file_handle
    mov cx, 3
    lea dx, file_score
    mov ah, 3Fh
    int 21h
    endm
closefile macro
    mov ah, 3Eh
    mov bx, file_handle
    int 21h
endm
printfile macro
    lea dx, file_score
    mov ah, 09h
    int 21h
endm
checkscore macro
    local check_ascii1,check_ascii2,check_ascii3
    push ax
    openfile
    readfile 
    pop ax
    mov ax,0
    add al,file_score[2]
    cmp al,96
    jna check_ascii1
    sub al,39
    check_ascii1:
    sub al,30h
    mov bl,file_score[1]
    cmp bl,96
    jna check_ascii2
    sub bl,39
    check_ascii2:
    sub bl,30h
    shl bl,4
    add al,bl
    mov bl,file_score[0]
    cmp bl,96
    jna check_ascii3
    sub bl,39
    check_ascii3:
    sub bl,30h
    add ah,bl
    mov highest_score,ax
    pusha
    closefile
    popa
    endm
writescore macro
    transscore
    openfile
    writefile
    closefile
endm
printstr13h macro str,atr,len,row,col,cursor_move  ;繪圖模式輸出字串
	    mov ax,ds
	    mov es,ax
            mov bp,offset str
	    mov ah,13h
	    mov al,cursor_move
            mov bh,00
	    mov bl,atr	    
            mov cx,len
	    mov dh,row
	    mov dl,col
	    int 10h
	    endm
SetCursor macro row,col  ;設定游標位置
    mov dh,row
    mov dl,col
    mov bx,00h
    mov ah,02h
    int 10h
endm

transscore macro
    local m1,m2,m3
    mov ax,now_score
    add ah,30h
    cmp ah,57
    jbe m1
    add ah,39
    m1:
    mov score[0],ah
    shr al,4
    add al,30h
    cmp al,57
    jbe m2
    add al,39
    m2:
    mov score[1],al
    mov ax,now_score
    shl al,4
    shr al,4
    add al,30h
    cmp al,57
    jbe m3
    add al,39
    m3:
    mov score[2],al
endm

trans_Score_DEC macro input
    Mov AX, input
    Mov DX, 0
    Mov CX, 100
    DIV CX
    ADD AX, 30h
    Mov score_dec[0], AL
    Mov AX, DX
    Mov DX, 0
    Mov CX, 10
    DIV CX
    ADD AX, 30h
    Mov score_dec[1], Al
    ADD DX, 30h
    Mov score_dec[2], Dl
endm

Restart macro
    local checkdir1, checkdir2, checkdir3,endcheck,check1,check2,check3
    cmp life,3
    jne check1
    heart 450,450,1000b
check1:
    cmp life,2
    jne check2
    heart 470,450,1000b
check2:
    cmp life,1
    jne check3
    

check3:
    Multiply Pacman_X, 15
    Mov PX, AX
    Multiply Pacman_Y, 15
    Mov PY, AX
    mov bx,Pacman_Dir

    cmp bx,0
    jne checkdir1
    sumcircle PY,PX,1110b
    upsmile PY,PX
    ;play_sound
    jmp endcheck
    checkdir1:
    cmp bx,1
    jne checkdir2
    sumcircle PY,PX,1110b
    rightsmile PY,PX
    ;play_sound
    jmp endcheck
    checkdir2:
    cmp bx,2
    jne checkdir3
    sumcircle PY,PX,1110b
    downsmile py,px
    ;play_sound
    jmp endcheck
    checkdir3:      
    sumpac py,px,1110b
    endcheck:
    ;play_sound
    Mov Speed_up, 0
    ;/////////////////////////////////
    Multiply Ghost1_X, 15
    Mov GX, AX
    Multiply Ghost1_Y, 15
    Mov GY, AX
    sumghostc GY,GX,00b
    Mov Ghost1_X, 1
    Mov Ghost1_Y, 1
    Mov Ghost1_dir, 0
    Multiply Ghost1_X, 15
    Mov GX, AX
    Multiply Ghost1_Y, 15
    Mov GY, AX
    sumghost GY,GX,00b
    ;/////////////////////////////////
    Multiply Ghost2_X, 15
    Mov GX, AX
    Multiply Ghost2_Y, 15
    Mov GY, AX
    sumghostc GY,GX,00b
    Mov Ghost2_X, 1
    Mov Ghost2_Y, 26
    Mov Ghost2_dir, 0
    Multiply Ghost2_X, 15
    Mov GX, AX
    Multiply Ghost2_Y, 15
    Mov GY, AX
    sumghost GY,GX,00b
    ;//////////////////////////////////
    Multiply Ghost3_X, 15
    Mov GX, AX
    Multiply Ghost3_Y, 15
    Mov GY, AX
    sumghostc GY,GX,00b
    Mov Ghost3_X, 28
    Mov Ghost3_Y, 1
    Mov Ghost1_dir, 1
    Multiply Ghost3_X, 15
    Mov GX, AX
    Multiply Ghost3_Y, 15
    Mov GY, AX
    sumghost GY,GX,00b
    ;///////////////////////////////////
    Multiply Ghost4_X, 15
    Mov GX, AX
    Multiply Ghost4_Y, 15
    Mov GY, AX
    sumghostc GY,GX,00b
    Mov Ghost4_X, 28
    Mov Ghost4_Y, 26
    Mov Ghost4_dir, 1
    Multiply Ghost4_X, 15
    Mov GX, AX
    Multiply Ghost4_Y, 15
    Mov GY, AX
    sumghost GY,GX,00b
    ;//////////////////////////////////////
endm
pac_space1 macro X,Y;Success
    push BX
    Mov BX, X
    Multiply BX,13
    Mov BX, AX
    add BX, Y
    Mov AX, 0
    Mov Al, pacman_photo[BX]

    pop BX
endm
sumpac_photo macro 
    local m1,m2,m3,m4,m5
    pushA
    mov ax,13
m1:
    push ax
    mov bx,15;高長
m2:
    push bx
    mov cx,13
m3:
    push cx
    pac_space1 xpac1,ypac1
    mov dx,15;寬長
m4:
    push dx
    WrPixel ypac2,xpac2,0h
    cmp ax,0
    jne m5
    WrPixel ypac2,xpac2,1110b
m5:
    inc ypac2
    pop dx
    dec dx
    cmp dx,0
    jne m4
    inc ypac1
    pop cx
    dec cx
    cmp cx,0
    jne m3
    inc xpac2
    mov ypac1,0
    mov ypac2,215
    pop bx 
    dec bx
    cmp bx,0
    jne m2
    inc xpac1
    mov ypac1,0
    pop ax
    dec ax
    cmp ax,0
    jne m1
    endm
sumghost_photo macro col,mox
    local m1,m2,m3,m4,m5,m6,m7
    pushA
    mov ax,14
m1:
    push ax
    mov bx,14;高長
m2:
    push bx
    mov cx,14
m3:
    push cx
    ghost_space1 xghost1,yghost1
    mov dx,14;寬長
m4:
    push dx
    WrPixel yghost2,xghost2,0h
    cmp ax,0
    jne m5
    WrPixel yghost2,xghost2,col
m5:
    cmp ax,2
    jne m6
    WrPixel yghost2,xghost2,1111b

m6:
cmp ax,3
jne m7 
WrPixel yghost2,xghost2,0000b
m7:
    inc yghost2
    pop dx
    dec dx
    cmp dx,0
    jne m4
    inc yghost1
    pop cx
    dec cx
    cmp cx,0
    jne m3
    inc xghost2
    mov yghost1,0
    mov ax,mox
    mov yghost2,ax
    pop bx 
    dec bx
    cmp bx,0
    jne m2
    inc xghost1
    mov yghost1,0
    pop ax
    dec ax
    cmp ax,0
    jne m1
    endm
ghost_space1 macro X,Y;Success
    push BX
    Mov BX, X
    Multiply BX,14
    Mov BX, AX
    add BX, Y
    Mov AX, 0
    Mov Al, ghost_photo[BX]
    pop bx
    endm
.model small
.stack
.data
Start dw 1111h
Pacman_X dw 11
Pacman_Y dw 12
Pacman_Dir dw 0

Ghost1_X dw 1
Ghost1_Y dw 1
Ghost1_dir dw 0

Ghost2_X dw 1
Ghost2_Y dw 26
Ghost2_dir dw 0

Ghost3_X dw 28
Ghost3_Y dw 1
Ghost3_dir dw 1

Ghost4_X dw 28
Ghost4_Y dw 26
Ghost4_dir dw 1

Direction_usable db 4 dup(?)

GX dw 0h
GY dw 0h
PX dw 0h
PY dw 0h
G_dir dw 0h

Ghost_space dw 30
Ghost2_near_time dw 0
Ghost3_near_time dw 0
Ghost4_near_time dw 0
Pacman_space dw 30

time1 dw 0h
time2 dw 0h
time3 dw 0h

G_change_position_flag db 1
Ghost_time dw 0h
P_change_position_flag db 1
Pacman_time dw 0h

char db 0h
Ghost_max dw 150

b1 dw 0
b2 dw 0
c1 dw 0
c2 dw 0
c3 dw 0
x1 dw 0
y1 dw 0
z1 dw 0
x2 dw 0
y2 dw 0

file_name db "Score.txt",0
file_handle dw 0
file_score db 3 dup(?)

highest_score dw 0
now_score dw 0

score db "000"
score_dec db "000"
start_point db "000"
highest_score_srting db "Highest score: "
now_score_string db "Your Score: "
Welcome_Press_Space db "Press Space to Continue~"
Turtorial_1 db "Pacman need to escape the chased of Ghost"
Turtorial_2 db "Ghost will speed up after 150 move"
check_escape db "press esc to end game"
w_a_s_d db "use lower case'w' 'a' 's' 'd'to move"
Speed_up dw 0h
life db 4
pacman_photo db 1,1,1,1,1,0,0,0,1,1,1,1,1;,1
db 1,1,1,0,0,0,0,0,0,0,1,1,1;,2
db 1,1,0,0,0,0,0,0,0,0,0,1,1;,3
db 1,0,0,0,0,0,0,0,0,0,0,0,1;4
db 1,0,0,0,0,0,0,0,0,0,1,1,1;5
db 0,0,0,0,0,0,0,0,1,1,1,1,1;6
db 0,0,0,0,0,0,1,1,1,1,1,1,1;7
db 0,0,0,0,0,0,0,0,1,1,1,1,1;8
db 1,0,0,0,0,0,0,0,0,0,1,1,1;9
db 1,0,0,0,0,0,0,0,0,0,0,0,1;,1,0
db 1,1,0,0,0,0,0,0,0,0,0,1,1;,1,1
db 1,1,1,0,0,0,0,0,0,0,1,1,1;,1,2
db 1,1,1,1,1,0,0,0,1,1,1,1,1;,1,3
;;;;;;;;;
ghost_photo db 1,1,1,1,1,0,0,0,0,1,1,1,1,1;,1
db 1,1,1,0,0,0,0,0,0,0,0,1,1,1;,2
db 1,1,0,0,0,0,0,0,0,0,0,0,1,1;,3
db 1,0,0,0,2,2,0,0,0,0,2,2,0,1;4
db 1,0,0,2,2,2,2,0,0,2,2,2,2,1;5
db 1,0,0,2,2,3,3,0,0,2,2,3,3,1;6
db 0,0,0,2,2,3,3,0,0,2,2,3,3,0;7
db 0,0,0,0,2,2,0,0,0,0,2,2,0,0;8
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0;9
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0;,1,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0;,1,1
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0;,1,2
db 0,0,1,0,0,0,1,1,0,0,0,1,0,0;,1,3
db 0,1,1,1,0,0,1,1,0,0,1,1,1,0;,14
xpac1 dw 0
ypac1 dw 0
xpac2 dw 0
ypac2 dw 0
xghost1 dw 0
xghost2 dw 0
yghost1 dw 0
yghost2 dw 0
matrix  db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        db 1,7,0,0,0,0,7,0,0,0,0,0,7,0,0,7,0,0,0,0,0,7,0,0,0,0,7,1 
        db 1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1
        db 1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1 
        db 1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1 
        db 1,7,0,0,0,0,7,0,0,7,0,0,7,0,0,7,0,0,7,0,0,7,0,0,0,0,7,1 
        db 1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1 
        db 1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1 
        db 1,7,0,0,0,0,7,1,1,7,0,0,7,0,0,7,0,0,7,1,1,7,0,0,0,0,7,1 
        db 1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,1,1 
        db 1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,1,1 
        db 1,1,1,1,1,1,0,1,1,7,0,0,7,0,0,7,0,0,7,1,1,0,1,1,1,1,1,1 
        db 1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1 
        db 1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1 
        db 1,1,1,1,1,1,7,0,0,7,1,1,1,1,1,1,1,1,7,0,0,7,1,1,1,1,1,1 
        db 1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1
        db 1,1,1,1,1,1,0,1,1,7,0,0,0,0,0,0,0,0,7,1,1,0,1,1,1,1,1,1
        db 1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1
        db 1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1
        db 1,7,0,0,0,0,7,0,0,7,0,0,7,0,0,7,0,0,7,0,0,7,0,0,0,0,7,1
        db 1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1
        db 1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1
        db 1,7,0,7,1,1,7,0,0,7,0,0,7,0,0,7,0,0,7,0,0,7,1,1,7,0,7,1
        db 1,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,1
        db 1,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,1
        db 1,7,0,7,0,0,7,1,1,7,0,0,7,1,1,7,0,0,7,1,1,7,0,0,7,0,7,1
        db 1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1
        db 1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1
        db 1,7,0,0,0,0,7,0,0,0,0,0,7,0,0,7,0,0,0,0,0,7,0,0,0,0,7,1
        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
cover db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,03fh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,078h ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,003h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,07fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,001h ,0ffh ,000h ,03fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e1h ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,03fh 
db 0ffh ,0feh ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0c0h ,01fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,07fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,03eh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,03fh 
db 0ffh ,0f0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0e0h ,00fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,07fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,01eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,03fh 
db 0ffh ,0c0h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0f0h ,007h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,07fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0e0h ,03fh ,0ffh ,0f0h ,01eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,07fh 
db 080h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0f8h ,007h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,07fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0f0h ,007h ,0ffh ,0f0h ,01eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,07fh ,080h ,0ffh 
db 0c0h ,002h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0fch ,003h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0f0h ,001h ,0ffh ,0f8h ,01eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,00fh ,080h ,0ffh 
db 0c0h ,01fh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0fch ,003h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0f8h ,000h ,0ffh ,0f8h ,01eh ,007h ,0cfh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,001h ,0ffh 
db 0e0h ,07fh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0fch ,000h ,0ffh ,0f8h ,01eh ,007h ,083h ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,003h ,0ffh 
db 0e0h ,07fh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0feh ,000h ,0ffh ,0f8h ,01eh ,007h ,081h ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,003h ,0ffh 
db 0e0h ,0ffh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,000h ,0ffh ,0f8h ,01eh ,007h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,003h ,0ffh 
db 0e0h ,0ffh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,080h ,0ffh ,0f8h ,01eh ,006h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,0ffh 
db 0e0h ,0ffh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0c1h ,0ffh ,0f8h ,01eh ,006h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,03fh 
db 0e0h ,0ffh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,0f8h ,01eh ,004h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,00fh 
db 0e0h ,0ffh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,018h ,01eh ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,020h ,007h 
db 0e0h ,0ffh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,00ch ,01eh ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,070h ,003h 
db 0e0h ,0ffh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0ffh ,000h 
db 03fh ,0ffh ,0ffh ,0ffh ,0f0h ,003h ,0ffh ,0ffh ,0e3h ,003h ,0f8h ,00fh ,0ffh ,0ffh ,0e0h ,007h 
db 0ffh ,0ffh ,0ffh ,03fh ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,01eh ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,0fch ,003h 
db 0c0h ,0ffh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0f0h ,000h 
db 003h ,0ffh ,0ffh ,0ffh ,000h ,000h ,03fh ,0ffh ,080h ,000h ,0e0h ,003h ,0ffh ,0feh ,000h ,000h 
db 07fh ,0ffh ,0fch ,038h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,01eh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,003h ,0feh ,003h 
db 0c0h ,0ffh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0feh ,001h ,0ffh ,0c0h ,000h 
db 001h ,0ffh ,0ffh ,0fch ,000h ,000h ,00fh ,0f8h ,000h ,000h ,000h ,001h ,0ffh ,0f8h ,000h ,000h 
db 03fh ,0ffh ,0e0h ,030h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0ffh ,080h ,07fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,01eh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,007h ,0ffh ,003h 
db 0c0h ,0ffh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0fch ,003h ,0ffh ,080h ,07fh 
db 000h ,0ffh ,0ffh ,0f8h ,003h ,0f0h ,007h ,0f0h ,000h ,0c0h ,002h ,000h ,0ffh ,0f0h ,00fh ,0e0h 
db 01fh ,0feh ,000h ,000h ,030h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0f0h ,000h ,01fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,01eh ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,00fh ,0ffh ,0ffh 
db 0c1h ,0ffh ,003h ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0fch ,003h ,0ffh ,001h ,0ffh 
db 0c0h ,07fh ,0ffh ,0e0h ,00fh ,0fch ,003h ,0f0h ,001h ,0c0h ,00fh ,000h ,0ffh ,0e0h ,03fh ,0f8h 
db 00fh ,0feh ,000h ,000h ,0fch ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,007h ,0ffh 
db 0ffh ,0ffh ,0ffh ,087h ,0feh ,000h ,01eh ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,03ch ,03fh ,0ffh 
db 081h ,0ffh ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0f8h ,007h ,0feh ,003h ,0ffh 
db 0e0h ,03fh ,0ffh ,0c0h ,03fh ,0feh ,003h ,0f8h ,003h ,0e0h ,01fh ,080h ,07fh ,0c0h ,07fh ,0fch 
db 007h ,0feh ,000h ,003h ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,007h ,0ffh 
db 0ffh ,0ffh ,0feh ,001h ,0ffh ,000h ,01eh ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,078h ,00ch ,00fh 
db 083h ,0ffh ,080h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0f0h ,007h ,0fch ,003h ,0ffh 
db 0e0h ,03fh ,0ffh ,080h ,07fh ,0fch ,001h ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,080h ,07fh ,0fch 
db 007h ,0ffh ,0c0h ,007h ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,007h ,0ffh 
db 0ffh ,0ffh ,0f8h ,000h ,0ffh ,0f8h ,01eh ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0c1h ,0fch ,004h ,003h 
db 003h ,0ffh ,080h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0e0h ,00fh ,0f8h ,003h ,0ffh 
db 0e0h ,01fh ,0ffh ,080h ,0ffh ,0fch ,001h ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,07fh ,0fch 
db 003h ,0ffh ,0e0h ,00fh ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,007h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0e0h ,000h ,07fh ,0f8h ,01eh ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,006h ,002h 
db 007h ,0ffh ,0e0h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,080h ,01fh ,0f8h ,001h ,0ffh 
db 0f0h ,01fh ,0ffh ,000h ,0ffh ,0f8h ,001h ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,03fh ,0feh 
db 003h ,0ffh ,0e0h ,01fh ,0ffh ,080h ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,000h ,000h ,07fh ,0f8h ,01eh ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,007h ,000h 
db 00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0feh ,000h ,03fh ,0f8h ,001h ,0ffh 
db 0f0h ,01fh ,0feh ,001h ,0ffh ,0f8h ,001h ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,03fh ,0feh 
db 003h ,0ffh ,0e0h ,01fh ,0ffh ,080h ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0fch ,000h ,000h ,07fh ,0f8h ,01eh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,007h ,000h 
db 03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,0ffh ,0f8h ,001h ,0ffh 
db 0f0h ,01fh ,0feh ,003h ,0ffh ,0fch ,003h ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,03fh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0fch ,000h ,00eh ,000h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0fch ,001h ,000h ,0ffh ,0e0h ,01eh ,008h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,007h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,003h ,0ffh ,0f8h ,001h ,0ffh 
db 0f0h ,01fh ,0fch ,003h ,0ffh ,0fch ,003h ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,03fh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,003h ,0feh ,000h ,07fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,001h ,0ffh ,080h ,01eh ,00ch ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,007h ,0ffh 
db 0ffh ,0ffh ,087h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,03fh ,0ffh ,0fch ,003h ,0ffh 
db 0f0h ,01fh ,0fch ,007h ,0ffh ,0ffh ,00fh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,080h ,07fh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,03fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0feh ,003h ,0feh ,000h ,01eh ,00eh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,007h ,001h 
db 0ffh ,0fch ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,09fh ,0ffh 
db 0f0h ,01fh ,0fch ,007h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0f3h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,01fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0feh ,007h ,0f8h ,000h ,03ch ,00fh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h 
db 0ffh ,080h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0f0h ,01fh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0ffh ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,01fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0fch ,00fh ,080h ,000h ,03ch ,00fh ,0c1h ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h 
db 000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0e0h ,01fh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0ffh ,0ffh ,0fch 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,004h ,00fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0fch ,01fh ,000h ,010h ,03ch ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,00fh 
db 000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h 
db 000h ,01fh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0ffh ,0ffh ,000h 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,006h ,007h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0fch ,03fh ,080h ,030h ,03ch ,00fh ,0ffh ,0c7h ,0ffh ,0feh ,000h ,000h ,007h ,0ffh 
db 000h ,00fh ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h 
db 000h ,01fh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0ffh ,0f0h ,000h 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,00eh ,003h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0f8h ,03fh ,080h ,060h ,07ch ,00fh ,0ffh ,0c3h ,0ffh ,0fch ,000h ,000h ,007h ,0ffh 
db 0c0h ,0ffh ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h 
db 000h ,01fh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0ffh ,000h ,000h 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,00fh ,003h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0fch ,01fh ,0c0h ,0e0h ,07ch ,00fh ,0ffh ,0c3h ,0ffh ,0feh ,000h ,01eh ,007h ,0ffh 
db 0e0h ,07fh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,001h 
db 0f0h ,01fh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0f8h ,000h ,03eh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,01fh ,001h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0feh ,00fh ,0ffh ,0e0h ,07eh ,00fh ,0ffh ,0c3h ,0ffh ,0ffh ,081h ,0feh ,006h ,01fh 
db 0f0h ,07eh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,01fh 
db 0f0h ,01fh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0f0h ,003h ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,01fh ,080h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0feh ,007h ,0ffh ,0c0h ,0feh ,00fh ,0ffh ,0c3h ,0ffh ,0ffh ,0ffh ,0feh ,006h ,007h 
db 0f8h ,03eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0feh ,000h ,07fh 
db 0f0h ,01fh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,0c0h ,00fh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,03fh ,080h ,07fh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,003h ,0ffh ,0c0h ,0feh ,00fh ,0ffh ,081h ,0ffh ,0ffh ,0ffh ,0feh ,006h ,007h 
db 0fch ,01eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0fch ,001h ,0ffh 
db 0f0h ,01fh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,080h ,03fh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,03fh ,0c0h ,03fh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,081h ,0ffh ,081h ,0feh ,007h ,0ffh ,081h ,0ffh ,0ffh ,0fch ,07eh ,006h ,007h 
db 0fch ,00ch ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0f8h ,003h ,0ffh 
db 0f0h ,01fh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,07fh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,07fh ,0c0h ,01fh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,081h ,0ffh ,083h ,0feh ,007h ,0ffh ,000h ,0ffh ,0ffh ,0fch ,00eh ,006h ,00fh 
db 0feh ,00ch ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0f8h ,007h ,0ffh 
db 0f0h ,01fh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,07fh ,0e0h ,00fh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0c1h ,0ffh ,003h ,0ffh ,001h ,0feh ,000h ,0ffh ,0ffh ,0fch ,006h ,006h ,00fh 
db 0ffh ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0f0h ,00fh ,0ffh 
db 0f0h ,01fh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07eh ,001h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,0ffh ,0f0h ,007h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0c1h ,0feh ,007h ,0ffh ,000h ,000h ,000h ,0ffh ,0ffh ,0fch ,006h ,00eh ,00fh 
db 0ffh ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0f0h ,01fh ,0ffh 
db 0f0h ,01fh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07eh ,003h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0feh ,000h ,0ffh ,0f0h ,003h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0c1h ,0feh ,00fh ,0ffh ,000h ,000h ,000h ,0ffh ,0ffh ,0fch ,006h ,00eh ,00fh 
db 0ffh ,080h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0f0h ,01fh ,0ffh 
db 0f0h ,01fh ,0fch ,003h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0e0h ,01fh ,080h ,07eh ,003h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0f8h ,001h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0c1h ,0fch ,01fh ,0ffh ,080h ,000h ,001h ,0ffh ,0ffh ,0fch ,00eh ,00eh ,00fh 
db 0ffh ,0c0h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0e0h ,01fh ,0ffh 
db 0f0h ,01fh ,0fch ,003h ,0ffh ,0ffh ,0f8h ,07ch ,003h ,0e0h ,01fh ,080h ,07ch ,003h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0ffh ,0fch ,000h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0c1h ,0f8h ,07fh ,0ffh ,0c0h ,000h ,003h ,0ffh ,0ffh ,0f8h ,01eh ,00eh ,00fh 
db 0ffh ,0c0h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0e0h ,01fh ,0ffh 
db 0f0h ,01fh ,0fch ,003h ,0ffh ,0ffh ,0f8h ,07ch ,003h ,0e0h ,01fh ,080h ,07ch ,003h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0f8h ,007h ,0ffh ,0fch ,000h ,07fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0c1h ,0f0h ,0ffh ,0ffh ,0f0h ,000h ,01fh ,0ffh ,0ffh ,0f8h ,01eh ,00eh ,00fh 
db 0ffh ,0c0h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0e0h ,01fh ,0ffh 
db 0f0h ,01fh ,0feh ,001h ,0ffh ,0ffh ,0f0h ,0fch ,003h ,0e0h ,01fh ,080h ,07ch ,003h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0f0h ,007h ,0ffh ,0feh ,000h ,03fh ,0ffh 
db 0ffh ,0f8h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0c7h ,0ffh ,0ffh ,0ffh ,0f8h ,03ch ,00eh ,000h 
db 00fh ,080h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0e0h ,01fh ,0ffh 
db 0f0h ,01fh ,0feh ,000h ,0ffh ,0ffh ,0e0h ,0fch ,003h ,0e0h ,01fh ,080h ,07ch ,003h ,0ffh ,0feh 
db 003h ,0ffh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0e0h ,00fh ,0ffh ,0ffh ,000h ,00fh ,0ffh 
db 0ffh ,0f0h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,03ch ,00fh ,000h 
db 00fh ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0e0h ,01fh ,0ffh 
db 0e0h ,018h ,0ffh ,000h ,0ffh ,0ffh ,0c1h ,0fch ,003h ,0e0h ,01fh ,080h ,07ch ,003h ,0ffh ,0fch 
db 003h ,01fh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,0c0h ,01fh ,0ffh ,0ffh ,000h ,007h ,0ffh 
db 0ffh ,0f8h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,07ch ,00fh ,080h 
db 00eh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0e0h ,01fh ,0ffh 
db 080h ,018h ,07fh ,000h ,07fh ,0ffh ,083h ,0fch ,003h ,0e0h ,01fh ,080h ,07ch ,003h ,0ffh ,0f0h 
db 003h ,00fh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,080h ,03fh ,0ffh ,0ffh ,080h ,001h ,0ffh 
db 0ffh ,0fch ,000h ,07ch ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,07ch ,00fh ,0e0h 
db 03ch ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0f0h ,00fh ,0ffh 
db 000h ,010h ,07fh ,080h ,03fh ,0ffh ,003h ,0fch ,003h ,0e0h ,01fh ,080h ,07eh ,001h ,0ffh ,0e0h 
db 002h ,00fh ,0e0h ,03fh ,0ffh ,080h ,0ffh ,0ffh ,0ffh ,000h ,07fh ,0ffh ,0ffh ,0c0h ,000h ,07fh 
db 0ffh ,0feh ,007h ,0ffh ,0c0h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,0fch ,00fh ,0ffh 
db 0f8h ,004h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0f0h ,007h ,0fch 
db 000h ,000h ,0ffh ,0c0h ,00fh ,0fch ,007h ,0fch ,003h ,0e0h ,01fh ,080h ,07eh ,000h ,0ffh ,080h 
db 000h ,01fh ,0e0h ,01fh ,0ffh ,080h ,0ffh ,0ffh ,0feh ,000h ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c1h ,0fch ,00fh ,0ffh 
db 0e0h ,01eh ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,001h ,0ffh ,0ffh ,0ffh ,0f8h ,003h ,0f0h 
db 000h ,000h ,0ffh ,0e0h ,000h ,000h ,00fh ,0fch ,003h ,0e0h ,01fh ,080h ,07fh ,000h ,07eh ,000h 
db 000h ,01fh ,0c0h ,01fh ,0ffh ,000h ,07fh ,0ffh ,0fch ,001h ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,083h ,0f8h ,00fh ,0ffh 
db 080h ,03fh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,01fh ,0ffh ,0ffh ,0f8h ,000h ,000h 
db 030h ,001h ,0ffh ,0f0h ,000h ,000h ,01fh ,0f8h ,000h ,0c0h ,006h ,000h ,01fh ,000h ,000h ,006h 
db 000h ,03eh ,000h ,003h ,0f8h ,000h ,00fh ,0ffh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,001h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh ,007h ,0f8h ,00fh ,0feh 
db 000h ,0ffh ,080h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,01fh ,0ffh ,0ffh ,0feh ,000h ,000h 
db 0f8h ,003h ,0ffh ,0fch ,000h ,000h ,07fh ,0f0h ,000h ,080h ,006h ,000h ,01fh ,0c0h ,000h ,01fh 
db 000h ,07eh ,000h ,001h ,0f8h ,000h ,007h ,0ffh ,0e0h ,00fh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h 
db 07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,003h ,0feh ,01fh ,0f8h ,00fh ,0f8h 
db 007h ,0ffh ,080h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,000h ,003h 
db 0f8h ,007h ,0ffh ,0ffh ,000h ,001h ,0ffh ,0f0h ,000h ,080h ,006h ,000h ,01fh ,0e0h ,000h ,07fh 
db 000h ,0feh ,000h ,001h ,0f8h ,000h ,007h ,0ffh ,0c0h ,03fh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h 
db 01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,007h ,0ffh ,0ffh ,0f8h ,00fh ,0c0h 
db 01fh ,0ffh ,0c0h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,003h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,07fh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h 
db 01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0f8h ,00fh ,0ffh 
db 0ffh ,0ffh ,0e0h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0fch ,00fh ,0ffh 
db 0ffh ,0ffh ,0f0h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0fch ,01fh ,0ffh 
db 0ffh ,0ffh ,0f8h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0fch ,01fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,03fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch 
db 03fh ,0ffh ,0e1h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c3h 
db 0ffh ,0ffh ,0feh ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,07fh ,0ffh ,0c3h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,03eh 
db 000h ,000h ,003h ,0e3h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,087h ,0ffh ,0ffh ,0fch ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,0f0h 
db 000h ,000h ,000h ,078h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0fch ,07ch ,000h ,000h ,007h ,0c7h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,08eh ,000h 
db 000h ,000h ,000h ,003h ,08fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f1h ,0e0h ,000h ,000h ,000h ,0f1h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,09ch ,000h 
db 000h ,000h ,000h ,001h ,0cfh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,01ch ,000h ,000h ,000h ,000h ,007h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fdh ,0e0h ,000h 
db 000h ,000h ,000h ,000h ,03dh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,038h ,000h ,000h ,000h ,000h ,003h ,09fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f3h ,080h ,000h 
db 000h ,000h ,000h ,000h ,00eh ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0fbh ,0c0h ,000h ,000h ,000h ,000h ,000h ,07bh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ceh ,000h ,000h 
db 000h ,000h ,000h ,000h ,003h ,09fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0e7h ,000h ,000h ,000h ,000h ,000h ,000h ,01ch ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0bch ,000h ,000h 
db 000h ,000h ,000h ,000h ,001h ,0efh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,09ch ,000h ,000h ,000h ,000h ,000h ,000h ,007h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,0c0h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,01bh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,078h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0dfh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,0c0h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,01bh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0fdh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,037h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fbh ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,006h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0fdh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,037h ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e6h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,003h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0f6h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00dh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,08ch ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,001h ,08fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0cch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,006h ,07fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,070h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,077h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,018h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,01fh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,040h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,013h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0feh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0efh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fdh ,080h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,00dh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0fch ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,027h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fdh ,080h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,00dh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0fbh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,01bh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f2h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,002h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0fbh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,01bh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e6h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,003h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0e4h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,004h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,003h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0cch ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,001h ,09fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0cch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,006h ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,00fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0d8h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,09fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,098h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,03fh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h 
db 003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,020h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,067h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0b0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,03fh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h 
db 000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,040h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,017h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0feh ,040h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0cfh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h 
db 000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,080h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,00bh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0feh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,02fh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h 
db 000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0fdh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,017h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,088h ,000h ,000h ,000h ,000h ,000h 
db 000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fdh ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,005h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f9h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,004h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0fah ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00bh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f2h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,002h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0f2h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,009h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,027h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f4h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0e4h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,004h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0e8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,002h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c8h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,09fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,090h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,04fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 090h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,03fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0a0h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,02fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 020h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,09fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,020h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,027h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 040h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,05fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh 
db 040h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,04fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,080h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00bh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fdh 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,017h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fdh ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,005h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fah 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00bh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,038h 
db 000h ,000h ,000h ,000h ,000h ,000h ,018h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,003h ,0ffh 
db 080h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0e0h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h 
db 000h ,000h ,000h ,000h ,000h ,070h ,000h ,000h ,000h ,000h ,000h ,000h ,030h ,000h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,00fh ,0ffh 
db 0f0h ,000h ,000h ,000h ,000h ,007h ,0ffh ,0f0h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h 
db 000h ,000h ,000h ,000h ,007h ,0ffh ,000h ,000h ,000h ,000h ,000h ,007h ,0ffh ,0c0h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,07fh ,0ffh 
db 0fch ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0fch ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h 
db 000h ,000h ,000h ,000h ,01fh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,00fh ,0ffh ,0e0h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,07fh ,0ffh 
db 0fch ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0feh ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h 
db 000h ,000h ,000h ,000h ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,0ffh ,0ffh ,0f8h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,001h ,0ffh ,0ffh 
db 0ffh ,000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h 
db 000h ,000h ,000h ,000h ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,0ffh ,0ffh ,0fch ,000h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,001h ,0ffh ,0ffh 
db 0ffh ,000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,080h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h 
db 000h ,000h ,000h ,003h ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0feh ,000h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,003h ,0ffh ,0ffh 
db 0ffh ,0c0h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0c0h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h 
db 000h ,000h ,000h ,003h ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,000h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,003h ,0ffh ,0ffh 
db 0ffh ,0c0h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0e0h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h 
db 000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,080h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh 
db 0ffh ,0e0h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0f0h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h 
db 000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0c0h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh 
db 0ffh ,0e0h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0f0h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0e0h ,00fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh 
db 0ffh ,0f0h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0e0h ,00fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh 
db 08fh ,0f8h ,000h ,000h ,00fh ,0ffh ,0ffh ,087h ,0f8h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0f0h ,00fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0fch 
db 000h ,0f8h ,000h ,000h ,01fh ,0ffh ,0feh ,000h ,0f8h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0ffh ,01fh ,0f0h ,000h ,000h ,01fh ,0ffh ,0ffh ,00fh ,0f0h ,00fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0f8h 
db 000h ,078h ,000h ,000h ,03fh ,0ffh ,0fch ,000h ,07ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0f8h ,001h ,0f0h ,000h ,000h ,03fh ,0ffh ,0fch ,001h ,0f0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0f8h 
db 000h ,078h ,000h ,000h ,03fh ,0ffh ,0f8h ,000h ,07ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,0f0h ,000h ,000h ,07fh ,0ffh ,0f8h ,000h ,0f8h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0f0h 
db 000h ,03ch ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,01ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,0f0h ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,0f8h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0f0h 
db 000h ,03ch ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,01ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,078h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,038h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0c0h 
db 000h ,03ch ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,00ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,078h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,038h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0c0h 
db 000h ,01ch ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,00ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,080h ,000h ,078h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,018h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0c0h 
db 000h ,01eh ,000h ,000h ,07fh ,0ffh ,0e0h ,000h ,00eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,080h ,000h ,038h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,018h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0c0h 
db 000h ,01eh ,000h ,000h ,07fh ,0ffh ,0e0h ,000h ,00eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,080h ,000h ,03ch ,000h ,000h ,0ffh ,0ffh ,0c0h ,000h ,01ch ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0c0h 
db 000h ,01eh ,000h ,000h ,07fh ,0ffh ,0e0h ,000h ,00eh ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,080h ,000h ,03ch ,000h ,000h ,0ffh ,0ffh ,0c0h ,000h ,01ch ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0c0h 
db 000h ,01ch ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,00ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,080h ,000h ,03ch ,000h ,000h ,0ffh ,0ffh ,0c0h ,000h ,01ch ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0c0h 
db 000h ,03ch ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,00ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,080h ,000h ,038h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,018h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0f0h 
db 000h ,03ch ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,00ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,080h ,000h ,078h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,018h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0f0h 
db 000h ,03ch ,000h ,000h ,03fh ,0ffh ,0f0h ,000h ,03ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,078h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,018h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0f0h 
db 000h ,038h ,000h ,000h ,03fh ,0ffh ,0f8h ,000h ,03ch ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0e0h ,000h ,078h ,000h ,000h ,07fh ,0ffh ,0e0h ,000h ,078h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 00bh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0f8h 
db 000h ,0f8h ,000h ,000h ,03fh ,0ffh ,0fch ,000h ,078h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0e0h ,000h ,070h ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,078h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 00bh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0feh 
db 001h ,0f8h ,000h ,000h ,01fh ,0ffh ,0feh ,001h ,0f8h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0f0h ,001h ,0f0h ,000h ,000h ,07fh ,0ffh ,0f8h ,000h ,0f0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh 
db 083h ,0f8h ,000h ,000h ,01fh ,0ffh ,0ffh ,083h ,0f8h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0fch ,003h ,0f0h ,000h ,000h ,03fh ,0ffh ,0fch ,003h ,0f0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh 
db 0ffh ,0f0h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0f0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0ffh ,007h ,0f0h ,000h ,000h ,03fh ,0ffh ,0ffh ,007h ,0f0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,00fh ,0ffh ,0ffh 
db 0ffh ,0e0h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0f0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0e0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,007h ,0ffh ,0ffh 
db 0ffh ,0c0h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0f0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0e0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,007h ,0ffh ,0ffh 
db 0ffh ,0c0h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0e0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0e0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh 
db 0ffh ,080h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,080h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0c0h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,001h ,0ffh ,0ffh 
db 0ffh ,000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,080h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,001h ,0ffh ,0ffh 
db 0ffh ,000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,003h ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,0ffh ,0ffh 
db 0feh ,000h ,000h ,000h ,000h ,07fh ,0ffh ,0feh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,003h ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0feh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,03fh ,0ffh 
db 0f8h ,000h ,000h ,000h ,000h ,01fh ,0ffh ,0f8h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,001h ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,0ffh ,0ffh ,0fch ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,01fh ,0ffh 
db 0f0h ,000h ,000h ,000h ,000h ,01fh ,0ffh ,0f8h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0f0h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh 
db 080h ,000h ,000h ,000h ,000h ,003h ,0ffh ,080h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,03fh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,03fh ,0ffh ,0f0h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,0feh 
db 000h ,000h ,000h ,000h ,000h ,000h ,0feh ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,007h ,0ffh ,000h ,000h ,000h ,000h ,000h ,007h ,0ffh ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00bh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,001h ,0fch ,000h ,000h ,000h ,000h ,000h ,001h ,0fch ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,01fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,07fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,00fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,001h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 0bfh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,020h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0a0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,013h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,090h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,060h ,000h ,000h ,000h 
db 000h ,020h ,000h ,000h ,000h ,000h ,00ch ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f9h ,080h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,013h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,001h ,0fch ,000h ,000h ,000h 
db 003h ,0feh ,000h ,000h ,000h ,000h ,03fh ,000h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,000h ,0c0h ,000h ,000h ,000h ,000h ,040h ,000h ,000h ,000h ,000h ,018h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,0c0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,003h ,0feh ,000h ,000h ,000h 
db 003h ,0feh ,000h ,000h ,000h ,000h ,07fh ,080h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,003h ,0f8h ,000h ,000h ,000h ,007h ,0fch ,000h ,000h ,000h ,000h ,07eh ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,00fh ,0ffh ,000h ,000h ,000h 
db 00fh ,0ffh ,080h ,000h ,000h ,001h ,0ffh ,0e0h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,007h ,0fch ,000h ,000h ,000h ,007h ,0fch ,000h ,000h ,000h ,000h ,0ffh ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,088h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,03fh ,0ffh ,080h ,000h ,000h 
db 01fh ,0ffh ,0c0h ,000h ,000h ,003h ,0ffh ,0f8h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,01fh ,0feh ,000h ,000h ,000h ,01fh ,0ffh ,000h ,000h ,000h ,003h ,0ffh ,0c0h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,03fh ,0ffh ,080h ,000h ,000h 
db 03fh ,0ffh ,0e0h ,000h ,000h ,003h ,0ffh ,0f8h ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,07fh ,0ffh ,000h ,000h ,000h ,03fh ,0ffh ,080h ,000h ,000h ,007h ,0ffh ,0f0h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,000h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,0ffh ,0ffh ,0c0h ,000h ,000h 
db 07fh ,0ffh ,0f0h ,000h ,000h ,007h ,0ffh ,0fch ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 000h ,07fh ,0ffh ,000h ,000h ,000h ,07fh ,0ffh ,0c0h ,000h ,000h ,007h ,0ffh ,0f0h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,0ffh ,0ffh ,0c0h ,000h ,000h 
db 07fh ,0ffh ,0f0h ,000h ,000h ,007h ,0ffh ,0fch ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 001h ,0ffh ,0ffh ,080h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,000h ,00fh ,0ffh ,0f8h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,001h ,0ffh ,0ffh ,0f0h ,000h ,000h 
db 0ffh ,0ffh ,0f8h ,000h ,000h ,00fh ,0ffh ,0feh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 001h ,0ffh ,0ffh ,080h ,000h ,000h ,0ffh ,0ffh ,0e0h ,000h ,000h ,00fh ,0ffh ,0f8h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e0h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,001h ,0ffh ,0ffh ,0f0h ,000h ,000h 
db 0ffh ,0ffh ,0fch ,000h ,000h ,01fh ,0ffh ,0ffh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 003h ,0ffh ,0ffh ,0e0h ,000h ,001h ,0ffh ,0ffh ,0f0h ,000h ,000h ,01fh ,0ffh ,0fch ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,008h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,003h ,0ffh ,0ffh ,0f8h ,000h ,001h 
db 0ffh ,0ffh ,0fch ,000h ,000h ,01fh ,0ffh ,0ffh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 003h ,0ffh ,0ffh ,0e0h ,000h ,001h ,0ffh ,0ffh ,0f8h ,000h ,000h ,03fh ,0ffh ,0feh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,007h ,0ffh ,0ffh ,0fch ,000h ,001h 
db 0ffh ,0ffh ,0feh ,000h ,000h ,01fh ,0ffh ,0ffh ,080h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 007h ,0ffh ,0ffh ,0f0h ,000h ,003h ,0ffh ,0ffh ,0f8h ,000h ,000h ,03fh ,0ffh ,0feh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h ,000h 
db 000h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,00fh ,0ffh ,0ffh ,0feh ,000h ,003h 
db 0ffh ,0ffh ,0ffh ,000h ,000h ,07fh ,0ffh ,0ffh ,0c0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h 
db 00fh ,0ffh ,0ffh ,0f8h ,000h ,003h ,0ffh ,0ffh ,0fch ,000h ,000h ,03fh ,0ffh ,0ffh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e2h ,000h ,000h ,000h ,000h ,000h 
db 000h ,03fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,00fh ,0ffh ,0ffh ,0feh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,000h ,000h ,0ffh ,0ffh ,0ffh ,0c0h ,003h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h 
db 01fh ,0ffh ,0ffh ,0fch ,000h ,007h ,0ffh ,0ffh ,0feh ,000h ,000h ,0ffh ,0ffh ,0ffh ,080h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,000h ,000h 
db 001h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h ,03fh ,0ffh ,0ffh ,0feh ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,080h ,001h ,0ffh ,0ffh ,0ffh ,0f0h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h 
db 01fh ,0ffh ,0ffh ,0fch ,000h ,00fh ,0ffh ,0ffh ,0feh ,000h ,001h ,0ffh ,0ffh ,0ffh ,080h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h ,000h ,000h ,000h ,000h 
db 007h ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,07fh ,0ffh ,0ffh ,0ffh ,000h ,00fh 
db 0ffh ,0ffh ,0ffh ,0e0h ,003h ,0ffh ,0ffh ,0ffh ,0f0h ,007h ,0ffh ,0ffh ,0ffh ,0ffh ,0feh ,000h 
db 07fh ,0ffh ,0ffh ,0fch ,000h ,00fh ,0ffh ,0ffh ,0ffh ,000h ,003h ,0ffh ,0ffh ,0ffh ,0e0h ,00fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,000h ,000h ,000h ,010h 
db 07fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,080h ,07fh ,0ffh ,0ffh ,0ffh ,080h ,00fh 
db 0ffh ,0ffh ,0ffh ,0e0h ,003h ,0ffh ,0ffh ,0ffh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h 
db 0ffh ,0ffh ,0ffh ,0feh ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0c0h ,007h ,0ffh ,0ffh ,0ffh ,0e0h ,00fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0e2h ,000h ,000h ,000h ,007h 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,0ffh ,0ffh ,0ffh ,0ffh ,0c0h ,03fh 
db 0ffh ,0ffh ,0ffh ,0f8h ,00fh ,0ffh ,0ffh ,0ffh ,0fch ,00fh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,000h 
db 0ffh ,0ffh ,0ffh ,0ffh ,000h ,01fh ,0ffh ,0ffh ,0ffh ,0c0h ,007h ,0ffh ,0ffh ,0ffh ,0f0h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0fch ,000h ,000h ,000h ,03fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,081h 
db 0ffh ,0ffh ,0ffh ,0ffh ,080h ,07fh ,0ffh ,0ffh ,0ffh ,0f0h ,01fh ,0ffh ,0ffh ,0ffh ,0f8h ,01fh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,081h ,000h ,001h ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0f8h ,000h ,01fh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh 
db 0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh ,0ffh
X5 dw 0
Y5 dw 0 
count db 0
.code
.386
main proc
    mov ax, @data
    mov ds,ax
    SetMode 12h  ;繪圖模式
	SetColor 00h ;背景
    call sumcover
    SetCursor 19h,19h
    printstr13h Welcome_Press_Space,1001b,23,0ffh,0ffh,00h
    scan_start:
    Scan_IN
    cmp al,20h
    jne scan_start
    mov ax,0
    SetMode 12h  ;繪圖模式
	SetColor 00h
    SetCursor 13h,19h
    printstr13h w_a_s_d,1001b,36,0ffh,0ffh,00h
    SetCursor 19h,19h
    printstr13h Welcome_Press_Space,1001b,23,0ffh,0ffh,00h
    checkscore
scan_again:
    Scan_IN
    .if al !=20h
        jmp scan_again
    .endif
    SetMode 12h  ;繪圖模式
	SetColor 00h
    heart 450,450,1100b
    heart 470,450,1100b
    heart 490,450,1100b
    sunmap
    checkscore
    trans_Score_DEC highest_score
    SetCursor 1,35h
    printstr13h highest_score_srting,1001b,15,0ffh,0ffh,00h
    SetCursor 1,44h
    printstr13h score_dec,1001b,3,0ffh,0ffh,00h
    SetCursor 2,35h
    printstr13h now_score_string,1001b,12,0ffh,0ffh,00h
    play_sound 
while_loop:
        Scan_IN
        cmp G_change_position_flag, 1
        je Ghost_change_position
        jne Ghost_change_point_PASS
        Ghost_change_position:
            ;//////////////////////////////////////////////////////////Ghost1
            Multiply Ghost1_X, 15
            Mov GX, AX
            Multiply Ghost1_Y, 15
            Mov GY, AX
            sumghostc GY,GX,00b
            matrix_return Ghost1_X, Ghost1_Y
            cmp AX, 7
            je Ghost1_pivotal_point
            jne Ghost1_pivotal_point_PASS
            Ghost1_pivotal_point:
                Ghost1_to_Direction Ghost1_X, Ghost1_Y, Ghost1_dir, Pacman_X, Pacman_Y
                call Ghost_move
                Mov Ghost1_dir, AX
            Ghost1_pivotal_point_PASS:
            Ghost1_Position_change
            
            Multiply Ghost1_X, 15
            Mov GX, AX
            Multiply Ghost1_Y, 15
            Mov GY, AX
            sumghost gy,gx,1011b
            ;//////////////////////////////////////////////////////////Ghost2
            
            Multiply Ghost2_X, 15
            Mov GX, AX
            Multiply Ghost2_Y, 15
            Mov GY, AX
            sumghostc GY,GX,00B

            matrix_return Ghost2_X, Ghost2_Y
            cmp AX, 7
            je Ghost2_pivotal_point
            jne Ghost2_pivotal_point_PASS
            Ghost2_pivotal_point:
                .if Ghost2_near_time > 10 && Ghost2_dir == 0
                    Mov Ghost2_dir, 2
                    Mov Ghost2_near_time, 0
                    JMP Ghost2_pivotal_point_PASS
                .elseif Ghost2_near_time > 10 && Ghost2_dir == 1
                    Mov Ghost2_dir, 3
                    Mov Ghost2_near_time, 0
                    JMP Ghost2_pivotal_point_PASS
                .elseif Ghost2_near_time > 10 && Ghost2_dir == 2
                    Mov Ghost2_dir, 0
                    Mov Ghost2_near_time, 0
                    JMP Ghost2_pivotal_point_PASS
                .elseif Ghost2_near_time > 10 && Ghost2_dir == 3
                    Mov Ghost2_dir, 1
                    Mov Ghost2_near_time, 0
                    JMP Ghost2_pivotal_point_PASS
                .endif
                Push5_parameter Pacman_X, Pacman_Y, Ghost2_X, Ghost2_Y, 10
                call Distance
                cmp AX, Ghost_max
                jae Ghost2_far
                jb Ghost2_near
                Ghost2_near:
                    INC Ghost2_near_time
                    Ghost1_to_Direction Ghost2_X, Ghost2_Y, Ghost2_dir, Pacman_X, Pacman_Y
                    call Ghost_move
                    Mov Ghost2_dir, AX
                    JMP Ghost2_pivotal_point_PASS
                Ghost2_far:  
                Mov Ghost2_near_time, 0
                Ghost2_to_Direction
                call Ghost_move
                Mov Ghost2_dir, AX
            Ghost2_pivotal_point_PASS:
            Ghost2_Position_change

            Multiply Ghost2_X, 15
            Mov GX, AX
            Multiply Ghost2_Y, 15
            Mov GY, AX
            sumghost GY,GX,1101b
            ;//////////////////////////////////////////////////////////
            Scan_IN
            ;/////////////////////////////////////////////////////////Ghost3
            
            Multiply Ghost3_X, 15
            Mov GX, AX
            Multiply Ghost3_Y, 15
            Mov GY, AX
            sumghostc GY,GX,00b

            matrix_return Ghost3_X, Ghost3_Y
            cmp AX, 7
            je Ghost3_pivotal_point
            jne Ghost3_pivotal_point_PASS
            Ghost3_pivotal_point:
                .if Ghost3_near_time > 8 && Ghost3_dir == 0
                    Mov Ghost3_dir, 2
                    Mov Ghost3_near_time, 0
                    JMP Ghost3_pivotal_point_PASS
                .elseif Ghost3_near_time > 8 && Ghost3_dir == 1
                    Mov Ghost3_dir, 3
                    Mov Ghost3_near_time, 0
                    JMP Ghost3_pivotal_point_PASS
                .elseif Ghost3_near_time > 8 && Ghost3_dir == 2
                    Mov Ghost3_dir, 0
                    Mov Ghost3_near_time, 0
                    JMP Ghost3_pivotal_point_PASS
                .elseif Ghost3_near_time > 8 && Ghost3_dir == 3
                    Mov Ghost3_dir, 1
                    Mov Ghost3_near_time, 0
                    JMP Ghost3_pivotal_point_PASS
                .endif
                Push5_parameter Pacman_X, Pacman_Y, Ghost3_X, Ghost3_Y, 10
                call Distance
                cmp AX, Ghost_max
                jae Ghost3_far
                jb Ghost3_near
                Ghost3_near:
                    INC Ghost3_near_time
                    Ghost1_to_Direction Ghost3_X, Ghost3_Y, Ghost3_dir, Pacman_X, Pacman_Y
                    call Ghost_move
                    Mov Ghost3_dir, AX
                    JMP Ghost3_pivotal_point_PASS
                Ghost3_far:
                Mov Ghost3_near_time, 0
                Ghost3_to_Direction
                call Ghost_move
                Mov Ghost3_dir, AX
            Ghost3_pivotal_point_PASS:
            Ghost3_Position_change

            Multiply Ghost3_X, 15
            Mov GX, AX
            Multiply Ghost3_Y, 15
            Mov GY, AX
            sumghost GY,GX,0110b
            ;/////////////////////////////////////////////////////////Ghost4
            
            Multiply Ghost4_X, 15
            Mov GX, AX
            Multiply Ghost4_Y, 15
            Mov GY, AX
            sumghostC GY,GX,00b

            matrix_return Ghost4_X, Ghost4_Y
            cmp AX, 7
            je Ghost4_pivotal_point
            jne Ghost4_pivotal_point_PASS
            Ghost4_pivotal_point:
                .if Ghost4_near_time > 10 && Ghost4_dir == 0
                    Mov Ghost4_dir, 2
                    Mov Ghost4_near_time, 0
                    JMP Ghost4_pivotal_point_PASS
                .elseif Ghost4_near_time > 10 && Ghost4_dir == 1
                    Mov Ghost4_dir, 3
                    Mov Ghost4_near_time, 0
                    JMP Ghost4_pivotal_point_PASS
                .elseif Ghost4_near_time > 10 && Ghost4_dir == 2
                    Mov Ghost4_dir, 0
                    Mov Ghost4_near_time, 0
                    JMP Ghost4_pivotal_point_PASS
                .elseif Ghost4_near_time > 10 && Ghost4_dir == 3
                    Mov Ghost4_dir, 1
                    Mov Ghost4_near_time, 0
                    JMP Ghost4_pivotal_point_PASS
                .endif
                Push5_parameter Pacman_X, Pacman_Y, Ghost4_X, Ghost4_Y, 10
                call Distance
                cmp AX, Ghost_max
                jae Ghost4_far
                jb Ghost4_near
                Ghost4_near:
                    INC Ghost4_near_time
                    Ghost1_to_Direction Ghost4_X, Ghost4_Y, Ghost4_dir, Pacman_X, Pacman_Y
                    call Ghost_move
                    Mov Ghost4_dir, AX
                    JMP Ghost4_pivotal_point_PASS
                Ghost4_far:
                Mov Ghost4_near_time, 0
                Ghost4_to_Direction
                call Ghost_move
                Mov Ghost4_dir, AX
            Ghost4_pivotal_point_PASS:
            Ghost4_Position_change
            
            Multiply Ghost4_X, 15
            Mov GX, AX
            Multiply Ghost4_Y, 15
            Mov GY, AX
            sumghost GY,GX,1100b

            Mov G_change_position_flag, 0
        Ghost_change_point_PASS:
        Ghost_change_position_flag
		;/////////////////////////////////////////////////////////Player
        Game_over
		cmp AX, 1
		je Chased
        Scan_IN
        cmp P_change_position_flag, 1
        je Pacman_change_position
        jne Pacman_change_position_PASS
        Pacman_change_position:
            call Pacman_mov
            INC now_score
            INC Speed_up
            .if Speed_up >= 150
                Mov Speed_up, 0
                DEC Ghost_space
            .endif
            trans_Score_DEC now_score
            SetCursor 2,44h
            printstr13h score_dec,1001b,3,0ffh,0ffh,00h

            Multiply Pacman_X, 15
            Mov PX, AX
            Multiply Pacman_Y, 15
            Mov PY, AX
            mov bx,Pacman_Dir
        
            cmp bx,0
            jne checkdir1
            sumcircle PY,PX,1110b
            upsmile PY,PX
            ;play_sound
            jmp endcheck
            checkdir1:
            cmp bx,1
            jne checkdir2
            sumcircle PY,PX,1110b
            rightsmile PY,PX
            ;play_sound
            jmp endcheck
            checkdir2:
            cmp bx,2
            jne checkdir3
            sumcircle PY,PX,1110b
            downsmile py,px
            ;play_sound
            jmp endcheck
            checkdir3:      
            sumpac py,px,1110b
            ;play_sound
            Mov P_change_position_flag, 0
            Pacman_change_position_PASS:
		    ;/////////////////////////////////////////////////////////Game error
            endcheck:
        Pacman_change_position_flag
        Game_over
		cmp AX, 1
		je Chased
		JMP while_loop
Chased:
    DEC life
    .if life > 1
        play_sound
        Restart
        JMP while_loop
    .endif
    play_sound
    play_sound
    play_sound
    mov ax,highest_score
    cmp ax,now_score
    jae refresh_file
    writescore
refresh_file:
    heart 490,450,1000b
    SetMode 12h  ;繪圖模式
	SetColor 00h
    sumghost_photo 1011b,5
    sumpac_photo
    mov xghost1,0
    mov xghost2,0
    mov yghost1,0
    mov yghost2,0
    sumghost_photo 1101b,420
    SetCursor 18h,19h
    printstr13h now_score_string,1001b,12,0ffh,0ffh,00h
    SetCursor 18h,25h
    printstr13h score_dec,1001b,3,0ffh,0ffh,00h
    SetCursor 19h,16h
    printstr13h check_escape,1001b,21,0ffh,0ffh,00h

wait_esc:
    Scan_IN
    cmp al,1bh
    jne wait_esc
    mov ah,00h  ;設定顯示模式
	mov al,03h  ;選擇模式3h(文字模式)
	int 10h
    mov ax, 4c00h
    int 21h
main endp

Ghost_move proc
;PX:WORD[bp + 12], PY:WORD[bp + 10], GX:WORD[bp + 8], GY:WORD[bp + 6], Predirection:WORD[bp + 4]
    local nShortest:WORD, pointer:WORD, pointer_distance:WORD;, nDistance:WORD
	Mov nShortest, 0
	Mov pointer_distance, 0
	Mov pointer, 0
    Mov AX, G_dir
    Mov pointer, AX
    Mov AX, PX
    Mov BX, PY
    Mov CX, GX
    Mov DX, GY
    cmp AX, CX
    je Compare_Whether_Same
    jne Compare_Whether_Same_PASS
Compare_Whether_Same:
    cmp BX, DX
    je Ghost_Chased
    jne Compare_Whether_Same_PASS
Ghost_Chased:
    Mov AX, 10
    ret
Compare_Whether_Same_PASS:
    matrix_space GX, GY, -1, 0
    cmp AX, 0
    je UP_have_Space
    jne UP_have_Space_PASS
UP_have_Space:
    Mov Direction_usable[0], 1
UP_have_Space_PASS:

    matrix_space GX, GY, 0, 1
    cmp AX, 0
    je RIGHT_have_Space
    jne RIGHT_have_Space_PASS
RIGHT_have_Space:
    Mov Direction_usable[1], 1
RIGHT_have_Space_PASS:

    matrix_space GX, GY, 1, 0
    cmp AX, 0
    je DOWN_have_Space
    jne DOWN_have_Space_PASS
DOWN_have_Space:
    Mov Direction_usable[2], 1
DOWN_have_Space_PASS:

    matrix_space GX, GY, 0, -1
    cmp AX, 0
    je LEFT_have_Space
    jne LEFT_have_Space_PASS
LEFT_have_Space:
    Mov Direction_usable[3], 1
LEFT_have_Space_PASS:
    Mov BX, pointer
    ADD BX, 2
    cmp BX, 3
    ja pointer_too_big
    jbe pointer_not_too_big
pointer_too_big:
    SUB BX, 4
pointer_not_too_big:
    Mov Direction_usable[BX], 0
    Mov AX, 0
    Mov CX, 0
Loop_compare_shortest_distance:
        Mov BX, CX
        cmp Direction_usable[BX], 1
        je if_direction_usable
        jne if_direction_not_usable
    if_direction_usable:
		Mov pointer_distance, CX
        push GX
        push GY
        Push5_parameter PX, PY, GX, GY, pointer_distance
        call Distance
        pop GY
        pop GX
        
        Mov BX, nShortest;if(nShortest == 0)
        cmp BX, 0
        je First_Distance
        jne Not_First_Distance
        First_Distance:
            Mov nShortest, AX
            Mov pointer, CX
        Not_First_Distance:
        cmp nShortest, AX;if(nDistance < nShorest)
        jae nShortest_change
        jb if_direction_not_usable
        nShortest_change:
            Mov nShortest, AX
            Mov pointer, CX
    if_direction_not_usable:
		INC CX 
        CMP CX, 4
		jne Loop_compare_shortest_distance
    Mov AX, pointer
    ret
Ghost_move endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Distance proc;Success
;PX:WORD[bp + 12], PY:WORD[bp + 10], GX:WORD[bp + 8], GY:WORD[bp + 6], Direction:WORD[bp + 4]
    local nDistance:WORD
    Mov nDistance, 0
    push BX
    Mov BX, G_dir
    cmp BX, 0
    je Direction0
    jne Direction0_pass
Direction0:
        Mov AX, GX
        SUB AX, 1
        Mov GX, AX
Direction0_pass:
    cmp BX, 1
    je Direction1
    jne Direction1_pass
Direction1:
        Mov AX, GY
        ADD AX,  1
        Mov GY, AX
Direction1_pass:
    cmp BX, 2
    je Direction2
    jne Direction2_pass
Direction2:
        Mov AX, GX
        ADD AX, 1
        Mov GX, AX
Direction2_pass:
    cmp BX, 3
    je Direction3
    jne Direction3_pass
Direction3:
        Mov AX, GY
        SUB AX,  1
        Mov GY, AX
Direction3_pass:
    Mov AX, PX
    Mov BX, GX
    SUB AX, BX
    Multiply AX, AX
    Mov nDistance, AX
    Mov AX, PY
    Mov BX, GY
    SUB AX, BX
    Multiply AX, AX
    Mov BX, nDistance
    ADD AX, BX
	pop BX
    ret
Distance endp

;////////////////////////////////////////////////////
Pacman_mov proc
	local pre_direction:WORD
    Mov AX,Pacman_Dir
    Mov pre_direction, AX
    Multiply Pacman_X, 15
    Mov PX, AX
    Multiply Pacman_Y, 15
    Mov PY, AX
    ;WrPixel PY, PX, 00b
    ;sumtri PY,PX,5,00b
    sumcirclec PY,PX
    Scan_IN
    Mov al, char 
	cmp Al, 77h
	je W_dir
	jne W_dir_PASS
	W_dir:
		Mov Pacman_Dir, 0
	W_dir_PASS:

	cmp Al, 64h
	je D_dir
	jne D_dir_PASS
	D_dir:
		Mov Pacman_Dir, 1
	D_dir_PASS:

	cmp Al, 73h
	je S_dir
	jne S_dir_PASS
	S_dir:
		Mov Pacman_Dir, 2
	S_dir_PASS:

	cmp Al, 61h
	je A_dir
	jne A_dir_PASS
	A_dir:
		Mov Pacman_Dir, 3
	A_dir_PASS:

	cmp Pacman_Dir, 0
    je Position_0
    jne position_0_pass
    Position_0:
	matrix_space Pacman_X, Pacman_Y, -1, 0
        cmp AX, 1
        je ERROR
        DEC Pacman_X
        ret
    position_0_pass:
	cmp Pacman_Dir, 1
    je Position_1
    jne Position_1_Pass
    Position_1:
		matrix_space Pacman_X, Pacman_Y, 0, 1
		cmp AX, 1
		je ERROR
		INC Pacman_Y
		ret
	Position_1_Pass:
	cmp Pacman_Dir, 2
    je Position_2
    jne Position_2_Pass
    Position_2:
		matrix_space Pacman_X, Pacman_Y, 1, 0
		cmp AX, 1
		je ERROR
		INC Pacman_X
		ret
	Position_2_Pass:
	cmp Pacman_Dir, 3
    je Position_3
    jne Position_3_Pass
    Position_3:
		matrix_space Pacman_X, Pacman_Y, 0, -1
		cmp AX, 1
		je ERROR
		DEC Pacman_Y
		ret
	Position_3_Pass:
ERROR:
    cmp pre_direction, 0
    jne E_position_0_Pass
        matrix_space Pacman_X, Pacman_Y, -1, 0
        .if AX == 0
            DEC Pacman_X
            Mov char, 77h
            Mov Pacman_Dir, 0
        .elseif AX == 1
            Mov Pacman_Dir, 0
        .endif
        ret
    E_position_0_Pass:
    cmp pre_direction, 1
    jne E_position_1_Pass
        matrix_space Pacman_X, Pacman_Y, 0, 1
        .if AX == 0
            INC Pacman_Y
            Mov char, 64h
            Mov Pacman_Dir, 1
        .elseif AX == 1
            Mov Pacman_Dir, 1
        .endif
        ret
    E_position_1_Pass:
    cmp pre_direction, 2
    jne E_position_2_Pass
        matrix_space Pacman_X, Pacman_Y, 1, 0
        .if AX == 0
            INC Pacman_X
            Mov char, 73h
            Mov Pacman_Dir, 2
        .elseif AX == 1
            Mov Pacman_Dir, 2
        .endif
        ret
    E_position_2_Pass:
	cmp pre_direction, 3
    jne E_position_3_Pass
        matrix_space Pacman_X, Pacman_Y, 0, -1
        .if AX == 0
            DEC Pacman_Y
            Mov char, 61h
            Mov Pacman_Dir, 3
        .elseif AX == 1
            Mov Pacman_Dir, 3
        .endif
        ret
    E_position_3_Pass:
Pacman_mov endp

sumcover proc
    local temp:WORD
    Mov BX, 0
Again:
    INC BX
    Mov Al, cover[BX]
    Mov CX, 8
    Mov count, 0
    while_loo_proc:
        push cx
        .if AL >= 128
            INC Y5
        .elseif AL < 128
            WrPixel Y5, X5, 1111b
            INC Y5
        .endif
        Shl Al, 1
        .if X5 >= 480 && Y5 >= 640
            JMP break
        .elseif Y5 >= 640
            Mov Y5, 0
            INC X5
        .endif
       pop cx 
    loop while_loo_proc
    JMP Again
    break:
    ret 
sumcover  endp
end main