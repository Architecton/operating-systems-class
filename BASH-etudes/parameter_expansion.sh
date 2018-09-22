name="John"
echo ${name}
echo ${name/J/j}    #=> "john" (substitution: J -> j)
echo ${name:0:2}    #=> "jo" (string from 0th position until length 2)
echo ${name::2}     #=> "jo" (slicing from beginning until length 2)
echo ${name::-1}    #=> "joh" (slicing) (From beginning to one position less than end)
echo ${food:-Cake}  #=> $food or "Cake" as default value

length=2
echo ${name:0:length}  #=> "jo" - similar as some examples above

#See: Parameter expansion


STR="/path/to/foo.cpp"
echo ${STR%.cpp}    # /path/to/foo - remove suffix .cpp
echo ${STR%.cpp}.o  # /path/to/foo.o - remove suffix .cpp and add suffix .o

echo ${STR##*.}     # cpp (extension) - print substring after last '.'
echo ${STR##*/}     # foo.cpp (basepath) - print substring after last '/'

echo ${STR#*/}      # path/to/foo.cpp - substring after first '/'
echo ${STR##*/}     # foo.cpp - substring after last '/'

echo ${STR/foo/bar} # /path/to/bar.cpp - replace substring foo with bar
STR="Hello world"
echo ${STR:6:5}   # "world" - substring from 6th position until length 5
echo ${STR:-5:5}  # "world" - substring from 5 position from end until length 5
SRC="/path/to/foo.cpp"
BASE=${STR##*/}   #=> "foo.cpp" (basepath - substring from last /)
DIR=${SRC%$BASE}  #=> "/path/to" (dirpath - substring without suffix stored in BASE)