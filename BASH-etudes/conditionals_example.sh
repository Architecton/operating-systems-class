string="Test"

if [ -z "$string" ]; then
  echo "1. variable is empty"
elif [ -n "$string" ]; then
  echo "1. variable is not empty"
fi

string2=""

if [ -z "$string2" ]; then
	echo "2. variable is empty"
elif [ -n "$string" ]; then
	echo "2. variable is not empty"
fi