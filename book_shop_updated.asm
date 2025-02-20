org 100h

.model large
.stack 1000h
.data

english_books db 'Wuthering Heights$', 'Middlemarch$', '1984$', 'The Lord of the Rings$', 0  
bangla_books db 'Gitanjali$', 'Devdas$', 'Deyal$', 'Srikanto$', 0
selfhelp_books db 'The alchemist$', 'Outliers$', 'Deep Work$', 'Atomic Habit$', 0


    


;welcome page

a1 db 10,13,'                     ***********************************************$'
a2 db 10,13,'                     **               Welcome                     **$'
a3 db 10,13,'                     **                  To                       **$'
a4 db 10,13,'                     **              Online Book                  **$'
a5 db 10,13,'                     **                 Shop                      **$'
a6 db 10,13,'                     ***********************************************$'
 
 

bookPrompt1 db 10,13,10,13,'                    >>> Enter the name of the book: $'
bookBuffer1 db 20,?, 20 dup('$') 
flat_array db 20 dup('$') 
   

foundmsg db '                *** Found it! The book is on the list ***$'
msg_done db 10,13,'           Book not found! Make sure the title is correct.', 0
                   

newline dw 10,13,'$'
newline2 db 10,13,10,13,'$'


 
 ;logindata
 
  
inputPrompt1 db 10,13,'Enter Username: $'
inputPrompt2 db 10,13,'Enter Password: $'
usernameCorrect db 'admin$'      ; Predefined correct username
passwordCorrect db '1234$'       ; Predefined correct password
correctMsg db 13,'Access granted!$'
incorrectMsg db 10,13,'Invalid username or password.Try again$'
maxattemptmsg db 10,13,'You have reached your maximum limit (3 times).$'
endmsg db 10,13,'You can not enter the system.The program is terminated$' 


inputBuffer1 db 20 dup('$') ; Buffer for user-entered username
inputBuffer2 db 20 dup('$') ; Buffer for user-entered password 
 
 
 
 

 

 
 

a7 db 10,13,'                      Books List---$'
a8 db 10,13,'                      Enter Your Choice: $'
a49 db 10,13,'                     What do you want to search ? $'

a34 db 10,13,'                              Pick Your Book: $'
a35 db 10,13,'                              Enter Quantity: $'
a36 db 10,13,'                         Invalid Input! Please try again.$'
a37 db 10,13,'                              Total Price: $'
a38 db 10,13,'                    > 1.Books List $'
a39 db 10,13,'                    > 2.Search a book $'  
a40 db 10,13,'                    > 3.Exit $'



;Book List
a9 db 10,13,'                         1.English Novels$'
a10 db 10,13,'                         2.Bengali Novels$'
a11 db 10,13,'                         3.Self Help Books$'


                                 
                                 
                                 
;English Novels List               
a12 db 10,13,'                    *********    English Novels List         *******$'
a13 db 10,13,'                        1. Vuthering Heights        50/-$'    
a14 db 10,13,'                        2. Middle March             50/-$'
a15 db 10,13,'                        3. 1984                     50/-$'
a16 db 10,13,'                        4. The Lord of the Ringe    50/-$'
a17 db 10,13,'                        5. Diary of Nobody          50/-$'
a18 db 10,13,'                        6. His Bark Materials       50/-$'   


;Bangla Novels List
a20 db 10,13,'                    *********    Bengali Novels List          ********$' 
a21 db 10,13,'                        1.Gitanjali            100/-$'
a22 db 10,13,'                        2.Sesher Kobita        100/-$'
a23 db 10,13,'                        3.Devdas               100/-$'
a24 db 10,13,'                        4.Aaj himur biyer      100/-$'
a25 db 10,13,'                        5.Deyal                100/-$'   
a26 db 10,13,'                        6.Srikanto             100/-$'


                



a27 db 10,13,'                    *********    Self Help Books List            ********$'
a28 db 10,13,'                      1.Atomic Habit             200/-$'  
a29 db 10,13,'                      2.The alchemist            200/-$' 
a30 db 10,13,'                      3.OUtliers                 200/-$' 
a31 db 10,13,'                      4.Dopamine Detox           200/-$' 
a32 db 10,13,'                      5.Think and grow rich      200/-$' 
a33 db 10,13,'                      6.Deep Work                200/-$' 
exitMessage db 10,13,'            Thank you for visiting! See you again soon!$'  
nextLine db 10,13,'$'






.code 
main proc
    
    mov ax,@data
    mov ds,ax
    
     
    
    ;welcome page
    call welcome  
    ;newline
 
  call NEWLINE_PRINT2
  
  call authenticate_user
  
  
  

