#import "/theofig.typ" as theofig-module: *
#import "@preview/tidy:0.4.1"


#set page(numbering: "1")
#set par(justify: true)
#set text(lang: "en")
#show link: underline.with(stroke: 1pt + blue.lighten(70%), offset: 1.5pt)

#let VERSION = toml("/typst.toml").package.version

// show references to headings as the heading title with a link
// not as "Section 1.2.3"
#show ref: it => {
	if it.element.func() == heading {
		link(it.target, it.element.body)
	} else { it }
}

#let scope = dictionary(theofig-module)

// #let docs = tidy.parse-module(
//   read("/theofig.typ"),
//   scope: (
//     theofig: theofig
//   ),
//   name: "theofig",
//   preamble: "import theofig: *\n",
// )
//
// #tidy.show-module(
//   docs, 
//   style: tidy.styles.minimal, 
// )

#v(.2fr)

#align(center)[
	#stack(
		spacing: 14pt,
		{
			set text(1.3em)
			// fletcher.diagram(
			// 	edge-stroke: 1pt,
			// 	spacing: 27mm,
			// 	label-sep: 6pt,
			// 	node((0,1), $A$),
			// 	node((1,1), $B$),
			// 	edge((0,1), (1,1), $f$, ">>->"),
			// )
		},
		text(2.7em, `theofig`),
		[_`figure` implementation of theorem environments_],
	)

	#v(30pt)

    A #link("https://typst.app/")[Typst] package for creation and
    customization \ of theorem environments built on top of
    #link("https://typst.app/docs/reference/model/figure/")[`std.figure`].


	#link("https://github.com/Jollywatt/typst-fletcher")[`github.com/Jollywatt/typst-fletcher`]

	*Version #VERSION*
]

#set raw(lang: "typc")
#show raw.where(block: false): it => {
	// if raw block is a function call, like `foo()`, make it a link
	if it.text.match(regex("^[a-z-]+\(\)$")) == none { it }
	else {
		let l = label(it.text)
		context {
			if query(l).len() > 0 {
				link(l, it)
			} else {
				it
			}
		}
	}
}

#show raw.where(block: true): set text(7pt)

#v(1fr)

#columns(2)[
	#outline(
		title: align(center, box(width: 100%)[Guide]),
		indent: 1em,
		target: selector(heading).before(<func-ref>, inclusive: false),
	)
	#colbreak()
	#outline(
		title: align(center, box(width: 100%)[Reference]),
		indent: 1em,
		target: selector(heading.where(level: 1)).or(heading.where(level: 2)).after(<func-ref>, inclusive: true),
	)

]

#v(1fr)

#pagebreak()


= Usage examples

Importing everything with `*` is recommended:

#raw(lang: "typ", "#import \"@preview/theofig:" + VERSION + "\": *")


#let code-example(src) = (
	{
		set text(.85em)
		let code = src.text.replace(regex("(^|\n).*// hide\n|^[\s|\S]*// setup\n"), "")
		box(raw(block: true, lang: src.lang, code)) // box to prevent pagebreaks
	},
	eval(
		src.text,
		mode: "markup",
		scope: scope
	),
)

#let code-example-row(src) = stack(
	dir: ltr,
	spacing: 1fr,
	..code-example(src).map(align.with(horizon))
)

#table(
	columns: (2fr, 2fr),
	align: (horizon, center + horizon),
	stroke: (x: none),
	inset: (x: 0pt, y: 7pt),

	..code-example(```typ
      #theorem[
        #lorem(5)
      ] <theorem-1>

      #theorem[Author B. C.][#lorem(10)]

      #proof[It follows directly from @theorem-1.]
      ```),

	
    ..code-example(```typ
      #theorem[#lorem(5)]

      #lemma[#lorem(5)]

      #statement[#lorem(5)]

      #remark[#lorem(5)]

      #corollary[#lorem(5)]

      #example[#lorem(5)]

      #definition[#lorem(5)]

      #algorithm[#lorem(5)]

      #proof[#lorem(5)]

      #problem[#lorem(5)]
      
      #solution[#lorem(5)]
      ```),

    ..code-example(```typ


      #definition[
        Equivalent to @definition-2.
      ]<definition-1>

      #definition(
        number: <definition-1>,
        numbering: numbering.with("1'")
      )[
        Equivalent to @definition-1
      ]<definition-2>
      
      #definition(number: $cal(A)$)[
        #lorem(5)
      ]<definition-3>
      
      #definition[#lorem(5)]

      #definition(numbering: none)[#lorem(5)]
      ```),


  )

= Styling

= Numbering

= Limitations



= Main functions <func-ref>

// #dictionary(theofig-module)
