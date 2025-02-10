strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Network = FALSE")

For Each objPrinter in colInstalledPrinters
    objPrinter.Delete_
Next