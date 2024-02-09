// -- DO NOT CHANGE ANYTHING UNTIL THE **** LINE--
//
//SUBB stores the subtracted value in a 
//XCH exchanges the value between the two registers
ORG 0H 
LJMP MAIN 
ORG 100H 
MAIN: SJMP Fetch 
Come_back: Acall HCF 
HERE: SJMP HERE
ORG 130h 
Fetch: mov a, 50h 
mov b, 51h 
SUBB a, b 
JNC Come_back 
XCH a, b 
SJMP Come_back 

HCF: 
mov r1, b
CJNE r1, #00, SLICE_EM
mov 52h, a
ret

SLICE_EM:
push b
div ab
mov a, b
pop b
xch a, b
SJMP HCF

END