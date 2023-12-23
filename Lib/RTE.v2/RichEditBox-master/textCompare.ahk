	#Include <Directives\__AE.v2>
	#SingleInstance force
	#Include <Class\RTE\RichEdit>
	; #Include <RTE.v2\RichEditBox-master\Class_RichEdit>
	;#Include Print.ahk

	default1 := "Longest common subsequence problem`n`n`tThe longest common subsequence (LCS) problem is the problem of finding the longest subsequence common to all sequences in a set of sequences (often just two sequences). It differs from the longest common substring problem: unlike substrings, subsequences are not required to occupy consecutive positions within the original sequences. The longest common subsequence problem is a classic computer science problem, the basis of data comparison programs such as the diff utility, and has applications in computational linguistics and bioinformatics. It is also widely used by revision control systems such as Git for reconciling multiple changes made to a revision-controlled collection of files.`n`nhttps://en.wikipedia.org/wiki/Longest_common_subsequence_problem`n`n3.141592653589793238462643383239502884127169799375105840974944592307816406286...`n`nPut old version here to see what has been deleted."
	default2 := "Longest common subsequence problem (LCS)`n`n`tThe LCS problem is about finding the longest subsequence common to all sequences in a set of sequences (often just two sequences). It differs from the longest common substring problem.  Unlike substrings, subsequences are not required to occupy consecutive positions within the original sequences. The longest common subsequence problem is a classic computer science problem, and is the basis of data comparison programs such as the diff utility.  It also has applications in computational linguistics and bioinformatics, and is also widely used by revision control systems such as Git for reconciling multiple changes made to a collection of files.`n`nhttps://en.wikipedia.org/wiki/Longest_common_subsequence_problem`n`n3.141592653589793238462643383279502884197169399375105820974944592307816406286...`n`nPut new version here to see what has been added."

	twidth := 600, bwidth := 150, bwidth2 := 100, opts := "r40  0x100000" ;enable horizontal scroll
	gTComp := Gui('',"Basic Text Comparison")

	; t1 := RichEdit(gui, opts " w" twidth)				
	; t2 := RichEdit(gui, opts " w" twidth " xp" twidth)
	t1 := RichEdit(gTComp, opts " w" twidth)
	t1.Opt('+Wrap')
	t1.SetText(default1)
	t2 := RichEdit(gTComp, opts " w" twidth " xp" twidth)
	t2.Opt('+Wrap')
	t2.SetText(default2)
	btn := gTComp.AddButton("Default w" bwidth " x" gTComp.MarginX + twidth - bwidth/2, "Compare/Update")
	btn.OnEvent("Click", (*)=>compare())
	gTComp.OnEvent("Close", (*)=>ExitApp())

	gTComp.SetFont('bold')
	gTComp.AddText("yp5 xp" bwidth + 30, "Mode:")
	gTComp.SetFont('norm')
	radc := gTComp.AddRadio("vModeGroup yp0", "Char")
	radw :=	gTComp.AddRadio("yp0", "Word")
	radl :=	gTComp.AddRadio("yp0 Checked", "Line")
	gTComp.AddText("yp", "Word/Char mode is very slow on long text.  Close to terminate.") 
	; cpr := gTComp.AddButton("w" bwidth2 " y" btn.pos.y " x" gTComp.MarginX + wrap.pos.w, "Copy RED")
	cpr := gTComp.AddButton("w" bwidth2 " yp0" " x" gTComp.MarginX , "Copy RED")
	cpg := gTComp.AddButton("w" bwidth2 " yp0", "Copy GREEN")
	cpc := gTComp.AddButton("w" bwidth2 " yp0", "Copy LCS")
	; nde := gTComp.AddCheckbox("y" wrap.pos.y " xp" cpc.pos.w + 5, "``r``n (CRLF) delimited")
	nde := gTComp.AddCheckbox("yp0", "``r``n (CRLF) delimited")
	wrap := gTComp.AddCheckBox("vWrap Checked yp0 x+" gTComp.MarginX, "Word wrap")

	; (wrap.Value = 'Checked') ? (*)=> (t1.WordWrap(wrap.value), t2.WordWrap(wrap.value)) : 0

	cpr.onEvent("Click", (*)=>copy("RED"))
	cpg.onEvent("Click", (*)=>copy("GREEN"))
	cpc.onEvent("Click", (*)=>copy("LCS"))
			
	; t1.text := default1, t2.text := default2
	; t1.SetText(default1)
	; t2.SetText(default2)
	t1.WordWrap(wrap.value)
	t2.WordWrap(wrap.value)
	gTComp.show()

	copy(list) {
		global
		if !isObject(c)
			return
		cstr := t1str := t2str := ""
		de := nde.value ? "`r`n" : ""

		for _, v in c
			cstr .= v . de
		for _, v in t1Arr
			t1str .= v . de
		for _, v in t2Arr
			t2str .= v . de
		
		if (list = "red"){
			; clipboard := t1str
			A_Clipboard := t1str
		}
		else if (list = "green"){
			; clipboard := t2str
			A_Clipboard := t2str
		}
		else {
			; clipboard := cstr
			A_Clipboard := cstr
		}
	}

	compare() {
		global t1, t2, radc, radw, radl, wrap, nde, c, t1Arr := [], t2Arr := []
		
		;get t1, t2 and convert them to plain text
		; t1.text := t1text := t1.text, t2.text := t2text := t2.text	;get t1, t2 and convert them to plain text
		t1text := t1.GetText()
		
		t2text := t2.GetText()	
		
		t1.WordWrap(wrap.value)
		t2.WordWrap(wrap.value)
		if (radc.value){
			de := ""
		}
		else if (radw.value){
			de := [" ", "`n", "`r"]
		}
		else if (radl.value){
			de := ["`n", "`r"]
		}
		a := strsplit(t1text, de), b := strsplit(t2text, de), c := lcs(a, b)
		t1s := 1, t1e := 1, t2s := 1, t2e := 1, t1m := [], t2m := []
		for _, v in c {
			
			;Deleted
			while (a[t1e] !== v){
				t1e++
			}
			if (t1e > t1s){
				t1m.push(t1s, t1e--)
			}
			t1s := ++t1e

			;Inserted
			while (b[t2e] !== v){
				t2e++
			}
			if (t2e > t2s){
				t2m.push(t2s, t2e--)
			}
			t2s := ++t2e
		}
		
		consolidate(t1m, a)
		for _, v in t1m {
			if (radc.value){
				start := v[1] - 1, end := v[2]
			}
			else if (radw.value){
				start := wordStart(a, v[1]), end := wordStart(a, v[2]) + StrLen(a[v[2]])
			}
			else if (radl.value){
				start := lineStart(a, v[1]), end := lineStart(a, v[2]) + StrLen(a[v[2]])
			}
			t1.SetSel(start, end)
			t1.SetFont({BkColor:"RED", Color:"WHITE"})
			t1Arr.Push(SubStr(t1text, start + 1, end - start))
		}
		
		consolidate(t2m, b)
		for _, v in t2m {
			if (radc.value){
				start := v[1] - 1
				end := v[2]
			}
			else if (radw.value){
				start := wordStart(b, v[1])
				end := wordStart(b, v[2]) + StrLen(b[v[2]])
			}
			else if (radl.value){
				start := lineStart(b, v[1]), end := lineStart(b, v[2]) + StrLen(b[v[2]])
			} ; fix ..: double check either of the below lines belong in this else if
			t2.SetSel(start, end)
			t2.SetFont({BkColor:"GREEN", Color:"WHITE"})
			t2Arr.Push(SubStr(t2text, start + 1, end - start))
		}
		
		;Leftovers
		if (radc.value){
			start1 := t1s--
			start2 := t2s--
		}
		else if (radw.value){
			start1 := wordStart(a, t1s)
			start2 := wordStart(b, t2s)
		}
		else if (radl.value){
			start1 := lineStart(a, t1s), start2 := lineStart(b, t2s)
		} ; fix ..: double check either of the below lines belong in this else if
		t1.SetSel(start1, -1)
		t1.SetFont({BkColor:"RED", Color:"WHITE"})
		t1.SetSel(0, 0)
		t1.ScrollCaret()
		t1Arr.Push(SubStr(t1text, start1 + 1))
		t2.SetSel(start2, -1)
		t2.SetFont({BkColor:"GREEN", Color:"WHITE"})
		t2.SetSel(0, 0)
		t2.ScrollCaret()
		t2Arr.Push(SubStr(t2text, start2 + 1))
		
		
		;-------------------------------------------------------------------------------------------
		;nested helper functions for compare()
		
		consolidate(tm, t) {	;combine adjacent changes
			; if tm.Length() > 1 {
			if (tm.Length > 1) {
				loop {
					skip := false
					for k, v in tm
						if k > 1 && tm[k-1][2] + 1 == v[1] {
							tm[k-1][2] := v[2], skip := k
							break
						}	
					if !skip {
						for k, v in tm {
							if t[v[2]] == t[v[1]-1] {
								tm[k][1] := v[1]-1, tm[k][2] := v[2]-1
								break
							}
							; if k == tm.Length()
							if k == tm.Length
								break 2
						}
					}
					else 
						; tm.RemoveAt(skip)
						tm.RemoveAt(A_Index)
				}	
			}
		}
		
		;find line start position
		lineStart(lineArr, index) {
			len := 0
			; index := A_Index
			loop (index - 1){
				_len := StrLen(lineArr[A_Index])
				len += _len + 1
			}
			return len
		}

		wordStart(wordArr, index) { ;find word start position
			len := 0

			loop (index - 1){
				len += StrLen(wordArr[A_Index]) + 1
			}
			return len
		}

		lcs(a, b) { ; Longest Common Subsequence of strings, using Dynamic Programming
					; https://rosettacode.org/wiki/Longest_common_subsequence#AutoHotkey
					; https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
					; modified to accept array of strings. Comparison is CASE SENSITIVE.
			len := [], t:= []
			; Loop a.Length() + 2 {   	; Initialize
			Loop (a.Length + 2) {   	; Initialize
				i := (A_Index - 1)
				; Loop b.Length() + 2 
				Loop (b.Length + 2){ 
					j := (A_Index - 1)
					len.Push(i, j)
					i := 0
					j := 0
				}
			}
			
			for i, va in a {			; scan a
				i1 := ++i
				x := va
				for j, vb in b {		; scan b
					j1 := ++j 
					y := vb
					len.Get(i1)
					x == y ? (++i && ++j) : (u := len.Get(i1, j)) > (v := len.Get(i, j1)) ? u : v
				}
			}
			
			; x := a.Length() + 1, y := b.Length() + 1
			x := a.Length + 1, y := b.Length + 1
			While x * y {            	; construct solution from lengths
				x1 := x - 1, y1 := y - 1
				If (len.Get(x, y) = len.get(x1, y)) {
					x := x1
				}
				Else If  (len.Get(x, y) = len.Get(x, y1)) {
					y := y1
				}
				Else
					x := x1, y := y1, t.InsertAt(1, a[x])
			}
			Return t
		}
	}