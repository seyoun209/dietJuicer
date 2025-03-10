#!/bin/bash
##########
#The MIT License (MIT)
#
# Copyright (c) 2015 Aiden Lab
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
##########
#
# Small helper script to count reads with ligation junction
# Juicer version 1.5

gunzip -c $R1 | grep -n $ligation | cut -f1 -d : > $temp;
gunzip -c $R2 | grep -n $ligation | cut -f1 -d : >> $temp;
num1=$(sort $temp | uniq | wc -l | awk '{{print $1}}');
num2=$(gunzip -c $R1 | wc -l | awk '{{print $1}}');

echo -ne "$num1 " > $res;
echo "$num2" > $linecount;

# num1=$(paste <(gunzip -c $R1) <(gunzip -c $R2) | grep -cE $ligation)
# num2=$(gunzip -c $R1 | wc -l | awk '{{print $1}}')

# echo -ne "$num1 " > $res;
# echo "$num2" > $linecount;
