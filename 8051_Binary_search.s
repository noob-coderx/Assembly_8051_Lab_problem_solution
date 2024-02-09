// -- DO NOT CHANGE ANYTHING UNTIL THE **** LINE--
//
//SUBB stores the subtracted value in a 
//XCH exchanges the value between the two registers
ORG 0H 
LJMP MAIN 
ORG 100H 
MAIN: acall Pre_req
acall Binary_search
HERE: SJMP HERE
ORG 130h 
Pre_req:
mov r0, #30h 
mov a, @r0
mov r2, a
mov r3, #8//Sequence length
add a, r3
mov r3, a 
Dec r3//point to the high location
//now that we know where the array is at, we dont need to have r0 with 30h anymore lets reuse it
mov r0, 02h //r0 -> low_pointer, r1 -> high_pointer
mov r1, 03h
mov r4, 31h // 31h contains the query number, also default output of not finding the number is ff
ret

Binary_search:

push 00
push 01
mov a, r0
mov b, r1
SUBB a, b
JZ Make_decision_rn
pop 01
pop 00

CLR cy
mov a, @r0
SUBB a, r4
JZ print_low
JNC print_ffh
mov a, @r1
CLR cy
SUBB a, r4
JZ print_high
JC print_ffh
push 00h
clr cy             // BRO, this is so messed up, as there will be overflow as the addresses are too big, must divide first
mov a, r0
mov b, #2
DIV ab
mov r5, a
mov a, r1
mov b, #2
DIV ab
add a, r5
mov r0, a
mov 60h, 00h // 60h temporarily holds the value of the r0 which is the low pointer
mov a, @r0
SUBB a, r4
pop 00h
JC SET_LOW_TO_MID
JNC SET_HIGH_TO_MID
Back1:
CLR cy
SJMP binary_search


print_ffh:
mov 32h, #0ffh
ret

SET_LOW_TO_MID:
mov r0, 60h
SJMP back1

SET_HIGH_TO_MID:
mov r1, 60h
SJMP back1

print_low:
mov 32h, r0
ret

print_high:
mov 32h, r1
ret

Make_decision_rn:
pop 01
pop 00
mov a, r0
SUBB a, r4
JNZ print_ffh
SJMP print_low

END