proceedToMainMenu: 
 
    
    
    ;take input to start
    mov ah,9
     mov dx,offset a38
     int 21h
     
     mov ah,9
     mov dx,offset a39
     int 21h
     
     mov ah,9
     mov dx,offset a40
     int 21h 
     
     mov ah,9
     mov dx,offset a8
     int 21h
     
     mov ah,1
     int 21h
     sub al,48
     
     
     cmp al,1
     je BookList
     
     cmp al,2
     je SearchBook
     
     cmp al,3
     je Exit 
     
     jmp Invalid
    
    
    
   BookList:
    ;newline
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    
    
    mov ah,9
    mov dx,offset a7
    int 21h
    mov dx,offset a9
    int 21h
    mov dx,offset a10
    int 21h
    mov dx,offset a11
    int 21h
    
     
     
     
    ;list choose
    mov dx,offset a8
    int 21h
    
    mov ah,1
    int 21h
    mov bh,al
    sub bh,48
    
    
    
    cmp bh,1
    je EnglishNovels
    
    cmp bh,2
    je BengaliNovels
    
    cmp bh,3
    je selfhelps
    
    jmp Invalid
    
    
    
    
    ;English Novels list
    EnglishNovels:
    
    ;newline
 call NEWLINE_PRINT2
    
    
 
    
    
    
    mov ah,9
    mov dx,offset a12  
    int 21h
    mov ah,9
    mov dx,offset a13
    int 21h
    mov dx,offset a14
    int 21h
    mov dx,offset a15
    int 21h
    mov dx,offset a16
    int 21h
    mov dx,offset a17
    int 21h
    mov dx,offset a18
    int 21h
    
    
    
    
    ;condition checking
    mov dx,offset a34
    int 21h
    
    
    mov ah,1
    int 21h
    mov bl,al
    sub bl,48
    
    
    
    cmp bl,1
    je fifty
    
    cmp bl,2
    je fifty 
    
    cmp bl,3
    je fifty
    
    cmp bl,4
    je fifty
    
    cmp bl,5
    je fifty
    
    cmp bl,6
    je fifty
    
    
    jmp Invalid
    
    
    
    BengaliNovels:
    
 call NEWLINE_PRINT2
    
    
    mov ah,9
    mov dx,offset a20
    int 21h
    
    
 call NEWLINE_PRINT
    
    
    mov ah,9
    mov dx,offset a21
    int 21h  
    mov dx,offset a22
    int 21h
    mov dx,offset a23
    int 21h 
    mov dx,offset a24
    int 21h          
    mov dx,offset a25
    int 21h 
    mov dx,offset a26
    int 21h  
    
    
    ;condition checking
    mov dx,offset a34
    int 21h
    
    mov ah,1
    int 21h
    mov bl,al 
    sub bl,48
    
    
    cmp bl,1
    je Hundred  
    
    cmp bl,2
    je Hundred
    
    cmp bl,3
    je Hundred
    
    cmp bl,4
    je Hundred
    
    cmp bl,5
    je Hundred
    
    cmp bl,6
    je Hundred 
    
    
    jmp Invalid
    
    
    ;for exit
  call NEWLINE_PRINT
    
    
    mov ah,9
    mov dx,offset a38
    int 21h
    
    mov ah,1
    int 21h
    mov bh,al
    
    cmp bh,1
    jmp Exit
    
    
    
    
    selfhelps:
    ;newline
    
 call NEWLINE_PRINT2
      
    
    ;List start
    mov ah,9
    mov dx,offset a27
    int 21h
    
 call NEWLINE_PRINT
    
    
    mov ah,9
    mov dx,offset a28
    int 21h
    mov dx,offset a29
    int 21h
    mov dx,offset a30
    int 21h
    mov dx,offset a31
    int 21h
    mov dx,offset a32
    int 21h
    mov dx,offset a33
    int 21h
    
    
    ;condition checking 
    mov dx,offset a34
    int 21h
    
    mov ah,1
    int 21h
    mov bl,al
    sub bl,48
    
    
     
     cmp bl,1
     je TwoHundred   
     
     cmp bl,2
     je TwoHundred
     
     cmp bl,3
     je TwoHundred
     
     cmp bl,4
     je TwoHundred
     
     cmp bl,5
     je TwoHundred
     
     cmp bl,6
     je TwoHundred 
     
     jmp Invalid
     
     
     fifty:
     mov bl,5
     mov dx,offset a35
     mov ah,9
     int 21h
     
     
     mov ah,1
     int 21h
     sub al,48
     
     mul bl
     aam  
     
     
     mov cx,ax
     add ch,48
     add cl,48
     
     
     mov dx,offset a37
     mov ah,9
     int 21h
     
     
     mov ah,2
     mov dl,ch
     int 21h
     

     
     mov dl,cl
     int 21h
     
     mov dl,'0'
     int 21h
     
     
     mov dl,47
     int 21h
     mov dl,45
     int 21h
     
     
     ;for exit or main menu
 call NEWLINE_PRINT
     
     
      mov ah,9
     mov dx,offset a38
     int 21h
     
     mov ah,9
     mov dx,offset a39
     int 21h
     
     mov ah,9
     mov dx,offset a40
     int 21h
     
     mov ah,1
     int 21h
     sub al,48
     
     
     cmp al,1
     je BookList
     
     cmp al,2
     je SearchBook
     
     cmp al,3
       je exit
     
     jmp Invalid

     
     
     
     
       
       
     Hundred: 
     
     mov bl,10
     mov dx,offset a35
     mov ah,9
     int 21h
     
     
     mov ah,1
     int 21h
     sub al,48
     
     mul bl
     aam
     
     
     mov cx,ax
     add ch,48
     add cl,48
     
     mov dx,offset a37
     mov ah,9
     int 21h
     
     
     mov ah,2
     mov dl,ch
     int 21h
     

     
     mov dl,cl
     int 21h
     
     mov dl,'0'
     int 21h
     
     
     mov dl,47
     int 21h
     mov dl,45
     int 21h
     
     
     ;for exit
     mov ah,2
     mov dl,10
     int 21h
     mov dl,13
     int 21h
     
     mov ah,9
     mov dx,offset a38
     int 21h  
     
     mov ah,9
     mov dx,offset a39
     int 21h 
     
     mov ah,9
     mov dx,offset a40
     int 21h
     
     mov ah,9
     mov dx,offset a8
     int 21h
     
     mov ah,1
     int 21h
     sub al,48
     
     
     cmp al,1
     je BookList
     
     cmp al,2
     je SearchBook 
     
     cmp al,3
     je Exit
     
     jmp Invalid
     
     
     
     TwoHundred:
     mov bl,20
     mov dx,offset a35
     mov ah,9
     int 21h
     
     mov ah,1
     int 21h
     sub al,48
     
     mul bl
     aam
     
     mov cx,ax
     add ch,48
     add cl,48
     
     
     mov dx,offset a37
     mov ah,9
     int 21h
     
     mov ah,2
     mov dl,ch
     int 21h
     
     mov dl,cl
     int 21h
     
     mov dl,'0'
     int 21h
     
     mov dl,47
     int 21h
     mov dl,45
     int 21h
     
     
 
 
 ;for exit
 call NEWLINE_PRINT
 
 mov ah,9
 mov dx,offset a38
 int 21h
 
 mov ah,9
 mov dx,offset a39
 int 21h
 
 
 mov ah,9
 mov dx,offset a40
 int 21h 
 
 mov ah,9
 mov dx,offset a8
 int 21h
 
 
 mov ah,1
 int 21h
 sub al,48
 
 cmp al,1
 je BookList 
 
  cmp al,2
 je SearchBook
 
 cmp al,3
 je Exit
 
 jmp Invalid
 

     
     
     
       
       
  
 SearchBook:
 
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    
    
    mov ah,9
    mov dx,offset a49
    int 21h 
    
    mov dx,offset a9
    int 21h
    mov dx,offset a10
    int 21h
    mov dx,offset a11
    int 21h
    
     
     
     
    ;list choose
    mov dx,offset a8
    int 21h
    
    mov ah,1
    int 21h
    mov bh,al
    sub bh,48
    
    
    
    cmp bh,1
    je SearchEnglishNovels
    
    cmp bh,2
    je SearchBengaliNovels
    
    cmp bh,3
    je Searchselfhelps
    
    jmp Invalid   


     
     
