#Requires AutoHotkey v2.0
#SingleInstance Force

class Keymap extends Gui {
    __New(WindowWidth, WindowHeight) {
        this.WindowWidth := WindowWidth
        this.WindowHeight := WindowHeight
        ButtonWidth := 65
        ButtonHeight := 40
        this.Characters := [
            [
                ["``", "~", unset],
                ["1", "!", unset],
                ["2", "@", unset],
                ["3", "#", unset],
                ["4", "$", unset],
                ["5", "%", unset],
                ["6", "^", unset],
                ["7", "&&", unset],
                ["8", "*", unset],
                ["9", "(", unset],
                ["0", ")", unset],
                ["-", "_", unset],
                ["=", "+", unset],
                ["Backspace", "Backspace", unset]
            ],
            [
                ["Tab", "Tab", unset],
                ["q", "Q", unset],
                ["w", "W", unset],
                ["e", "E", unset],
                ["r", "R", unset],
                ["t", "T", unset],
                ["y", "Y", unset],
                ["u", "U", unset],
                ["i", "I", unset],
                ["o", "O", unset],
                ["p", "P", unset],
                ["[", "{", unset],
                ["]", "}", unset],
                ["\", "|", unset]
            ],
            [
                ["Caps Lock", "Caps Lock", unset],
                ["a", "A", unset],
                ["s", "S", unset],
                ["d", "D", unset],
                ["f", "F", unset],
                ["g", "G", unset],
                ["h", "H", unset],
                ["j", "J", unset],
                ["k", "K", unset],
                ["l", "L", unset],
                [";", ":", unset],
                ["'", "`"", unset],
                ["Enter", "Enter", unset]
            ],
            [
                ["Shift", "Shift", unset],
                ["z", "Z", unset],
                ["x", "X", unset],
                ["c", "C", unset],
                ["v", "V", unset],
                ["b", "B", unset],
                ["n", "N", unset],
                ["m", "M", unset],
                [",", "<", unset],
                [".", ">", unset],
                ["/", "?", unset]
            ],
            [
                ["Ctrl", "Ctrl", unset],
                ["LWin", "LWin", unset],
                ["Alt", "Alt", unset],
                ["Space", "Space", unset]

            ]
        ]
        super.__New()
        super.OnEvent("Close", (*) => ExitApp())
        this.ShiftActive := super.AddCheckbox("x10 y10", "Shift")
        this.ShiftActive.OnEvent("Click", (*) => this.__SetCharacters())
        CurrentRow := 1
        For Row in this.Characters {
            For Key in Row {
                Key[3] := super.AddButton("x" WindowWidth * 0.5 + ButtonWidth * (-Row.Length / 2 + A_Index - 1) " y" ButtonHeight * CurrentRow " w" ButtonWidth " h" ButtonHeight)
            }
            CurrentRow++
        }
        this.__SetCharacters()

        super.Show("w" this.WindowWidth " h" this.WindowHeight)
        this.HotkeyInterface := unset
        this.Hotkeys := this.__GetHotkeys()
        For Key, Value in this.Hotkeys {
            this.__ActivateHotkey(Key, Value)
        }
    }

    __AssignKey(Name, Modifier) {
        Try {
            this.HotkeyInterface.Destroy()
        }
        this.HotkeyInterface := Gui("+Parent" super.Hwnd " -Caption")
        this.HotkeyInterface.AddGroupBox("x0 y0 w" this.WindowWidth " h" this.WindowHeight / 2, Name)
        Result := this.HotkeyInterface.AddEdit("x10 y20 w120 h20", this.Hotkeys.Has(Name) ? this.Hotkeys[Name] : "")
        Apply := this.HotkeyInterface.AddButton("x10 y40 w60 h20", "Apply")
        Apply.OnEvent("Click", (*) => this.__ActivateHotkey(Modifier . Name, Result.Value))
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
        Loop Parse Trim(FileRead("Hotkeys.txt"), "`n"), "`n" {
            CurrentHotkey := StrSplit(A_LoopField, ",")
            Hotkeys[CurrentHotkey[1]] := CurrentHotkey[2]
        }
        Return Hotkeys
    }

    __SetHotkeys() {
        File := FileOpen("Hotkeys.txt", "w")
        Text := ""
        For Key, Value in this.Hotkeys {
            Text .= Key "," Value "`n"
        }
        File.Write(Trim(Text, "`n"))
    }

    __SetCharacters() {
        CurrentRow := 1
        For Row in this.Characters {
            For Key in Row {
                Key[3].Text := this.ShiftActive.Value ? Key[2] : Key[1]
                If this.ShiftActive.Value {
                    Key[3].OnEvent("Click", (GuiControlObject, *) => this.__AssignKey(GuiControlObject.Text, "+"))
                }
                Else {
                    Key[3].OnEvent("Click", (GuiControlObject, *) => this.__AssignKey(GuiControlObject.Text, ""))
                }
            }
            CurrentRow++
        }
    }
}

KeymapGUI := Keymap(1200, 600)