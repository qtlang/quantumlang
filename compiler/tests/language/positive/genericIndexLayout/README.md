# Generic Index Layout

This positive fixture locks the complete target-directed generic `Index<K, V>`
surface.

Covered forms:

- explicit generic constructor and factory calls
- omitted owner generics resolved from a variable target
- omitted nested `Range<T>` generics resolved from constructor parameters
- explicit outer owner with inferred nested owners
- target-typed nested object literals
- mixed constructor and object literals
- named generic object literals
- range-expression literals in generic fields and constructor arguments
- static factory inference from a target type
- return-context inference
- parameter-context inference
- named constructor arguments
- generic function parameter inference
- primitive, wide integer, and aggregate type arguments

The companion negative fixture is
`../../negative/genericIndexInferenceAmbiguous`. It locks rejection when neither
an explicit generic list nor a target/argument context can determine `K` and
`V`.
