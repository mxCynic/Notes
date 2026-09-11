
## Send
4种Cell都是Send的，只要内部的T是Send

## Sync
只有OnceCell<T>是Sync的，如果内部的T是Sync，
其他3种都是不Sync的