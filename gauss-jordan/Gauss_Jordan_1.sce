clear

///////////////////////////////////////////////////////
//  Gauss_Jordan_1.sce
//
//  Este programa pide una serie de ecuaciones y obtiene
//  su solucion utilizando el método de Gauss-Jordan
//
//   Armando Roque A01138717
//   Marco Brown A00822215
//
//   1 / OCT  / 19    version 1.0
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
//  Funcion que imprime la matriz
//
//   Parametros:
//      matAns la matriz a imprimir
//   Regresa:
//     nada
/////////////////////////////////////////////////////
function DisplayMatrix(matAns)
    disp(matAns)
endfunction

//////////////////////////////////////////////////////
//  GaussJordan
//
//  Funcion que aplica el método de Gauss-Jordan a una
//  matriz
//
//   Parametros:
//     matPar  matriz que tiene el sistema de ecuaciones
//   Regresa:
//     nada
/////////////////////////////////////////////////////
function GaussJordan(matPar)
    // Recorre todos los renglones
    for iRen = 1 : size(matPar, 1)
        // El elemento pivote siempre está en la diagonal
        dPivote = matPar(iRen, iRen)
        // Cambia el renglón del elemento pivote y cada número lo divide entre el elemento pivote
        for iCol = 1 : size(matPar, 2)
            matPar(iRen, iCol) = matPar(iRen, iCol) / dPivote
        end
        // Recorre todos los renglones para ir dejando la matriz en ceros y la diagonal el uno
        for iRenK = 1 : size(matPar, 1)
            // Solamente se aplica a filas donde no está el elemento pivote
            if iRen <> iRenK
                // Se calcula el factor por el que hay que multiplicar el pivote para dejar en cero los números arriba y abajo del pivote
                dFact = -(matPar(iRenK, iRen))
                // Se aplica el factor a todo el renglón.
                for iCol = 1 : size(matPar, 2)
                    matPar(iRenK, iCol) = matPar(iRenK, iCol) + dFact * matPar(iRen, iCol)
                end
            end
        end
        // Se imprime la matriz después de cada paso
        DisplayMatrix(matPar)
    end
endfunction

/////// Programa Principal
// pido los valores
matPar = GetMatrix()
// evaluo la serie con los valores obtenidos
GaussJordan(matPar)