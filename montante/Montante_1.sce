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
        matMon(iRen, iTam+1)=input("Ingresa el termino constante del renglon")
    end
    DisplayMatrix(matMon)
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
                end
                matMon(iK,iRen)=0
             end
        end
        iPivAnt=matMon(iRen,iRen)
        DisplayMatrix(matMon)
    end
    for(iRen=1:size(matMon,1)-1)
        matMon(iRen,iRen)=iPivAnt
    end
    DisplayMatrix(matMon)
    for iRen=1:size(matMon,1)
        x(iRen)=matMon(iRen,size(matMon,2))/iPivAnt
    end
    DisplayMatrix(x)
endfunction
/////// Programa Principal
// pido los valores
matMon = GetMatrix()
// evaluo la serie con los valores obtenidos
Montante(matMon)
