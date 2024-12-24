The solution is to declare the delegate property in `MyObject` as `weak`:

```objectivec
@interface MyObject : NSObject
@property (nonatomic, weak) id <MyObjectDelegate> delegate; //Changed to weak
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
    self.myObject.delegate = self;
}

- (void)myObjectDidSomething:(MyObject *)sender {
    // Handle event
}
- (void)dealloc {
    NSLog (@"MyViewController Dealloc");
}
@end
```
By using `weak`, `MyObject` no longer retains a strong reference to its delegate, breaking the retain cycle. Now, when `MyViewController` is deallocated, `MyObject` will also be deallocated correctly.