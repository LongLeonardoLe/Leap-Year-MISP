.data
# Declare Text
	InputNgay: .asciiz "Nhap Ngay (Day): "
	InputThang: .asciiz "Nhap Thang (Month): "
	InputNam: .asciiz "Nhap Nam (Year): "
	InputTime1: .asciiz "Nhap Chuoi Time 1: "
	InputTime: .asciiz "Nhap Chuoi Time: "
	InputTime2: .asciiz "Nhap Chuoi Time 2: "
	sWrongTime: .asciiz "\nChuoi Time Khong hop le!!!"
	
	sChoice: .asciiz "\nChoice: "
	sComeback: .asciiz "\nPress Enter to come back to menu!"
	sDistance: .asciiz "\nDistance: "
	sDay: .asciiz " days"
	sAnd: .asciiz " and "
	sWrongChoice: .asciiz "Wrong Choice!!!"
	sLeap: .asciiz "This is Leap Year!!!"
	sNLeap: .asciiz "This is Not Leap Year!!!"
	sMenu2: .asciiz " 	1. MM/DD/YYYY \n 	2. Month DD, YYYY \n 	3. DD Month, YYYY \n"
	sMenu: .asciiz "\n----------Ban hay chon 1 trong cac thao tac duoi day ------------------ \n 1.Xuat chuoi TIME theo dinh dang DD/MM/YYYY \n 2.Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau va xuat ra: \n 	A. MM/DD/YYYY \n 	B. Month DD, YYYY \n 	C. DD Month, YYYY \n 3. Kiem tra nam trong chuoi TIME co phai nam nhuan khong \n 4.Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2 \n 5. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time \n 6.Thoat"
# Declare Int
	day: .word 0
	month: .word 0
	year: .word 0
	day1: .word 0
	month1: .word 0
	year1: .word 0
	day2: .word 0
	month2: .word 0
	year2: .word 0
	
	choice: .word 0
	choice2: .word 0
#Declare string
	strInput: .space 20
	TIME_1: .space 20
	TIME_2: .space 20
	TIME_Re: .space 20
#Declare Const Text
	ListMonth: .asciiz	"January","February","March","April","May","June","July","August","September","October","November","December"
	ListN:	.word	0,8,17,23,29,33,38,43,50,60,68,77,86
#=========================================
.text
main:

	#Output string InputNgay
	addi $v0, $0, 4
	la $a0,	InputNgay
	syscall
	
	#Input Ngay
	addi $v0, $0, 5
	syscall
	#Save Ngay
	sw	$v0, day
	
	#Output string InputThang
	addi $v0, $0, 4
	la $a0,	InputThang
	syscall
	
	#Input Thang
	addi $v0, $0, 5
	syscall
	
	#Save thang
	sw	$v0, month
	
	#Output string InputNam
	addi $v0, $0, 4
	la $a0,	InputNam
	syscall
	
	#Input NAM
	addi $v0, $0, 5
	syscall
	
	#Save Nam
	sw	$v0, year
menu:
	#Output string sMenu
	addi $v0, $0, 4
	la $a0,	sMenu
	syscall
		
InputChoice:
	#Output string sChoice
	addi $v0, $0, 4
	la $a0,	sChoice
	syscall

	#Input Choice
	addi $v0, $0, 5
	syscall
	
	#Save Choice
	sw	$v0, choice
	# if v0 = 6 -> exit
	addi 	$t0,	$0,	6
	beq	$v0,	$t0,	Exit	
	#Check if 0< Choice <7
	# Pass in parameter a0 = choice a1 = 0 , a2 = 7
	lw 	$a0,	choice
	addi	$a1,	$0,	0
	addi	$a2,	$0,	7
	jal checkBetween
	addi 	$t0,	$v0,	0
	
	#check if t0 = 0 => nhap lai, choie = 6=> exit
	bne	$t0,	$0,	RightChoice
	#Output string sChoice
	addi $v0, $0, 4
	la $a0,	sWrongChoice
	syscall
	j InputChoice
RightChoice:
	lw	$t0,	choice	#t0 = choice
	# choice	 = 1
	addi	$t1,	$0,	1	#t1= 1
	beq		$t0,	$t1,	Choice1
	# choice	 = 2
	addi	$t1,	$0,	2	#t1= 2
	beq		$t0,	$t1,	Choice2
	
	# choice	 = 3
	addi	$t1,	$0,	3	#t1= 3
	beq		$t0,	$t1,	Choice3
	
	# choice	 = 4
	addi	$t1,	$0,	4	#t1= 4
	beq		$t0,	$t1,	Choice4
	
	# choice	 = 5
	addi	$t1,	$0,	5	#t1= 5
	beq		$t0,	$t1,	Choice5
Choice1:	
	lw	$a0,	day
	lw	$a1,	month
	lw	$a2,	year
	jal	Outputddmmyyyy
	#Output string TIME_Re
	addi $v0, $0, 4
	la $a0,	TIME_Re
	syscall
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j	menu
Choice2:
loopnhapTime:
	#Output string InputTime1
	addi $v0, $0, 4
	la $a0,	InputTime
	syscall
	#Input InputString
	addi $v0, $0, 8
	la	$a0,	strInput
	addi	$a1,	$0,20
	syscall
	jal CheckstrValid
	bne	$v0,	$0,	NhapxongTime
	beq	$v0,	$0,	WrongTime
	jal	InputString
	addi	$a0,	$s1,	0
	addi	$a1,	$s2,	0
	addi	$a2,	$s3,	0
	jal	valid
	bne	$v0,	$0,	NhapxongTime
WrongTime:
	#Output string sWrongTime
	addi $v0, $0, 4
	la $a0,	sWrongTime
	syscall
	j loopnhapTime
	
