.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.code

public  min

min:    push    ebp                 ; push frame pointer
        mov     ebp, esp            ; update ebp
        sub     esp, 4              ; space for local variable v [ebp-4]
        push    ebx
        mov     eax, [ebp+8]        ; eax = p0
        cmp     [ebp+12], eax       ; if(p1 < p0)
        jge     min1                ; skip
        mov     eax, [ebp+12]
min1:   cmp     [ebp+16], eax
        jge     min2
        mov     eax, [ebp+16]
min2:   pop     ebx
        mov     esp, ebp
        pop     ebp
        ret     0

        
