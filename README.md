# Eta NoFib: Test & Benchmark Suite

This is a set of benchmarks for functional languages, popularly known as `nofib`, that has been adapted for the Eta programming language. The actual benchmarks that are used to test the Eta compiler can be found in the [eta-benchmarks](https://github.com/typelead/eta-benchmarks) repo.

## Methodology
The [Java Micobenchmarking Harness](http://openjdk.java.net/projects/code-tools/jmh/) is used to conduct the benchmarks. The follow process occurs when you run a benchmark:

1. The benchmark is compiled into a JAR file.
2. The `eta.main.main` method (the entry point into Eta programs) is invoked from the
   JMH framework.
3. The JMH framework will fork a single JVM process and run the program 5 times for
   warmup and 5 times for measurement and the average/error is calculated.

## Getting Started

### Prerequisites
- Maven
- JDK 1.7+
- Eta

### Runner Installation

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

#### Replicating the results

`$ ./eta-benchmarks.sh`

If you see any major differences, please report your results as an [issue](https://github.com/rahulmutt/nofib/issues/new) or on [Gitter](https://gitter.im/typelead/eta).

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
- real/hidden - Throws an Eta exception: fromInp
- real/scs - Throws an Eta exception: Prelude.undefined

Other benchmarks that won't work by category:
- imaginary
  - gen_regexps - Hangs
  - integrate - Wrong output
  - kahan - Wrong output
- spectral
  - ansi - Hangs
  - banner - Hangs
  - boyer - Exception, probably due to unimplemented IO function
  - cichelli - Exception, probably due to unimplemented IO function
  - compreals - Runner can't match the program
  - cryptarithm1 - Hangs
  - cse - Exception, probably due to unimplemented IO function
  - eliza - Hangs
  - exact-reals - Hangs
  - expert - Eta Exception, probably due to unimplemented IO function (File I/O)
  - fft2 - Wrong output
  - integer - Hangs
  - last-piece - Depends on `text` package
  - mandel - Hangs
  - mandel2 - Eta Exception, probably due to unimplemented IO function
  - mate - Eta Exception, probably due to unimplemented IO function (File I/O)
  - minimax - Eta Exception, probably due to unimplemented IO function
  - multiplier - Selector Thunk bug
  - para - Eta Exception, probably due to unimplemented IO function (File I/O)
  - power - Eta Exception, probably due to unimplemented IO function
  - pretty - Eta Exception, probably due to unimplemented IO function
  - primetest - Hangs
  - salishan - Runner can't match the program
  - secretary - Issue with `time` library
  - simple - Hangs
  - sorting - Hangs
  - sphere - Non-exhaustive patterns
  - treejoin - SelectorThunk bug
  - triangle - Depends on `FiniteMap` package
- spectral/hartel
  - nucleic2 - Wrong output
  - transform - Exception, probably due to unimplemented IO function
  - wave4main - Wrong output
- real
  - HMMS - Broken build
  - PolyGP - Broken build
  - anna - Eta Exception, probably due to unimplemented IO function (File I/O)
  - bspt - Exception, probably due to unimplemented IO function
  - cacheprof - Broken pipe
  - compress  - Hangs
  - compress2 - Broken pipe
  - ebnf2ps - Broken build
  - fem - Hangs
  - fluid - Hangs
  - fulsom - Eta Exception: Prelude.read: no parse
  - gamteb - Hangs
  - gg - Hangs
  - grep - Hangs
  - hidden - Eta Exception: fromInp
  - hpg - Wrong output
  - infer - Hangs
  - lift - SelectorThunk bug
  - maillist - Hangs
  - mkhprog - Wrong output
  - parser - Hangs
  - pic - Hangs
  - prolog - Eta Exception, probably due to unimplemented IO function (File I/O)
  - reptile - Hangs
  - rsa - Hangs
  - rx - Bad Main file
  - scs - Eta Exception, probably due to unimplemented IO function (File I/O)
  - symalg - Hangs
  - veritas - Invalid argument for stdin
