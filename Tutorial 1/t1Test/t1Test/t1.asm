.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.data
public	g
g		DWORD	4
.code

public  min

min:    push    ebp                 ; push frame pointer
        mov     ebp, esp            ; update ebp
        push    ebx
        mov     eax, [ebp+8]        ; eax = p0
        cmp     [ebp+12], eax       ; if(p1 < p0) swap
        jge     min1                ; else skip
        mov     eax, [ebp+12]
min1:   cmp     [ebp+16], eax		; same compare as before with next param,
        jge     min2
        mov     eax, [ebp+16]		;swap if less than
min2:   pop     ebx					;restore
        mov     esp, ebp			;
        pop     ebp					;
        ret     0					;exit

public	p

p:		push	ebp					;initilize funtion as before
		mov		ebp, esp			;
		push	ebx					;
		push	[ebp+12]			; manually perform stack pushes that C function call would do
		push	[ebp+8]				;
		mov		eax, [g]			;
		push	eax					;
		call	min					;call min function
		push	[ebp+20]			;again manually doing stack pushes of params
		push	[ebp+16]			;
		push	eax					;
		call	min					;call min function with result of last min as a param
		pop     ebx					;restore	
        mov     esp, ebp			;
        pop     ebp					;
        ret     0					;exit

public gcd


gcd:	push	ebp					;initilize as before
		mov		ebp, esp			;
		push	ebx					;
		mov		eax, 0				;set eax to 0 for comparison to B
		cmp		[ebp+12], eax		;if be = 0
		je		gcd1				;jump to gcd1 and retun a
		mov		eax, [ebp+8]		;else get value a into eax
		cdq							;eax:edx
		mov		ebx, [ebp+12]		;get value b into ebx
		idiv	ebx					;signed divison of eax:edx by ebx where remainder(what we are lookinf for)is stored in edx
		mov		ecx, ebx			;save the last divisor
		push	edx					;push new params onto stack 
		push	[ebp+12]			;
		call	gcd					;and call gcd again
gcd1:
		mov		eax, ecx			;move last devisor used into eax for return
		pop     ebx					;restore
        mov     esp, ebp			;
        pop     ebp					;
        ret     0					;exit

end       
