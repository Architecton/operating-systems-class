# Go over [1, 5]
for i in {1..5}; do
	echo "Welcome $i"
done

printf "\nWith steps... \n\n"

# Go over [5, 50] in steps of 5
for i in {5..50..5}; do
    echo "Welcome $i"
done