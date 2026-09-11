标记某个数据，保证他在内存中的值不会被移动，他的引用，指向他的指针，都能保证能找到这个值。

## what is pinning
We say that a value has been pinned when it has been put into a state where it is guaranteed to remain located at the same place in memory from the time it is pinned until its drop is called.
这是标准库中的说法，我的理解是，从一个值被声明为pin到这个值被drop，它都存在在内存中的同一个位置。

## Using Pin< Ptr> to pin values

Notice that the thing wrapped by Pin is not the value which we want to pin itself, but rather a pointer to that value! A Pin< Ptr> does not pin the Ptr; instead, it pins the pointer’s pointee value.  
这也是标准库中的说法，实际上是说在用Pin时，是用Pin包裹值一个指针类型(Box等).同时约束的是指针类型指向的值，约束他们在被drop前不会移动。

## A self-referential struct

自引用类型，某一个字段会被另一个字段引用的struct
```
/// This is a self-referential struct because `self.slice` points into `self.data`.
struct Unmovable {
    /// Backing buffer.
    data: [u8; 64],
    /// Points at `self.data` which we know is itself non-null. Raw pointer because we can't do
    /// this with a normal reference.
    slice: NonNull<[u8]>,
    /// Suppress `Unpin` so that this cannot be moved out of a `Pin` once constructed.
    _pin: PhantomPinned,
}

impl Unmovable {
    /// Creates a new `Unmovable`.
    ///
    /// To ensure the data doesn't move we place it on the heap behind a pinning Box.
    /// Note that the data is pinned, but the `Pin<Box<Self>>` which is pinning it can
    /// itself still be moved. This is important because it means we can return the pinning
    /// pointer from the function, which is itself a kind of move!
    fn new() -> Pin<Box<Self>> {
        let res = Unmovable {
            data: [0; 64],
            // We only create the pointer once the data is in place
            // otherwise it will have already moved before we even started.
            slice: NonNull::from(&[]),
            _pin: PhantomPinned,
        };
        // First we put the data in a box, which will be its final resting place
        let mut boxed = Box::new(res);

        // Then we make the slice field point to the proper part of that boxed data.
        // From now on we need to make sure we don't move the boxed data.
        boxed.slice = NonNull::from(&boxed.data);

        // To do that, we pin the data in place by pointing to it with a pinning
        // (`Pin`-wrapped) pointer.
        //
        // `Box::into_pin` makes existing `Box` pin the data in-place without moving it,
        // so we can safely do this now *after* inserting the slice pointer above, but we have
        // to take care that we haven't performed any other semantic moves of `res` in between.
        let pin = Box::into_pin(boxed);

        // Now we can return the pinned (through a pinning Box) data
        pin
    }
}
```
这个代码中一个Unmovable的值，他的slice字段引用了data字段的值