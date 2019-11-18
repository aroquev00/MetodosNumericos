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

// leer valores del excel
function iMatValues = GetExcelValues()
    // pide nombre de archivo
    sExcelName = input("Da el nombre del archivo de Excel (sin la extension)", "string")
    // lee las hojas del excel
    dSheets = readxls('datos.xls')
    // lee la primera hoja del excel
    dSheet1 = dSheets(1)
    // la matriz almacena los valores de las x y las y
    iMatValues = dSheet1( : , 1 : 2)
endfunction

// Montante

//////////////////////////////////////////////////////
//  Montante
//
//  Funcion que imprime la matriz transformada y los
//resultados de las incognitas de la matriz
//   Parametros:
//      matMon la matriz a transformar
//   Regresa:
//     iArrRegression un arreglo con las respuestas
/////////////////////////////////////////////////////
function iArrRegression = Montante(matMon)
    iPivAnt=1
    //empieza en uno porque no existe uno anterior
    for iRen=1:size(matMon,1)
        //se realiza el pivoteo con todos los renglones
        for iK=1:size(matMon,1)
            //se toma un renglon K con el que se pivotean los demas
            if(iK<>iRen)
                //el renglon del valor K actual no cambia
                for iCol=iRen+1:size(matMon,2)
                    //se toman los valores desde el renglon +1 porque los otros ya se han tomado en cuenta.
                    matMon(iK,iCol)=(matMon(iRen,iRen)*matMon(iK,iCol)-matMon(iK,iRen)*matMon(iRen,iCol))/iPivAnt
                    //se realizan los determinantes entre el pivote anterior
                end
                matMon(iK,iRen)=0
                //los demas de la columna se transforman a 0
             end
        end
        iPivAnt=matMon(iRen,iRen)
        //el pivote anterior cambia por el renglon K
    end
    for(iRen=1:size(matMon,1)-1)
        //el ultimo pivote anterior toma las posiciones de los demas repitiendose
        matMon(iRen,iRen)=iPivAnt
    end
    for iRen=1:size(matMon,1)
        //se expresan los resultados 
        iArrRegression(iRen)=matMon(iRen,size(matMon,2))/iPivAnt
    end
endfunction



// funcion que te regresa los valores que ocupas
// 1- Lineal
// 2- Cuadratica
// 3- Exponencial
// 4- Potencia
function iArrParams = GetParamsRegression(iMatValues, iType)
    // numero de elementos (renglones)
    iN = size(iMatValues, 1)
    iArrParams(1) = iN

    if (iType < 4) then
        // sumatoria de X's
        iSumX = 0
        for (iRen = 1 : iN)
            iSumX = iSumX + iMatValues(iRen, 1)
        end
        iArrParams(2) = iSumX

        // sumatoria de X^2s
        iSumX2 = 0
        for (iRen = 1 : iN)
            iSumX2 = iSumX2 + (iMatValues(iRen, 1)) ^ 2
        end
        iArrParams(3) = iSumX2

        if (iType < 3) then
            // sumatoria de Y's
            iSumY = 0
            for (iRen = 1 : iN)
                iSumY = iSumY + iMatValues(iRen, 2)
            end

            // sumatoria de (X * Y)'s
            iSumXY = 0
            for (iRen = 1 : iN)
                iSumXY = iSumXY + (iMatValues(iRen, 1) * iMatValues(iRen, 2))
            end

            if (iType == 1) then
                iArrParams(4) = iSumY
                iArrParams(5) = iSumXY
            else
                // es de tipo 2 (cuadratica)
                // sumatoria de X^3s
                iSumX3 = 0
                for (iRen = 1 : iN)
                    iSumX3 = iSumX3 + (iMatValues(iRen, 1)) ^ 3
                end
                iArrParams(4) = iSumX3

                // sumatoria de X^4s
                iSumX4 = 0
                for (iRen = 1 : iN)
                    iSumX4 = iSumX4 + (iMatValues(iRen, 1)) ^ 4
                end
                iArrParams(5) = iSumX4

                iArrParams(6) = iSumY

                iArrParams(7) = iSumXY

                // sumatoria de (X^2 * Y)'s
                iSumX2Y = 0
                for (iRen = 1 : iN)
                    iSumX2Y = iSumX2Y + ((iMatValues(iRen, 1) ^2) * iMatValues(iRen, 2))
                end
                iArrParams(8) = iSumX2Y

            end
        else 
            // es tipo 3 (exponencial)
            // sumatoria de ln(Y)'s
            iSumLnY = 0
            for (iRen = 1 : iN)
                iSumLnY = iSumLnY + log(iMatValues(iRen, 2))
            end
            iArrParams(4) = iSumLnY

            // sumatoria de ln(Y) * X
            iSumLnY_X = 0
            for (iRen = 1 : iN)
                iSumLnY_X = iSumLnY_X + (log(iMatValues(iRen, 2)) * iMatValues(iRen, 1))
            end
            iArrParams(5) = iSumLnY_X

        end

    else
        // es de tipo 4 (potencia)
        // sumatoria de ln(X)'s
        iSumLnX = 0
        for (iRen = 1 : iN)
            iSumLnX = iSumLnX + log(iMatValues(iRen, 1))
        end
        iArrParams(2) = iSumLnX

        // sumatoria de ln(X)^2's
        iSumLnX2 = 0
        for (iRen = 1 : iN)
            iSumLnX2 = iSumLnX2 + (log(iMatValues(iRen, 1)) ^ 2)
        end
        iArrParams(3) = iSumLnX2

        // sumatoria de ln(Y)'s
        iSumLnY = 0
        for (iRen = 1 : iN)
            iSumLnY = iSumLnY + log(iMatValues(iRen, 2))
        end
        iArrParams(4) = iSumLnY

        // sumatoria de ln(Y) * ln(X)
        iSumLnYLnX = 0
        for (iRen = 1 : iN)
            iSumLnYLnX = iSumLnYLnX + (log(iMatValues(iRen, 2)) * log(iMatValues(iRen, 1)))
        end
        iArrParams(5) = iSumLnYLnX

    end
