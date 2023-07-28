#include "file_flags.S"
#define STACK_ALIGNMENT_TRAP	movdqa	(%rsp), %xmm0

#define ST_OFF_NAME                 (0)
#define ST_OFF_DISCORD_USERNAME     (64)
#define ST_OFF_GENDER               (64 + 32)
#define ST_OFF_HOBBY                (64 + 32 + 64)

#define ST_SIZEOF_NAME              (64)
#define ST_SIZEOF_DISCORD_USERNAME  (32)
#define ST_SIZEOF_GENDER            (1)
#define ST_SIZEOF_HOBBY             (64)
#define SIZEOF_STRUCT_MEMBER        (64 + 32 + 1 + 64)

.section .rodata
menu_str:
  .ascii "========================================================\n"
  .ascii "====  Welcome to Bocchi-Group Staff Member DB Software  ====\n"
  .ascii "========================================================\n"
  .ascii "\t1. [C] Add a new staff member\n"
  .ascii "\t2. [R] Show staff members\n"
  .ascii "\t3. [U] Update a staff member\n"
  .ascii "\t4. [D] Delete a staff member\n"
  .ascii "\t5. Exit\n"
  .ascii "========================================================\n"
  .ascii "Enter menu: "
  .byte 0x0
invalid_menu_str:
  .ascii "Invalid menu number selected!\n"
  .ascii "Please re-enter the menu number based on available options!\n"
  .byte 0x0
hang_until_enter_str:
  .ascii "\n\nPress enter to continue! "
  .byte 0x0
clear_screen_bytes:
  .byte 0x1b, 0x63, 0x00

reg_start_str:
  .ascii "======== Add a new staff member ========\n"
  .byte 0x0
reg_name_str:
  .ascii "Enter name: "
  .byte 0x0
reg_discord_username_str:
  .ascii "Enter Discord username: "
  .byte 0x0
reg_gender_str:
  .ascii "Enter gender (m (male), f (female), h (hidden)): "
  .byte 0x0
reg_invalid_gender_str:
  .ascii "Invalid gender! Please enter the correct option!\n"
  .byte 0x0
reg_hobby_str:
  .ascii "Enter hobby: "
  .byte 0x0
reg_success_str:
  .ascii "Successfully added a new staff member!\n"
  .byte 0x0

.section .data
struct_member:
  .space SIZEOF_STRUCT_MEMBER

.section .text
.global _start

_start:
  movq  (%rsp), %rdi
  leaq  8(%rsp), %rsi
  leaq  16(%rsp, %rdi, 8), %rdx
  xorl  %ebp, %ebp
  andq  $-16, %rsp
  STACK_ALIGNMENT_TRAP
  callq main
  movl  %eax, %edi
  movl  $60, %eax
  syscall

main:
  pushq %rbp
  movq  %rsp, %rbp
  STACK_ALIGNMENT_TRAP
.Lmain__show_menu:
  callq clear_screen
  callq show_menu
  testl %eax, %eax
  js    .Lmain__invalid_menu
  cmpl  $1, %eax
  je    .Lmain__do_add_member
  cmpl  $2, %eax
  je    .Lmain__out
  cmpl  $3, %eax
  je    .Lmain__out
  cmpl  $4, %eax
  je    .Lmain__out
  cmpl  $5, %eax
  je    .Lmain__out
  jmp   .Lmain__show_menu

.Lmain__do_add_member:
  callq do_add_member
  jmp   .Lmain__hang

.Lmain__invalid_menu:
  callq show_invalid_menu_alert
.Lmain__hang:
  callq hang_until_enter
  jmp   .Lmain__show_menu

.Lmain__out:
  xorl  %eax, %eax
  movq  %rbp, %rsp
  popq  %rbp
  retq

print:
  pushq %rbp
  movq  %rsp, %rbp
  STACK_ALIGNMENT_TRAP
  xorl  %edx, %edx
  xorl  %eax, %eax
  movq  %rdi, %rcx
.Lprint__do_loop:
  cmpb  $0, (%rcx)
  jz    .Lprint__out
  addq  $1, %rdx
  addq  $1, %rcx
  jmp   .Lprint__do_loop
.Lprint__out:
  movq  %rdi, %rsi
  movl  $1, %edi
  movl  $1, %eax
  syscall

  movq  %rbp, %rsp
  popq  %rbp
  retq

read_stdin:
  pushq %rbp
  movq  %rsp, %rbp
  STACK_ALIGNMENT_TRAP
  movq  %rsi, %rdx
  movq  %rdi, %rsi
  xorl  %eax, %eax
  xorl  %edi, %edi
  syscall

  movq  %rbp, %rsp
  popq  %rbp
  retq

show_menu:
  pushq %rbp
  movq  %rsp, %rbp
  subq  $128, %rsp
  STACK_ALIGNMENT_TRAP
  leaq  menu_str(%rip), %rdi
  callq print
  leaq  -128(%rbp), %rdi
  movl  $128, %esi
  callq read_stdin
  cmpl  $2, %eax
  jg    .Lshow_menu__invalid
  movzbl -128(%rbp), %eax
  cmpl  $'1', %eax
  jb    .Lshow_menu__invalid
  cmpl  $'5', %eax
  ja    .Lshow_menu__invalid
  subl  $'0', %eax
.Lshow_menu__out:
  movq  %rbp, %rsp
  popq  %rbp
  retq

.Lshow_menu__invalid:
  movl  $-1, %eax
  jmp   .Lshow_menu__out

show_invalid_menu_alert:
  pushq %rbp
  movq  %rsp, %rbp
  STACK_ALIGNMENT_TRAP
  leaq  invalid_menu_str(%rip), %rdi
  callq print
  movq  %rbp, %rsp
  popq  %rbp
  retq

clear_screen:
  pushq
