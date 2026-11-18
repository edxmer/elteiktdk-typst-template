// =============================================================================
//  Example TDK thesis
//
//  Compile with:  typst compile main.typ
// =============================================================================

#import "tdk.typ": tdk, appendix, starred-chapter, compact
#import "tdk.typ": definition, theorem, remark, note, proof
#import "tdk.typ": fig, tab, code, algorithm
#import "tdk.typ": list-of-figures, list-of-tables, list-of-codes, list-of-algorithms

#show: tdk.with(
  title: [Title of the TDK thesis],
  authors: (
    (name: "John Smith", degree: "Computer Science MSc", period: "V. grade"),
    (name: "Jane Smith", degree: "Computer Science MSc", period: "IV. grade"),
  ),
  supervisors: (
    (name: "John Doe", affiliation: "Assistant Lecturer"),
    (name: "Jane Doe", affiliation: "PhD Student"),
  ),
  university: "Eötvös Loránd University",
  faculty: "Faculty of Informatics",
  department: "Dept. of Software Technology and Methodology",
  city: "Budapest",
  year: 2024,
  logo: "images/elte_cimer_szines.png",
  language: "en",
  bib: bibliography("refs.bib", style: "ieee"),
)

// =============================================================================
//  1  Introduction
// =============================================================================

= Introduction <ch:intro>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu egestas mauris. Quisque
nisl elit, varius in erat eu, dictum commodo lorem. Sed commodo libero et sem laoreet
consectetur. Fusce ligula arcu, vestibulum et sodales vel, venenatis at velit
@dahl1972structured. Aliquam erat volutpat. Proin condimentum accumsan velit id
hendrerit. Cras egestas arcu quis felis placerat, ut sodales velit malesuada.
Maecenas et turpis eu turpis placerat
euismod.#footnote[Maecenas a urna viverra, scelerisque nibh ut, malesuada ex.]

Aliquam suscipit dignissim tempor. Praesent tortor libero, feugiat et tellus porttitor,
malesuada eleifend felis. Orci varius natoque penatibus et magnis dis parturient montes,
nascetur ridiculus mus @cormen2009algorithms @krasner1988mvc. Nullam eleifend imperdiet
lorem, sit amet imperdiet metus pellentesque vitae. Donec nec ligula urna. Aliquam
bibendum tempor diam, sed lacinia eros dapibus id. Donec sed vehicula turpis. Aliquam
hendrerit sed nulla vitae convallis. Etiam libero quam, pharetra ac est nec, sodales
placerat augue @dijkstra1979goto.

// =============================================================================
//  2  Specification and design
// =============================================================================

= Specification and design <ch:spec>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nibh leo, dapibus in
elementum nec, aliquet id sem. Suspendisse potenti. Nullam sit amet consectetur nibh.

== Enumerations and lists

Etiam vel odio ante. Etiam pulvinar nibh quis massa auctor congue. Pellentesque quis
odio vitae sapien molestie vestibulum sit amet et quam.

- Fusce in aliquet neque, in pretium sem.
- Donec tincidunt tellus id lectus pretium fringilla.
- Nunc faucibus, erat pretium tempus tempor, tortor mi fringilla neque, ac congue ex dui
  vitae mauris.

Donec dapibus sodales ante, at scelerisque nunc laoreet sit amet. Mauris porttitor
tincidunt neque, vel ullamcorper neque pulvinar et.

+ Donec pretium et quam a cursus. Ut sollicitudin tempus urna et mollis.
+ Aliquam et aliquam turpis, sed fermentum mauris. Nulla eget ex diam.
+ Donec eget tellus pharetra, semper neque eget, rutrum diam (see @ch:spec).

=== Lists with narrow spacing

Phasellus ultricies, sapien sit amet ultricies placerat, velit purus viverra ligula, id
consequat ipsum odio imperdiet enim:

