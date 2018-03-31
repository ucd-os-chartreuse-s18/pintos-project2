
func () {
  echo This is a function.
}

if $func ; then
  echo This is not a function.
fi

if [ $func ]; then
  echo This is also not a function.
fi

VAR=$func #return types are not a thing
if [ $VAR ]; then
  echo $VAR and VAR
fi

func

if func ; then #runs the function so that echo executes
  echo This is the 4th statement.
fi

if [ func ]; then #this results to "true". based on what?
  echo This is the 5th statement.
fi