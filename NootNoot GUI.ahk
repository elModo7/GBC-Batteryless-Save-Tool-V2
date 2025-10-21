;@Ahk2Exe-SetName NootNoot GUI
;@Ahk2Exe-SetDescription Bootleg cartridge save injector and extractor
;@Ahk2Exe-SetVersion 1.0.0
;@Ahk2Exe-SetCopyright Copyright (c) 2025`, BennVenn • elModo7 / VictorDevLog
;@Ahk2Exe-SetOrigFilename NootNoot GUI.exe
version := "1.0"
#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
#Include <Neutron>
#Include <AboutScreen>
global romFilePath
FileInstall, lib/NootNoot.exe, % A_Temp "\NootNoot.exe", 1

Menu, Tray, NoStandard
Menu, Tray, Tip, NootNoot GUI %version%
Menu, tray, add, About, showAboutScreen
Menu, Tray, Add
Menu, Tray, Add, Exit, NeutronClose

neutron := new NeutronWindow()
neutron.Load("lib/nootnoot.html")
neutron.Gui("+LabelNeutron")
neutron.doc.getElementById("windowTitle").innerHTML := "NootNoot GUI • Bootleg Cart Save Injector & Extractor • BennVenn • elModo7 / VictorDevLog " A_YYYY " v" version
neutron.Show("w1200 h430")
OnExit, GuiClose
return

FileInstall, lib/nootnoot.html, nootnoot.html
FileInstall, lib/bootstrap.min.css, bootstrap.min.css
FileInstall, lib/bootstrap.min.js, bootstrap.min.js
FileInstall, lib/jquery.min.js, jquery.min.js

BrowseRom(neutron, event) {
	global romFilePath
    FileSelectFile, romFilePath, 3,, Select Batteryless ROM, Game Boy ROM (*.gbc; *.sgb; *.gb)
	neutron.doc.getElementById("keyInput").innerText := romFilePath
}

InjectSave(neutron, event) {
	global
    if (romFilePath = "")
    {
        MsgBox, 48, Missing path, Please select a ROM first.
        Return
    }
    FileSelectFile, saveFilePath,,,Select save file to inject, Game Boy Save (*.sav; *.srm; *.sa1)
	if (saveFilePath == "")
	{
		MsgBox, 48, Error, Please select a Save file.
		return
	}
	RunWait, %A_Temp%\NootNoot.exe "%romFilePath%" "%saveFilePath%",, Hide
	MsgBox 0x40, Done!, Save file injected.
}

ExtractSave(neutron, event) {
	global
    if (romFilePath == "")
    {
        MsgBox, 48, Missing ROM, Please select a ROM file first.
        Return
    }
	RunWait, %A_Temp%\NootNoot.exe "%romFilePath%",, Hide
	MsgBox 0x40, Done!, Save file was extracted.
}

showAboutScreen:
	showAboutScreen("NootNoot GUI v" version, "Graphical version of Bootleg cartridge save injector and extractor NootNoot by BennVenn.")
return

NeutronClose:
GuiClose:
GuiEscape:
   Gui, Destroy
ExitApp

aboutGuiEscape:
aboutGuiClose:
	AboutGuiClose()
return