myfunc() {
	echo "hello $1!"
	return 0
}

# Same as above (alternate syntax)
function myfunc2() {
	echo "hello $1 in a slightly different way!"
	return 0
}

myfunc "Jernej"
myfunc2 "Jernej"

greeting=$(myfunc "Jernej")

echo "${greeting} from a variable!"
