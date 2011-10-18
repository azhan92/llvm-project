@ RUN: llvm-mc -mcpu=cortex-a8 -triple thumb-unknown-unknown -show-encoding < %s | FileCheck %s

.code 16

	vmov.i8	d16, #0x8
	vmov.i16	d16, #0x10
	vmov.i16	d16, #0x1000
	vmov.i32	d16, #0x20
	vmov.i32	d16, #0x2000
	vmov.i32	d16, #0x200000
	vmov.i32	d16, #0x20000000
	vmov.i32	d16, #0x20FF
	vmov.i32	d16, #0x20FFFF
@	vmov.i64	d16, #0xFF0000FF0000FFFF

@ CHECK: vmov.i8	d16, #0x8       @ encoding: [0xc0,0xef,0x18,0x0e]
@ CHECK: vmov.i16	d16, #0x10      @ encoding: [0xc1,0xef,0x10,0x08]
@ CHECK: vmov.i16	d16, #0x1000    @ encoding: [0xc1,0xef,0x10,0x0a]
@ CHECK: vmov.i32	d16, #0x20      @ encoding: [0xc2,0xef,0x10,0x00]
@ CHECK: vmov.i32	d16, #0x2000    @ encoding: [0xc2,0xef,0x10,0x02]
@ CHECK: vmov.i32	d16, #0x200000  @ encoding: [0xc2,0xef,0x10,0x04]
@ CHECK: vmov.i32	d16, #0x20000000 @ encoding: [0xc2,0xef,0x10,0x06]
@ CHECK: vmov.i32	d16, #0x20FF    @ encoding: [0xc2,0xef,0x10,0x0c]
@ CHECK: vmov.i32	d16, #0x20FFFF  @ encoding: [0xc2,0xef,0x10,0x0d]
@ FIXME: vmov.i64 d16, #0xFF0000FF0000FFFF @ encoding: [0xc1,0xff,0x33,0x0e]


	vmov.i8	q8, #0x8
	vmov.i16	q8, #0x10
	vmov.i16	q8, #0x1000
	vmov.i32	q8, #0x20
	vmov.i32	q8, #0x2000
	vmov.i32	q8, #0x200000
	vmov.i32	q8, #0x20000000
	vmov.i32	q8, #0x20FF
	vmov.i32	q8, #0x20FFFF
@	vmov.i64	q8, #0xFF0000FF0000FFFF

@ CHECK: vmov.i8	q8, #0x8        @ encoding: [0xc0,0xef,0x58,0x0e]
@ CHECK: vmov.i16	q8, #0x10       @ encoding: [0xc1,0xef,0x50,0x08]
@ CHECK: vmov.i16	q8, #0x1000     @ encoding: [0xc1,0xef,0x50,0x0a]
@ CHECK: vmov.i32	q8, #0x20       @ encoding: [0xc2,0xef,0x50,0x00]
@ CHECK: vmov.i32	q8, #0x2000     @ encoding: [0xc2,0xef,0x50,0x02]
@ CHECK: vmov.i32	q8, #0x200000   @ encoding: [0xc2,0xef,0x50,0x04]
@ CHECK: vmov.i32	q8, #0x20000000 @ encoding: [0xc2,0xef,0x50,0x06]
@ CHECK: vmov.i32	q8, #0x20FF     @ encoding: [0xc2,0xef,0x50,0x0c]
@ CHECK: vmov.i32	q8, #0x20FFFF   @ encoding: [0xc2,0xef,0x50,0x0d]
@ FIXME: vmov.i64 q8, #0xFF0000FF0000FFFF @ encoding: [0xc1,0xff,0x73,0x0e]


	vmvn.i16	d16, #0x10
	vmvn.i16	d16, #0x1000
	vmvn.i32	d16, #0x20
	vmvn.i32	d16, #0x2000
	vmvn.i32	d16, #0x200000
	vmvn.i32	d16, #0x20000000
	vmvn.i32	d16, #0x20FF
	vmvn.i32	d16, #0x20FFFF

