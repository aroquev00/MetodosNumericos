clear

///////////////////////////////////////////////////////
//  Gauss_Jordan_1.sce
//
//  Este programa pide una serie de ecuaciones y obtiene
//  su solucion utilizando el método de Gauss-Jordan
//
//   Armando Roque A01138717
//   30 / SEP  / 19    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//  GetMatrix
//
//  Funcion que pide el sistema de ecuaciones al usuario
//
//   Parametros:
//      no tiene
//   Regresa:
//     matPar     la matriz con los valores a utilizar
/////////////////////////////////////////////////////
function matPar = GetMatrix()
    // pide datos
    tam = input("Ingresa el numero de variables a despejar ")
    // recorre renglones
    for iRen = 1 : tam
        // recorre columnas
        for iCol = 1 : tam
            // llena los datos de las variables
            matPar(iRen, iCol) = input("Ingresa el coeficiente de la variable en la posicion " + string(iCol) + " de la " + string(iRen) + "a ecuacion ")
        end
        // llena los datos de las constantes
        matPar(iRen, tam + 1) = input("Ingresa el termino constante de la " + string(iRen) + "a ecuacion ")
    end
endfunction

//////////////////////////////////////////////////////
//  DisplayMatrix
//
//  Funcion que imprime los resultados
//
//   Parametros:
//      matAns la matriz con la solucion X
//   Regresa:
//     no tiene
/////////////////////////////////////////////////////
function DisplayMatrix(matAns)
    for iX = 1 : size(matAns,1)
        disp("El valor de la variable en la " + string(iX) + "a posicion es: " + string(matAns(iX, size(matAns, 2))))
    end
endfunction

//////////////////////////////////////////////////////
//  GaussJordan
//
//  Funcion que calcula las soluciones al sistema de
//  ecuaciones
//
//   Parametros:
//      matPar  matriz que tiene el sistema de ecuaciones
//   Regresa:
//     matPar   matriz transformada con los resultados en la última columna
/////////////////////////////////////////////////////
function matPar = GaussJordan(matPar)
    for iRen = 1 : size(matPar, 1)
        dPivote = matPar(iRen, iRen)
        for iCol = size(matPar, 2)
            matPar(iCol, iRen) = matPar(iCol, iRen)
        end
        for iRenK = 1 : size(matPar, 1)
            if iRen <> iRenK
                dFact = -(matPar(iRenK, iRen))
                for iCol = 1 : size(matPar, 2)
                    matPar(iRenK, iCol) = matPar(iRenK, iCol) + dFact * matPar(iRen, iCol)
                end
            end
        end
    end
endfunction

/////// Programa Principal
// pido los valores
matPar = PedirDatos()
// evaluo la serie con los valores obtenidos
matAns = GaussJordan(matPar)
// imprimir resultados
DisplayMatrix(matAns)