NhapxongTime:
	jal	InputString
	sw	$s1,	day
	sw	$s2,	month
	sw	$s3,	year
	#Output string sMenu2
	addi $v0, $0, 4
	la $a0,	sMenu2
	syscall
	
	#Input Choice
	addi $v0, $0, 5
	syscall
	
	# choice	 = A
	addi	$t1,	$0,	1	#t1= 1
	beq		$v0,	$t1,	Choice2A
	# choice	 = B
	addi	$t1,	$0,	2	#t1= 2
	beq		$v0,	$t1,	Choice2B
	
	# choice	 = C
	addi	$t1,	$0,	3	#t1= 3
	beq		$v0,	$t1,	Choice2C
Choice2A:
	lw	$a0,	day
	lw	$a1,	month
	lw	$a2,	year
	jal	Outputmmddyyyy
	#Output string TIME_Re
	addi $v0, $0, 4
	la $a0,	TIME_Re
	syscall
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j	menu
Choice2B:
	lw	$a0,	day
	lw	$a1,	month
	lw	$a2,	year
	jal	OutputMonthddyyyy
	#Output string TIME_Re
	addi $v0, $0, 4
	la $a0,	TIME_Re
	syscall
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j	menu
Choice2C:
	lw	$a0,	day
	lw	$a1,	month
	lw	$a2,	year
	jal	OutputDdMonthyyyy
	#Output string TIME_Re
	addi $v0, $0, 4
	la $a0,	TIME_Re
	syscall
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j	menu
Choice3:
loopnhapTime3:
	#Output string InputTime1
	addi $v0, $0, 4
	la $a0,	InputTime
	syscall
	#Input InputString
	addi $v0, $0, 8
	la	$a0,	strInput
	addi	$a1,	$0,20
	syscall
	jal CheckstrValid
	bne	$v0,	$0,	NhapxongTime3
	beq	$v0,	$0,	WrongTime3
	jal	InputString
	addi	$a0,	$s1,	0
	addi	$a1,	$s2,	0
	addi	$a2,	$s3,	0
	jal	valid
	bne	$v0,	$0,	NhapxongTime3
WrongTime3:
	#Output string sWrongTime
	addi $v0, $0, 4
	la $a0,	sWrongTime
	syscall
	j loopnhapTime
	
NhapxongTime3:
	jal	InputString
	sw	$s1,	day
	sw	$s2,	month
	sw	$s3,	year
	lw	$a2,	year
	jal	LeapYear
	beq	$v0,	$0,	OutputNotLeapYear
	# Is Leap Year
	#Output string LeapYear
	addi $v0, $0, 4
	la $a0,	sLeap
	syscall
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j menu
OutputNotLeapYear:
	addi $v0, $0, 4
	la $a0,	sNLeap
	syscall
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j menu
Choice4:
loopnhapTime1:
	#Output string InputTime1
	addi $v0, $0, 4
	la $a0,	InputTime1
	syscall
	#Input InputString
	addi $v0, $0, 8
	la	$a0,	strInput
	addi	$a1,	$0,20
	syscall
	jal CheckstrValid
	bne	$v0,	$0,	NhapxongTime1
	beq	$v0,	$0,	WrongTime1
	jal	InputString
	addi	$a0,	$s1,	0
	addi	$a1,	$s2,	0
	addi	$a2,	$s3,	0
	jal	valid
	bne	$v0,	$0,	NhapxongTime1
WrongTime1:
	#Output string sWrongTime
	addi $v0, $0, 4
	la $a0,	sWrongTime
	syscall
	j loopnhapTime1
	
NhapxongTime1:
	jal	InputString
	sw	$s1,	day1
	sw	$s2,	month1
	sw	$s3,	year1
loopnhapTime2:
	#Output string InputTime2
	addi $v0, $0, 4
	la $a0,	InputTime2
	syscall
	#Input InputString
	addi $v0, $0, 8
	la	$a0,	strInput
	addi	$a1,	$0,	20
	syscall
	jal CheckstrValid
	bne	$v0,	$0,	NhapxongTime2
	beq	$v0,	$0,	WrongTime2
	jal	InputString
	addi	$a0,	$s1,	0
	addi	$a1,	$s2,	0
	addi	$a2,	$s3,	0
	jal	valid
	bne	$v0,	$0,	NhapxongTime2
WrongTime2:
	#Output string sWrongTime
	addi $v0, $0, 4
	la $a0,	sWrongTime
	syscall
	j loopnhapTime2
	
NhapxongTime2:
	jal	InputString
	sw	$s1,	day2
	sw	$s2,	month2
	sw	$s3,	year2
	
	#Load Into Distance
	lw	$s0,		day1
	lw	$s1,		month1
	lw	$s2,		year1
	lw	$s3,		day2
	lw	$s4,		month2
	lw	$s5,		year2
	
	jal Distance
	
	addi	$t0,	$v0,	0
	#Output string sDistance
	addi $v0, $0, 4
	la $a0,	sDistance
	syscall
	addi	$a0,	$t0,	0
	addi $v0,	$0,	1
	syscall
	
	#Output string sDay
	addi $v0, $0, 4
	la $a0,	sDay
	syscall
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j	menu
Choice5:
loopnhapTime5:
	#Output string InputTime1
	addi $v0, $0, 4
	la $a0,	InputTime
	syscall
	#Input InputString
	addi $v0, $0, 8
	la	$a0,	strInput
	addi	$a1,	$0,20
	syscall
	jal CheckstrValid
	bne	$v0,	$0,	NhapxongTime5
	beq	$v0,	$0,	WrongTime5
	jal	InputString
	addi	$a0,	$s1,	0
	addi	$a1,	$s2,	0
	addi	$a2,	$s3,	0
	jal	valid
	bne	$v0,	$0,	NhapxongTime5
WrongTime5:
	#Output string sWrongTime
	addi $v0, $0, 4
	la $a0,	sWrongTime
	syscall
	j loopnhapTime1
	
NhapxongTime5:
	jal	InputString
	sw	$s1,	day
	sw	$s2,	month
	sw	$s3,	year
	lw	$a2,	year
	jal	nearestLeapYear
	addi	$a0,	$v0,	0
	addi	$t0,	$v1,	0
	
	addi $v0,	$0,	1
	syscall
	
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sAnd
	syscall
	
	addi	$a0,	$t0,	0
	addi $v0,	$0,	1
	syscall
	
	#Output string sComeback
	addi $v0, $0, 4
	la $a0,	sComeback
	syscall
	#Comeback
	addi $v0, $0, 12
	syscall
	j	menu
	
	
