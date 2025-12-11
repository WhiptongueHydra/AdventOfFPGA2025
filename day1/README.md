# This days challenge
https://adventofcode.com/2025/day/1
- instructions.txt file is the generated test input from the website for me to genererate a solution from 

## Note on cheating
- I was going to open the raw instruction file in VHDL, convert all R's -> +'s and L's to -'s so they can be treated as integers, but I got fed up fucking about with file IO stuff and just cleaned the file with:

    ```sed -i 's/R/+/g' instructions.txt```
  
    ```sed -i 's/L/-/g' instructions.txt```

- I was also going to cycle through the file to count the number of instructions and use this to populate the generics for it all to be nice and automated, but this was a ballache also so just did:

    wc -l instructions.txt

  and input the number it spat out to a constant in the final TB which populates generics. So not completely hardcoded but not as smooth as I imagined.