#compact[
  + Maecenas eget lobortis leo.
  + Donec eget libero enim.
  + In eu eros a eros lacinia maximus ullamcorper eget augue.
]

In quis turpis metus. Proin maximus nibh et massa eleifend, a feugiat augue porta. Sed
eget est purus. Duis in placerat leo. Donec pharetra eros nec enim convallis:

#compact[
  - Pellentesque odio lacus.
  - Maximus ut nisl auctor.
  - Sagittis vulputate lorem.
]

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
Sed lorem libero, dignissim vitae gravida a, ornare vitae est.

/ Vestibulum venenatis: malesuada enim, ac auctor erat vestibulum et. Phasellus id purus
  a leo suscipit accumsan.
/ Orci varius natoque: penatibus et magnis dis parturient montes, nascetur ridiculus mus.
  Nullam interdum rhoncus nisl, vel pharetra arcu euismod sagittis.

== Images and figures

Aliquam vehicula luctus mi a pretium. Nulla quam neque, maximus nec velit in, aliquam
mollis tortor. Aliquam erat volutpat. Curabitur vitae laoreet turpis. Integer id diam
ligula, see @fig:example.

#fig(
  image("images/elte_cimer_szines.png", width: 30%),
  caption: [Quisque ac tincidunt leo],
) <fig:example>

Nulla sodales purus id mi consequat, eu venenatis odio pharetra. Cras a arcu quam.
Suspendisse augue risus, pulvinar a turpis et, commodo aliquet turpis.

#fig(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    [#image("images/elte_cimer_szines.png", width: 60%)
      #v(0.3em) #text(size: 0.9em)[(a) Vestibulum quis mattis urna]],
    [#image("images/elte_cimer_szines.png", width: 60%)
      #v(0.3em) #text(size: 0.9em)[(b) Donec hendrerit quis dui]],
  ),
  caption: [Aenean porttitor mi volutpat massa gravida],
) <fig:subfigures>

Nam et nunc eget elit tincidunt sollicitudin. Quisque ligula ipsum, tempor vitae tortor
ut, commodo rhoncus diam.

== Tables

Nam magna ex, euismod nec interdum sed, sagittis nec leo. Nam blandit massa bibendum
mattis tristique, see @tab:example.

#tab(
  table(
    columns: (1fr, 2.6fr),
    align: (left, left),
    stroke: 0.5pt,
    table.header([*Phasellus tortor*], [*Aenean consequat*]),
    table.hline(stroke: 1pt),
    [ _Sed malesuada_ ], [Aliquam aliquam velit in convallis ultrices.],
    [ _Purus sagittis_ ], [Quisque lobortis eros vitae urna lacinia euismod.],
    [ _Pellentesque_ ], [Curabitur ac lacus pellentesque, eleifend sem ut, placerat enim.],
  ),
  caption: [Maecenas tincidunt non justo quis accumsan],
) <tab:example>

Vivamus gravida faucibus efficitur. Ut non erat quis arcu vehicula lacinia.

// =============================================================================
//  3  Implementation and usage
// =============================================================================

= Implementation and usage <ch:impl>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nibh leo, dapibus in
elementum nec, aliquet id sem. Suspendisse potenti.

== Theorem-like environments

#definition[
  Mauris tristique sollicitudin ultrices. Etiam tristique quam sit amet metus dictum
  imperdiet. Nunc id lorem sed nisl pulvinar aliquet vitae quis arcu.
]

Maecenas rutrum eros sem, pharetra interdum nulla porttitor sit amet. In vitae viverra
ante. Maecenas sit amet placerat orci, sed tincidunt velit.

#theorem[
  Nulla finibus ante vel arcu tincidunt, ut consectetur ligula finibus. Mauris mollis
  lectus sed ipsum bibendum, ac ultrices erat dictum.
]
#proof[
  Etiam pulvinar nibh quis massa auctor congue. Pellentesque quis odio vitae sapien
  molestie vestibulum sit amet et quam. Quisque sollicitudin ultrices enim, nec porta
  magna imperdiet vitae.
]

