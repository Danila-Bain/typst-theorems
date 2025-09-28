# typst-theorems

An implementation of theorem environments
[typst](https://github.com/typst/typst).

Import as
```typst
#import "@preview/theofigs:0.0.1": *
```

# Features

- Default theorem environments, which as specifications of function `theofig`:
    - `theorem`
    - `lemma`
    - `statement`
    - `proof`
    - `corollary`
    - `remark`
    - `example`
    - `definition`
    - `algorithm`
- Custom theorem environments can be added.
- Environments can share counters by having the same `kind` but different `suppliment`.
- Environments can be `<label>`'d and `@reference`'d
- Environments can be customized with show rules as `figure`s with corresponding kinds.
    - apply text style, block with stroke or fill, etc
    - customize text style of the suppliment
    - customize numbering
- Convinent selectors for environments, which can select all, some, or all except some theorem environments.

# Examples

You can find a relatively complete list of examples that goes through features
of this project in the
[repository](https://github.com/Danila-Bain/typst-theorems/tree/main/examples).

# Documentation

The following variables and functions are defined in this package:
- `theofig`: returns a styled theorem environment. All environments
    are defined as specializations of this function, i.e. 
    `#let theorem = theofig.with(kind: "theorem", supplement: "Theorem")`.
    ```typst
    theofig(
      ..args,
      kind: none, 
      supplement: auto, 
      numbering: auto, 
      block-options: (:),
      figure-options: (:),
      separator: ".",
      translated-supplement: true,
      qed: false,
      body
    )
    ```
    parameters:
    - `..args`. First additional positional argument adds annotation to the title. 
        I.e. `#theorem[123.]` will look like "Theorem 1. 123." but `#theorem[ABC][123.]` will look like "Theorem 1 (ABC). 123."
    - `kind : none`. Kind of theorem, which determines numbering group.
        setting two commands with one kind and different supplements
        makes them have shared numbering but different titles.
    - `supplement : auto`. Title of the theorem, i.e. "Lemma" or "Definition", 
        which is used in title of environment as well as in referencing.
    - `numbering : auto`. Numbering pattern to use.
    - `block-options: none`. Options passed to the `block` container.
    - `figure-options: none`. Options passed to the `figure` container.
    - `separator: "."`. Separator between the supplement (title) and the body.
    - `translated-supplement: true`. If `true`, apply translation of the supplement to `text.lang` language using `theofig-translations-list` dictionary.
    - `qed: false`. If `true`, insert `math.qed` at the end of the body.
    - `body`. Body of the theorem
- `theofig-kinds-list`: list of environments implemented by default.

    It can be exteneded with custom environment types and used as in
    `show theofig-selector(..theofig-kinds-list): ...` to apply
    the same custom styling to default and new environments.
- `theofig-translations-list`: per-language list of default suppliments 
    for each default environment kind, i.e.
    ```typst
    #let theofig-translations-list = (
        <...>
        "ru": (
            <...>
            "lemma":          "Лемма",
            "theorem":        "Теорема",
            <...>
        ),
        <...>
    )
    ```
    By default, supplement in `theofig` is a context expression, which
    evaluates supplement as 
    `theofig-translations-list.at(text.lang).at(lower(supplement), default: supplement)`
    if supplement is provided and 
    `theofig-translations-list.at(text.lang).at(kind, default: kind)`
    if supplement is `auto`.

- Default environments are set as follows:
    ```typst
    #let theorem = theofig.with(kind: "theorem", supplement: "Theorem")
    #let lemma = theofig.with(kind: "lemma", supplement: "Lemma")
    #let statement = theofig.with(kind: "statement", supplement: "Statement")
    #let remark = theofig.with(kind: "remark", supplement: "Remark")
    #let corollary = theofig.with(kind: "corollary", supplement: "Corollary", numbering: none)
    #let example = theofig.with(kind: "example", supplement: "Example")
    #let definition = theofig.with(kind: "definition", supplement: "Definition")
    #let algorithm = theofig.with(kind: "algorithm", supplement: "Algorithm")
    #let proof = theofig.with(kind: "proof", numbering: none, qed: true)
    ```
    If you wish this list were extended, open an issue in repository, and it will probably added shortly.


# Why another one?

There is a number of packages for theorem environments, including [all
theese](https://typst.app/universe/search/?q=theorem). Many of them are
similar to this project, but differ in small details of how style 
customization is handled. Our package offers predefined commands
such as `#definition`, `#theorem`, and `#proof` together with
style customization which can be applied to all or some environments.
We focus on minimalization of necessary boilerplate in preambule,
aiming to provide a package which is setup in 2-3 lines of code in preambule
for most of uses with reasonable ability to customize further when needed. 

