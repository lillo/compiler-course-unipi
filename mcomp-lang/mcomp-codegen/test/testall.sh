#!/usr/bin/env bash

testfolder="samples"
cwd=`pwd`
files="test-array1.mc test-array2.mc test-array3.mc test-array4.mc test-array5.mc test-array6.mc test-array7.mc test-return1.mc test-return2.mc test-return3.mc test-ptr1.mc test-ptr2.mc test-ptr3.mc \
test-add1.mc test-arith1.mc test-arith2.mc test-arith3.mc test-fib.mc test-for1.mc \
test-for2.mc test-func1.mc test-func2.mc test-func3.mc test-func4.mc test-func5.mc \
test-func6.mc test-func7.mc test-func8.mc test-gcd2.mc test-gcd.mc test-global1.mc test-global2.mc test-global3.mc test-global4.mc test-hello.mc \
test-if1.mc test-if2.mc test-if3.mc test-if4.mc test-if5.mc test-if6.mc test-local1.mc test-local2.mc test-ops1.mc test-ops2.mc \
test-var1.mc test-var2.mc test-while1.mc test-while2.mc test-ex1.mc test-ex2.mc test-ex3.mc test-ex4.mc test-ex5.mc test-ex6.mc test-ex8.mc test-ex9.mc test-ex10.mc test-ex11.mc test-ex11count.mc \
test-ex12.mc test-ex13.mc test-ex14.mc test-ex15.mc test-ex16.mc test-ex17.mc test-ex18.mc \
test-ex19.mc test-ex20.mc test-ex21.mc test-ex22.mc test-ex23.mc test-ex24.mc test-ex25.mc \
test-sort1.mc test-sort2.mc test-sort3.mc test-sort4.mc"

files=$(cd $testfolder; ls test-*.mc)


cd $testfolder
for f in $files; do
    name=${f%*.mc}
    echo -ne "Testing $f: "
    if [ -f "$name.out" ]; then
        dune exec ../../bin/mcompc.exe -- $f -O -o $name.bc 2> /dev/null > /dev/null
        if [ $? != 0 ]; then
          echo "compilation error"
          break
        else
          clang $name.bc ../../bin/rt-support.c -o $name 2> comp-$name.out
          if [ $? != 0 ]; then
            echo "clang error"
            break
          fi
          ./$name > result-$name.out
          diff result-$name.out $name.out
          if [ $? != 0 ]; then
            echo "execution error"
            break
          else
            echo "OK"
            rm $name $name.bc result-$name.out comp-$name.out
          fi
        fi
    fi
done

cd $cwd
