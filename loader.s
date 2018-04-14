# Cabecera multiboot
.set MAGIC,		0x1badb002			# Identificador=Kernel
.set ALIGN,    1<<0					# Alineación de modulos cargados
.set MEMINFO,  1<<1					# Mapa de memoria
.set FLAGS,    ALIGN | MEMINFO
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
	.long MAGIC
	.long FLAGS
	.long CHECKSUM

# Seccion read-only: cargar solo una vez en ram
.section .text

# Referencia al metodo principal de kernel.cpp
.extern kernel_main

# Punto de entrada al programa
.global loader

loader:
	mov $kernel_stack, %esp	# Inicialización del registro SP (Stack Pointer)
	
	# Parametros
	push %eax				# Anyadir puntero multiboot a la pila
	push %ebx				# Anyadir valor "MAGIC" a la pila
	
	call kernel_main		# Entrar en kernel.cpp
	
_stop:				# Bucle infinito
	cli				# Limpiar el flag de interrupcion
	hlt				# Esperar hasta interrupcion
	jmp _stop		# Bucle infinito [Fin]

# Seccion de datos sin inicializar: alias
.section .bss

.space 2*1024*1024	# Rellenar 2MiB con valor 0x0

kernel_stack:
