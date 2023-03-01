extern NtWriteFile
extern RtlExitUserProcess
; extern NtTerminateProcess

%define NtCurrentPeb() gs:[0x60]
%define ProcessParameter 32
%define StandardOutput 40
%define NtCurrentProcess() -1

section .rdata
	msg db `Hello, world!\n\0`
section .text
	global main
main:
        sub rsp, 86
	mov rcx, NtCurrentPeb()
	mov rcx, ProcessParameter[rcx]
	mov rcx, StandardOutput[rcx] ; hStdOut
	xor edx, edx ; NULL
	xor r8d, r8d ; NULL
	xor r9d, r9d ; NULL
	lea r10, 72[rsp]
	mov qword 32[rsp], r10 ; &IoStatusBlock
	mov qword 40[rsp], msg
	mov qword 48[rsp], 14
	mov qword 56[rsp], 0 ; NULL
	mov qword 64[rsp], 0 ; NULL
	call NtWriteFile

	; There are two ways to terminate the calling process either using NtTerminateProcess directly
	; or via RtlExitUserProcess but the second one is doing cleanup before terminate.
	; mov rcx, NtCurrentProcess()
	; xor edx, edx
	; call NtTerminateProcess
	xor ecx, ecx
	call RtlExitUserProcess
	int3
