.MODEL SMALL
.386
.STACK 50H
.DATA
D1 DB 0AH,"ENTER THE FIRST NUMBER:",24H
D2 DB 0AH,"ENTER THE SECOND NUMBER:",24H
D3 DB 0AH,"SUM IS:",24H
.CODE
START:
MOV AX,@DATA
MOV DS,AX

MOV DX,OFFSET D1
MOV AH,09H
INT 21H
CALL Input
MOV EBP,EBX
MOV DX,OFFSET D2
MOV AH,09H
INT 21H
CALL Input

ADD EBX,EBP
MOV DX,OFFSET D3
MOV AH,09H
INT 21H
CALL Output
MOV AH,4CH
INT 21H

Input PROC NEAR
MOV EBX,00000000H
MOV EDX,00000000H
MOV CL,1CH
MOV CH,08H

L1: MOV AH,01H
    INT 21H
    CMP AL,39H
    JBE L2
    SUB AL,37H
    JMP L3

L2: SUB AL,30H

L3: MOV DL,AL
    SHL EDX,CL
    ADD EBX,EDX
    MOV EDX,00000000H
    SUB CL,04H
    SUB CH,01H
    JNZ L1
    RET
Input ENDP
Output PROC NEAR
    JNC L4
    MOV DL,31H
    MOV AH,02H
    INT 21H

L4: MOV EBP,0F0000000H
    MOV CL,1CH
    MOV CH,08H

L5: MOV EDX,EBX
    AND EDX,EBP
    SHR EDX,CL
    CMP DL,09H
    JBE L6
    ADD DL,37H
    JMP L7

L6: ADD DL,30H

L7: MOV AH,02H
    INT 21H
    MOV AL,CL
    MOV CL,04H
    SHR EBP,CL
    MOV CL,AL
    SUB CL,04H
    SUB CH,01H
    JNZ L5
    RET
Output ENDP
END START