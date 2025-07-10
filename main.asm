.extern SDL_Init
.extern SDL_Quit

.extern SDL_CreateWindow
.extern SDL_CreateRenderer

.extern SDL_RenderClear
.extern SDL_RenderPresent
.extern SDL_SetRenderDrawColor

.extern SDL_Delay
.extern SDL_PollEvent

.data
  Title: .ascii "window\0"

  window: .skip 8
  renderer: .skip 8

  init_v: .word 0x00000020

  window_f: .word 0x00000004
  window_ren: .word 0x00000002
  window_e: .skip 64

.text
  .global _start

_start:

  adr x0, init_v
  ldr x0, [x0]
  bl SDL_Init

  adr x0, Title
  mov x1, #0
  mov x2, #0
  mov x3, #800
  mov x4, #400
  adr x5, window_f
  ldr x5, [x5]
  bl SDL_CreateWindow

  adr x1, window
  str x0, [x1]

  adr x0, window
  ldr x0, [x0]
  mov x1, #-1
  adr x2, window_ren
  ldr x2, [x2]
  bl SDL_CreateRenderer 

  adr x1, renderer
  str x0, [x1]

  loop:
    adr x0, window_e
    bl SDL_PollEvent

    cmp x0, #0
    beq loop

    adr x0, renderer
    ldr x0, [x0]

    mov x1, #0
    mov x2, #0
    mov x3, #0
    mov x4, #0
    bl SDL_SetRenderDrawColor

    adr x0, renderer
    ldr x0, [x0]
    bl SDL_RenderClear

    adr x1, window_e
    mov x2, #0
    ldr w2, [x1]
    
    cmp w2, #0x100
    beq exit

    adr x0, renderer
    ldr x0, [x0]

    mov x1, #255
    mov x2, #255
    mov x3, #255
    mov x4, #255
    bl SDL_SetRenderDrawColor

    adr x0, renderer
    ldr x0, [x0]
    bl SDL_RenderPresent

    b loop

print:

  mov x2, x1
  mov x1, x0
  
  mov x8, #64
  mov x0, #1
  svc #0

  ret

exit:

  bl SDL_Quit

  mov x8, #93
  mov x0, #0
  svc #0
