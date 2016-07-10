.section .init
.globl _start
_start:
/*
|byte3|byte2|byte1|byte0| --> the first 10 gpios
000(GPIO 0) 000(GPIO1) 000 000 000 000 000 000 000 000(GPIO 9) 00(RESERVED)
--> 001 translates to mode=output
*/

/* load adress of GPIO region into r0*/
ldr r0, = 0x20200000
 

/* enables OURPUT to GPIO 4 (red) */
mov r1, #1
lsl r1, #12    /* shift 1 left by 12 places -- > */
str r1, [r0, #0]

/*enables INPUT for GPIO 24*/
mov r1, #0
str r1, [r0, #12]

/* r1 -> location of gpio4 */
mov r1, #1
lsl r1, #4


/* ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ MAIN-LOOP ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ */
loop$:
    /* GPIO ON*/
    str r1, [r0, #28]

    /*WAIT*/
    ldr r2, = #90000000
    wait$:
        sub r2, #1
    bne wait$

    /*GPIO OFF*/
    str r1, [r0, #40]

    /*WAIT*/
    ldr r2, = #90000000
    waitTWO$:
        sub r2, #1
    bne waitTWO$

b loop$