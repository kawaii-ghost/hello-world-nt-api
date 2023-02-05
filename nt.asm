extern NtWriteFile
extern RtlExitUserProcess
; extern NtTerminateProcess

%define NtCurrentPeb() gs:[0x60]
%define ProcessParameter 32
%define StandardOutput 40
%define NtCurrentProcess() -1

section .rdata
	msg db `Hello, world!\n\0`
section .bss
	IoStatusBlock resb 16
section .text
	global main
main:
        sub rsp, 72
	mov rcx, NtCurrentPeb()
	mov rcx, ProcessParameter[rcx]
	mov rcx, StandardOutput[rcx]
	xor edx, edx
	xor r8d, r8d
	xor r9d, r9d
	mov qword 32[rsp], IoStatusBlock
	mov qword 40[rsp], msg
	mov qword 48[rsp], 14
	mov qword 56[rsp], 0
	mov qword 64[rsp], 0
	call NtWriteFile

	; There are two ways to TerminateProcess either using NtTerminateProcess directly
	; or via RtlExitUserProcess but the second one is much safer
	; mov rcx, NtCurrentProcess()
	; xor edx, edx
	; call NtTerminateProcess
	xor ecx, ecx
	call RtlExitUserProcess
	int3
