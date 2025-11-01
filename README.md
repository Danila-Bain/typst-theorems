# typst-theorems

An implementation of theorem environments for
[Typst](https://github.com/typst/typst).

Import as
```typ
#import "@preview/theofigs:0.0.1": *
```

# Features

- Many default theorem environments:
    - `definition`,
    - `theorem`,
    - `lemma`,
    - `statement`,
    - `proof`,
    - `corollary`,
    - `remark`,
    - `example`,
    - `algorithm`,
    - `problem`,
    - `solution`.
    
    All of them are defined as `theofig.with(...)`. Custom environments can also be defined
    in terms of generic `theofig` with appropriate `kind`, `suppliment` and `numberation`.
    
- Environments can share counters by having the same `kind` but different `suppliment`.
- Environments can be `<label>`'d and `@reference`'d
- Environments can be customized with show rules as `figure`s with
  corresponding kinds (with some limitations on nested figures).
- Environments can be customized using arguments in the corresponding functions.
- Default environments are translated depending on `lang.text` to many languages.

# Documentation

For detailed guide and documentation see 
[manual](https://github.com/Danila-Bain/typst-theorems/tree/main/docs/manual.pdf).

# Examples

## Basic usage

```typ
#import "/src/theofig.typ": *
#set page(paper: "a6", height: auto, margin: 6mm)

#definition[#lorem(5)]<def-1>

#theorem[Lorem, 2025][
  #lorem(12)
]<th-1>

#theorem[
  #lorem(14)
]<th-2>

#proof[
  @th-2 follows immediately from @def-1 and @th-1, which is obvious.
]
```
![example](readme-examples/1-basic-usage.svg)


## Custom environments
```typ
#import "/src/theofig.typ": theofig, problem, solution
#set page(paper: "a6", height: auto, margin: 6mm)

#let hard_problem = theofig.with(
  supplement: "Problem", 
  numbering: n => $#n^*$
)

#let hint = theofig.with(
  supplement: "Hint", 
  numbering: none, 
  format-caption: none,
  separator: ":"
)

= Default

#problem[ What $1 + 1$ equals to in $ZZ_2$? ]

#solution[
  Observe that $1 + 1$ is $2$, and $2 mod 2$ is $0$. 
  Hense, the answer is $0$.
]

= Custom

#hard_problem[ Prove that $ZZ_2$ is a field. ]

#hint[ Verify all axioms of a field exaustively. ]
]

#hard_problem[
  Prove that $ZZ_2$ is a field.
]

#hint[
  Verify all axioms of a field exaustively.
]
```
![example](readme-examples/2-custom-environments.svg)

# Why another one?

There is a number of packages for theorem environments, including [all
theese](https://typst.app/universe/search/?q=theorem). Many of them are
similar to this project, but differ in small details of how style 
customization is handled. Our package offers predefined commands
such as `#definition`, `#theorem`, `#proof`, ..., together with
style customization which can be applied to all or some environments.
We focus on minimalization of necessary boilerplate in preambule,
aiming to provide a package which is setup in 1-5 lines of code in preambule
for most of uses with reasonable ability to customize further when needed. 

