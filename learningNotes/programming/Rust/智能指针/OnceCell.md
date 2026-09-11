只能设置一次值的Cell

获取值和Cell一样是get

他的set和Cell的set有所不同，
```Rust
use std::cell::OnceCell;

let cell = OnceCell::new();
assert!(cell.get().is_none());

assert_eq!(cell.set(92), Ok(()));
assert_eq!(cell.set(62), Err(62));

assert!(cell.get().is_some());
```

可以在设置值失败时获得旧值，try_insert方法
```Rust 
#![feature(once_cell_try_insert)]

use std::cell::OnceCell;

let cell = OnceCell::new();
assert!(cell.get().is_none());

assert_eq!(cell.try_insert(92), Ok(&92));
assert_eq!(cell.try_insert(62), Err((&92, 62)));

assert!(cell.get().is_some());
```

