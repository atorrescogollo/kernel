# Params: Generar codigo para 32bit
ASPARAMS = --32

GPPPARAMS  = -m32 
GPPPARAMS += -fno-use-cxa-atexit		# Sin manejador de memoria
GPPPARAMS += -nostdlib					# Sin glibc
GPPPARAMS += -fno-builtin				# Sin optimizacion de funciones
GPPPARAMS += -fno-rtti					# Sin identificacion de clases
GPPPARAMS += -fno-exceptions			# Sin excepciones
GPPPARAMS += -fno-leading-underscore	# Linker con ensamblador

LDPARAMS = -melf_i386

# Archivos compilados
objects = loader.o kernel.o

# Make para archivos *.s (ensamblador)
#	as --32 -o <output> <input>
%.o: %.s
	as $(ASPARAMS) -o $@ $<

# Make para archivos *.cpp (C++)
#	g++ -m32 -o <output> -c <input>
%.o: %.cpp
	g++ $(GPPPARAMS) -o $@ -c $<

# Make para el linker
#	ld -melf_i386 -T <script> -o <output> <sources>*
kernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

# Make para instalacion
install: kernel.bin
	sudo cp $< /boot/kernel.bin