#====================================================
#Exit 
Exit:
addi $v0,	$0,	10
syscall	
#=====================================================
#Function check a0 is between a1 and a2: a1<a0<a2
#Output
# $v0 = 1 if Yes
# $v0 = 0 If No
# save t0 t1

checkBetween:
	addi	$sp, $sp , -12
	sw	$ra, 8($sp) 
	sw	$t0, 4($sp) 
	sw	$t1, 0($sp) 
	slt	$t0, $a1, $a0 # if (a1<a0)
	slt 	$t1, $a0, $a2 # if (a0<a2)
	and	$v0, $t0, $t1
	#restore t0 t1 ra
	sw	$t1, 0($sp)
	sw	$t0, 4($sp)
	sw	$ra, 8($sp)
	jr $ra
#=================================================
#Function Check a string Input is Valid
#Input:	strInput
#Output: v0 = 1: valid		v0 = 0 : not valid
#Used:	s0	t0 t1 t2 t3 t4 t5
#Header
CheckstrValid:
	addi $sp,	$sp,	-32		# 8 spaces
	sw	$ra,	0($sp)		# Store $ra
	sw	$t0,	4($sp)		# Store $t0
	sw	$t1,	8($sp)		# Store $t1
	sw	$t2,	12($sp)		# Store $t2
	sw	$t3,	16($sp)		# Store $t3
	sw	$t4,	24($sp)		# Store $t4
	sw	$t5,	28($sp)		# Store $t5
	sw	$s0,	32($sp)		# Store $s0
#Main
	la	$s0,	strInput	#s0 = address of strInput
	addi	$t0,	$0,	0	#t0 = 0 => Index of the string
	addi	$t1,	$0,	11	#t1	=	11
	#check length
	loopchecklength:
		slt		$t2,	$t0,	$t1		#if t0 < 11
		beq		$t2,	$0,		bloopchecklength # if t0 >11 go to bloopchecklength
		lb		$t3,	($s0)	
		beq		$t3,	$0		setFalse2	#string end before 11
		addi	$t0,	$t0,	1	#t0++
		addi	$s0,	$s0,	1	#s0++
		j	loopchecklength
	bloopchecklength:	
		lb	$t3,	($s0)
		bne	$t3,	$0,	setFalse2
	#check 2 "/"
	la	$s0,	strInput	#s0 = address of strInput
	addi	$t0,	$0,	0	#t0 = 0 => Index of the string
		#check strInput[2]
		lb	$t3,	2($s0)
		addi	$t3,	$t3,	-47
		bne		$t3,	$0,		setFalse2	#check if strInput[2]!='/' then FALSE
		#check strInput[5]
		addi	$s0,	$s0,	5
		lb	$t3,	($s0)
		addi	$t3,	$t3,	-47
		bne		$t3,	$0,		setFalse2
	
	#check 8 numbers
	la	$s0,	strInput	#s0 = address of strInput
	addi	$t0,	$0,	0	#t0 = 0 => Index of the string
	addi	$t2,	$0,	10	#t2 = 10 
	addi	$t5,	$0,	0	#t5 = 0 => Result
	
	loopcheck8numbers:
		lb	$t3,	($s0)	#load strInput[i]
		beq	$t3,	$0,	bloopcheck8numbers
		addi	$t3,	$t3,	-48	#t3 = t3 -48
		sltu	$t4,	$t3,	$t2	#	if (t3<10) t4 = 1
		add		$t5,	$t5,	$t4	#if number then count
		addi	$t0,	$t0,	1	#t0++
		addi	$s0,	$s0,	1	#s0++
		j loopcheck8numbers
	bloopcheck8numbers:
		addi	$t1,	$0,	8	#t1 = 8
		bne		$t5,	$t1,	setFalse2
		
	#True	
		addi	$v0,	$0,	1	#v0 =1 => valid

#Tailer
Tailercheckvalidstr:

			sw	$s0,	32($sp)		# Store $s0
			sw	$t5,	28($sp)		# Store $t5
			sw	$t4,	24($sp)		# Store $t4
			sw	$t3,	16($sp)		# Store $t3
			sw	$t2,	12($sp)		# Store $t2
			sw	$t1,	8($sp)		# Store $t1
			sw	$t0,	4($sp)		# Store $t0
			sw	$ra,	0($sp)		# Store $ra
			addi $sp,	$sp,	32		# 8 spaces
			jr	$ra
			
setFalse2: #if the string is not valid
	addi	$v0,	$0,	0	#v0 =0 => not valid
	j	Tailercheckvalidstr
#=================================================
#Function Output the DD/MM/YYYY
#Input: a0:day, a1:month, a2:year
#Output: v0: address of string TIME_Re
Outputddmmyyyy:
# Use s0,s1,s2,s3,s4,t0
#Header
	addi $sp,	$sp,	-28		# 7 spaces
	sw	$ra,	0($sp)		# Store $ra
	sw	$s0,	4($sp)		# Store $s0
	sw	$s1,	8($sp)		# Store $s1
	sw	$s2,	12($sp)		# Store $s2
	sw	$s3,	16($sp)		# Store $s3
	sw	$s4,	24($sp)		# Store $s4
	sw	$t0,	28($sp)		# Store $t0
	
