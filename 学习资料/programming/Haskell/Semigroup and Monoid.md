First,Semigroup is Super Class of Monoid,
## Semigruop
from WIkipedia:
A semigroup is a set S together with a binary operation ⋅ (that is, a function ⋅ : S × S → S) that satisfies the associative property:
For all a, b, c ∈ S, the equation (a ⋅ b) ⋅ c = a ⋅ (b ⋅ c) holds.
More succinctly, a semigroup is an associative magma.
在这里最重要的是结合律,开发者实现一个 `Semigroup` 实例时，他们需要遵循结合律的约定。虽然 Haskell 编译器不会强制执行这一点，但实现者必须对这个约定负责。比如，如果一个类型的 `Semigroup` 实例不遵循结合律，那么这个实例的行为就可能是意外和不一致的。

## Monoid
from wikipedia:
A [set](https://en.wikipedia.org/wiki/Set_(mathematics) "Set (mathematics)") _S_ equipped with a [binary operation](https://en.wikipedia.org/wiki/Binary_operation "Binary operation") _S_ × _S_ → _S_, which we will denote •, is a **monoid** if it satisfies the following two axioms:

Associativity

For all _a_, _b_ and _c_ in _S_, the equation (_a_ • _b_) • _c_ = _a_ • (_b_ • _c_) holds.

Identity element

There exists an element _e_ in _S_ such that for every element _a_ in _S_, the equalities _e_ • _a_ = _a_ and _a_ • _e_ = _a_ hold.

## minimal complete definition 
```
instance Semigroup Foo where
  (<>) = …
  
-- 一个Monoid就是一个Semigroup，因此不需要限制Foo是一个Semigroup
instance Monoid Foo where 
  mempty = …
```
一个Monoid的乘法运算就是对应的Semigroup的乘法运算，因此不需要重复定义
