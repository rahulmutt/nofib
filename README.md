# Eta NoFib: Test & Benchmark Suite

This is a set of benchmarks for functional languages, popularly known as `nofib`, that has been adapted and modified for the Eta programming language.

## Getting Started

First, build the runner:

`$ stack build`

### To run an individual test
`$ stack exec -- nofib-runner [test-name] --run`

Example:
`$ stack exec -- nofib-runner scs --run`

### To run an entire suite
`$ stack exec -- nofib-runner [suite-name] --run`

Example:
`$ stack exec -- nofib-runner imaginary --run`

### Clean up test/benchmark artifacts
`$ stack exec -- nofib-runner clean`

## Current Status

Some of the tests are failing due to various reasons, but a good chunk of them work. Work is underway to tweak the build script to support all the tests.
