用于dny和类型反射。Any是一个tarit

```
pub trait Any: 'static {
    // Required method
    fn type_id(&self) -> TypeId;
}
```
