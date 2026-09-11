将借用规则延迟到运行时，违反[借用规则](借用规则.md)

借用的方法是borrow()和borrow_mut()

其中borrow_mut()可以在只有不可变借用时改变值
```Rust
    pub const fn borrow_mut(&self) -> RefMut<'_, T> {
    }
```
