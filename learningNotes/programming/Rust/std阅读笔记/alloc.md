内存分配api 
有一个unsafe GlobalAlloc tarit，
可以用实现该tarit的空struct来自定义一个global allocator
```
unsafe impl GlobalAlloc for MyAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        unsafe { System.alloc(layout) }
    }

    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        unsafe { System.dealloc(ptr, layout) }
    }
}
```

然后用#[global_allocator]定义一个该类型的静态值
```
#[global_allocator]
static GLOBAL: MyAllocator = MyAllocator;
```