#main
	la	$s0,	TIME_Re 			# s0 = address of TIME_Re
	#Get the MOD and DIV of DD
	addi	$t0,	$0,	10 			# t0= 10
	div		$a0,	$t0			# lo = a0/t0 
	mflo	$s1					# s1 = lo = first digit of day
	mfhi	$s2					# s2 = hi = 2nd digit of day
	addi	$s1,	$s1,	48			# s1 = s1 + 48
	addi	$s2,	$s2,	48			# s2 = s2 + 48
	addi	$s3,	$0,	47			# s3 = 47 '/'
	sb		$s1,	($s0)			#	Save s1 into string TIME_Re
	sb		$s2,	1($s0)			#	Save s2 into string TIME_Re
	sb		$s3,	2($s0)			#	Save s2 into string TIME_Re
	addi	$s0,	$s0,	3			# s0 = s0 +3: move to MM
	## Process MM
	div		$a1,	$t0			# lo = a1/t0 
	mflo	$s1					# s1 = lo = first digit of Month
	mfhi	$s2					# s2 = hi = 2nd digit of Month
	addi	$s1,	$s1,	48			# s1 = s1 + 48
	addi	$s2,	$s2,	48			# s2 = s2 + 48
	addi	$s3,	$0,	47			# s3 = 47 '/'
	sb		$s1,	($s0)		#	Save s1 into string TIME_Re
	sb		$s2,	1($s0)			#	Save s2 into string TIME_Re
	sb		$s3,	2($s0)			#	Save s2 into string TIME_Re
	addi	$s0,	$s0,	3			# s0 = s0 +3: move to YYYY
	## Process YYYY
	div 	$a2,	$t0				#a2/t0: a2 /10
	mflo	$s1					# s1 = lo = 3 first digits of Year
	mfhi	$s4					# s2 = hi = 4th digit of Year
	addi	$a2,	$s1,	0			# a2 = 3 first digits of year
	
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 2 first digits of Year
	mfhi	$s3					# s3 = hi = 3rd digit of Year
	addi	$a2,	$s1,	0			# a2 = 2 first digits of year
		
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 1 first digits of Year
	mfhi	$s2					# s3 = hi = 2nd digit of Year

	#YYYY =	s1s2s3s4
	addi	$s1,	$s1,	48	#s1 = s1 +48
	addi	$s2,	$s2,	48	#s2 = s2 +48
	addi	$s3,	$s3,	48	#s3 = s3 +48
	addi	$s4,	$s4,	48	#s4 = s4 +48
	
	sb		$s1,	($s0)		#store s1
	sb		$s2,	1($s0)		#store s2
	sb		$s3,	2($s0)		#store s3
	addi	$s0,	$s0,	1	# s0++
	sb		$s4,	2($s0)		#store s4
	
	addi	$s0,	$s0,	1	# s0++
	addi	$s4,	$0,		0	# s0++
	sb		$s4,	2($s0)		#store s4

#Tailer	
	lw	$t0,	28($sp)		# Store $t0
	lw	$s4,	24($sp)		# Store $s4
	lw	$s3,	16($sp)		# Store $s3
	lw	$s2,	12($sp)		# Store $s2
	lw	$s1,	8($sp)		# Store $s1
	lw	$s0,	4($sp)		# Store $s0
	lw	$ra,	0($sp)		# Store $ra
	addi $sp,	$sp,	28		# 7 spaces
	jr	$ra
#=================================================
#Function Input String
#Used: s0,t0,t1,s1,s2,s3
InputString:
#Header
	addi $sp,	$sp,	-16		# 4 spaces
	sw	$ra,	0($sp)		# Store $ra
	sw	$s0,	4($sp)		# Store $s0
	sw	$t1,	24($sp)		# Store $t1
	sw	$t0,	28($sp)		# Store $t0
#Main
	la	$s0,	strInput	#s0 = address of strInput
	#Process DD
	lb	$t0,	($s0)		#Load first
	addi	$t0,	$t0,	-48	# -48 into int
	add	$t1,	$t0,	$t0		#t1 = 2*t0
	sll		$t0,	$t0,	3	#t0 = 8*t0
	add		$t1,	$t0,	$t1	#t1 = 10*t0
	addi	$s0,	$s0,	1	#s0++
	lb	$t0,	($s0)		#Load second
	addi	$t0,	$t0,	-48	# -48 into int
	add		$s1,	$t0,	$t1	# s1 = DD
	addi	$s0,	$s0,	2	# Move to MM
	#Process Month
	lb	$t0,	($s0)		#Load first
	addi	$t0,	$t0,	-48	# -48 into int
	add	$t1,	$t0,	$t0		#t1 = 2*t0
	sll		$t0,	$t0,	3	#t0 = 8*t0
	add		$t1,	$t0,	$t1	#t1 = 10*t0
	addi	$s0,	$s0,	1	#s0++
	lb	$t0,	($s0)		#Load second
	addi	$t0,	$t0,	-48	# -48 into int
	add		$s2,	$t0,	$t1	# s2 = MM
	
	addi	$s0,	$s0,	2	# Move to YYYY
	
	#Process YYYY
	lb	$t0,	($s0)		#Load first
	addi	$t0,	$t0,	-48	# -48 into int
	add	$t1,	$t0,	$t0		#t1 = 2*t0
	sll		$t0,	$t0,	3	#t0 = 8*t0
	add		$t1,	$t0,	$t1	#t1 = 10*t0
	addi	$s0,	$s0,	1	#s0++
	
	lb	$t0,	($s0)		#Load second
	addi	$t0,	$t0,	-48	# -48 into int
	add		$t0,	$t1,	$t0	
	add	$t1,	$t0,	$t0		#t1 = 2*t0
	sll		$t0,	$t0,	3	#t0 = 8*t0
	add		$t1,	$t0,	$t1	#t1 = 10*t0
	addi	$s0,	$s0,	1	#s0++
	
	lb	$t0,	($s0)		#Load third
	addi	$t0,	$t0,	-48	# -48 into int
	add		$t0,	$t1,	$t0	
	add	$t1,	$t0,	$t0		#t1 = 2*t0
	sll		$t0,	$t0,	3	#t0 = 8*t0
	add		$t1,	$t0,	$t1	#t1 = 10*t0
	addi	$s0,	$s0,	1	#s0++
	
	lb	$t0,	($s0)		#Load fourth
	addi	$t0,	$t0,	-48	# -48 into int
	add		$s3,	$t1,	$t0	# $s3 = YYYY
	
	
	
