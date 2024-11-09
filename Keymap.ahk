#Requires AutoHotkey v2.0
#SingleInstance Force

class Keymap extends Gui {
    __New(WindowWidth, WindowHeight) {
        this.WindowWidth := WindowWidth
        this.WindowHeight := WindowHeight
        ButtonWidth := 40
        ButtonHeight := 40
        super.__New()
        super.OnEvent("Close", (*) => ExitApp())
        Q := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 4.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "Q")
        Q.OnEvent("Click", (*) => this.__AssignKey("Q"))
        W := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 3.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "W")
        W.OnEvent("Click", (*) => this.__AssignKey("W"))
        E := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 2.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "E")
        E.OnEvent("Click", (*) => this.__AssignKey("E"))
        R := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 1.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "R")
        R.OnEvent("Click", (*) => this.__AssignKey("R"))
        T := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 0.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "T")
        T.OnEvent("Click", (*) => this.__AssignKey("T"))
        Y := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 0.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "Y")
        Y.OnEvent("Click", (*) => this.__AssignKey("Y"))
        U := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 1.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "U")
        U.OnEvent("Click", (*) => this.__AssignKey("U"))
        I := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 2.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "I")
        I.OnEvent("Click", (*) => this.__AssignKey("I"))
        O := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 3.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "O")
        O.OnEvent("Click", (*) => this.__AssignKey("O"))
        P := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 4.5 " y" ButtonHeight * 1 " w" ButtonWidth " h" ButtonHeight, "P")
        P.OnEvent("Click", (*) => this.__AssignKey("P"))
        A := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 4.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "A")
        A.OnEvent("Click", (*) => this.__AssignKey("A"))
        S := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 3.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "S")
        S.OnEvent("Click", (*) => this.__AssignKey("S"))
        D := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 2.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "D")
        D.OnEvent("Click", (*) => this.__AssignKey("D"))
        F := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 1.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "F")
        F.OnEvent("Click", (*) => this.__AssignKey("F"))
        G := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 0.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "G")
        G.OnEvent("Click", (*) => this.__AssignKey("G"))
        H := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 1.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "H")
        H.OnEvent("Click", (*) => this.__AssignKey("H"))
        J := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 2.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "J")
        J.OnEvent("Click", (*) => this.__AssignKey("J"))
        K := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 3.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "K")
        K.OnEvent("Click", (*) => this.__AssignKey("K"))
        L := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 4.0 " y" ButtonHeight * 2 " w" ButtonWidth " h" ButtonHeight, "L")
        L.OnEvent("Click", (*) => this.__AssignKey("L"))
        Z := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 3.0 " y" ButtonHeight * 3 " w" ButtonWidth " h" ButtonHeight, "Z")
        Z.OnEvent("Click", (*) => this.__AssignKey("Z"))
        X := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 2.0 " y" ButtonHeight * 3 " w" ButtonWidth " h" ButtonHeight, "X")
        X.OnEvent("Click", (*) => this.__AssignKey("X"))
        C := super.AddButton("x" WindowWidth * 0.5 - ButtonWidth * 1.0 " y" ButtonHeight * 3 " w" ButtonWidth " h" ButtonHeight, "C")
        C.OnEvent("Click", (*) => this.__AssignKey("C"))
        V := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 0.0 " y" ButtonHeight * 3 " w" ButtonWidth " h" ButtonHeight, "V")
        V.OnEvent("Click", (*) => this.__AssignKey("V"))
        B := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 1.0 " y" ButtonHeight * 3 " w" ButtonWidth " h" ButtonHeight, "B")
        B.OnEvent("Click", (*) => this.__AssignKey("B"))
        N := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 2.0 " y" ButtonHeight * 3 " w" ButtonWidth " h" ButtonHeight, "N")
        N.OnEvent("Click", (*) => this.__AssignKey("N"))
        M := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * 3.0 " y" ButtonHeight * 3 " w" ButtonWidth " h" ButtonHeight, "M")
        M.OnEvent("Click", (*) => this.__AssignKey("M"))

        super.Show("w" this.WindowWidth " h" this.WindowHeight)
        this.HotkeyInterface := unset
        this.Hotkeys := this.__GetHotkeys()
        for Key, Value in this.Hotkeys {
            this.__ActivateHotkey(Key, Value)
        }
    }

    __AssignKey(Name) {
        try {
            this.HotkeyInterface.Destroy()
        }
        this.HotkeyInterface := Gui("+Parent" super.Hwnd " -Caption")
        this.HotkeyInterface.AddGroupBox("x0 y0 w" this.WindowWidth " h" this.WindowHeight / 2, Name)
        Result := this.HotkeyInterface.AddEdit("x10 y20 w120 h20", this.Hotkeys.Has(Name) ? this.Hotkeys[Name] : "")
        Apply := this.HotkeyInterface.AddButton("x10 y40 w60 h20", "Apply")
        Apply.OnEvent("Click", (*) => this.__ActivateHotkey(Name, Result.Value))
        this.HotkeyInterface.Show("x0 y" this.WindowHeight / 2 " w" this.WindowWidth " h" this.WindowHeight / 2)
    }

    __DeactivateHotkey(Input) {
        Hotkey(Input, "Off")
        this.Hotkeys.Delete(Input)
        this.__SetHotkeys()
    }

    __ActivateHotkey(Input, Output) {
        this.Hotkeys[Input] := Output
        Hotkey(Input, (*) => Send(this.Hotkeys[Input]))
        Hotkey(Input, "On")
        this.__SetHotkeys()
    }

    __GetHotkeys() {
        Hotkeys := Map()
        Hotkeys.CaseSense := "Off"
        loop parse Trim(FileRead("Hotkeys.txt"), "`n"), "`n" {
            CurrentHotkey := StrSplit(A_LoopField, ",")
            Hotkeys[CurrentHotkey[1]] := CurrentHotkey[2]
        }
        return Hotkeys
    }

    __SetHotkeys() {
        File := FileOpen("Hotkeys.txt", "w")
        Text := ""
        for Key, Value in this.Hotkeys {
            Text .= Key "," Value "`n"
        }
        File.Write(Trim(Text, "`n"))
    }
}

KeymapGUI := Keymap(1200, 600)