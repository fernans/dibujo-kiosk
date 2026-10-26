VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "FlDbg9c.ocx"
Begin VB.Form Form1 
   BorderStyle     =   0  'None
   Caption         =   "Dibujar"
   ClientHeight    =   3090
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4680
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox Picture1 
      Height          =   255
      Left            =   3480
      ScaleHeight     =   195
      ScaleWidth      =   195
      TabIndex        =   1
      Top             =   1920
      Visible         =   0   'False
      Width           =   255
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash Flash1 
      Height          =   1215
      Left            =   1440
      TabIndex        =   0
      Top             =   600
      Width           =   1335
      _cx             =   2355
      _cy             =   2143
      FlashVars       =   ""
      Movie           =   ""
      Src             =   ""
      WMode           =   "Window"
      Play            =   -1  'True
      Loop            =   -1  'True
      Quality         =   "High"
      SAlign          =   ""
      Menu            =   -1  'True
      Base            =   ""
      AllowScriptAccess=   ""
      Scale           =   "ShowAll"
      DeviceFont      =   0   'False
      EmbedMovie      =   0   'False
      BGColor         =   ""
      SWRemote        =   ""
      MovieData       =   ""
      SeamlessTabbing =   -1  'True
      Profile         =   -1  'True
      ProfileAddress  =   ""
      ProfilePort     =   1162363743
      AllowNetworking =   "all"
      AllowFullScreen =   "false"
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Sub Sleep Lib "kernel32" (ByVal milliseconds As Long)
Dim fs As Scripting.FileSystemObject
Dim fol As Scripting.Folder
Dim nfiles As Long
Dim findex As Long
Dim fnames() As String
'Variable para usar la dll
Dim Capture As CaptureWindow

Private Sub Flash1_FSCommand(ByVal command As String, ByVal args As String)
    If (command = "SALIR") Then End
    If (command = "FIRST") Then
        'MsgBox "First"
        findex = 1
    End If
    If (command = "NEXT") Then
        'MsgBox "Next"
        findex = findex + 1
        If (findex > nfiles) Then findex = 1
    End If
    If (command = "PREV") Then
        'MsgBox "Prev"
        findex = findex - 1
        If (findex <= 0) Then findex = nfiles
    End If
    If (command = "PRINT") Then
        'Sleep 5000 'espera 5 segundos...
        Set Picture1.Picture = Capture.CapturarCliente(Me)
        Capture.PrinterPicture Printer, Picture1
        Flash1.TGotoLabel "_root", "Dibujar"
    End If
    If (command = "FIRST" Or command = "NEXT" Or command = "PREV") Then
        imagen = fnames(findex)
        'MsgBox imagen
        request = "<invoke name=" & Chr(34) & "CargarImagen" & Chr(34) & "><arguments><string>" & imagen & "</string></arguments></invoke>"
        Flash1.CallFunction request
    End If
End Sub

Private Sub Form_Load()
    'Flash1.Movie = App.Path & "\dibujo.swf"
    Flash1.Movie = App.Path & "\interfaz.mdl"
    
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set fol = fs.GetFolder(App.Path & "\images")
    nfiles = fol.Files.Count
    ReDim fnames(0 To nfiles)
    findex = 1
    For Each f In fol.Files
        If (fs.GetExtensionName(f.Path) = "png") Then
            fnames(findex) = f.Name
            findex = findex + 1
        End If
    Next
    nfiles = findex - 1
    findex = 1
    If nfiles < 1 Then
        MsgBox "La carpeta 'images' no existe, o está vacia."
        End
    End If
    Set Capture = New CaptureWindow
    Capture.AjustarPicToPage = True 'se ajusta a la hoja
End Sub

Private Sub Form_Resize()
    Flash1.Left = 0
    Flash1.Top = 0
    Flash1.Width = Me.Width
    Flash1.Height = Me.Height
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set Capture = Nothing
End Sub
