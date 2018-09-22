fruits=('Banana' 'Apple' 'Kiwi' 'Avocado')

printf "Printing the array:\n\n"
for i in ${fruits[@]}; do
	echo $i
done

printf "\nPushing 'Watermelon' to the end of array:\n\n"

fruits=("${fruits[@]}" "Watermelon")

printf "Printing the new array:\n\n"

for i in ${fruits[@]}; do
	echo $i
done

printf "\nRemoving an element by a regex match:\n"

fruits=(${fruits[@]/Ap*/})

printf "Printing the resulting array:\n\n"

for i in ${fruits[@]}; do
	echo $i
done

printf "Item at index 2: "
echo ${fruits[2]}
printf "\nRemoving item at index 2...\n"
unset fruits[2]
for i in ${fruits[@]}; do
	echo $i
done

vegetables=('Lettuce' 'Cabbage' 'Spinach')

printf "\nPrinting the vegetables array:\n"

for i in ${vegetables[@]}; do
	echo $i
done

printf "Concatenating the two arrays and printing them:\n\n"

fruits_and_vegetables=("${fruits[@]}" "${vegetables[@]}")

for i in ${fruits_and_vegetables[@]}; do
	echo $i
done