#Tailer
	lw	$t0,	28($sp)		# Store $t0
	lw	$t1,	24($sp)		# Store $t1
	lw	$s0,	4($sp)		# Store $s0
	lw	$ra,	0($sp)		# Store $ra
	addi $sp,	$sp,	16		# 4 spaces
	jr	$ra
#=================================================
#Function Output the MM/DD/YYYY
#Input: a0:day, a1:month, a2:year
#Output: v0: address of string TIME_Re
Outputmmddyyyy:
# Use s0,s1,s2,s3,s4,t0
#Header
	addi $sp,	$sp,	-28		# 7 spaces
	sw	$ra,	0($sp)		# Store $ra
	sw	$s0,	4($sp)		# Store $s0
	sw	$s1,	8($sp)		# Store $s1
	sw	$s2,	12($sp)		# Store $s2
	sw	$s3,	16($sp)		# Store $s3
	sw	$s4,	24($sp)		# Store $s4
	sw	$t0,	28($sp)		# Store $t0
	
#main
	la	$s0,	TIME_Re 			# s0 = address of TIME_Re
	addi	$t0,	$0,	10 			# t0= 10
	## Process MM
	div		$a1,	$t0			# lo = a1/t0 
	mflo	$s1					# s1 = lo = first digit of Month
	mfhi	$s2					# s2 = hi = 2nd digit of Month
	addi	$s1,	$s1,	48			# s1 = s1 + 48
	addi	$s2,	$s2,	48			# s2 = s2 + 48
	addi	$s3,	$0,	47			# s3 = 47 '/'
	sb		$s1,	($s0)		#	Save s1 into string TIME_Re
	sb		$s2,	1($s0)			#	Save s2 into string TIME_Re
	sb		$s3,	2($s0)			#	Save s2 into string TIME_Re
	addi	$s0,	$s0,	3			# s0 = s0 +3: move to DD
	
	#Get the MOD and DIV of DD
	
	div		$a0,	$t0			# lo = a0/t0 
	mflo	$s1					# s1 = lo = first digit of day
	mfhi	$s2					# s2 = hi = 2nd digit of day
	addi	$s1,	$s1,	48			# s1 = s1 + 48
	addi	$s2,	$s2,	48			# s2 = s2 + 48
	addi	$s3,	$0,	47			# s3 = 47 '/'
	sb		$s1,	($s0)			#	Save s1 into string TIME_Re
	sb		$s2,	1($s0)			#	Save s2 into string TIME_Re
	sb		$s3,	2($s0)			#	Save s2 into string TIME_Re
	addi	$s0,	$s0,	3			# s0 = s0 +3: move to YYYY
	## Process YYYY
	div 	$a2,	$t0				#a2/t0: a2 /10
	mflo	$s1					# s1 = lo = 3 first digits of Year
	mfhi	$s4					# s2 = hi = 4th digit of Year
	addi	$a2,	$s1,	0			# a2 = 3 first digits of year
	
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 2 first digits of Year
	mfhi	$s3					# s3 = hi = 3rd digit of Year
	addi	$a2,	$s1,	0			# a2 = 2 first digits of year
		
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 1 first digits of Year
	mfhi	$s2					# s3 = hi = 2nd digit of Year

	#YYYY =	s1s2s3s4
	addi	$s1,	$s1,	48	#s1 = s1 +48
	addi	$s2,	$s2,	48	#s2 = s2 +48
	addi	$s3,	$s3,	48	#s3 = s3 +48
	addi	$s4,	$s4,	48	#s4 = s4 +48
	
	sb		$s1,	($s0)		#store s1
	sb		$s2,	1($s0)		#store s2
	sb		$s3,	2($s0)		#store s3
	addi	$s0,	$s0,	1	# s0++
	sb		$s4,	2($s0)		#store s4
	
	addi	$s0,	$s0,	1	# s0++
	addi	$s4,	$0,		0	# s0++
	sb		$s4,	2($s0)		#store s4

#Tailer	
	lw	$t0,	28($sp)		# Store $t0
	lw	$s4,	24($sp)		# Store $s4
	lw	$s3,	16($sp)		# Store $s3
	lw	$s2,	12($sp)		# Store $s2
	lw	$s1,	8($sp)		# Store $s1
	lw	$s0,	4($sp)		# Store $s0
	lw	$ra,	0($sp)		# Store $ra
	addi $sp,	$sp,	28		# 7 spaces
	jr	$ra
#==============================================
#Function Output the Month DD,YYYY
#Input: a0:day, a1:month, a2:year
#Output: v0: address of string TIME_Re
OutputMonthddyyyy:
# Use s0,s1,s2,s3,s4,t0,t1
#Header
	addi $sp,	$sp,	-32		# 8 spaces
	sw	$ra,	0($sp)		# Store $ra
	sw	$s0,	4($sp)		# Store $s0
	sw	$s1,	8($sp)		# Store $s1
	sw	$s2,	12($sp)		# Store $s2
	sw	$s3,	16($sp)		# Store $s3
	sw	$s4,	24($sp)		# Store $s4
	sw	$t0,	28($sp)		# Store $t0
	sw	$t1,	32($sp)		# Store $t0	
