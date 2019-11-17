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
    // pide nombre de archivo
    sExcelName = input("Da el nombre del archivo de Excel (sin la extensión)", "string")
    // lee las hojas del excel
    dSheets = readxls(sExcelName + '.xls')
    // lee la primera hoja del excel
    dSheet1 = dSheets(1)
    // la matriz almacena los valores de las x y las y
    iMatValues = dSheet1( : , 1 : 2)
endfunction


/////// Programa Principal

// lee los programas de excel
iMatValues = GetExcelValues()
disp(iMatValues)