Donec dapibus sodales ante, at scelerisque nunc laoreet sit amet.

#remark[
  Nunc ornare mi at augue vulputate, eu venenatis magna mollis. Nunc sed posuere dui, et
  varius nulla. Sed mollis nibh augue, eget scelerisque eros ornare nec.
]

Fusce in aliquet neque, in pretium sem. Donec tincidunt tellus id lectus pretium
fringilla.

#note[
  Aliquam vehicula luctus mi a pretium. Nulla quam neque, maximus nec velit in, aliquam
  mollis tortor.
]

=== Equations, formulas

Duis suscipit ipsum nec urna blandit, $2 + 2 = 4$ pellentesque vehicula quam fringilla.

$ a^2 + b^2 = c^2 $

Phasellus mollis, elit sed convallis feugiat, dolor quam dapibus nibh, suscipit
consectetur lacus risus quis sem. In mathematics, Euler's identity is equation
@eq:euler:

$ e^(i times pi) + 1 = 0 $ <eq:euler>

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae.

== Source code samples

Nulla sodales purus id mi consequat, eu venenatis odio pharetra. Cras a arcu quam, see
@code:cpp.

#code(caption: [Hello World in C++])[
  ```cpp
  #include <iostream>

  int main()
  {
  	std::cout << "Hello World!" << std::endl;
  	std::cout << "Press any key to exit." << std::endl;
  	std::cin.get();
  	return 0;
  }
  ```
] <code:cpp>

Quisque ac tincidunt leo, see @alg:ibb.

#algorithm(caption: [A general interval B&B algorithm])[
  + Set the working list $cal(L)_W := {S}$ and the final list $cal(L)_Q := {}$
  + *while* ($cal(L)_W != emptyset$) *do*
    + Select an interval $X$ from $cal(L)_W$ #h(1fr) $triangle.stroked.r$ Selection rule
    + Compute $l b f (X)$ #h(1fr) $triangle.stroked.r$ Bounding rule
    + *if* $X$ cannot be eliminated *then*
      + Divide $X$ into $X^j, j = 1, dots, p$, subintervals
      + *for* $j = 1, dots, p$ *do*
        + *if* $X^j$ satisfies the termination criterion *then*
          + Store $X^j$ in $cal(L)_W$
        + *else*
          + Store $X^j$ in $cal(L)_W$
] <alg:ibb>

// =============================================================================
//  4  Summary and results
// =============================================================================

= Summary and results <ch:sum>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu egestas mauris. Quisque
nisl elit, varius in erat eu, dictum commodo lorem. Sed commodo libero et sem laoreet
consectetur.

Aliquam suscipit dignissim tempor. Praesent tortor libero, feugiat et tellus porttitor,
malesuada eleifend felis. Orci varius natoque penatibus et magnis dis parturient montes,
nascetur ridiculus mus.

// =============================================================================
//  Acknowledgements
// =============================================================================

#starred-chapter[Acknowledgements]

In case your TDK thesis received financial support from a project or the university, it
is usually required to indicate the proper attribution in the thesis itself. Special
thanks can also be expressed towards teachers, fellow students and colleagues who helped
you in the process of creating your thesis.

// =============================================================================
//  Appendices
// =============================================================================

#show: appendix

= Simulation results <appx:simulation>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque facilisis in nibh
auctor molestie. Donec porta tortor mauris. Cras in lacus in purus ultricies blandit.

Sed egestas dapibus nisl, vitae fringilla justo. Donec eget condimentum lectus, molestie
mattis nunc. Nulla ac faucibus dui. Nullam a congue erat.

// =============================================================================
//  Lists
// =============================================================================

#list-of-figures()
#list-of-tables()
#list-of-codes()
#list-of-algorithms()
