# dibujo-kiosk

Colour-drawing kiosk application for Windows (2006–2008), a Visual Basic 6 shell hosting the **Macromedia Flash 9 ActiveX control** (`FlDbg9c.ocx`, kept in-tree since requires registration) to run a Full-screen Flash drawing interface — loaded from `interfaz.mdl`, actually an SWF file renamed by the installer wizard.

How it works (see `development/Form1.frm`):

- The VB host loads the Flash movie fullscreen and connects via **FSCommand/ExternalInterface**: `SALIR` closes the app; `FIRST`/`NEXT`/`PREV` cycle the illustration list built by scanning `images\*.png` at start-up.
- The Flash overlay calls `CargarImagen(<filename>)` to draw the selected overlay picture; users draw on top of it.
- `PRINT` captures the whole client area (via the custom **CaptureWindow.dll**, in-tree, fitted to the page) and sends it to the default printer, then loops the Flash clip back to the "Dibujar" label.
- The illustration overlays (`jocoso`, `minie`, `oso` "bear") are designed with their own FLA sources in `development/images/development/`.

Setup wizard output (VB6 Package & Deployment, 2008) is kept in `instalador/` (setup.exe + CAB with the VB6 ES runtime + OCX + DLL).

> **This project is shared ONLY for educational purposes. Its use, direct or derived, for professional or economic purposes is not permitted.**

For security reasons, some parts of the project may have been edited or removed: `development/Dibujar.PDM` (VB6 packaging metadata containing the developer's local machine path) is excluded, as well as the original scan references (`development/images/development/IMG_0125.*`) and duplicate RAR archives. Everything else is published as-is.

## Requirements / How to run

- Windows with the Visual Basic 6 runtime (the `instalador/setup.exe` or the CAB contents install `msvbvm60.dll` + VB6ES + the Flash OCX).
- To rebuild: open `development/Dibujar.vbp` in VB6 with `FlDbg9c.ocx` registered, keep `CaptureWindow.dll` (source of the `Capture.CapturarCliente` / `PrinterPicture` calls) registered and the illustration PNGs in `images\`.
- Flash swfs were authoring with Flash CS/8-era tooling (`dibujo.fla`, `interfaz` mockups in `docs/interfaz/`).
- No printer/viewer service is contacted; everything is local.

No warranty of any kind is provided, and no liability is accepted for errors or damages resulting from its use of this software.

Additionally, the use of this project's content (code, documentation or assets) to train artificial intelligence or machine-learning systems is not permitted without the explicit permission of the author. Licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) — see [`LICENSE`](LICENSE).

---

# dibujo-kiosk

Aplicación kiosco de dibujo para colorear para Windows (2006–2008): una envolvente en **Visual Basic 6** que hospeda el **control ActiveX de Macromedia Flash 9** (`FlDbg9c.ocx`, incluida en el árbol porque se requiere registrada) para ejecutar una interfaz de dibujo en Flash a pantalla completa — cargada desde `interfaz.mdl`, que es un fichero SWF renombrado por el asistente de instalación.

Funcionamiento (ver `development/Form1.frm`):

- El host con VB carga la película Flash a pantalla completa y se conecta vía **FSCommand/ExternalInterface**: `SALIR` cierra; `FIRST`/`NEXT`/`PREV` recorren la lista de ilustraciones construida al inicio escaneando `images\*.png`.
- La capa Flash llama a `CargarImagen(<fichero>)` para pintar la imagen de plantilla seleccionada; el usuario dibuja encima.
- `PRINT` captura toda el área de cliente (con la **CaptureWindow.dll** propia, incluida, ajustada a la página) y lo envía a la impresora por defecto, volviendo al label "Dibujar" de Flash.
- Las plantillas (`jocoso`, `minie`, `oso`) se diseñaron con sus FLA fuente en `development/images/development/`.

Se conserva el output del asistente de instalación (VB6 Package & Deployment, 2008) en `instalador/` (setup.exe + CAB con el runtime VB6 ES + OCX + DLL).

> **Este proyecto se comparte SOLO con valor educativo. No está permitido su uso (directo o derivado) para fines profesionales o económicos.**

Por motivos de seguridad, algunas partes del proyecto pueden encontrarse editadas o eliminadas: `development/Dibujar.PDM` (metadatos de empaquetado VB6 con la ruta local de la máquina de desarrollo) está excluido, igual que las referencias del scan original (`development/images/development/IMG_0125.*`) y los archivos RAR duplicados. Todo lo demás se publica tal cual.

## Requisitos / Cómo ejecutar

- Windows con el runtime de Visual Basic 6 (el `instalador/setup.exe` o el contenido del CAB instalan `msvbvm60.dll` + VB6ES + el OCX de Flash).
- Para recompilar: abrir `development/Dibujar.vbp` en VB6 con `FlDbg9c.ocx` registrada, mantener `CaptureWindow.dll` (origen de las llamadas `Capture.CapturarCliente` / `PrinterPicture`) registrada y las plantillas PNG en `images\`.
- Los SWF se generaron con herramientas de la era Flash CS/8 (`dibujo.fla`, mockups de `interfaz` en `docs/interfaz/`).
- No se contacta ningún servicio de impresión/exposición externo: todo es local.

Este software se suministra sin garantía de ningún tipo, y no se asume ninguna responsabilidad por errores o daños que puedan producirse a partir de su uso.

Adicionalmente, no está permitido el uso del contenido de este proyecto (código, documentación o assets) para entrenar sistemas de inteligencia artificial o de aprendizaje automático sin el permiso explícito del autor. Licenciado bajo [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) — ver [`LICENSE`](LICENSE).
