/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any peon obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit peons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package lady.display;

import lady.renoise.Renoise;

class Text
{
    static function cleanString(input :String) : String
    {
        var length = input.length;
        var index = 0;
        var output = "";
        while(index < length) {
            var code = input.charCodeAt(index);
            if((code > 47 && code < 59) || code == 95 || code == 32 || code == 35 || code == 45 || code == 46 || code == 124 || (code > 96 && code < 123)) {
                output += input.charAt(index);
            }
            index++;
        }
        return output;
    }

    public static function make(text :String) : Array<Array<Int>>
    {
        var filteredText = cleanString(text.toLowerCase());

        var x = 0;
        var data = [[],[],[],[],[],[],[],[]];
        for(textIndex in 0...filteredText.length) {
            var letter = filteredText.charAt(textIndex);
            var dataIndex = 0;
            for(line in alphabet[letter]) {
                var letterIndex = 0;
                for(val in line) {
                    data[dataIndex][letterIndex + x] = val;
                    letterIndex++;
                }
                dataIndex++;
            }
            x += alphabet[letter][0].length;
        }

        return data;
    }

    public static var alphabet = [
        " " => [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0]
        ],
        "." => [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,0,0,0],
            [0,0,0,0,0,0],
        ],
        "-" => [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [1,1,1,1,1,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ],
        "#" => [
            [0,1,0,1,0,0],
            [0,1,0,1,0,0],
            [1,1,1,1,1,0],
            [0,1,0,1,0,0],
            [1,1,1,1,1,0],
            [0,1,0,1,0,0],
            [0,1,0,1,0,0],
            [0,0,0,0,0,0],
        ],
        "|" => [
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,0,0,0,0],
        ],
        "a" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,1,1,1,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "b" => [
            [1,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "c" => [
            [0,0,1,1,1,0],
            [0,1,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [0,1,0,0,0,0],
            [0,0,1,1,1,0],
            [0,0,0,0,0,0],
        ],
        "d" => [
            [1,1,1,0,0,0],
            [1,0,0,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,1,0,0],
            [1,1,1,0,0,0],
            [0,0,0,0,0,0],
        ],
        "e" => [
            [1,1,1,1,1,0],
            [1,0,0,0,0,0],
            [1,1,1,1,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,1,1,1,1,0],
            [0,0,0,0,0,0],
        ],
        "f" => [
            [1,1,1,1,1,0],
            [1,0,0,0,0,0],
            [1,1,1,1,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [0,0,0,0,0,0],
        ],
        "g" => [
            [0,1,1,1,1,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,1,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "h" => [
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,1,1,1,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "i" => [
            [1,1,1,1,1,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [1,1,1,1,1,0],
            [0,0,0,0,0,0],
        ],
        "j" => [
            [0,0,0,1,1,0],
            [0,0,0,0,1,0],
            [0,0,0,0,1,0],
            [0,0,0,0,1,0],
            [0,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "k" => [
            [1,0,0,0,1,0],
            [1,0,0,1,0,0],
            [1,0,1,0,0,0],
            [1,1,0,0,0,0],
            [1,0,1,0,0,0],
            [1,0,0,1,0,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "l" => [
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,1,1,1,1,0],
            [0,0,0,0,0,0],
        ],
        "m" => [
            [1,0,0,0,1,0],
            [1,1,0,1,1,0],
            [1,0,1,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "n" => [
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,1,0,0,1,0],
            [1,0,1,0,1,0],
            [1,0,0,1,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "o" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "p" => [
            [1,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,1,1,1,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [0,0,0,0,0,0],
        ],
        "q" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,1,0,1,0],
            [1,0,0,1,0,0],
            [0,1,1,0,1,0],
            [0,0,0,0,0,0],
        ],
        "r" => [
            [1,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,1,1,1,0,0],
            [1,0,0,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "s" => [
            [0,1,1,1,1,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [0,1,1,1,0,0],
            [0,0,0,0,1,0],
            [0,0,0,0,1,0],
            [1,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "t" => [
            [1,1,1,1,1,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,0,0,0,0],
        ],
        "u" => [
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "v" => [
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,0,1,0,0],
            [0,1,0,1,0,0],
            [0,0,1,0,0,0],
            [0,0,0,0,0,0],
        ],
        "w" => [
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,1,0,1,0],
            [1,1,0,1,1,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "x" => [
            [1,0,0,0,1,0],
            [0,1,0,1,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,1,0,1,0,0],
            [0,1,0,1,0,0],
            [1,0,0,0,1,0],
            [0,0,0,0,0,0],
        ],
        "y" => [
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,0,1,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,1,0,0,0],
            [0,0,0,0,0,0],
        ],
        "z" => [
            [1,1,1,1,1,0],
            [0,0,0,0,1,0],
            [0,0,0,1,0,0],
            [0,0,1,0,0,0],
            [0,1,0,0,0,0],
            [1,0,0,0,0,0],
            [1,1,1,1,1,0],
            [0,0,0,0,0,0],
        ],
        "1" => [
            [0,0,0,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,1,0,0],
            [0,0,0,1,0,0],
            [0,0,0,1,0,0],
            [0,0,0,1,0,0],
            [0,0,1,1,1,0],
            [0,0,0,0,0,0],
        ],
        "2" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [0,0,0,1,0,0],
            [0,0,1,0,0,0],
            [0,1,0,0,0,0],
            [1,0,0,0,0,0],
            [1,1,1,1,1,0],
            [0,0,0,0,0,0],
        ],
        "3" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [0,0,0,0,1,0],
            [0,0,1,1,0,0],
            [0,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "4" => [
            [0,0,0,1,0,0],
            [0,0,1,1,0,0],
            [0,1,0,1,0,0],
            [1,0,0,1,0,0],
            [1,1,1,1,1,0],
            [0,0,0,1,0,0],
            [0,0,0,1,0,0],
            [0,0,0,0,0,0],
        ],
        "5" => [
            [1,1,1,1,1,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [1,1,1,1,0,0],
            [0,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "6" => [
            [0,0,1,1,0,0],
            [0,1,0,0,0,0],
            [1,0,0,0,0,0],
            [1,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "7" => [
            [1,1,1,1,1,0],
            [0,0,0,0,1,0],
            [0,0,0,1,0,0],
            [0,0,1,0,0,0],
            [0,1,0,0,0,0],
            [1,0,0,0,0,0],
            [1,0,0,0,0,0],
            [0,0,0,0,0,0],
        ],
        "8" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        "9" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,1,0],
            [0,0,0,0,1,0],
            [0,0,0,1,0,0],
            [0,1,1,0,0,0],
            [0,0,0,0,0,0],
        ],
        "0" => [
            [0,1,1,1,0,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,0,1,0],
            [0,1,1,1,0,0],
            [0,0,0,0,0,0],
        ],
        ":" => [
            [0,0,0,0,0,0],
            [1,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [1,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ],
        "_" => [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [1,1,1,1,1,0],
            [0,0,0,0,0,0],
        ]
    ];
}