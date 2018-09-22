fruits=('Apple' 'Banana' 'Orange')

echo ${#fruits[@]}

# Go over the array
for i in ${fruits[@]}; do
	echo $i
done

