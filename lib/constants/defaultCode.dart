const DEFAULT_CODE = {
  "c": '''#include <stdio.h>
int main() {
  //code
  return 0;
}''',
  "cpp": '''#include <iostream>
using namespace std;
int main() {
  //code
  return 0;
}''',
  'go': '''func main() {
  fmt.Printf("Hello World!")
}''',
  'js': '''(function main() {
  console.log('Hello World!');
}());''',
  'ruby': '''#!/usr/bin/env ruby
puts "Hello World!"''',
  'bash': '''echo 'Hello World!''',
  "rust": '''fn main() {
    println!("Hello World!");
}''',
  "java": '''/*package whatever //do not write package name here */
import java.io.*;
class GFG {
	public static void main (String[] args) {
		System.out.println("CODE BUDDY!!!!");
	}
}''',
  "python": '''#code
print("CODE BUDDY!!!")''',
  "php": '''echo "Hello world";''',
  "scala": '''object Main {
	def main(args: Array[String]) {
		//Code
	}
}''',
  "cs": '''using System;
public class GFG{
	static public void Main (){
		//Code
	}
}'''
};
