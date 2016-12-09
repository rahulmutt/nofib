# Eta NoFib: Test & Benchmark Suite

This is a set of benchmarks for functional languages, popularly known as `nofib`, that has been adapted for the Eta programming language.

## Getting Started

First, install the runner:

`$ stack install`

## Running
 All runs of the runner should be at the root of the repository.

### To run an individual test
`$ nofib-runner [test-name] --run`

Example:
`$ nofib-runner scs --run`

### To run an entire suite
`$ nofib-runner [suite-name] --run`

Example:
`$ nofib-runner imaginary --run`

### Clean up test/benchmark artifacts
`$ nofib-runner clean`

## Benchmarking against GHC

### Working Benchmarks

| Benchmark              | Eta 0.0.3 ([62140d3](https://github.com/typelead/eta/commit/62140d3173cbc291b1f6c629fa55bf40e55171ea)) | GHC 8 ([4431e48](https://perf.haskell.org/ghc/#revision/4431e48e6dc0a0e47328b6d0ed34a9b8503be4b0)) |
| ---------------------- | ---------------------- | ------------------ |
| spectral/circsim       | 14102 ms               | 733 ms             |
| spectral/constraints   | 15884 ms               | 2488 ms            |
| shootout/pidigits      | 28 ms                  | 546 ms             |
| imaginary/wheel-sieve1 | 7 ms                   | 318 ms             |

#### Replicating the results

`$ nofib-runner spectral/circsim spectral/constraints shootout/pidigits imaginary/wheel-sieve1 --run`

If you see any major differences, please report your results as an [issue] or on [Gitter](https://gitter.im/typelead/eta).

### Benchmarks In Progress
The following currently don't work in Eta:
- shootout/binary-trees - relies on concurrency
- shootout/fannkuch-redux - relies on concurrency
- shootout/fasta - depends on `bytestring` (not implemented yet) and requires special test generation.
- shootout/k-nucleotide - relies on concurrency
- shootout/n-body - relies on concurrency
- shootout/spectral-norm - relies on concurrency
- real/cacheprof - Error in build
- spectral/cryptarithm1 - Hangs
- spectral/integer - Hangs
- real/hidden - Error in build
- spectral/lcss - Test fails
- real/scs - Exception at runtime

## Current Status

Some of the tests are failing due to various reasons, but a good chunk of them work. Work is underway to tweak the build script to support all the tests.
