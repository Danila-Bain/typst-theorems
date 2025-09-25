#import "../theofigs.typ": *
#set page(paper: "a6", margin: 10mm)

#let problem = theofig.with(supplement: "Problem")
#let hard_problem = theofig.with(supplement: "Problem", numbering: n => $#n^*$)

#let solution = theofig.with(supplement: "Solution", numbering: none)
#let hint = theofig.with(supplement: "Hint", numbering: none, separator: ":")

#theofig-kinds-list.insert(-1, "problem")
#theofig-kinds-list.insert(-1, "solution")
#show: theofig-style-default(kinds: theofig-kinds-list)

#show: theofig-style("italic-title", kinds: ("hint",))

#problem[What $1 + 1$ equals to in $ZZ_2$?]

#solution[Observe that $1 + 1$ is $2$, and $2 mod 2$ is $0$. Hense, the answer is $0$.]

#hard_problem[Prove that $ZZ_2$ is a field.]

#hint[Verify all axioms of a field exaustively.]

