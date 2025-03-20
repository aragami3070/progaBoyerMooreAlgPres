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
#set text(size: 30pt)
#align(center)[
	*Алгоритм Бойера-Мура основан на 3-х идях*
]
- *Сканирование слева направо, сравнение справа налево*. Совмещается начало текста и шаблона(подстрока, которую мы ищем), проверка начинается с последнего символа шаблона. Если символ шаблона не совпадает с символом строки, шаблон сдвигается на несколько символов вправо
- *Правило плохого символа* (эврстика стоп символа)
- *Правило хорошего суфуфикса* (эвристика совпавшего суфуфикса)

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
	#text(size:26.5pt, "Нужно переместить шаблон так, чтобы стоп символ \nсовпадал с символом из шаблона\n(синий из шаблона и красный из строки)")
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

== Пример правила хорошего суффикса
#v(40pt)
#only("1")[Если при чтении шаблона совпал суффикс $S$, а символ $b$, стоящий перед $S$ в шаблоне (то есть шаблон имеет вид $P b S$), не совпал, то сдвигаем шаблон на наименьшее число позиций вправо так, чтобы строка $S$ совпала с шаблоном, а символ, предшествующий в шаблоне данному совпадению $S$, отличался бы от $b$ (если такой символ вообще есть).]

#let eq6() = {
	alternatives[$ #h(50pt)
		#v(40pt)

	K #[#h(-31pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)] 
	rd(K) #[#h(-36.5pt) #square(size: 35pt)] 
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)] 
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(L) #[#h(-30pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 

	$ $ #h(-295pt)

	K #[#h(-33pt) #square(size: 35pt)]
	O #[#h(-33pt) #square(size: 35pt)] 
	rd(L) #[#h(-30pt) #square(size: 35pt)] 
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)]
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(L) #[#h(-30pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "Ищем OKOL. Нет. Ищем KOL, он есть сдвигаем до KOL")
	][]
}
#let eq7() = {
	alternatives[$ #h(50pt)
		#v(40pt)

	K #[#h(-31pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)] 
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(L) #[#h(-30pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 

	$ $ #h(-295pt)

	bl(K) #[#h(-33pt) #square(size: 35pt)]
	bl(O) #[#h(-33pt) #square(size: 35pt)] 
	bl(L) #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)]
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(L) #[#h(-30pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "Ищем OKOL. Нет. Ищем KOL, он есть сдвигаем до KOL")
	][]
}

#let eq8() = {
	alternatives[$ #h(50pt)
		#v(40pt)

	K #[#h(-31pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)] 
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(L) #[#h(-30pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)]
	rd(K) #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 

	$ $ #h(-5pt)

	gr(K) #[#h(-33pt) #square(size: 35pt)]
	gr(O) #[#h(-33pt) #square(size: 35pt)] 
	gr(L) #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)]
	rd(L) #[#h(-30pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "K != L. сдвигаем на 1")
	][]
}
#let eq9() = {
	alternatives[$ #h(50pt)
		#v(40pt)

	K #[#h(-31pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	L #[#h(-30pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	rd(O) #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 

	$ $ #h(65pt)

	K #[#h(-33pt) #square(size: 35pt)]
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)]
	rd(L) #[#h(-30pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "O != L. сдвигаем на 1")
	][]
}
#let eq10() = {
	alternatives[$ #h(50pt)
		#v(40pt)

	K #[#h(-31pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	L #[#h(-30pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)] 
	gr(O) #[#h(-33pt) #square(size: 35pt)] 
	gr(L) #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-33pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 

	$ $ #h(135pt)

	bl(K) #[#h(-33pt) #square(size: 35pt)]
	bl(O) #[#h(-33pt) #square(size: 35pt)] 
	bl(L) #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)]
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(L) #[#h(-30pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "Ищем KOL. Нашли, сдвигаем до KOL")
	][$ #h(50pt)
		#v(40pt)

	K #[#h(-31pt) #square(size: 35pt)]
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	K #[#h(-36.5pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)]
	L #[#h(-30pt) #square(size: 35pt)] 
	L #[#h(-30pt) #square(size: 35pt)] 
	O #[#h(-32pt) #square(size: 35pt)] 
	K #[#h(-36.5pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)] 
	gr(O) #[#h(-33pt) #square(size: 35pt)] 
	gr(L) #[#h(-30pt) #square(size: 35pt)] 
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)] 
	gr(O) #[#h(-33pt) #square(size: 35pt)] 
	gr(L) #[#h(-30pt) #square(size: 35pt)] 

	$ $ #h(420pt)

	gr(K) #[#h(-33pt) #square(size: 35pt)]
	gr(O) #[#h(-33pt) #square(size: 35pt)] 
	gr(L) #[#h(-30pt) #square(size: 35pt)] 
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(K) #[#h(-36.5pt) #square(size: 35pt)]
	gr(O) #[#h(-32pt) #square(size: 35pt)]
	gr(L) #[#h(-30pt) #square(size: 35pt)]
	$
	#text(size:26.5pt, "Нашли шаблон в строке")]
}
#v(70pt)