@ CHECK: vmvn.i16	d16, #0x10      @ encoding: [0xc1,0xef,0x30,0x08]
@ CHECK: vmvn.i16	d16, #0x1000    @ encoding: [0xc1,0xef,0x30,0x0a]
@ CHECK: vmvn.i32	d16, #0x20      @ encoding: [0xc2,0xef,0x30,0x00]
@ CHECK: vmvn.i32	d16, #0x2000    @ encoding: [0xc2,0xef,0x30,0x02]
@ CHECK: vmvn.i32	d16, #0x200000  @ encoding: [0xc2,0xef,0x30,0x04]
@ CHECK: vmvn.i32	d16, #0x20000000 @ encoding: [0xc2,0xef,0x30,0x06]
@ CHECK: vmvn.i32	d16, #0x20FF    @ encoding: [0xc2,0xef,0x30,0x0c]
@ CHECK: vmvn.i32	d16, #0x20FFFF  @ encoding: [0xc2,0xef,0x30,0x0d]


	vmovl.s8	q8, d16
	vmovl.s16	q8, d16
	vmovl.s32	q8, d16
	vmovl.u8	q8, d16
	vmovl.u16	q8, d16
	vmovl.u32	q8, d16
	vmovn.i16	d16, q8
	vmovn.i32	d16, q8
	vmovn.i64	d16, q8
	vqmovn.s16	d16, q8
	vqmovn.s32	d16, q8
	vqmovn.s64	d16, q8
	vqmovn.u16	d16, q8
	vqmovn.u32	d16, q8
	vqmovn.u64	d16, q8
	vqmovun.s16	d16, q8
	vqmovun.s32	d16, q8
	vqmovun.s64	d16, q8

@ CHECK: vmovl.s8	q8, d16         @ encoding: [0xc8,0xef,0x30,0x0a]
@ CHECK: vmovl.s16	q8, d16         @ encoding: [0xd0,0xef,0x30,0x0a]
@ CHECK: vmovl.s32	q8, d16         @ encoding: [0xe0,0xef,0x30,0x0a]
@ CHECK: vmovl.u8	q8, d16         @ encoding: [0xc8,0xff,0x30,0x0a]
@ CHECK: vmovl.u16	q8, d16         @ encoding: [0xd0,0xff,0x30,0x0a]
@ CHECK: vmovl.u32	q8, d16         @ encoding: [0xe0,0xff,0x30,0x0a]
@ CHECK: vmovn.i16	d16, q8         @ encoding: [0xf2,0xff,0x20,0x02]
@ CHECK: vmovn.i32	d16, q8         @ encoding: [0xf6,0xff,0x20,0x02]
@ CHECK: vmovn.i64	d16, q8         @ encoding: [0xfa,0xff,0x20,0x02]
@ CHECK: vqmovn.s16	d16, q8         @ encoding: [0xf2,0xff,0xa0,0x02]
@ CHECK: vqmovn.s32	d16, q8         @ encoding: [0xf6,0xff,0xa0,0x02]
@ CHECK: vqmovn.s64	d16, q8         @ encoding: [0xfa,0xff,0xa0,0x02]
@ CHECK: vqmovn.u16	d16, q8         @ encoding: [0xf2,0xff,0xe0,0x02]
@ CHECK: vqmovn.u32	d16, q8         @ encoding: [0xf6,0xff,0xe0,0x02]
@ CHECK: vqmovn.u64	d16, q8         @ encoding: [0xfa,0xff,0xe0,0x02]
@ CHECK: vqmovun.s16	d16, q8         @ encoding: [0xf2,0xff,0x60,0x02]
@ CHECK: vqmovun.s32	d16, q8         @ encoding: [0xf6,0xff,0x60,0x02]
@ CHECK: vqmovun.s64	d16, q8         @ encoding: [0xfa,0xff,0x60,0x02]


@	vmov.s8	r0, d16[1]
@	vmov.s16	r0, d16[1]
@	vmov.u8	r0, d16[1]
@	vmov.u16	r0, d16[1]
@	vmov.32	r0, d16[1]
@	vmov.8	d16[1], r1
@	vmov.16	d16[1], r1
@	vmov.32	d16[1], r1
@	vmov.8	d18[1], r1
@	vmov.16	d18[1], r1
@	vmov.32	d18[1], r1

@ FIXME: vmov.s8	r0, d16[1]      @ encoding: [0x50,0xee,0xb0,0x0b]
@ FIXME: vmov.s16	r0, d16[1]      @ encoding: [0x10,0xee,0xf0,0x0b]
@ FIXME: vmov.u8	r0, d16[1]      @ encoding: [0xd0,0xee,0xb0,0x0b]
@ FIXME: vmov.u16	r0, d16[1]      @ encoding: [0x90,0xee,0xf0,0x0b]
@ FIXME: vmov.32	r0, d16[1]      @ encoding: [0x30,0xee,0x90,0x0b]
@ FIXME: vmov.8	d16[1], r1              @ encoding: [0x40,0xee,0xb0,0x1b]
@ FIXME: vmov.16	d16[1], r1      @ encoding: [0x00,0xee,0xf0,0x1b]
@ FIXME: vmov.32	d16[1], r1      @ encoding: [0x20,0xee,0x90,0x1b]
@ FIXME: vmov.8	d18[1], r1              @ encoding: [0x42,0xee,0xb0,0x1b]
@ FIXME: vmov.16	d18[1], r1      @ encoding: [0x02,0xee,0xf0,0x1b]
@ FIXME: vmov.32	d18[1], r1      @ encoding: [0x22,0xee,0x90,0x1b]
