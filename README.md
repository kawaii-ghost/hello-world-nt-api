# Hello World NT API

> This program is may work under NT version number 10.0 (Windows 10, Windows Server (2016-2019-2022), and Windows 11) only.

![gambar](https://user-images.githubusercontent.com/86765295/208801010-ce0c49d5-9c6c-4c4d-b470-9eb6a3be9b0d.png)

I made this repo because I found many people asking _How to Hello World x64 Assembly using Windows System Call_ across the internet. And here we are :).

This program is still depend on `ntdll.dll` because NT system call number changed across version _~unlike Linux~_.

## Some Note
### Calling convention
NT System Call Calling Convention is same like the userspace.

Except the first argument is placed on `R10` (`syscall` destroy `RCX` as return address `RIP` and `R11` as rflags as documented on [x64 ABI conventions](https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions?view=msvc-170#register-volatility-and-preservation). 

Another source is analyzing `ntdll.dll` and you will look `mov r10, rcx`.

| System Call Number | Arg0 | Arg1 | Arg2 | Arg3 |
| ------------------ | ---- | ---- | ---- | ---- |
| `RAX` | `R10` | `RDX` | `R8` | `R9` |

The stack argument is placed at `[rsp + 32 + 8]` due to shadow store and return address from `call NtXxx` sub-routine.

### Different NT version behaviour

This is slightly bother me, but I tried this on NT version number 5.2 (Windows Server 2003) it doesn't work.

But the **Peb** structure is work. Seems like different NT version has different System call calling convention.

-------

## Public Documentation

- [PE Format](https://learn.microsoft.com/en-us/windows/win32/debug/pe-format)
- [PEB Structure](https://learn.microsoft.com/en-us/windows/win32/api/winternl/ns-winternl-peb)
- [NtWriteFile function (ntifs.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/nf-ntifs-ntwritefile)
- [ZwCurrentProcess](https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/zwcurrentprocess)
- [GetCurrentProcess function (processthreadsapi.h)](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getcurrentprocess)
- [ZwTerminateProcess function (ntddk.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntddk/nf-ntddk-zwterminateprocess)

## Undocumented

![](https://i.imgflip.com/751y23.jpg)

Special Thanks to [@ReactOS](https://github.com/reactos/) team for the undocumented parts :D

- [GetStdHandle](https://doxygen.reactos.org/df/d28/dll_2win32_2kernel32_2client_2console_2console_8c_source.html#l01170)
- [NtCurrentPeb](https://www.geoffchappell.com/studies/windows/km/ntoskrnl/inc/api/pebteb/peb/index.htm)
- [_RTL_USER_PROCESS_PARAMETERS](https://doxygen.reactos.org/d5/df7/ndk_2rtltypes_8h_source.html#l01529)
- [WriteConsole](https://doxygen.reactos.org/d5/d48/base_2setup_2usetup_2console_8c_source.html#l00174)
- [NtCurrentProcess](https://doxygen.reactos.org/db/dc9/nt__native_8h_source.html#l01657)
- [ExitProcess](https://doxygen.reactos.org/d9/dd7/dll_2win32_2kernel32_2client_2proc_8c_source.html#l01487) (Idk if it's necessary to do stuff before self terminate.)
