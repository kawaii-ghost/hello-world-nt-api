# Hello World NT API

> This only work at NT version number 10.0 (Windows 10, Windows Server (2016-2019-2022), and Windows 11) only.

![gambar](https://user-images.githubusercontent.com/86765295/208801010-ce0c49d5-9c6c-4c4d-b470-9eb6a3be9b0d.png)

I made this repo because I found many people asking _How to Hello World Assembly using Windows System Call_ across the internet. And here we are :).

This program is still depend on `ntdll.dll` because NT system call number changed across version _~unlike Linux~_.



## Notes
### Calling convention
NT System Call Calling Convention is same like the userspace.

Except the first argument is placed on `R10` (`syscall` destroy `RCX` as return address `RIP` and `R11` as rflags as documented on [x64 ABI conventions](https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions?view=msvc-170#register-volatility-and-preservation). 

Another source is analyzing `ntdll.dll` and you will look `mov r10, rcx`.

| System Call Number | Arg0 | Arg1 | Arg2 | Arg3 |
| ------------------ | ---- | ---- | ---- | ---- |
| RAX | R10 | RDX | R8 | R9 |

The stack argument is placed at `[rsp + 32 + 8]` due to shadow store and return address from `call NtXxx` sub-routine.

### Different NT version behaviour

This is slightly bother me, but I tried this on NT version number 5.2 (Windows Server 2003) it doesn't work.

But the **Peb** structure is work. Seems like different NT version has different System call calling convention.

-------
