ASMC = as
LD = ld

SRC = ./main.asm

ASMCF = -g
LDF = 

NAME = main
OUT = ./${NAME}

all: build run

build:
	${ASMC} ${SRC} ${ASMCF}
	${LD} a.out -lSDL2 ${LDF} -o ${OUT}
	rm a.out

run:
	${OUT}

clean:
	rm a.out
