
; Author: Joseph Di Lullo
; Last Modified: 3/13/2022

INCLUDE Irvine32.inc

.data

.code

main PROC

exit
main ENDP

;Description: Compute procedure, calls the encrypt, decrypt, and decoy procedures
;Receives: dest
;Returns: nothing
;Preconditions: none
;Register changed: eax, esi, ebp, esp, ebx
compute PROC

	push ebp 
	mov ebp, esp							

								
	mov eax, [ebp + 8]
	mov eax, [eax]							;put the value of dest into eax
	
	cmp eax, -1								;if dest is -1 then jump to encrypt function
	je encryptionmode1

	cmp eax, -2								;if dest is -2 then jump to decrypt function
	je decryptionmode1

	call decoymode							

	pop ebp
ret 

encryptionmode1:
	mov eax, [ebp + 12]
	push eax
	mov ebx, [ebp + 16]						
	push ebx

	call encryptionmode

ret 12

decryptionmode1:
	mov eax, [ebp + 12]
	push eax								
	mov ebx, [ebp + 16]
	push ebx

	call decryptionmode

ret 12

compute ENDP

;Description: decoy procedure
;Receives: dest
;Returns: dest
;Preconditions: dest must not be -1 or -2
;Register changed: eax, ebp
decoymode PROC

	push ebp 
	mov ebp, esp

	mov eax, 26
	mov [dest], eax							

	pop ebp
ret 
decoymode ENDP

;Description: encryption procedure, encrptes the message
;Receives: message
;Returns: modified message
;Preconditions: dest is -1
;Register changed: eax, esi, ebp, esp, edi, ebx
encryptionmode PROC

	push ebp 
	mov ebp, esp

	mov esi, [ebp + 12]						;set the address of message into esi
	mov edi, [ebp + 8]						;set the address of message into edi
	sub esi, 1

outerloop:
	add esi, 1								

	mov eax, 0								
	mov ebx, 0

	mov al, [esi]							
	cmp al, 0
	je done

	cmp al, 97								
	jl space

	sub al, 'a'								

	mov bl, [edi + eax]						

	again:

	mov [esi], bl							
	mov eax, ebx

	jmp outerloop

space:
	mov bl, ' '									
	jmp again

done:
	mov bl, '.'									
	mov [esi - 1], bl

	pop ebp

ret 12
encryptionmode ENDP

;Description: decryption procedure, decrypts message
;Receives: message
;Returns: modified message
;Preconditions: dest is -2
;Register changed: eax, esi, ebx, bl, al, ebp, esp, edi
decryptionmode PROC

	push ebp 
	mov ebp, esp

	mov esi, [ebp + 12]						
	mov edi, [ebp + 8]						

	sub esi, 1	

theouterloop:
	add esi, 1

	mov al, [esi]							
	cmp al , 0
	je ender

	cmp al, 97								
	jl space1

	mov cl, 0								

	mov edi, [ebp + 8]						

	sub edi, 1

	theinnerloop:
	inc cl									

	add edi, 1								

	mov bl, [edi]							

	cmp cl, 26								
	jg theouterloop

	cmp bl, al								
	je equal

	jmp theinnerloop						

equal:
	dec cl 

	add cl, 97								
	mov al, cl
	mov [esi], al							

	jmp theinnerloop


space1:
	mov al, ' '								
	mov [esi], al

	jmp theinnerloop
	
ender:
	mov al, '.'
	mov [esi - 1], al						
	pop ebp

ret 12
decryptionmode ENDP


END main