#pause
#for value in (1, 2, 3, 4, 5) {
	if value == 1 {
		eq6()
	}
	if value == 2 {
		v(-200.5pt)
		eq7()
	}
	if value == 3 {
		v(-200.5pt)
		eq8()
	}
	if value == 4 {
		v(-200.5pt)
		eq9()
	}
	if value == 5 {
		v(-200.5pt)
		eq10()
	}
	pause
}

= Как найти нужный символ в шаблоне
== Таблица стоп символов
#v(40pt)
#only("1")[В таблице стоп-символов указывается последняя позиция в шаблоне s (*исключая последнюю букву*) каждого из символов алфавита. Для всех символов, не вошедших в $s$, пишем $-1$, если нумерация символов начинается с $0$.Например, если $s = A B C D A D C D$  таблица стоп-символов StopTable будет выглядеть так:]
#only("2")[Для стоп-символа «D» последняя позиция будет $5$, а не $7$ т.к. последняя буква не учитывается. Это известная ошибка, приводящая к неоптимальности. 

	Для алгоритма БМ она не фатальна из-за эвристики суффикса, но фатальна для алгоритма БМ Хорспула. ] 

#align(center)[
	#set text(size: 40pt)
	#table(
		columns: 5,
		table.header(
			[$A$], [$B$], [$C$], [$D$], [все остальные],
		),
		[$0$], [$2$], [$6$], [$5$], [$-1$],
	)
]
== Таблица суффиксов
#only("1")[Для каждого возможного суффикса $t$ данного шаблона $s$ указываем наименьшую величину, на которую нужно сдвинуть вправо шаблон, чтобы он снова совпал с $t$ и при этом символ, предшествующий этому вхождению $t$ , не совпадал бы с символом, предшествующим суффиксу $t$. Если такой сдвиг невозможен, ставится $| s | = m$ (в обеих системах нумерации).] Например, для $s = a a c c b c c b c c$ будет: #pause
#align(center)[
	#set text(size: 25pt)
	#table(
		columns: 8,
		table.header(
		[Суффикс], [[пустой]], [л], [ол], 
		[кол], [$dots$], [олокол], [колокол],
		),
	[Сдвиг], [$$], [$$], [$$], 
	[$$], [$dots$], [$$], [$$],
	[Иллюстра\ ция], [$1$], [$7$], [$7$], 
	[$7$], [$dots$], [$4$], [$4$],
	[Было], [?], [?л], [?ол], 
	[?кол], [$dots$], [?олокол], [колокол],
	[Стало], [колокол], [колокол], [колокол], 
	[колокол], [$dots$], [колокол], [колокол],
	)
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
Общая оценка вычислительной сложности современного варианта алгоритма Бойера --- Мура --- $O ( n + m )$, если не используется таблица стоп-символов  и $O ( n + m + | Sigma | )$, если используется таблица стоп-символов, где $n$ --- длина строки, в которой выполняется поиск, $m$ --- длина шаблона поиска, $Sigma$ --- алфавит, на котором проводится сравнение

#align(center)[
	*Гуд алгоритм, пользуемся)*
]
