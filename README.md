# calculator

basic calculator using flutter framework

## Documentation

- we have put the design and logic code in a stateful class Calculator.
- We have two displays: One to display the expression and the second to display the result
- You can see that we used GridView Widget and give it 4 for crossAxisCount to make 4 buttons in a
  row
- Normal buttons (Numbers) when one clicks them just show out the number
- Backspace button delete the last character from the expression
- 'C' button erase all content on the screen
- '()' button to surround a particular equation with a practices
- operation buttons '+' '-' '×' '÷' used to do the basic operations by adding the operation to the
  display string and use a third party library to parse and calculate the result of that string when
  pressing '=' button