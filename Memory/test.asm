.org	0x0000

MAIN:
	ldi	r5, 0x0064
	ldi	r6, 5
	sub	r1, r5, r6
	ldi	r2, 300
	st	r1, 0(r2)


# Init loop
ldi	r2, 5			# put 5 in r2.
ldi	r3, 1			# put 1 in r3.

LOOP:
	sub	r2, r2, r3	# subtract r2 by 1.
	brnz	r2, LOOP	# end when r2 is zero.
	ldi	r2, 500
	st	r2, 0(r5)	# Store 500 in 100. 
	halt
	
.org	0x00C8
.word	1
.word	500