SearchEnglishNovels:
    mov ah, 9
    mov dx,offset bookPrompt1
    int 21h  
 
    ; Read username
    mov dx,offset bookBuffer1
    mov ah, 0Ah
    int 21h  
    
    lea si, english_books
    
    call findtheBook 
    
    
    
 SearchBengaliNovels:
 
      mov ah, 9
    mov dx,offset bookPrompt1
    int 21h  
    
  
    
    ; Read username
    mov dx,offset bookBuffer1
    mov ah, 0Ah
    int 21h  
    
    lea si, bangla_books            ; SI points to the original strings array
    
    call findtheBook 
 
     
 Searchselfhelps:    
 
    mov ah, 9
    mov dx,offset bookPrompt1
    int 21h  
 
    ; Read username
    mov dx,offset bookBuffer1
    mov ah, 0Ah
    int 21h 
    
    lea si, selfhelp_books          ; SI points to the original strings array 
    
    call findtheBook 
 
    
    
main endp  
  
  
findtheBook proc    

   
    
process_strings:
    cmp byte ptr [si], 0       ; Check if the current byte is null (end of strings)
    je all_done                ; If null, exit the loop

    ; Save SI before copying and comparing the string
    push si                    ; Save SI to the stack

    ; Step 2: Copy a string to flat_array
    lea di, flat_array         ; DI points to flat_array
    call copy_single_string    ; Copy one string

    ; Step 3: Print the copied string
   ; lea di, flat_array         ; Reset DI to flat_array
  ;  call print_string          ; Print the string  

    lea di, flat_array         ; Reset DI to flat_array
    call compareStrings2        ; Compare the flat_array with the input string
    
    cmp al, 1                  ; Check if the strings are equal (al = 1 means equal)
    je found                   ; If equal, jump to found label

    ; Step 5: Clear flat_array for reuse
    call clear_flat_array      ; Clear flat_array for the next string

    ; Restore SI after the comparison
    pop si                     ; Restore SI from the stack

    ; Skip the current string (past the '$' delimiter)
    find_next_string:
        cmp byte ptr [si], '$'  ; Check for the string delimiter '$'
        je next_string_found    ; If '$' found, move to the next string
        inc si                  ; Move to the next byte (continue if not '$')
        jmp find_next_string    ; Repeat until '$' is found

    next_string_found:
        inc si                  ; Skip past the '$' delimiter

    ; Process the next string
    jmp process_strings        ; Go back and process the next string

