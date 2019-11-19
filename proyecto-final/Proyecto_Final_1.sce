clear
///////////////////////////////////////////////////////
//  Proyecto_Final_1.sce
//
//
//   Armando Roque A01138717
//   Marco Brown Cunningham 
//
//   16 / Noviembre  / 2019    version 1.0
//////////////////////////////////////////////////////

function iMatValues = GetExcelValues()
    // pide al usuario que seleccione el archivo
    sExcelName = uigetfile("*.xls")
    disp(sExcelName)
    // lee las hojas del excel
    dSheets = readxls(sExcelName)
    // lee la primera hoja del excel
    dSheet1 = dSheets(1)
    // la matriz almacena los valores de las x y las y
    iMatValues = dSheet1( : , 1 : 2)
endfunction


/////// Programa Principal

// lee los programas de excel
iMatValues = GetExcelValues()
disp(iMatValues)


