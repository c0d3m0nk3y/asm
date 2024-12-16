section .text
  global main
main:
  mov edx, 9
  mov ecx, name
  mov ebx, 1
  mov eax, 4
  int 0x80
  
  mov [name], dword 'Nuha'
  mov edx, 8
  mov ecx, name
  mov ebx, 1
  mov eax, 4
  int 0x80

  mov eax, 1
  int 0x80

section .data
  name db 'Zara Ali '

