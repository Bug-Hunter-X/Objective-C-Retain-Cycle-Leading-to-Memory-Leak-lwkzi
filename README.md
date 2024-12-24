# Objective-C Retain Cycle Bug

This repository demonstrates a common Objective-C retain cycle bug that leads to memory leaks.  A `MyViewController` creates a `MyObject`, and sets itself as the delegate. If `MyObject` holds a strong reference to its delegate, a retain cycle occurs, preventing both objects from being deallocated.

## How to Reproduce

1. Clone the repository.
2. Open the project in Xcode.
3. Run the application.
4. Observe that `MyViewController`'s `dealloc` method is never called, indicating a memory leak.

## Solution

The solution involves breaking the retain cycle by using a `weak` property for the delegate in `MyObject`. This ensures that the delegate isn't retained, thus allowing for proper deallocation.

## Learning Points

This example highlights the importance of understanding and carefully managing object lifecycles and memory in Objective-C.  Proper use of `weak` references and understanding the implications of strong references are crucial in preventing retain cycles and ensuring efficient memory management.