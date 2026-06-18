# Question 2 - CPS
## 2a
A procedure `func` of type `[A1 *...*AN -> T | 'fail]` and its Success-Fail-Continuations 
version `func$` of type `[A1 *...*AN * [T->T1] * [Empty->T2]  -> T1|T2]` are equivalent iff for every valid sequence `x1,...,xn` and any continuation functions `success` and `fail`:

1. `(func x1...xn)` will terminate and return value `res` &ne; `'fail` &iff; `(func$ x1...xn success fail)` results in the evaluation of `(success res)`

2. `(func x1...xn)` will terminate and return `'fail` &iff; `(func$ x1...xn success fail)` results in the evaluation of `(fail)`.

3. `(func x1...xn)` does not terminate &iff; `(func$ x1...xn success fail)` does not terminate.


## 2d
We will prove get-value and get-value$ equivalence using induction on `n = len(assoc-list)`
### Base
On `n=0`, `(empty? assoc-list)` evaluates to `true`. Therefore, `get-value` will terminate and return `'fail`, and `get-value$` will evaluate `(fail)`.

### Proposition
For every `n > 0`, we will assume that for every `assoc-list` with `len(assoc-list) = n`, `get-value` and `get-value$` are equivalent.

### Induction step
We will proof that `(get-value assoc-list key)` and `(get-value$ assoc-list key success fail)` are equivalent for `assoc-list` with `len(assoc-list) = n+1`.

For easier reading, we will refer `(get-value assoc-list key)` as `get-value` and `(get-value$ assoc-list key success fail)` as `get-value$`.


`len(assoc-list) > 0`, therefore, `get-value` will evaluate to
```scheme
(if (eq? key (car (car assoc-list)))
    (cdr (car assoc-list))
    (get-value (cdr assoc-list) key)
)
```
and `get-value$` will evaluate to
```scheme
(if (eq? key (car (car assoc-list)))
    (success (cdr (car assoc-list)))
    (get-value$ (cdr assoc-list) key success fail)
)
```

#### Case 1: `eq? key (car (car assoc-list))` evaluates to `#t`
In this case, `get-value` will evaluate to `(cdr (car assoc-list))`, and `get-value$` will evaluate to `(success (cdr (car assoc-list)))`. Therefore, they are equivalent.

#### Case 2: `eq? key (car (car assoc-list))` evaluates to `#f`
Here, `get-value` will return the evaluation of `(get-value (cdr assoc-list) key)`, and `get-value$` will evaluate `(get-value$ (cdr assoc-list) key success fail)`.

Assume the induction hypothesis for `(cdr assoc-list)`, with length `n`, meaning that `(get-value (cdr assoc-list) key)` and `(get-value$ (cdr assoc-list) key success fail)` are equivalent. Therefore, `get-value` and `get-value$` are equivalent.