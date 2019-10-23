clear
///////////////////////////////////////////////////////
//  Trapecio.sce
//
//  Este programa aproxima la integral con trapecios
//  pidiendo los valores de los limites y el numero de 
//  trapecios
//
//   Armando Roque A01138717
//   23 / Octubre  / 2019    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//  F
//
//  Funcion que calcula f(x) = x^3 - 3x^2
//
//   Parametros:
//     dX     es el valor de x para evaluar
//   Regresa:
//     dY     es el caclulo de x elevado al cuadrado
/////////////////////////////////////////////////////
function dY = F(dX)
    dY = (dX * dX * dX) - 3 * (dX * dX)
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
    // ciclo para sumar los valores que van multiplicados por 2
    for i = 1 : iN - 1
        dSuma = dSuma + F(dA + i * dH)
    end
    // agrego el valor inicial y final
    dSuma = (dSuma * 2) + F(dA) + F(dB)
    dSuma = (dH / 2) * dSuma 
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
iN = input("Da el numero de trapecios ")
while iN < 1 then
    disp("El numero de trapecios debe ser positivo")
    iN = input("Da el numero de trapecios ")
end

// despliego la integral aproximada
disp(" Area Aproximada = " + string(Area(dA, dB, iN)))
