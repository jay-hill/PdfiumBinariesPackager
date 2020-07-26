
# Packaging Pre-compiled binaries of PDFium

This project packages the pre-compiled binaries from the [pdfium-binaries project](https://github.com/bblanchon/pdfium-binaries) so that they can be used in other projects such as the version of [PDFiumViewer](https://github.com/jay-hill/PdfiumViewer) which has been modified to use these more up to date binaries

# Prerequisites

You will need to install [chocolaty](https://chocolatey.org/) in order to run the package.ps1 powershell script.  The nuget packages will be in the pack directory afer the script completes.

Pick the binaries you want to package from the available [releases](https://github.com/bblanchon/pdfium-binaries/releases)

---

This project isn't affilated with Google nor Foxit.

Many thanks to [Pieter van Ginkel](https://github.com/pvginkel) for creating the PDFiumViewer project & [Benoît Blanchon](https://github.com/bblanchon) for generating the stable binaries of the pdfium project.


