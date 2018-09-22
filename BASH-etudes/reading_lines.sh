# Pipe stdout of cat to stdin of read.
# While read returns status 0 (succesfuly ready) perform loop
cat file.txt | while read line; do
	echo $line
done