found: 

    call NEWLINE_PRINT2   
    mov ah,09h
    mov dx, offset foundmsg
    int 21h 
    
    call NEWLINE_PRINT  
    
    
   jmp proceedToMainMenu
    
    ;mov ah,4ch
    ;int 21h
    
all_done:
    mov dx, offset msg_done
    mov ah, 09h
    int 21h  
    jmp proceedToMainMenu
   
   
   ; mov ax, 4C00h
    ;int 21h
 
findtheBook endp
 
copy_single_string proc
    copy_loop:
        mov al, [si]                ; Load a byte from strings
        cmp al, '$'                 ; Check if end of the current string
        je copy_done                ; Exit loop if '$' is found
        mov [di], al                ; Store the character in flat_array
        inc si                      ; Move to the next byte in strings
        inc di                      ; Move to the next byte in flat_array
        jmp copy_loop               ; Continue copying
    copy_done:
        mov byte ptr [di], '$'      ; Add '$' delimiter at the end of the string 
        ret
        
copy_single_string endp

print_string proc 
    
    mov ah, 09h 
    mov dx, offset newline
    int 21h
   
    print_loop:
        mov al, [di]                ; Load the current byte (character)
        cmp al, '$'                 ; Check if end of string
        je end_print                ; Exit if end of string
        mov dl, al                  ; Move the character in AL to DL
        mov ah, 02H                 ; DOS function to print a character
        int 21H                     ; Print the character
        inc di                      ; Move to the next character
        jmp print_loop              ; Continue printing
    end_print: 

        ret

print_string endp

clear_flat_array proc
    lea di, flat_array             ; DI points to flat_array
    mov cx, 20                     ; Length of flat_array
    clear_loop:
        mov byte ptr [di], '$'     ; Reset each byte to '$'
        inc di
        loop clear_loop
    ret
 
 clear_flat_array endp
 
compareStrings2 proc
    lea si, flat_array            ; SI points to flat_array
    lea di, bookBuffer1+2                 ; DI points to input_string
    
    cmpLoop:
        mov al, [si]              ; Load character from the first string (SI)
        mov bl, [di]              ; Load character from the second string (DI)

        cmp al, '$'        
        je checkEnd
        cmp bl, '$'        
        je checkEnd

        cmp al, bl                ; Compare the characters
        jne notEqual              ; If not equal, jump to notEqual

        inc si                    ; Move SI to the next character
        inc di                    ; Move DI to the next character

        jmp cmpLoop               ; Continue comparing

    checkEnd:
        cmp al, '$'               ; Check if the first string has ended
        je equal                  ; If the first string ends with '$', continue

        cmp bl, '$'               ; Check if the second string has ended
        je equal                  ; If the second string ends with '$', continue

    notEqual:
        mov al, 0                 ; Strings are not equal
        ret

    equal:
        mov al, 1                 ; Strings are equal
        ret
   
   
 compareStrings2 endp
  
    
 NEWLINE_PRINT proc
    mov ah,9
    mov dx,offset newline
    int 21h
    ret
