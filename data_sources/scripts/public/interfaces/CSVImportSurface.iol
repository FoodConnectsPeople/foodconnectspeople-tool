type ImportFileRequest: void {
  .separator: string
  .filename: string
  .verbose?: bool
}

type ImportFileResponse: void {
  .line*: void { ? }
}

interface CSVImportInterface {
  RequestResponse:
    importFile( ImportFileRequest )( ImportFileResponse )
}

outputPort CSVImport {
  Interfaces: CSVImportInterface
}

embedded {
  Java:
    "small.utilities.CSVImport" in CSVImport
}
