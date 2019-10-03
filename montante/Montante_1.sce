////////////////////////////////////////////////////
// Montante_1.sce
// Esta programa calcula la matriz resultante
// con la inversa y determinante
// proporcionadas por el usuario
// Marco Brown Cunningham y Armando Roque
// 28/8/2019 versión 1.0
////////////////////////////////////////////////////
clear
//////////////////////////////////////////////////////
//  GetMatrix
//
//  Funcion que pide el sistema de ecuaciones al usuario
//
//   Parametros:
//      no tiene
//   Regresa:
//     matMon     la matriz con los valores a utilizar
/////////////////////////////////////////////////////
function matMon=GetMatrix()
    iTam = input("ingresa el numero de variables")
     // pide datos
    for iRen= 1:iTam
         // recorre renglones
        for iCol=1:iTam
            // recorre columnas
            matMon(iRen,iCol)=input("Ingresa el coeficiente")
            // llena los datos de las variables
        end
        matMon(iRen, iTam+1)=input("Ingresa el termino constante del renglon")
        // llena los datos de las constantes
    end
    DisplayMatrix(matMon)
endfunction
//////////////////////////////////////////////////////
//  DisplayMatrix
//
//  Funcion que imprime la matriz
//
//   Parametros:
//      matMon la matriz a imprimir
//   Regresa:
//     nada
/////////////////////////////////////////////////////
function DisplayMatrix(matMon)
    disp(matMon)
endfunction
//////////////////////////////////////////////////////
//  Montante
//
//  Funcion que imprime la matriz transformada y los
//resultados de las incognitas de la matriz
//   Parametros:
//      matMon la matriz a transformar
//   Regresa:
//     nada
/////////////////////////////////////////////////////
function Montante(matMon)
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
        DisplayMatrix(matMon)
    end
    for(iRen=1:size(matMon,1)-1)
        //el ultimo pivote anterior toma las posiciones de los demas repitiendose
        matMon(iRen,iRen)=iPivAnt
    end
    DisplayMatrix(matMon)
    for iRen=1:size(matMon,1)
        //se expresan los resultados 
        x(iRen)=matMon(iRen,size(matMon,2))/iPivAnt
    end
    DisplayMatrix(x)
endfunction
/////// Programa Principal
// pido los valores
matMon = GetMatrix()
// evaluo la serie con los valores obtenidos
Montante(matMon)
