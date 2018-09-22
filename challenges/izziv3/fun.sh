# funkcije
function fakiter()
{
	res=1
	n=$1
	for ((i=1; i <= n; i++))
	do
	res=$((res*(i)))
	done
	echo $res
}

function fibiter()
{
	a=0
	b=1
	n=6
	if [ $n -eq 1 ]
	then
		echo 1
	else
		for ((i=1; i < n; i++))
		do
			c=$((a+b))
			a=$b
			b=$c
		done
		echo $c
	fi
}

function fakrek()
{
	if [ $1 -eq 0 ] || [ $1 -eq 1 ]
	then
		echo 1
	else
	echo $(($1 * $(fakiter $(($1 - 1)))))
	fi
}

function fibrek()
{
	if [ $1 -eq 1 ] || [ $1 -eq 0 ]
	then
		echo 1
	else
		echo $(( $(fibrek  $(($1 - 1))) + $(fibrek $(($1 - 2)))))
	fi
}

# val := drugi argument (privzeta vrednost je 10)
val=${2:-10}

# izberi funkcijo glede na podan prvi argument
if [ "$1" == "fakrek" ]
then
	res=$(fakrek $val)
	echo $res
elif [ "$1" == "fakiter" ]
then
	res=$(fakiter $val)
	echo $res
elif [ "$1" == "fibrek" ]
then
	res=$(fibrek $val)
	echo $res
elif [ "$1" == "fibiter" ]
then
	res=$(fibiter $val)
	echo $res
elif [ "$1" == "help" ]
then
	echo "Script for computing fibonacci numbers and factorials of numbers.
The first argument specifies the function to be used. It supports the following function:
	- fibiter (compute n-th Fibonacci number using an iterative algorithm),
	- fibrek (compute n-th Fibonacci number using a recursive algorithm),
	- fakiter (compute factorial of number using an iterative algorithm),
	- fakrek (compute factorial of number using a recursive algorithm).

The second argument specifies the index of the Fibonacci number 
or the number of which the factorial will be computed.
If no second argument is specified, the default value is 10."
fi