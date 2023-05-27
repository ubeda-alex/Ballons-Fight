include 'emu8086.inc'
.model small

.data            


;###################PANTALLA DE INICIO#################



    
    inicioJuego db '  ',0ah,0dh  ;muestra en pantalla el siguiente mensaje
    
    dw ' ',0ah,0dh      ;espacios en blanco para centrar el recuadro
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw '             ====================================================',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh                                        
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||--------------------------------------------------||',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||    ______       _ _  ______ _       _     _      ||',0ah,0dh
    dw '            ||    | ___ \     | | | |  ___(_)     | |   | |     ||',0ah,0dh
    dw '            ||    | |_/ / __ _| | | | |_   _  __ _| |__ | |_    ||',0ah,0dh
    dw '            ||    | ___ \/ _` | | | |  _| | |/ _| | |_ \| __|   ||',0ah,0dh
    dw '            ||    | |_/ | (_| | | | | |   | | (_| | | | | |_    ||',0ah,0dh
    dw '            ||    \____/ \__,_|_|_| \_|   |_|\__, |_| |_|\__|   ||',0ah,0dh
    dw '            ||                                __/ |             ||',0ah,0dh
    dw '            ||                               |___/              ||',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||                 Created by Al3pr6                ||',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh  
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||            Presione Enter para iniciar           ||',0ah,0dh 
    dw '            ||                                                  ||',0ah,0dh
    dw '            ||                                                  ||',0ah,0dh
    dw '             ====================================================',0ah,0dh
    dw '$',0ah,0dh,13,10  
  
  
    
;#############INFO DE LOS JUGADORES######################


    
    jug1 db 10,13, 'ID del primer jugador: ', '$'   ;nickname del jugador 1  
    jug2 db 10,13,10,13,10,13,10,13,10,13,'ID del segundo jugador: ', '$'   ;nickname del jugador2
    signoj1 db 10,13,10,13,'Simbolo identificador del Jugador 1: ', '$'   ;simbolo con el que jugara el jugador1
    signoj2 db 10,13,10,13,'Simbolo identificador del jugador 2: ', '$'   ;simbolo con el que jugara el jugador2
    jug1Valor db '0$'   ;guarda el id del jugador 1
    jug2Valor db '0$'   ;guarda el id del jugador 2
    signoj1Valor db '0$'     ;guarda el simbolo del jugador 1
    signoj2Valor db '0$'     ;guarda el simbolo del jugador 2    
    
    




;#############PANTALLA DE JUEGO###############################


    ;MOSTRAR UNA MATRIZ EN PANTALLA
    matriz1 db ' ======================','$' ;borde superior e inferior
	matriz2 db 'º                      º','$';costados de la matriz 




    

.code  

    .startup
    

;------------------------------MACROS------------------------------
    
    limpiarPantalla macro                               ;esta macro limpia las pantallas.
        mov ah, 0fh
        int 10h
        mov ah, 0
        int 10h
    endm    

    imprimirPantallas macro pantalla                    ;esta macro imprime las pantallas. Recibe la pantalla que se desea imprimir.
       mov ah,09h
       lea dx, pantalla                                ;aqui se imprime la pantalla.
       int 21h
    endm 
    
;-----------------------IMPRIMIR PANTALLA INICIO------------------------------      
    
    inicioPrincipal:                                      ;en esta seccion se imprimira la pantalla principal                                 ;se llama a la macro limpiar Pantalla
        imprimirPantallas inicioJuego           ;aqui se llama a imprimir la pantalla que queremos
        mov ah,0
        int 16h
        cmp al,13
        je limpiar
          
    limpiar:
        limpiarPantalla
         


        
;###################SOLICITA EL VALOR DE LOS JUGADORES#########################


      

    imprimirInputs macro texto, variable   ;solicita la entrada de algun dato, lo lee y almacena donde se le indique
        mov ah, 09           ;valor en registro necesario para la ejecucion de la interrupcion
        lea dx, texto        ;imprime el mensaje que se le solicito.
        int 21h              ;ejecuta la interrupcion 21 que espera un input                           
        
        mov ah, 1            ;lee
        int 21h              ;ejecuta otra int 21
        mov variable, al     ;almacena el dato en la variable.
    endm
     
 
     usuarios:         ;--> se solicitan los datos principales del usuario                          
        imprimirInputs jug1, jug1Valor         ;solicita al usuario el id del jugador 1
        imprimirInputs signoj1, signoj1Valor             ;solicita al usuario el simbolo del jugador 1
        imprimirInputs jug2, jug2Valor         ;solicita al usuario el id del jugador 2
        imprimirInputs signoj2, signoj2Valor             ;solicita al usuario el simbolo del jugador 
        
    limpiar2:
        limpiarPantalla

;###################IMPRIMIR CUADRO DE JUEGO########################
        
        
        
        
    imprimirTexto macro texto,y,x                       ;esta macro imprime los textos predeterminados. Recibe el
        mov ah, 02h                                     ;texto que se desea imprimir, y las coordenadas.
        mov bh, 00d
        mov dh, y                                       ; coordenada y.
        mov dl, x                                       ; coordenada x.
        int 10h
               
        mov ah, 9
        lea dx, texto                                   ;imprime el texto.
        int 21h
   endm         
        
    imprimirMatriz:                                    
        imprimirTexto matriz1,1,7      ;borde superior
        imprimirTexto matriz2,2,7      ;empieza a imprimir los bordes
        imprimirTexto matriz2,3,7
        imprimirTexto matriz2,4,7
        imprimirTexto matriz2,5,7
        imprimirTexto matriz2,6,7
        imprimirTexto matriz2,7,7
        imprimirTexto matriz2,8,7
        imprimirTexto matriz2,9,7
        imprimirTexto matriz2,10,7
        imprimirTexto matriz2,11,7  
        imprimirTexto matriz2,12,7
        imprimirTexto matriz2,13,7
        imprimirTexto matriz2,14,7
        imprimirTexto matriz2,15,7
        imprimirTexto matriz2,16,7
        imprimirTexto matriz2,17,7
        imprimirTexto matriz2,18,7
        imprimirTexto matriz2,19,7
        imprimirTexto matriz2,20,7
        imprimirTexto matriz2,21,7   ;termina de construir los bordes
        imprimirTexto matriz1,22,7   ;borde inferior 
        
end