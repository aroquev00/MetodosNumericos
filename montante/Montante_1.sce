////////////////////////////////////////////////////
// Montante_1.sce
// Esta programa calcula la matriz resultante
// con la inversa y determinante
// proporcionadas por el usuario
// Marco Brown Cunningham y Armando Roque
// 28/8/2019 versión 1.0
////////////////////////////////////////////////////
clear
function matMon=GetMatrix()
    iTam = input("ingresa el numero de variables")
    for iRen= 1:iTam
        for iCol=1:iTam
            matMon(iRen,iCol)=input("Ingresa el coeficiente")
        end
        matMon(iRen, tam+1)="Ingresa el termino constante del renglon"
    end
endfunction

function DisplayMatrix(matMon)
    disp(matMon)
endfunction

function Montante(matMon)
    iPivAnt=1
    for iRen=1:size(matMon,1)
        for iK=1:size(matMon,1)
            if(iK<>iRen)
                for iCol=iRen+1:size(matMon,2)
                    matMon(iK,iCol)=(matMon(iRen,iRen)*matMon(iK,iCol)-matMon(iK,iRen)*matMon(iRen,iCol))/iPivAnt
                    matMon(iK,iRen)=0
                end
                iPivAnt=matMon(iRen,iRen)
                DisplayMatrix(matMon)
        end
        matMon(iRen,iRen)=iPivAnt
        DisplayMatrix(matMon)
    end
    DisplayMatrix(matMon)
    for iI=1:size(matMon,1)
        x(iI)=matMon(iI,iCol)/iPivAnt
    end
    DisplayMatrix(x)
endfunction
/////// Programa Principal
// pido los valores
matMon = GetMatrix()
// evaluo la serie con los valores obtenidos
Montante(matMon)
