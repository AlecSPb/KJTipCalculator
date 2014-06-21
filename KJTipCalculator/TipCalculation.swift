/*
Copyright (c) 2014 Kristopher Johnson

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

// Given subtotal, tip percentage, and number in party, calculates tip, total, and per-person split
struct TipCalculation {
    var subtotal: Double
    var tipPercentage: Int
    var numberInParty: Int
    var tip: Double
    var total: Double
    var perPerson: Double
    
    init(subtotal: Double, tipPercentage: Int, numberInParty: Int) {
        assert(numberInParty > 0)
        
        self.subtotal = subtotal
        self.tipPercentage = tipPercentage
        self.numberInParty = numberInParty
        
        tip = (Double(tipPercentage) * 0.01) * subtotal
        total = subtotal + tip
        perPerson = total / Double(numberInParty)
    }
}