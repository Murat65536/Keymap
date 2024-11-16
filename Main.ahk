#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ScrollBar.ahk

class Keymap extends Gui {
    __New(WindowWidth, WindowHeight) {
        super.__New(, "Keymap")
        this.WindowWidth := WindowWidth
        this.WindowHeight := WindowHeight
        this.Hotkeys := []
        super.AddButton("x10 y10 w20 h20", "+").OnEvent("Click", (*) => this.__AddHotkey())
        super.Show("w" this.WindowWidth " h" this.WindowHeight)
    }

    __AddHotkey() {
        this.Hotkeys.Push(Map("TriggerText", "", "ActionText", "", "Trigger", "", "Action", ""))
        this.__UpdateList()
    }

    __RemoveHotkey(Index, *) {
        Try {
            Hotkey(this.Hotkeys[Index]["Trigger"], "Off")
        }
        this.Hotkeys.RemoveAt(Index)
        this.__UpdateList()
    }

    __UpdateList() {
        Try {
            this.HotkeyList.Destroy()
        }
        this.HotkeyList := Gui("+Parent" super.Hwnd " -Caption")
        Loop this.Hotkeys.Length {
            this.HotkeyList.AddGroupBox("x20 y" 20 + (A_Index - 1) * 110 " w" this.WindowWidth * 0.8 " h100", "Hotkey")
            this.HotkeyList.AddText("x30 y" 40 + (A_Index - 1) * 110 " w100 h20", "Trigger")
            this.HotkeyList.AddEdit("x30 y" 60 + (A_Index - 1) * 110 " w100 h20", this.Hotkeys[A_Index]["TriggerText"]).OnEvent("Change", ObjBindMethod(this, "__UpdateTriggerText", A_Index))
            this.HotkeyList.AddText("x150 y" 40 + (A_Index - 1) * 110 " w100 h20", "Action")
            this.HotkeyList.AddEdit("x150 y" 60 + (A_Index - 1) * 110 " w100 h20", this.Hotkeys[A_Index]["ActionText"]).OnEvent("Change", ObjBindMethod(this, "__UpdateActionText", A_Index))
            this.HotkeyList.AddButton("x30 y" 90 + (A_Index - 1) * 110 " w60 h20", "Append").OnEvent("Click", ObjBindMethod(this, "__AppendHotkey", A_Index))
            this.HotkeyList.AddButton("x500 y" 90 + (A_Index - 1) * 110 " w20 h20", "-").OnEvent("Click", ObjBindMethod(this, "__RemoveHotkey", A_Index))
        }
        ; DllCall("ShowScrollBar", "ptr", this.HotkeyList.Hwnd, "int", 1, "int", true)
        ; this.Scroll := ScrollInfo()
        ; this.__GetPageSize(this.HotkeyList, &Left, &Right, &Up, &Down)
        ; this.Scroll.nMax := Down - Up
        ; this.Scroll.nPage := this.WindowHeight
        ; this.Scroll.fMask := 1 | 2
        ; DllCall("SetScrollInfo", "ptr", this.HotkeyList.Hwnd, "int", 1, "ptr", this.Scroll.Ptr, "int", true)
        ; this.Scroll.fMask := 1 | 2 | 4 | 16
        ; ScrollBar(this.HotkeyList, this.WindowWidth * 0.9, this.WindowHeight)
        this.HotkeyList.Show("w" this.WindowWidth * 0.9 " h" 110 + (this.Hotkeys.Length - 1) * 110)
    }

    __UpdateTriggerText(Index, GuiCtrlObj, *) {
        this.Hotkeys[Index]["TriggerText"] := GuiCtrlObj.Text
    }

    __UpdateActionText(Index, GuiCtrlObj, *) {
        this.Hotkeys[Index]["ActionText"] := GuiCtrlObj.Text
    }

    __AppendHotkey(Index, *) {
        this.Hotkeys[Index]["Trigger"] := this.Hotkeys[Index]["TriggerText"]
        this.Hotkeys[Index]["Action"] := this.Hotkeys[Index]["ActionText"]
        Try {
            Hotkey(this.Hotkeys[Index]["Trigger"], (*) => Send(this.Hotkeys[Index]["Action"]))
            Hotkey(this.Hotkeys[Index]["Trigger"], "On")
        }
    }

    __GetPageSize(Window, &Left?, &Right?, &Up?, &Down?) {
        GuiObjects := WinGetControls(Window.Hwnd)
        Left := 9223372036854775807
        Right := 0
        Up := 9223372036854775807
        Down := 0

        For Object in GuiObjects {
            Window[Object].GetPos(&ObjectX, &ObjectY, &ObjectWidth, &ObjectHeight)
            Left := Max(Left, ObjectX)
            Right := Max(Right, ObjectX + ObjectWidth)
            Up := Max(Up, ObjectY)
            Down := Max(Down, ObjectY + ObjectHeight)
        }

        Left -= 8
        Right -= 8
        Up -= 8
        Down -= 8
    }
}

Keymap(640, 480)