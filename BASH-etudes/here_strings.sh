echo "hello world" | read first second
echo $second $first

# The output of the 2nd echo command a single space. 
# Whaaaa? What happened # to my variables? 
# Because the read command is in a pipeline, it is run in a subshell. 
# It correctly reads 2 words from its stdin and assigns to the variables. 
# But then the command completes, the subshell exits and the 
# variables are lost.

# Sometimes you can work around this with braces:

echo "hello world" | {
    read first second
    echo $second $first
}

# That's OK if your need for the values is contained, 
# but you still don't have those variables in the current shell of your script. 
# To remedy this confusing situation, use a here-string

read first second <<< "hello world"
echo $second $first