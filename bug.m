In Objective-C, a common yet subtle issue arises when dealing with memory management and object lifecycles, especially when using delegates or blocks.  Consider this scenario: a view controller (A) creates a custom object (B) and sets itself as the delegate of B.  If B retains a strong reference to A (a common practice via the delegate property), and A doesn't explicitly release B when it's done with it, a retain cycle is created. This leads to memory leaks, where neither A nor B can be deallocated. 

Example:

```objectivec
@interface MyObject : NSObject
@property (nonatomic, weak) id <MyObjectDelegate> delegate;
@end

@protocol MyObjectDelegate <NSObject>
- (void)myObjectDidSomething:(MyObject *)sender;
@end

@interface MyViewController : UIViewController <MyObjectDelegate>
@property (nonatomic, strong) MyObject *myObject;
@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myObject = [[MyObject alloc] init];
    self.myObject.delegate = self; //Retain cycle potential here if MyObject holds a strong reference to its delegate
}

- (void)myObjectDidSomething:(MyObject *)sender {
    // Handle event
}

- (void)dealloc {
    NSLog (@"MyViewController Dealloc");
}
@end
```