# QuantumLang

**A native-first programming language and compiler platform for classical, systems, AI-oriented, embedded, and quantum computing.**

QuantumLang is designed around one central idea: advanced software should not have to choose between high-level expressiveness and direct, predictable machine execution.

The public repository contains the current QuantumLang compiler source and runtime foundation. The compiler is written in QuantumLang and is being developed toward complete self-hosting under the public executable name `qtlc`.

> **Project status:** QuantumLang is under active compiler development. It is not yet ready for production use.

## Vision

Modern computing is becoming heterogeneous. Applications increasingly combine CPUs, GPUs, accelerators, embedded devices, distributed systems, AI workloads, simulators, and emerging quantum hardware.

QuantumLang is being built as a unified language and compiler platform that can express these workloads without forcing every target through the same runtime, calling convention, memory model, or backend strategy.

```text
QuantumLang source
        ↓
Syntax and semantic analysis
        ↓
Typed high-level representation
        ↓
Optimized machine representation
        ↓
Native | Embedded | GPU | WebAssembly | Simulator | Quantum
```

One language should provide a consistent development model while allowing each backend to generate code that matches the actual target machine.

## Design Goals

QuantumLang is being designed for:

- native performance with inspectable and predictable lowering;
- strong static typing and compile-time diagnostics;
- direct control over memory, layout, ABI, machine, and backend behavior;
- concise high-level APIs without mandatory runtime-heavy abstractions;
- deterministic compilation and explicit subsystem ownership;
- safe systems programming with controlled low-level access;
- first-class classical and quantum programming concepts;
- modular compiler, runtime, library, package, and plugin architecture;
- native targeting across desktop, server, embedded, accelerator, and quantum environments;
- self-hosting as a practical proof of the language and toolchain.

The goal is not syntax alone. The goal is a complete programming platform where expressive source code can still lower into efficient, target-aware execution.

## Language Direction

QuantumLang combines systems-level control with an advanced API model.

Current language design areas include:

- `let` and `const` bindings;
- strong static and generic types;
- `Option<T>` and `Result<T, E>`;
- typed error propagation with `?`;
- typed recovery with `handle`;
- ownership, references, pointers, and deterministic resource cleanup;
- object and capability surfaces through `impl`, `impl view`, `context`, `extract`, and `extend`;
- explicit roles and visibility boundaries;
- generic extensions and variadic capability packs;
- direct native calls and low-level machine access;
- classical and quantum code within one compiler architecture.

Example error propagation:

```qn
pub build(body: WasmBody) -> Result<Executable, BuildError> {
    let code = Wasm32CodeImage.fromBody(body)?
    let linked = linker.link(code)?
    return Executable.from(linked)
}
```

Selective typed recovery:

```qn
pub build(body: WasmBody) -> Result<Executable, BuildError> {
    let code = Wasm32CodeImage.fromBody(body) handle {
        .MissingNameSection =>
            Wasm32CodeImage.fromBody(body.withGeneratedNames())?

        .Overflow(size) =>
            return BuildError.ImageTooLarge(size)
    }

    let linked = linker.link(code)?
    return Executable.from(linked)
}
```

## Classical and Quantum Computing

QuantumLang is not intended to be a classical-only language with quantum functionality added as an external afterthought.

Quantum concepts are designed to remain visible to the compiler so they can participate in:

- type checking;
- resource validation;
- effect analysis;
- circuit construction and transformation;
- simulation planning;
- backend selection;
- classical–quantum boundary checking;
- hardware-specific lowering and diagnostics.

The long-term model is hybrid:

```text
Classical control and systems code
                +
Quantum operations and circuit logic
                +
Target-aware compiler and runtime support
```

QuantumLang is also intended to support classical simulation and accelerator-backed development before large-scale quantum hardware becomes widely available.

## Compiler Architecture

The compiler is organized by ownership rather than by temporary implementation shortcuts.

Major areas currently include:

- source and package loading;
- lexer, parser, tokens, and AST;
- declaration and module ownership;
- name resolution and visibility;
- type checking, inference, generics, and ownership analysis;
- compile-time evaluation;
- high-level and middle-level intermediate representations;
- control-flow and optimization infrastructure;
- machine, ABI, layout, object, and target models;
- native and quantum backend planning;
- diagnostics, queries, storage, and incremental compilation direction;
- runtime and platform integration.

Public architecture overview:

```text
Source package
    ↓
Lexing and parsing
    ↓
Declarations, modules, and name resolution
    ↓
Type checking and semantic analysis
    ↓
HIR
    ↓
MIR
    ↓
Optimization and target lowering
    ↓
Native object code or specialized backend output
```

Detailed internal bootstrap and verification stages are intentionally treated as toolchain implementation details. The public compiler interface and final executable name are `qtlc`.

## Target Architecture

QuantumLang is designed as one language and toolchain with multiple native backends—not one generic machine model pretending every target is identical.

Planned target families include:

- Linux, Windows, and macOS;
- x86-64, ARM64, and RISC-V;
- embedded processors and microcontrollers;
- WebAssembly;
- GPU and accelerator execution;
- FPGA-oriented and specialized hardware workflows;
- quantum simulators;
- future quantum hardware backends.

Each target may define its own:

