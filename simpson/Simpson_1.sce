clear
///////////////////////////////////////////////////////
//  Simpson.sce
//
//  Este programa aproxima la integral con parábolas
//  pidiendo los valores de los limites y el numero de 
//  intervalos
//
//   Armando Roque A01138717
//   6 / Noviembre  / 2019    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//  F
//
//  Funcion que calcula f(x) = 1 - e ^ (- x)
//
//   Parametros:
//     dX     es el valor de x para evaluar
//   Regresa:
//     dY     es el caclulo de x elevado al cuadrado
/////////////////////////////////////////////////////
function dY = F(dX)
    dY = 1 - exp(- dX)
endfunction

//////////////////////////////////////////////////////
//  Area
//
//  Funcion que calcula la integral de los trapecios
//
//   Parametros:
//      dA     es el valor del limite inicial
//      dB     es el valor del limite final
//      iN     es el numero de trapecios
//   Regresa:
//     dSuma   es el area calculada como la suma de trapecios
/////////////////////////////////////////////////////
function dSuma = Area(dA, dB, iN)
    // calculo h (base de cada rectangulo)
    dH = (dB - dA) / iN
    // inicializo la suma
    dSuma = 0
    // ciclo para sumar los valores impares que van multiplicados por 4
    dImpares = 0
    for i = 1 : 2 : iN - 1
        dImpares = dImpares + F(dA + i * dH)
    end
    dSuma  = dSuma + (dImpares * 4)
    // ciclo para sumar los valores pares que van multiplicados por 2
    dPares = 0
    for i = 2 : 2 : iN - 2
        dPares = dPares + F(dA + i * dH)
    end
    dSuma = dSuma + (dPares * 2)
    // agrego el valor inicial y final
    dSuma = dSuma + F(dA) + F(dB)
    dSuma = (dH / 3) * dSuma 
endfunction


/////// Programa Principal

// pido los valores
dA = input("Da el limite inferior ")
dB = input("Da el limite superior ")
while dA >= dB then
    disp("Los límites no son válidos")
    dA = input("Da el limite inferior ")
    dB = input("Da el limite superior ")
end
iN = input("Da el numero de intervalos ")
while (iN < 1 | (modulo(iN, 2) ~= 0)) then
    disp("El numero de intervalos debe ser positivo y par")
    iN = input("Da el numero de intervalos ")
end

// despliego la integral aproximada
disp(" Area Aproximada = " + string(Area(dA, dB, iN)))
