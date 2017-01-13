
csv_format = 6

Set objFSO = CreateObject("Scripting.FileSystemObject")

src_file = objFSO.GetAbsolutePathName("FoodConnectsPeople.xlsx")


Dim oExcel
Set oExcel = CreateObject("Excel.Application")

Dim oBook
Set oBook = oExcel.Workbooks.Open(src_file)


oBook.Worksheets(1).Activate
dest_file = objFSO.GetAbsolutePathName("recipes")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(2).Activate
dest_file = objFSO.GetAbsolutePathName("recipe2ingredients")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(3).Activate
dest_file = objFSO.GetAbsolutePathName("unitconversions")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(4).Activate
dest_file = objFSO.GetAbsolutePathName("events")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(5).Activate
dest_file = objFSO.GetAbsolutePathName("recipe2events")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(6).Activate
dest_file = objFSO.GetAbsolutePathName("recipe2tools")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(7).Activate
dest_file = objFSO.GetAbsolutePathName("ingredients")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(8).Activate
dest_file = objFSO.GetAbsolutePathName("translations")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(9).Activate
dest_file = objFSO.GetAbsolutePathName("countries")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(10).Activate
dest_file = objFSO.GetAbsolutePathName("categories")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(11).Activate
dest_file = objFSO.GetAbsolutePathName("fcpusers")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(12).Activate
dest_file = objFSO.GetAbsolutePathName("authorsrecipes")
oBook.SaveAs dest_file, csv_format

oBook.Worksheets(13).Activate
dest_file = objFSO.GetAbsolutePathName("tools")
oBook.SaveAs dest_file, csv_format


oBook.Close False
oExcel.Quit
