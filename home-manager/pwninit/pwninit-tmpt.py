#!python

from pwn import *
import pwn
from sys import argv

{bindings}

context.binary = {bin_name}
context.terminal = ["kitty", "@", "new-window", "--cwd", getcwd()]
context.gdbinit = "/etc/profiles/per-user/darktar/share/pwndbg/gdbinit.py"

r: process = None

u64 = lambda d: pwn.u64(d.ljust(8, b"\0")[:8])
u32 = lambda d: pwn.u32(d.ljust(4, b"\0")[:4])
u16 = lambda d: pwn.u16(d.ljust(2, b"\0")[:2])
sla = lambda a, b: r.sendlineafter(a, b)
sa = lambda a, b: r.sendafter(a, b)
sl = lambda a: r.sendline(a)
s = lambda a: r.send(a)
recv = lambda: r.recv()
recvn = lambda a: r.recvn(a)
recvu = lambda a, b=False: r.recvuntil(a, b)

gdbscript = '''
    b main
    continue
'''

def conn():
    global r
    if len(argv) > 1:
        if argv[1] == "gdb":
            r = gdb.debug([{bin_name}.path], gdbscript=gdbscript)
        else:
            ip, port = argv[1], argv[2]
            r = remote(ip, port)
    else:
        r = {bin_name}.process()



def exploit():
    print("good luck pwning :)")
    
    

conn()
exploit()

# good luck pwning :)
r.interactive()
