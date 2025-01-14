eatsyscall: eatsyscall.o
	ld -o eatsyscall.bin eatsyscall.o
eatsyscall.o: eatsyscall.asm
	nasm -f elf64 -g -F dwarf eatsyscall.asm