#main
	la	$s0,	TIME_Re 			# s0 = address of TIME_Re
	la	$s2,	ListN 				# s2 = address of ListN
	addi	$t0,	$0,	10 			# t0= 10
	## Process Month
		#Take the Right Month Address and length of Month
		addi	$s1,	$a1,		0		#s1 = a2 Month
		addi	$s1,	$s1,		-1		#s1 = a2-2 Month
		
		sll		$s1,	$s1,	2		# s1 = 4*s1
		
		add		$s1,	$s2,	$s1		# s1 is the index of the ListN
		lw		$s3,	($s1)			#s3 is the address of Month in the ListMonth
		lw		$s4,	4($s1)			#s4 is the address of Month+1 in the ListMonth
		sub		$s1,	$s4,	$s3		#s1 = s4 - s3
		la		$s4,	ListMonth		# s4= Address of ListMonth
		add		$s3,	$s3,	$s4		#s3 is the address of Month
		#Copy string from $3 to $s0, length s1
		addi	$s2,	$0,	0	#s2 = 0 =>Index
		addi	$s1,	$s1,	-1
		loopCopyStr:
		slt		$t1,	$s2,	$s1	# s2 < s1(length)
		beq		$t1,	$0,	bloopCopyStr
		lb	$s4,	($s3)	#Load Month
		sb	$s4,	($s0)	#Save to TIME_Re
		addi	$s3,	$s3,	1 	#s3++
		#addi	$s4,	$s4,	1 	#s4++
		addi	$s2,	$s2,	1 	#s2++
		addi	$s0,	$s0,	1	#s0++
		j loopCopyStr
		
		bloopCopyStr:
		addi	$t1,	$0,	32	#t1 = ' '
		sb		$t1,	($s0)
		addi	$s0,	$s0,	1
	
	#Get the MOD and DIV of DD
	
	div		$a0,	$t0			# lo = a0/t0 
	mflo	$s1					# s1 = lo = first digit of day
	mfhi	$s2					# s2 = hi = 2nd digit of day
	addi	$s1,	$s1,	48			# s1 = s1 + 48
	addi	$s2,	$s2,	48			# s2 = s2 + 48
	addi	$s3,	$0,	44			# s3 = 4 ','
	sb		$s1,	($s0)			#	Save s1 into string TIME_Re
	sb		$s2,	1($s0)			#	Save s2 into string TIME_Re
	sb		$s3,	2($s0)			#	Save s2 into string TIME_Re
	addi	$s0,	$s0,	3			# s0 = s0 +3: move to YYYY
	## Process YYYY
	div 	$a2,	$t0				#a2/t0: a2 /10
	mflo	$s1					# s1 = lo = 3 first digits of Year
	mfhi	$s4					# s2 = hi = 4th digit of Year
	addi	$a2,	$s1,	0			# a2 = 3 first digits of year
	
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 2 first digits of Year
	mfhi	$s3					# s3 = hi = 3rd digit of Year
	addi	$a2,	$s1,	0			# a2 = 2 first digits of year
		
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 1 first digits of Year
	mfhi	$s2					# s3 = hi = 2nd digit of Year

	#YYYY =	s1s2s3s4
	addi	$s1,	$s1,	48	#s1 = s1 +48
	addi	$s2,	$s2,	48	#s2 = s2 +48
	addi	$s3,	$s3,	48	#s3 = s3 +48
	addi	$s4,	$s4,	48	#s4 = s4 +48
	
	sb		$s1,	($s0)		#store s1
	sb		$s2,	1($s0)		#store s2
	sb		$s3,	2($s0)		#store s3
	addi	$s0,	$s0,	1	# s0++
	sb		$s4,	2($s0)		#store s4
	
	addi	$s0,	$s0,	1	# s0++
	addi	$s4,	$0,		0	# s0++
	sb		$s4,	2($s0)		#store s4
	
	
#Tailer	
	lw	$t1,	32($sp)		# Store $t1
	lw	$t0,	28($sp)		# Store $t0
	lw	$s4,	24($sp)		# Store $s4
	lw	$s3,	16($sp)		# Store $s3
	lw	$s2,	12($sp)		# Store $s2
	lw	$s1,	8($sp)		# Store $s1
	lw	$s0,	4($sp)		# Store $s0
	lw	$ra,	0($sp)		# Store $ra
	addi $sp,	$sp,	32		# 8 spaces
	jr	$ra
#=============================================
#==============================================
#Function Output the DD Month,YYYY
#Input: a0:day, a1:month, a2:year
#Output: v0: address of string TIME_Re
OutputDdMonthyyyy:
# Use s0,s1,s2,s3,s4,t0,t1
#Header
	addi $sp,	$sp,	-32		# 8 spaces
	sw	$ra,	0($sp)		# Store $ra
	sw	$s0,	4($sp)		# Store $s0
	sw	$s1,	8($sp)		# Store $s1
	sw	$s2,	12($sp)		# Store $s2
	sw	$s3,	16($sp)		# Store $s3
	sw	$s4,	24($sp)		# Store $s4
	sw	$t0,	28($sp)		# Store $t0
	sw	$t1,	32($sp)		# Store $t0	
