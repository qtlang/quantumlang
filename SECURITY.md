# Security Policy

QuantumLang takes security reports seriously.

QuantumLang is currently under active compiler and runtime development. The
project has not yet reached a stable production release, and its public APIs,
binary formats, runtime behavior, and security guarantees may change.

## Supported Versions

Security fixes are currently applied only to the latest revision of the
`main` branch.

| Version | Supported |
| --- | --- |
| Latest `main` revision | Yes |
| Older commits, forks, and unofficial builds | No |
| Unreleased development snapshots | Best effort |

Until QuantumLang publishes its first supported release, no compatibility or
long-term security support is promised for historical revisions.

## Reporting a Vulnerability

Please do not open a public GitHub issue, discussion, pull request, or social
media post for a suspected security vulnerability.

Use GitHub's private vulnerability reporting feature for this repository:

1. Open the QuantumLang repository on GitHub.
2. Select **Security**.
3. Select **Report a vulnerability**.
4. Submit the report privately with the requested technical details.

Repository:

`https://github.com/qtlang/quantumlang`

If private vulnerability reporting is temporarily unavailable, contact the
repository owner privately through the verified contact method shown on the
QuantumLang GitHub organization or project profile. Do not include sensitive
exploit details in a public message.

## What to Include

A useful report should include as much of the following information as
possible:

- the affected commit, component, target, and operating system;
- whether the issue affects the compiler, runtime, library, package tooling,
  plugin system, generated code, or build process;
- a clear technical description of the vulnerability;
- reproducible steps or a minimal proof of concept;
- the expected and observed behavior;
- the potential security impact;
- any known prerequisites or environmental assumptions;
- suggested remediation, when available.

Please remove credentials, personal information, proprietary source code, and
unrelated sensitive data from reports.

## Security Scope

Examples of security issues that may be in scope include:

- compiler crashes caused by malformed untrusted input when they create a
  meaningful denial-of-service or memory-safety risk;
- incorrect code generation that can violate documented safety guarantees;
- ownership, lifetime, bounds, type, or capability-checking bypasses;
- runtime memory corruption or unsafe privilege transitions;
- malicious package, manifest, build-script, or plugin handling;
- path traversal or arbitrary file access in compiler and toolchain workflows;
- command injection or unintended process execution;
- signature, checksum, package-integrity, or update-verification failures;
- vulnerabilities in quantum, cryptographic, binary-decoding, networking, or
  serialization components;
- exposure of secrets through diagnostics, logs, build artifacts, or caches.

The following are generally out of scope unless they create a concrete
security impact:

- unsupported historical commits;
- vulnerabilities that exist only in modified or unofficial forks;
- feature requests and ordinary correctness bugs;
- reports based only on automated scanner output without a reproducible issue;
- denial-of-service requiring unrealistic local resources and no trust
  boundary;
- social engineering, physical attacks, or attacks on third-party services
  outside QuantumLang's control;
- claims about future or not-yet-implemented security guarantees.

## Coordinated Disclosure

Please allow the maintainers reasonable time to investigate, reproduce, fix,
and prepare a release before publicly disclosing a vulnerability.

During investigation, please:

- keep vulnerability details confidential;
- avoid accessing, modifying, or deleting data that does not belong to you;
- avoid disrupting users, services, or infrastructure;
- test only systems and repositories you own or are explicitly authorized to
  test;
- stop testing and report immediately if sensitive data is encountered.

The maintainers may request additional information, propose a coordinated
disclosure date, or determine that a report is not a security vulnerability.

## Response Process

The project will make a reasonable effort to:

1. acknowledge a complete report;
2. validate and assess its severity;
3. communicate material status changes;
4. develop and test a fix when appropriate;
5. publish an advisory or release information when necessary.

Response times are not guaranteed while QuantumLang remains an experimental,
independently developed project.

## Security Advisories and Credits

Confirmed vulnerabilities may be documented through GitHub Security
Advisories. Reporters may be credited with their permission, unless anonymity
is requested or disclosure would create additional risk.

## No Warranty

QuantumLang is experimental software. Unless a separate written agreement
states otherwise, the project is provided without warranties or guarantees of
fitness, security, availability, or compatibility.

Thank you for helping improve QuantumLang responsibly.
