# function that echoes a string
get_name() {
  echo "John"
  # return status
  return 42
}

# Catch echo in variable. Last return status is stored in variable $?.
echo "You are $(get_name) and last return status is ${?}."
