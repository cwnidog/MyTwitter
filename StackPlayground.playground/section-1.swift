// Playground - noun: a place where people can play

import UIKit

class StringStack {
  var elements = [String]()
  
  func push(newElement: String) {
    
    // just tack the new element onto the end of the e;lements array
    self.elements.append(newElement)
  } // end push()
  
  // pop the last element from the stack, if there is one
  func pop() -> String? {
    
    // if there are elements on that stack, return it
    if !self.elements.isEmpty {
      let element = self.elements.last
      self.elements.removeLast()
      return element! // unwrap
    }
      // otherwise, return nil
    else {
      return nil
    }
  } // pop()
  
  // return a copy of the last element from the stack for inspection, if there is one. The element remains on the stack.
  func inspect() -> String? {
    
    // if there are elemts onthe stack, return a copy of the last
    if !self.elements.isEmpty {
      return elements.last
    }
    // otherwise, return nil
    else {
      return nil
    }
  } // inspect
} // end Stack

let bobString = "Bob"
let carolString = "Carol"
let tedString = "Ted"
let aliceString = "Alice"

var testString = ""
var sampleStack = StringStack()

sampleStack.push(bobString)
sampleStack.push(carolString)
sampleStack.push(tedString)
sampleStack.push(aliceString)

println(sampleStack.inspect()!)
println(sampleStack.pop()!)
println(sampleStack.inspect()!)
sampleStack.pop()
println(sampleStack.inspect()!)
sampleStack.push(aliceString)