NEWLINE_PRINT endp   

NEWLINE_PRINT2 proc
    mov ah,9
    mov dx,offset newline2
    int 21h
    ret
NEWLINE_PRINT2 endp 
   


    

 
 
 
 welcome proc
    mov ah, 9
    lea dx, a1
    int 21h
    lea dx, a2
    int 21h
    lea dx, a3
    int 21h
    lea dx, a4
    int 21h
    lea dx, a5
    int 21h
    lea dx, a6
    int 21h
    ret
welcome endp
 

 authenticate_user proc 
  mov cl,3
   
   authloop:
    cmp cl,0
    je maxAttempts
    
    mov ah, 9
    mov dx,offset inputPrompt1
    int 21h  
    
    ; Read username
    mov dx,offset inputBuffer1
    mov ah, 0Ah
    int 21h 
        
    ;call NEWLINE_PRINT

    ; Prompt for password input
    mov ah, 9
    mov dx,offset inputPrompt2
    int 21h
    
    ; Read password
    mov dx,offset inputBuffer2
    mov ah, 0Ah
    int 21h  
    
 call NEWLINE_PRINT 
    
    ; Compare the username
    lea si, inputBuffer1+2       ; SI points to the actual username (skip size and length byte)
    lea di, usernameCorrect      ; DI points to the predefined correct username
    call compareStrings1
    
    ; If username is incorrect, jump to incorrect message
    cmp al, 0                    
    je incorrectUsername
    
    ; Compare the password
    lea si, inputBuffer2+2       ; SI points to the actual password (skip size and length byte)
    lea di, passwordCorrect      ; DI points to the predefined correct password
    call compareStrings1
    
    ; If password is incorrect, jump to incorrect message
    cmp al, 0
    je incorrectPassword
       
    call NEWLINE_PRINT
    ; If both username and password are correct
    mov ah, 9
    lea dx, correctMsg
    int 21h     
    
    call NEWLINE_PRINT2
    
    jmp proceedToMainMenu

incorrectUsername:
    ; If username is incorrect
    mov ah, 9
    lea dx, incorrectMsg
    int 21h
    
    
    
 call NEWLINE_PRINT
    
    loop authloop
    
    jmp exitProgram

incorrectPassword:
    ; If password is incorrect
    mov ah, 9
    lea dx, incorrectMsg
    int 21h  
 call NEWLINE_PRINT
    loop authloop
    
    jmp exitProgram 
    
maxAttempts: 

call NEWLINE_PRINT
 mov ah,9
 mov dx,offset maxattemptmsg
 int 21h 
   
;call NEWLINE_PRINT
 
 mov ah,9
 mov dx,offset endmsg
 int 21h 

jmp exitProgram 
 
 
authenticate_user endp



 
 
  compareStrings1 proc
    ; Compare strings character by character
   cmpLoop1:
    mov al, [si]      ; Load character from the first string (SI)
    mov bl, [di]      ; Load character from the second string (DI)

    ; Skip comparison if both characters are '$' (end of string)
    cmp al, '$'        
    je checkEnd1
    cmp bl, '$'        
    je checkEnd1

    cmp al, bl        ; Compare the characters
    jne notEqual1      ; If not equal, jump to notEqual

    inc si            ; Move SI to the next character
    inc di            ; Move DI to the next character

    jmp cmpLoop1       ; Continue comparing

checkEnd1:
    cmp al, '$'       ; Check if the first string has ended
    je equal1          ; If the first string ends with '$', continue

    cmp bl, '$'       ; Check if the second string has ended
    je equal1          ; If the second string ends with '$', continue

notEqual1:
    mov al, 0         ; Strings are not equal
    ret

equal1:
    mov al, 1         ; Strings are equal
    ret

compareStrings1 endp



 

 
 
 
 
 Invalid:
 ;newline

 
 mov ah,9
 mov dx,offset a36
 int 21h
 
call NEWLINE_PRINT    
 
 jmp proceedToMainMenu
 
 
 
 Exit: 
 
   
   mov ah,9
   mov dx,offset nextLine
   int 21h
   
   mov ah, 9         
   mov dx, offset exitMessage
   int 21h            
 
 mov ah,4ch
 int 21h 
 
 
 exitProgram:
    ; Exit program
    mov ah, 4Ch
    int 21h
        

 
 

 end main
 
  
       
    
    
    
    
    
    






