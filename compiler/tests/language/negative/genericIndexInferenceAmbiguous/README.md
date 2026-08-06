# Ambiguous Generic Index Inference

Expected result: typecheck failure.

`Index(Range(4, 3), Range(4, 3))` contains no type evidence for `K` or `V`.
The diagnostic must be the central generic-inference mismatch diagnostic and
must require either:

```qn
let rows: Index<Key, Value> =
  Index(Range(4, 3), Range(4, 3))
```

or:

```qn
let rows =
  Index<Key, Value>(Range(4, 3), Range(4, 3))
```

This fixture succeeding is a compiler soundness failure. Generic constructor
lookup may admit omitted generic arguments as an inference opportunity, but
final call resolution must reject the call when concrete substitutions were
not produced.
