# Subscribe Code Challenge

Instructions: [challenge.md](https://github.com/DeborahWatanabe/subscribe-challenge-2/blob/main/challenge.md)

## Dependencies

* Ruby: 3.2.2

## How to run

Go to `lib` folder, then run it:
```
ruby receipt_calculator.rb
```

Then it will print:
```
Welcome to the receipt calculator!
Please, input the products in the format "<amount> <product name> at <price>".
Input one product per row or enter a blank row to finish.
```

Input a list of products, for example:
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

Press enter, then it will return the receipt's details.
```
Your receipt:
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

## How to test

```
bundle e rspec
```