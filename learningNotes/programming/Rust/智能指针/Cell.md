Shareable mutable containers.
可共享的可变容器，
他的作用是能够在多出地方更改这个值

有一个set方法，可以把改变内部的值，但是本质上是replace了值，
``` Rust 
    pub fn set(&self, val: T) {
        self.replace(val);
    }

```
在replace的同时，也丢弃了原值

这是一个Send & !Sync的类型，比较特殊