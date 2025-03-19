#import "@preview/touying:0.5.5": *
#import themes.university: *
#import "@preview/cetz:0.3.1"
#import "@preview/fletcher:0.5.3" as fletcher: node, edge
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-info(
    title: [Поиск подстроки в строке Алгоритм Бойера-Мура],
    // subtitle: [Subtitle],
    author: [Смирнов Егор],
    // date: datetime.today(),
    institution: [СГУ КНиИТ 251гр],
    // logo: emoji.school,
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

// == Outline <touying:hidden>
//
// #components.adaptive-columns(outline(title: none, indent: 1em))

= Алгоритм Бойера-Мура

== Принцип работы алгоритма

#v(50pt)
#set text(size: 30pt)
#align(center)[
	*В алгоритме Бойера-Мура есть два правила*
]
- Правило плохого символа (эврстика стоп символа)
- Правило хорошего суфуфикса (эвристика совпавшего символа)

Далее под $quote.angle.l$шаблоном$quote.angle.r$ будем понимать подстроку, которую мы ищем.

== Пример правила плохого символа
#let gr(x) ={
	text(fill: rgb("#00dd00"), weight: "bold", $#x$)
}
#let rd(x) ={
	text(fill: rgb("#dd0000"), weight: "bold", $#x$)
}
#let bl(x) ={
	text(fill: rgb("#0000dd"), weight: "bold", $#x$)
}

#let eq1() = {
	alternatives[$ #h(150pt)

	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	rd(A) #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 

	$ $ #h(-165pt)

	bl(A) #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)]
	rd(C) #[#h(-33pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "Нужно переместить шаблон так, чтобы стоп символ \nс символом из шаблона (синий из шаблона и \nкрасный из строки)")
	][]
}
#let eq2() = {
	alternatives[$ #h(150pt)

	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	gr(A) #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	rd(B) #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 

	$ $ #h(45pt)

	gr(A) #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)]
	bl(B) #[#h(-33pt) #square(size: 35pt)]
	rd(C) #[#h(-33pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "После начинаем проверять новый срез \nОпять есть не совпадение. Ищем стоп символ в\nшаблоне. (Если такого символа нет, то сдвиг на 1)")
	][]
}
#let eq3() = {
	alternatives[$ #h(150pt)

	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	rd(A) #[#h(-33pt) #square(size: 35pt)]
	gr(B) #[#h(-33pt) #square(size: 35pt)] 
	gr(C) #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 

	$ $ #h(115pt)

	bl(A) #[#h(-33pt) #square(size: 35pt)]
	rd(C) #[#h(-33pt) #square(size: 35pt)]
	gr(B) #[#h(-33pt) #square(size: 35pt)]
	gr(C) #[#h(-33pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "A != C. Ищем стоп символ в шаблоне \nСдвигаем шаблон")
	][]
}

#let eq4() = {
	alternatives[$ #h(150pt)

	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	gr(A) #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	rd(B) #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 

	$ $ #h(185pt)

	gr(A) #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)]
	bl(B) #[#h(-33pt) #square(size: 35pt)]
	rd(C) #[#h(-33pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "B != C. Ищем стоп символ в шаблоне \nСдвигаем шаблон")
	][]
}
#let eq5() = {
	alternatives[$ #h(150pt)

	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	gr(B) #[#h(-33pt) #square(size: 35pt)] 
	rd(A) #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 

	$ $ #h(255pt)

	bl(A) #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)]
	gr(B) #[#h(-33pt) #square(size: 35pt)]
	rd(C) #[#h(-33pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "A != C. Ищем стоп символ в шаблоне \nСдвигаем шаблон")
	][$ #h(150pt)

	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	gr(A) #[#h(-33pt) #square(size: 35pt)]
	gr(C) #[#h(-33pt) #square(size: 35pt)] 
	gr(B) #[#h(-33pt) #square(size: 35pt)] 
	gr(C) #[#h(-33pt) #square(size: 35pt)] 

	$ $ #h(465pt)

	gr(A) #[#h(-33pt) #square(size: 35pt)]
	gr(C) #[#h(-33pt) #square(size: 35pt)]
	gr(B) #[#h(-33pt) #square(size: 35pt)]
	gr(C) #[#h(-33pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "ИИИИИИИ наконец-то мы нашли наш шаблон")
	]
}

#v(130pt)

#for value in (1, 2, 3, 4, 5) {
	if value == 1 {
		eq1()
	}
	if value == 2 {
		v(-265pt)
		eq2()
	}
	if value == 3 {
		v(-264.5pt)
		eq3()
	}
	if value == 4 {
		v(-230pt)
		eq4()
	}
	if value == 5 {
		v(-230pt)
		eq5()
	}
	pause
}

== Как найти нужный символ в шаблоне (Предобработка)
#v(40pt)

Предобработка шаблона --- это, например, построение таблицы, где строки это символы алфавита шаблона, а столбцы это символы самого шаблона. Пример для шаблона $quote.angle.l A C B C quote.angle.r$:
#align(center)[
	#set text(size: 40pt)
	#table(
		columns: 5,
		table.header(
			[], [$A$], [$C$], [$B$], [$C$],
		),
		[A], [$1$], [$1$], [$2$], [$3$],
		[B], [$1$], [$1$], [$1$], [$1$],
		[C], [$1$], [$1$], [$1$], [$1$],
	)
]

== Предобработка
#let eq6() = { $ #h(50pt)

	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	A #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	rd(A) #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)] 
	B #[#h(-33pt) #square(size: 35pt)] 
	C #[#h(-33pt) #square(size: 35pt)] 

	$
	$ #h(155pt)

	bl(A) #[#h(-33pt) #square(size: 35pt)]
	C #[#h(-33pt) #square(size: 35pt)]
	B #[#h(-33pt) #square(size: 35pt)]
	rd(C) #[#h(-33pt) #square(size: 35pt)]
	$
}

#align(center)[
	#alternatives[
		#eq6()
		#set text(size: 40pt)
		#table(
			columns: 5,
			table.header(
				[], [$A$], [$C$], [$B$], [$C$],
			),
			[A], [$1$], [$1$], [$2$], [$3$],
			[B], [$1$], [$1$], [$1$], [$1$],
			[C], [$1$], [$1$], [$1$], [$1$],
		)
	][
		#eq6()
		#set text(size: 40pt)
		#table(
			columns: 5,
			table.header(
				[], [$A$], [$C$], [$B$], table.cell(fill: red, $C$),
			),
			table.cell(fill: blue, $A$), table.cell(fill: blue, $1$), table.cell(fill: blue, $1$), table.cell(fill: blue, $2$), table.cell(fill: green, $3$),
			[B], [$1$], [$1$], [$1$], [$1$],
			[C], [$1$], [$1$], [$1$], [$1$],
		)
	]
]

= Код
== Код в сделку не входил
#image("Images/noCode.jpg")
= ПА
= ДЫ
= ТО
= ЖИМ
#show: appendix
= ПАДЫТОЖИМ
== ПАДЫТОЖИМ
текст