#main
	la	$s0,	TIME_Re 			# s0 = address of TIME_Re
	addi	$t0,	$0,	10 			# t0= 10
	
	#Get the MOD and DIV of DD
	
	div		$a0,	$t0			# lo = a0/t0 
	mflo	$s1					# s1 = lo = first digit of day
	mfhi	$s2					# s2 = hi = 2nd digit of day
	addi	$s1,	$s1,	48			# s1 = s1 + 48
	addi	$s2,	$s2,	48			# s2 = s2 + 48
	sb		$s1,	($s0)			#	Save s1 into string TIME_Re
	sb		$s2,	1($s0)			#	Save s2 into string TIME_Re
	addi	$s0,	$s0,	2			# s0 = s0 +3: move to YYYY
	
	
	addi	$t1,	$0,	32	#t1 = ' '
		sb		$t1,	($s0)
		addi	$s0,	$s0,	1
	
	## Process Month
		la	$s2,	ListN 				# s2 = address of ListN
		#Take the Right Month Address and length of Month
		addi	$s1,	$a1,		0		#s1 = a2 Month
		addi	$s1,	$s1,		-1		#s1 = a2-2 Month
		
		sll		$s1,	$s1,	2		# s1 = 4*s1
		
		add		$s1,	$s2,	$s1		# s1 is the index of the ListN
		lw		$s3,	($s1)			#s3 is the address of Month in the ListMonth
		lw		$s4,	4($s1)			#s4 is the address of Month+1 in the ListMonth
		sub		$s1,	$s4,	$s3		#s1 = s4 - s3
		la		$s4,	ListMonth		# s4= Address of ListMonth
		add		$s3,	$s3,	$s4		#s3 is the address of Month
		#Copy string from $3 to $s0, length s1
		addi	$s2,	$0,	0	#s2 = 0 =>Index
		addi	$s1,	$s1,	-1
		loopCopyStr2:
		slt		$t1,	$s2,	$s1	# s2 < s1(length)
		beq		$t1,	$0,	bloopCopyStr2
		lb	$s4,	($s3)	#Load Month
		sb	$s4,	($s0)	#Save to TIME_Re
		addi	$s3,	$s3,	1 	#s3++
		#addi	$s4,	$s4,	1 	#s4++
		addi	$s2,	$s2,	1 	#s2++
		addi	$s0,	$s0,	1	#s0++
		j loopCopyStr2
		
		bloopCopyStr2:
		
		addi	$s3,	$0,	44			# s3 = 44 ','
		sb		$s3,	($s0)			#	Save s2 into string TIME_Re
		addi	$s0,	$s0,	1
	## Process YYYY
	div 	$a2,	$t0				#a2/t0: a2 /10
	mflo	$s1					# s1 = lo = 3 first digits of Year
	mfhi	$s4					# s2 = hi = 4th digit of Year
	addi	$a2,	$s1,	0			# a2 = 3 first digits of year
	
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 2 first digits of Year
	mfhi	$s3					# s3 = hi = 3rd digit of Year
	addi	$a2,	$s1,	0			# a2 = 2 first digits of year
		
	div		$a2,	$t0				# a2/10
	mflo	$s1					# s1 = lo = 1 first digits of Year
	mfhi	$s2					# s3 = hi = 2nd digit of Year

	#YYYY =	s1s2s3s4
	addi	$s1,	$s1,	48	#s1 = s1 +48
	addi	$s2,	$s2,	48	#s2 = s2 +48
	addi	$s3,	$s3,	48	#s3 = s3 +48
	addi	$s4,	$s4,	48	#s4 = s4 +48
	
	sb		$s1,	($s0)		#store s1
	sb		$s2,	1($s0)		#store s2
	sb		$s3,	2($s0)		#store s3
	addi	$s0,	$s0,	1	# s0++
	sb		$s4,	2($s0)		#store s4
	
	addi	$s0,	$s0,	1	# s0++
	addi	$s4,	$0,		0	# s0++
	sb		$s4,	2($s0)		#store s4
	
	
#Tailer	
	lw	$t1,	32($sp)		# Store $t1
	lw	$t0,	28($sp)		# Store $t0
	lw	$s4,	24($sp)		# Store $s4
	lw	$s3,	16($sp)		# Store $s3
	lw	$s2,	12($sp)		# Store $s2
	lw	$s1,	8($sp)		# Store $s1
	lw	$s0,	4($sp)		# Store $s0
	lw	$ra,	0($sp)		# Store $ra
	addi $sp,	$sp,	32		# 8 spaces
	jr	$ra
#=============================================
#*************************** check the valid date. **********************
# day: $a0, month: $a1, year: $a2
valid:					# Use $t0, $t1, $t2
	addi $sp, $sp, -16
	sw $t0, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $ra, 0($sp)

	add $v0, $zero, $zero		# $v0 = 0

	slt $t0, $a2, $zero		# if year < 0
	bne $t0, $zero, setFalse
	slt $t0, $a1, $zero		# if month < 0
	bne $t0, $zero, setFalse
	slt $t0, $a0, $zero		# if day < 0
	bne $t0, $zero, setFalse

	addi $t0, $zero, 1		# month = 1, use for switch(month)
	beq $a1, $t0, Day31
	addi $t0, $t0, 1		# month = 2
	beq $a1, $t0, Month2
	addi $t0, $t0, 1		# month = 3
	beq $a1, $t0, Day31
	addi $t0, $t0, 1		# month = 4
	beq $a1, $t0, Day30
	addi $t0, $t0, 1		# month = 5
	beq $a1, $t0, Day31
	addi $t0, $t0, 1		# month = 6
	beq $a1, $t0, Day30
	addi $t0, $t0, 1		# month = 7
	beq $a1, $t0, Day31
	addi $t0, $t0, 1		# month = 8
	beq $a1, $t0, Day31
	addi $t0, $t0, 1		# month = 9
	beq $a1, $t0, Day30
	addi $t0, $t0, 1		# month = 10
	beq $a1, $t0, Day31
	addi $t0, $t0, 1		# month = 11
	beq $a1, $t0, Day30
	addi $t0, $t0, 1		# month = 12
	beq $a1, $t0, Day31

Day30:
	addi $t1, $zero, 30
	slt $t2, $t1, $a0		# if day > 30, $t0 = 1. Otherwise $t0 = 0
	bne $t2, $t0, setFalse
	j setTrue

Day31:
	addi $t1, $zero, 31
	slt $t2, $t1, $a0		# if day > 31, $t0 = 1. Otherwise $t0 = 0
	bne $t2, $zero, setFalse
	j setTrue

Month2:
	jal LeapYear
	beq $v0, $zero, Day28		# not leap year

Day29:
	addi $t1, $zero, 29		# $t1 = 29
	slt $t2, $t1, $a0		# if day > 29, $t0 = 1. Otherwise $t0 = 0
	bne $t2, $zero, setFalse
	j setTrue

Day28:
	addi $t1, $zero, 28		# $t1 = 28
	slt $t2, $t1, $a0		# if day > 28, $t0 = 1. Otherwise $t0 = 0
	bne $t2, $zero, setFalse
	j setTrue

setTrue:
	addi $v0, $zero, 1		# $v0 = 1, TRUE
setFalse:
	add $v0, $v0, $zero		# $v0 = 0, FALSE
	lw $ra, 0($sp)
	lw $t2, 4($sp)
	lw $t1, 8($sp)
	lw $t0, 12($sp)
	addi $sp, $sp, 16
	jr $ra

