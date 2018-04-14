
void printf(char* str){ // char=1byte ;	short=2bytes
	unsigned short* video_memory = (unsigned short*) 0xb8000;
	for (int i=0; str[i]!='\0'; i++){
		/*
		 * video_memory[i] = 0x1234
		 * 0x1234 & 0xff00 = 0x1200	// Aplicamos mascara
		 * 0x1200 | 0x00ab = 0x12ab	// Anyadimos byte
		 */
		video_memory[i] = (video_memory[i] & 0xff00) | ((unsigned short)str[i]);
	}
}

// <extern "C"> permite guardar el formato para la llamada desde el loader.s
extern "C" void kernel_main(void* multiboot_struct, unsigned int magicnumber){
	printf("Hola Mundo!");
	
	while(1);
}