- ABI and calling conventions;
- instruction selection;
- register and stack strategy;
- startup code;
- memory model;
- linker layout;
- runtime profile;
- platform and device capabilities.

This allows small targets to use only what they need while hosted systems can use the complete platform.

## Platform Layers

The long-term QuantumLang ecosystem is divided into clear layers:

```text
compiler/   language analysis, IR, optimization, and code generation
runtime/    execution support required by generated programs
library/    core, allocation, and system-facing standard APIs
plugins/    compiler, backend, runtime, GPU, and quantum extensions
packages/   application-level libraries such as HTTP and databases
tools/      CLI, formatter, language server, test runner, package manager
```

The intended library ownership model is:

```text
library/core   allocation-free fundamental types and APIs
library/alloc  heap-backed containers and ownership facilities
library/std    filesystem, networking, process, thread, time, and platform APIs
```

Application protocols and faster-moving ecosystems—such as HTTP, WebSocket, database clients, web frameworks, and cloud integrations—are expected to live in external packages rather than permanently expanding the compiler or core library.

## Repository Layout

The current public repository primarily contains the compiler and runtime foundation:

```text
quantumlang/
├── compiler/
│   ├── backend/
│   ├── buildSystem/
│   ├── constEval/
│   ├── controlFlow/
│   ├── core/
│   ├── declaration/
│   ├── diagnostics/
│   ├── driver/
│   ├── frontend/
│   ├── hir/
│   ├── host/
│   ├── interface/
│   ├── layout/
│   ├── machine/
│   ├── mir/
│   ├── moduleSystem/
│   ├── monomorphize/
│   ├── nameResolve/
│   ├── optimize/
│   ├── package/
│   ├── platform/
│   ├── quantum/
│   ├── query/
│   ├── semantic/
│   ├── source/
│   ├── storage/
│   ├── syntax/
│   ├── tests/
│   └── typeSystem/
│
├── runtime/
├── .gitignore
└── readme.md
```

Some general-purpose foundations currently remain inside the compiler while the self-hosted compiler is being completed. They are expected to be separated into the final library layers when the compiler can build those layers independently.

## Current Development Focus

The current work is focused on strengthening the compiler foundation rather than presenting unfinished components as stable releases.

Primary areas include:

- completing semantic and type-system ownership;
- strengthening roles, extensions, capabilities, and object surfaces;
- advancing HIR and MIR lowering;
- completing native object emission and linking;
- stabilizing runtime boundaries;
- separating reusable core and allocation facilities from compiler-specific support;
- improving deterministic queries, storage, and incremental products;
- expanding quantum IR, verification, simulation, and backend architecture;
- preparing the public `qtlc` toolchain for reproducible releases.

## Build Status

The repository is currently a development repository. Public binary releases and complete end-user build instructions will be published when the self-hosted toolchain reaches a supported milestone.

The intended user-facing command model is:

```bash
qtlc check .
qtlc build .
qtlc test .
qtlc run .
```

These commands describe the stable toolchain interface being developed; availability may vary while the compiler is under active construction.

## Quality Principles

QuantumLang development follows several core rules:

- do not hide incomplete semantics behind silent fallback behavior;
- keep major compiler concepts under one explicit owner;
- preserve deterministic and indexed hot paths;
- separate public language design from temporary bootstrap constraints;
- keep low-level behavior inspectable;
- avoid forcing every target through one universal runtime strategy;
- keep general-purpose APIs outside compiler-specific ownership when the library layer is ready;
- keep direct calls eligible for direct native lowering;
- separate positive tests, expected-failure tests, and design-only material;
- optimize for correctness, clarity, performance, and long-term maintainability together.

## Project Status

QuantumLang is experimental and evolving rapidly.

The repository should currently be viewed as:

- an active compiler implementation;
- a public record of language and toolchain development;
- a foundation for future native and quantum programming infrastructure;
- not yet a production-supported compiler distribution.

APIs, syntax, internal modules, and build behavior may change before the first supported release.

## Security

Please do not report security-sensitive issues through a public discussion or issue containing exploit details.

A dedicated security policy and private reporting process will be published as the project approaches supported releases.

Until then, security-related contact can be initiated through the repository owner without disclosing sensitive technical details publicly.

## Contributing

The contribution model is still being prepared.

Before submitting major code or architectural changes, open a focused discussion describing:

- the problem being solved;
- the affected compiler or runtime ownership area;
- expected language or ABI impact;
- test strategy;
- performance and compatibility considerations.

Large changes should not introduce parallel ownership models or temporary fallback behavior that weakens the language design.

## License

The final licensing model has not yet been published.

Unless and until an explicit license is added, no permission is granted to copy, modify, redistribute, sublicense, or commercially use the source code beyond rights provided directly by applicable law and GitHub's Terms of Service.

QuantumLang, QTLang, `qtlc`, Quantum Technology, and associated names and logos may be subject to separate trademark and branding policies.

## Links

- Repository: <https://github.com/qtlang/quantumlang>
- Compiler executable: `qtlc`
- Source extension: `.qn`

## One-Line Summary

**QuantumLang is a native-first, self-hosting classical-plus-quantum programming language where high-level APIs, systems control, target-aware compilation, and future quantum execution are designed as one platform.**