#=====================================
#************************** check leap year *******************************
# save year to $a2
LeapYear:				# Use $a2, $t0, $t1
	addi $sp, $sp, -12
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $ra, 0($sp)
	add $v0, $zero, $zero		# $v0 = 0
	addi $t0, $zero, 400		# $t0 = 400
	div $a2, $t0
	mfhi $t1
	beq $t1, $zero, Leap		# if divisible by 400, leap year
	addi $t0, $zero, 4		# $t0 = 100
	div $a2, $t0
	mfhi $t1
	bne $t1, $zero, notLeap		# jump next if divisble by 100. if not it is a leap
	addi $t0, $zero, 100		# $t0 = 4
	div $a2, $t0
	mfhi $t1
	beq $t1, $zero, notLeap		# if not divisible by 400, not leap year

Leap:
	addi $v0, $zero, 1		# $v0 = 1, YES

notLeap:
	add $v0, $v0, $zero		# $v0 = 0, NO
	lw $ra, 0($sp)
	lw $t1, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	jr $ra

#===================================================
#Output
# $v0 = how many days in that month
#Function output how many days in month year
#Input
# $a0 = month
# $a1 = year
DayInMonth:			# Use $t0
addi $sp, $sp, -8
sw $t0, 4($sp)
sw $ra, 0($sp)
addi $t0, $zero, 1		# month = 1, use for switch(month)
beq $a1, $t0, Return31
addi $t0, $t0, 1		# month = 2
beq $a1, $t0, ReturnMonth2
addi $t0, $t0, 1		# month = 3
beq $a1, $t0, Return31
addi $t0, $t0, 1		# month = 4
beq $a1, $t0, Return30
addi $t0, $t0, 1		# month = 5
beq $a1, $t0, Return31
addi $t0, $t0, 1		# month = 6
beq $a1, $t0, Return30
addi $t0, $t0, 1		# month = 7
beq $a1, $t0, Return31
addi $t0, $t0, 1		# month = 8
beq $a1, $t0, Return31
addi $t0, $t0, 1		# month = 9
beq $a1, $t0, Return30
addi $t0, $t0, 1		# month = 10
beq $a1, $t0, Return31
addi $t0, $t0, 1		# month = 11
beq $a1, $t0, Return30
addi $t0, $t0, 1		# month = 12
beq $a1, $t0, Return31

Return30:
addi $v0, $zero, 30
j ReturnDay

Return31:
addi $v0, $zero, 31
j ReturnDay

ReturnMonth2:
jal LeapYear
bne $v0, $zero, Return29
addi $v0, $zero, 28
j ReturnDay

Return29:
addi $v0, $zero, 29
j ReturnDay

ReturnDay:
lw $ra, 0($sp)
lw $t0, 4($sp)
addi $sp, $sp, 8
jr $ra
#********************* calculate the distance between 2 dates *********************
# $s0: day1, $s1: month1, $s2: year1, $s3: day2, $s4: month2, $s5: year2
Distance:
	addi $sp, $sp, -20
	sw $a2, 16($sp)
	sw $a1, 12($sp)
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $ra, 0($sp)
	beq $s2, $s5, DistSameYear	# when year2 = year1
	add $a1, $s1, $zero		# save month1 to $a1
	jal DayInMonth
	sub $t0, $v0, $zero		# $t0 = result = DayInMonth
	add $a2, $s2, $zero		# save year1 to $a2
	beq $a1, 12, Dist2		# check if the month1 is 12
	addi $a1, $a1, 1		

LoopDist1:				# loop until meet the Dec of year1
	jal DayInMonth
	add $t0, $t0, $v0		# increase the day of the current month
	addi $a1, $a1, 1		# month1++
	bne $a1, 13, LoopDist1		# if month goes to 12, jump the next year

Dist2:				
	addi $a2, $a2, 1		# year1++
	beq $a2, $s5, Dist3
LoopDist2:
	jal LeapYear			# check leap year
	beq $v0, $zero, Incr365
	addi $t0, $t0, 1
Incr365:
	addi $t0, $t0, 365		# result += 365
	addi $a2, $a2, 1		# year1++
	bne $a2, $s5, LoopDist2		# loop until come to year2

Dist3:
	add $t0, $s3, $t0		# $t0 += day2
	addi $a1, $zero, 1		# $a1 = tmpMonth = 1
	addi $t1, $s4, 1
	beq $a1, $s4, returnDist
LoopDist3:
	jal DayInMonth
	add $t0, $t0, $v0		# increase the day of the current month
	addi $a1, $a1, 1		# tmpMonth++
	bne $a1, $s4, LoopDist3		# loop until meet month2
	j returnDist

DistSameYear:
	beq $s1, $s4, sameMonth
	add $a1, $s1, $zero		# $a1 = month1
	add $a2, $s2, $zero		# $a2 = year1
	jal DayInMonth
	sub $t0, $v0, $s0		# $t0 = result = DayInMonth - day1
	add $t0, $s3, $t0		# $t0 = result += day2
	addi $a1, $a1, 1		# $a1 = month1 + 1
	j LoopDist3

sameMonth:
	sub $t0, $s3, $s0		# $t0 = result = day2 - day1
	
returnDist:
	add $v0, $t0, $zero
	lw $ra, 0($sp)
	lw $t1, 4($sp)
	lw $t0, 8($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	addi $sp, $sp, 20
	jr $ra

#*********************** find the two nearest leap years *******************
# save year to $a2
nearestLeapYear:
	addi $sp, $sp, -12
	sw $t0, 8($sp)
	sw $a2, 4($sp)
	sw $ra, 0($sp)
LoopLP:
	addi $a2, $a2, 1		# increase 1 year
	jal LeapYear			# check if is leap year
	beq $v0, $zero, LoopLP		
	add $t0, $zero, $a2		# save the first year to $t0
	addi $a2, $a2, 4		# increase the found leap year by 4
	jal LeapYear			# check if this year is leap or not
	bne $v0, $zero, NextLP
	addi $a2, $a2, 4		# keep increasing
NextLP:
	add $v0, $zero, $t0		# $v0: first leap year
	add $v1, $zero, $a2		# $v1: second leap year
	lw $ra, 0($sp)
	lw $a2, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	jr $ra