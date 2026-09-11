对于普通的#[tokio::main]宏，
```
#[tokio::main]
async fn main() {
    println!("Hello world");
}
```
它会等价于
```
fn main() {
    tokio::runtime::Builder::new_multi_thread()
        .enable_all()
        .build()
        .unwrap()
        .block_on(async {
            println!("Hello world");
        })
}
```
他还能设置单线程模式
```
#[tokio::main(flavor = "current_thread")]
```
设置工作线程数量
```
#[tokio::main(worker_threads = n)]
```