endfunction

// regresion lineal
function iArrRegLineal = GetRegLineal(iMatValues)
    // generar matriz a transformar para mandar a Montante
    iArrParams = GetParamsRegression(iMatValues, 1)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // X
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // X^2
    iMatMontanteParam(2, 2) = iArrParams(3)
    // Y
    iMatMontanteParam(1, 3) = iArrParams(4)
    // XY
    iMatMontanteParam(2, 3) = iArrParams(5)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegLineal = Montante(iMatMontanteParam)

endfunction

// regresion cuadratica
function iArrRegCuadratica = GetRegCuadratica(iMatValues)
    iArrParams = GetParamsRegression(iMatValues, 2)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // X
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // X^2
    iCol = 3
    for iRen = 1 : 3 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(3)
        iCol = iCol - 1
    end
    // X^3
    iCol = 3
    for iRen = 2 : 3 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(4)
        iCol = iCol - 1
    end
    // X^4
    iMatMontanteParam(3, 3) = iArrParams(5)
    // Y
    iMatMontanteParam(1, 4) = iArrParams(6)
    // XY
    iMatMontanteParam(2, 4) = iArrParams(7)
    // Y*X^2
    iMatMontanteParam(3, 4) = iArrParams(8)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegCuadratica = Montante(iMatMontanteParam)
endfunction

// regresion exponencial
function iArrRegExponencial = GetRegExponencial(iMatValues)
    iArrParams = GetParamsRegression(iMatValues, 3)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // X
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // X^2
    iMatMontanteParam(2, 2) = iArrParams(3)
    // ln(Y)
    iMatMontanteParam(1, 3) = iArrParams(4)
    // ln(Y)*X
    iMatMontanteParam(2, 3) = iArrParams(5)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegExponencial = Montante(iMatMontanteParam)
    // ajustar el valor del termino constante con exponencial
    iArrRegExponencial(1) = exp(iArrRegExponencial(1))
endfunction

// regresion potencia
function iArrRegPotencia = GetRegPotencia(iMatValues)
    iArrParams = GetParamsRegression(iMatValues, 4)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // ln(X)
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // ln(X)^2
    iMatMontanteParam(2, 2) = iArrParams(3)
    // ln(Y)
    iMatMontanteParam(1, 3) = iArrParams(4)
    // ln(Y)*ln(X)
    iMatMontanteParam(2, 3) = iArrParams(5)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegPotencia = Montante(iMatMontanteParam)
    // ajustar el valor del termino constante con exponencial
    iArrRegPotencia(1) = exp(iArrRegPotencia(1))
endfunction


// calcular r^2
function iArrRegR2 = GetR2(iMatValues, iArrRegressions)
    dYMean = mean(iMatValues(:, 2))
    disp(dYMean)
endfunction


/////// Programa Principal

// lee los datos de excel
iMatValues = GetExcelValues()

// estructuras de datos para guardar las regresiones
// regresion lineal
regLineal = struct("regParams", GetRegLineal(iMatValues))
deff("y = funLineal(x)", "y = regLineal.regParams(1) + regLineal.regParams(2) * x")
regLineal.regFunc = funLineal
iArrRegressions(1) = regLineal

//regCuadratica 
regCuadratica = struct("regParams", GetRegCuadratica(iMatValues))
deff("y = funCuadratica(x)", "y = regCuadratica.regParams(1) + regCuadratica.regParams(2) * x + regCuadratica.regParams(3) * (x ^ 2)")
regCuadratica.regFunc = funCuadratica
iArrRegressions(2) = regCuadratica

// regExponencial
regExponencial = struct("regParams", GetRegExponencial(iMatValues))
deff("y = funExponencial(x)", "y = regExponencial.regParams(1) * exp(regExponencial.regParams(2) * x)")
regExponencial.regFunc = funExponencial
iArrRegressions(3) = regExponencial

// reg Potencia
regPotencia = struct("regParams", GetRegPotencia(iMatValues))
deff("y = funPotencia(x)", "y = regPotencia.regParams(1) * (x ^ (regPotencia.regParams(2)))")
regPotencia.regFunc = funPotencia
iArrRegressions(4) = regPotencia

iArrRegressions = GetR2(iMatValues, iArrRegressions)

// calcular r^2


